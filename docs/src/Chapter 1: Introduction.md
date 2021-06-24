# Introduction
_What will be do here?_

## Overview

Control theory is hard! Lots of analysis is nuanced, and it's pretty easy to fall into incorrect assumptions
and incomplete understanding. That's where this refresher comes in. We'll cover basic definitions through
multi-input multi-output linear analysis, and everything in between. These notes are available as a 
[website](jcarpinelli.dev/ControlTheoryNotes.jl/stable), and (soon) via PDF. 
If you have any questions, suggestions, or corrections, always feel free to email the author, 
[Joe Carpinelli](mailto:jdcarpinelli@gmail.com).

## What is Control Theory?

Our world is filled with human-made, and natural systems. We can model each system with _equations of motion_. These equations describe how each system's _state_ changes! A quick definition for _state_ is described below. We often want to __control__ the state in some way. Think about the populations of predators and prey in an ecosystem, inflation rates in an economy, the orientation of a rocket, the speed of a car, etc.

!!! note "Definitions"
	__State__ – a set of values that _completely describe_ a system!

Over the years, smart people have developed a field known as __controls__. Control theory is a broad term which includes...

* the math used to describe systems you'd like to control
* the analysis tools you use to see how well your system behaves
* the strategies for developing controllers
* more stuff like this!

We'll need a few more definitions before we really get started. 

!!! note "Definitions"
    - __Plant__ – the system you'd like to control (a car, a rocket, etc.)
    - __Input__ - parameter values in your equations which you can change to influence your system's state (often a force or a device which produces a force for physical systems)
    - __Model__ - the equations you've been given, or you've chosen which represent your system (_model_ is synonymous with _equations of motion_)
    - __Dynamics__ - math (equations) which descibe how a system's state changes due to external forces
    - __Control Law__ - an equation which describes _how_ you change your input values (this is set by _you_, the controls engineer!)
    - __Performance__ – how well your controller _controls_ your system (how fast does the system move towards your desired state values, is your controller robust to perturbations and noise, etc.)

We'll walk through common control theory concepts and strategies in this note-set. It helps to have a concrete example for a system to control, so let's use one! NASA has developed a model aircraft for research, and university researchers produced an approximated model to describe this aircraft. We will use this model throughout these notes. By working through these notes, you'll be learning to control (a very rough model of) an airplane!

## What System are we Using?

NASA has developed a sub-scale model aircraft (think RC model plane) for flight controls research. This model is called the Generic Transport Model: GTM for short!
You can learn more about this in an [overview page](https://www.nasa.gov/larc/airstar-for-the-sake-of-pilots-and-passengers/), or by checking out the following video. 

University researchers ([Chakraborty et al](https://www.sciencedirect.com/science/article/abs/pii/S0967066110002595)) used curve-fitting strategies to approximate the equations which describe airplane flight as low-order _polynomials_. Polynomial approximations for systems are valuable because computers can compute polynomials quickly! 

This approximate (read, ROUGH) model for GTM flight dynamics has been ported to Julia as the [`PolynomialGTM`](https://github.com/cadojo/PolynomialGTM.jl) package. `PolynomialGTM` only exports one variable: `GTM`, a `ModelingToolkit.ODESystem` instance which includes the polynomial-approximated equations of motion for NASA's GTM. 

```@raw html
<iframe width="560" src="https://www.youtube.com/embed/_3JSRvaTRIQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
```

## What's Next?

Next, we'll look at _nonlinear dynamics_, and what these _models_ look like.

