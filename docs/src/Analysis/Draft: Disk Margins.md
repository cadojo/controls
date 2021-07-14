# Disk Margins
_How much gain __and__ phase can your system tolerate?_

!!! warning
    While all pages for this note-set will have chapter numbers,
    this page is just a draft! I'd like to write chapters in-order, 
    but I'm interested in exploring analysis methods, so I decided 
    to write this page before the several chapters that will
    come before it.

## Overview

Previous chapters have discussed __gain margins__ and __phase margins__. Each provides a measure for 
how much gain __or__ phase your system can tolerate – that is, the gain margin for your system 
tells you how much input _gain_ your system can tolerate when your input _phase_ is zero, and the 
phase margin tells you how much input _phase_ your system can tolerate when your input _gain_ is zero. 

In reality, would you expect a disturbance, sensor noise, or model uncertainty to introduce 
gain _or_ phase? The answer, of course, is no! Your controller will encounter 
model uncertainties that introduce gain _and_ phase simultaneously. The topic which relates to 
designing control systems that perform well in spite of model uncertainty, sensor noise, 
and disturbances is known as __robust control__. Engineers often use large gain 
margin and phase margin requirements alongside high-fidelity simulations to assess their control system's 
performance and robustness. The __disk margin__ is one method for determining how robust your system is 
to gain _and_ phase simultaneously. The video below is a fantastic reference for disk margins, and 
why they're useful. The paper below provides efficient algorithms for computing disk margins, 
and associated values.

## Computing the Disk Margin

!!! warning
    To do!

#### External Resources

##### Overview Paper

A thorough [paper](https://arxiv.org/abs/2003.04771), written by 
Peter Seiler, Andrew Packard, and Pascal Gahinet, covers disk margins in detail. 

##### Summary Video

Brian Douglass has authored a fantastic 
[video](https://www.youtube.com/embed/XazdN6eZF80) as an 
accompanyment to the previously mentioned paper. 

```@raw html
<iframe width="560" height="315" src="https://www.youtube.com/embed/XazdN6eZF80" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

## Example

First, let's linearize our polynomial aircraft dynamics about a trim condition. The 
trim condition used here is a _default_ condition provided by `PolynomialGTM`.

```@example Disk Margins
using Symbolics
using LinearAlgebra
using PolynomialGTM
using ControlSystems
using ModelingToolkit

LinearizedGTM  = let

    n = length(states(GTM))
    p = length(controls(GTM))

    A = let
        symbolic = calculate_jacobian(GTM)
        numeric  = map(element -> substitute(element, GTM.defaults), symbolic)

        numeric .|> ModelingToolkit.value .|> Float64
    end

    B = let
        symbolic = Symbolics.jacobian(getfield.(equations(GTM), :rhs), parameters(GTM))
        numeric  = map(element -> substitute(element, GTM.defaults), symbolic)

        numeric .|> ModelingToolkit.value .|> Float64
    end

    C = I(n)
    D = zeros(n, p)

    ss(A, B, C, D)
end
```

Note that the model we're using is a MIMO system – we'll have one transfer function 
for every input-output channel. As a result, $G(s)$ is a $4\times2$ 
transfer-function-matrix. Let's use a LQR-bsed control law. 

```@example Disk Margins
K = lqr(LinearizedGTM, I, I)
```


```@example Disk Margins# Disk Margins!

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

diskmarginplot(L) # right now this calculates it (slightly incorrectly) by brute force!
```

!!! warning
    TODO – this page is unfinished!
