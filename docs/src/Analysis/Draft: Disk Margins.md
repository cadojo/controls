# Disk Margins
_How much gain __and__ phase can your system tolerate?_

!!! warning
    While all pages for this note-set will have chapter numbers,
    this page is just a draft! I'd like to write chapters in-order, 
    but I'm interested in exploring disk margins, so I decided 
    to write this page before the roughly 10 chapters that will
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
why they're useful. 

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
        symbolic = calculate_control_jacobian(GTM)
        numeric  = map(element -> substitute(element, GTM.defaults), symbolic)

        numeric .|> ModelingToolkit.value .|> Float64
    end

    C = I(n)
    D = zeros(n, p)

    ss(A, B, C, D)
end
```

Alright, so our __open-loop__ system is stable. Note that 
the model we're using is a MIMO system – we'll have one transfer function 
for every input-output channel. As a result, $G(s)$ is a $4\times2$ 
transfer-function-matrix. 

```@example Disk Margins
K = lqr(LinearizedGTM, I, I)
```

```@example Disk Margins
using Plots
using StaticArrays
using CoordinateTransformations

"""
Returns a plot showing stable and unstable variations.
The radius `α` of the largest possible disk in the green 
region, centered at some skew value `e`, is the disk magin.

All `kwargs` are passed directly to `Plots.plot`.
"""
function diskmarginplot(
    L::TransferFunction;
    gains  = range(0.; stop=2, length=100),
    phases = range(-2; stop=2, length=50),
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
        "Gain: $(20*log10(real(γ))) dB\nPhase: $(rad2deg(imag(γ))) deg"
        for γ ∈ Γ
    ]

    defaults = (; title  = "Disk Margin Plot", 
                  xlabel = "Real", 
                  ylabel = "Imaginary")

    figure = plot(; merge(defaults, kwargs)...)

    for (stable, variation) ∈ zip(stability_with_variation, Γ)
        if stable
            scatter!(figure, [real(variation)], [imag(variation)]; 
                    label       = :none, 
                    markersize  = 2, 
                    markercolor = :green)
        end
    end

    # plot!(figure; hover=freqinfo)

    return figure
end

diskmarginplot(
    series(tf(LinearizedGTM), tf(K))
)
```

!!! warning
    TODO – this page is unfinished!
