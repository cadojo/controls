[![Docs](https://github.com/cadojo/ControlTheoryNotes.jl/workflows/Documentation/badge.svg)](https://cadojo.github.io/ControlTheoryNotes.jl/dev)

# Control Theory Notes
_Learning control theory by analyzing an approximated model for aircraft dynamics!_

## Overview

This repository contains notes (with concrete examples) 
which provide an introduction to control theory. We'll cover concepts like 
nonlinear dynamics, linearization, frequency analysis, loop shaping, and 
other general control concepts. Each notebook will only look at __one__
plant (a.k.a. one dynamical system that we want to control): a [polynomial 
approximation](https://github.com/cadojo/PolynomialGTM.jl) for a [NASA subscale model aircraft's](https://ntrs.nasa.gov/api/citations/20040085988/downloads/20040085988.pdf)
flight dynamics. 

All code is written with the Julia programming language. Modeling library courtesy of [
ModelingToolkit.jl](https://github.com/SciML/ModelingToolkit.jl), polynomial aircraft dynamics courtesy of 
[PolynomialGTM.jl](https://github.com/cadojo/PolynomialGTM.jl), and controls library courtesy of 
[ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl).
