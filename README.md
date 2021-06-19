# Control Theory Notebooks
_Learning control theory by analyzing an approximated model for aircraft dynamics!_

## Overview

This repository contains [Pluto](https://github.com/fonsp/Pluto.jl) notebooks 
which provide an introduction to control theory. We'll cover concepts like 
nonlinear dynamics, linearization, frequency analysis, loop shaping, and 
other general control concepts. Each notebook will only look at __one__
plant (a.k.a. one dynamical system that we want to control): a [polynomial 
approximation](https://github.com/cadojo/PolynomialGTM.jl) for a [NASA subscale model aircraft's](https://ntrs.nasa.gov/api/citations/20040085988/downloads/20040085988.pdf)
flight dynamics. 

All code is written with the Julia programming language. Modeling library courtesy of [ModelingToolkit.jl](https://github.com/SciML/ModelingToolkit.jl), and controls library courtesy of [ControlSystems.jl](https://github.com/JuliaControl/ControlSystems.jl).

## Replication & Usage
_Pssst! If you you're using `Pluto` version 0.15 and higher, you can skip step 3!_

1. Download and install he current stable [Julia](https://julialang.org/downloads/#current_stable_release) for your computer
2. Clone this repo: `git clone https://github.com/cadojo/ControlNotebooks.jl`
3. Instantiate the necessary dependencies: `cd ControlNotebooks`, `julia --project`, `julia> ]instantiate`
4. Start Pluto, and open the notebooks under `src`: `julia> import Pluto; Pluto.run()`