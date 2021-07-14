[![Docs](https://github.com/cadojo/exploring-control-theory/workflows/Documentation/badge.svg)](https://cadojo.github.io/exploring-control-theory/stable)

# Exploring Control Theory
_Learning control theory by analyzing an approximated model for aircraft dynamics!_

## Overview

This repository contains notes (with concrete examples) 
which provide an introduction to control theory. We'll cover concepts like 
linear and nonlinear dynamics, linear and nonlinear systems theory,
linearization, frequency analysis, loop shaping, stability analysis, 
robustness analysis, and other general control concepts. For the most part, 
allconcepts will be applied to __one__ plant (a.k.a. one dynamical 
system that we want to control): a [polynomial 
approximation](https://github.com/cadojo/PolynomialGTM.jl) for a [NASA subscale model aircraft's](https://ntrs.nasa.gov/api/citations/20040085988/downloads/20040085988.pdf)
flight dynamics. 

All code is written with the Julia programming language. Modeling library courtesy of [
ModelingToolkit.jl](https://github.com/SciML/ModelingToolkit.jl), polynomial aircraft dynamics courtesy of 
[PolynomialGTM.jl](https://github.com/cadojo/PolynomialGTM.jl), and controls library courtesy of 
[ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl).
