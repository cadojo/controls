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

!!! note "Definitions"
    __Disk Margins__ – Say you have some transfer function $G(s)$. How robust is this system to simultaneous
    gain _and_ phase variations? We can introduce gain to our system by multiplying $G(s)$ by some real constant
    $\alpha$. We can introduce phase to our system by multiplying our system by some complex constant
    $\beta i$. It follows, then, that we can introduce simultaneous gain and phase variations by 
    multiplying $G(s)$ by the _sum_ of $\alpha$ and $\beta i$. This sum forms a complex number!  
      
    We can left-multiply $G(s)$ by some complex number $\alpha + \beta i$, and determine
    if the resulting system is stable. Now, what if we try _hundreds_ or _thousands_ of different $\alpha$
    and $\beta$ values, and we plot each stable result in _green_, and each unstable result in _red_?
    We'd end up with a plot with a red background, and a shaded green region which shows the gain and 
    phase combinations that result in a __stable__ system! The _disk margin_ is the largest circle we can fit in 
    the _stable_ (green) region of the plot, with one additional caveat – the disk __must__ contain the point 
    $\alpha + \beta i = 1$, that is $\{\alpha = 1, \beta = 0\}$. 

#### An Excellent External Resource
```@raw html
<iframe width="560" height="315" src="https://www.youtube.com/embed/XazdN6eZF80" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

## Example

First, let's choose a SISO channel for our linearized dynamics polynomial aircraft dynamics!

```@example Disk Margins
using LinearAlgebra
using PolynomialGTM
using ControlSystems
using ModelingToolkit

n = length(states(GTM))
p = length(controls(GTM))

LinearizedGTM  = let

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

Turns out, the system is stable __without__ any changes in controls!
We can verify this by checking that the eigenvalues of the zero-input dynamics
(the `A` matrix) are _all_ in the left-half of the complex plane. We can _also_
check stability with the `isstable` function provided by `ControlSystems`.

```@example Disk Margins
isstable(LinearizedGTM)
```

Now we can start calculating the disk margin for our system! Note that 
the model we're using is a MIMO system – we'll have one transfer function 
for every input-output channel. As a result, $G(s)$ is a $4\times2$ 
transfer-function-matrix. 

```@example Disk Margins
L = tf(LinearizedGTM)

α = range(-10; stop=10, length=100)
β = range(-2π; stop=2π, length=100) .* im
Γ = [αᵢ + βⱼ for αᵢ ∈ α for βⱼ ∈ β] 

o = size(LinearizedGTM.C, 1)
all_channels_stable(γ) = all([isstable(γ * L[i, j]) for i ∈ 1:o for j ∈ 1:p])
```

!!! warning
    TODO – this page is unfinished!
    