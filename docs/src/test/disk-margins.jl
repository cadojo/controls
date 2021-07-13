# Disk Margins!

using Plots
using StaticArrays
using LinearAlgebra
using PolynomialGTM
using ControlSystems
using ModelingToolkit
using CoordinateTransformations

LinearizedGTM  = let

    n = length(states(GTM))
    p = length(controls(GTM))

    A = let
        symbolic = calculate_jacobian(GTM)
        numeric  = map(element -> substitute(element, GTM.defaults), symbolic)

        numeric .|> ModelingToolkit.value .|> Float64
    end

    B = let
        symbolic = calculate_control_jacobian(GTM)
        numeric  = map(element -> substitute(element, GTM.defaults), symbolic)

        numeric .|> ModelingToolkit.value .|> Float64
    end

    C = I(n)
    D = zeros(n, p)

    ss(A, B, C, D)
end

"""
Returns the disk margin for the open-loop transfer function `L`
as a tuple: `(e, α)`. The value `α` is the radius of the 
largest possible diskregion, centered at some skew value `e`.
"""
function diskmargin(L::TransferFunction, e = 1.0; tolerance = 1e-3, max_iter = 20, num_variations = 72)

    ins  = size(L, 2)
    outs = size(L, 1)

    polars     = Vector{Polar}(undef, num_variations)
    variations = Vector{Complex{eltype(e)}}(undef, num_variations)
    channels_stable = [false for x in 1:num_variations, y in 1:outs, z in 1:ins]

    polars!(polars, α) = map!(
        t -> Polar(α, t), 
        polars, 
        range(0.0; stop=2π, length=num_variations)
    )

    circle!(variations, e, polars) = map!(
        p -> let 
            val = CartesianFromPolar()(p)
            e + val[1] + val[2]*im
        end, 
        variations, 
        polars
    )

    stable!(channels_stable, variations) = let
        for index in CartesianIndices(channels_stable)
            γᵢ, i, j = Tuple(index)
            γ = variations[γᵢ]
            channels_stable[index] = isstable(γ*L[i,j] / (1 + γ*L[i,j]))
        end
    end

    αᵢ    = 1.0
    αᵢ₋₁  = 0.0
    delta = Inf

    for iter in 1:max_iter 

        polars!(polars, αᵢ)
        circle!(variations, e, polars)

        all_channels_stable = true
        for index in CartesianIndices(channels_stable)
            γᵢ, i, j = Tuple(index)
            γ = variations[γᵢ]
            channels_stable[index] = isstable(γ*L[i,j] / (1 + γ*L[i,j]))
            if channels_stable[index] == false
                all_channels_stable = false
                break
            end
        end

        delta = abs(αᵢ-αᵢ₋₁)
        αᵢ₋₁  = αᵢ

        if all_channels_stable
            αᵢ  += delta / 2
        else
            αᵢ  -= delta / 2
        end

        if delta ≤ tolerance
            break
        end

    end

    if delta > tolerance
        @error "Desired tolerance of $tolerance not reached! Iterations converged to a tolerance of $delta."
    end

    return e, αᵢ
end

"""
Returns the disk margin with variations applies as specified
by `vary`: `:inputs`, `:outputs`, or ``:all`. `G` is the 
plant's transfer function (or transfer function matrix), 
and `K` is the feedback transfer function (or transfer function matrix).
Function output is a tuple: `(e, α)`. The value `α` is the radius of the 
largest possible diskregion, centered at some skew value `e`.
"""
function diskmargin(G::TransferFunction, K::TransferFunction, e = 1.0; kwargs...)

    # vary inputs
    α = diskmargin(K * G, e; kwargs...)[2]

    # vary outputs
    α = min(α, diskmargin(G * K, e; kwargs...)[2])

    return (e, α)

end

using Plots
plotly()

function diskmarginplot(
    L::TransferFunction;
    gains  =  0.0:0.1:2.0,
    phases = -2.0:0.1:2.0,
    kwargs...)

    Γ = map((x -> x[1] + x[2]*im), Base.Iterators.product(gains, phases))
    
    num_inputs   = size(L, 2)
    num_outputs  = size(L, 1)

    stability_with_variation = [
        let
            channel_stability = [
                isstable(γ*L[i,j] / (1 + γ*L[i,j])) 
                for i ∈ 1:num_outputs for j ∈ 1:num_inputs
            ]
            all(channel_stability)
        end
        for γ ∈ Γ
    ]

    freqinfo = [
        "$(real(γ)) + $(imag(γ))im\n Gain: $(20*log10(real(γ))) dB\n  Phase: $(rad2deg(imag(γ))) deg"
        for γ ∈ Γ
    ]

    defaults = (; title        = "Disk Margin Plot", 
                  xlabel       = "Real", 
                  ylabel       = "Imaginary",
                  aspect_ratio = 1.0)

    figure = plot(; merge(defaults, kwargs)...)

    for (stable, variation) ∈ zip(stability_with_variation, Γ)
        if stable
            scatter!(figure, [real(variation)], [imag(variation)]; 
                    label       = :none, 
                    markersize  = 2, 
                    markercolor = :green)
        end
    end

    plot!(figure; hover=freqinfo)

    return figure
end

G = tf(LinearizedGTM)
K = tf(lqr(LinearizedGTM, I, I))
L = series(G, K)

diskmarginplot(L)
