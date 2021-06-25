# Control Theory Fundamentals
_Fundamental control theory concepts, and applications with a (rough) approximation of an aircraft model!_

!!! warning "Notes In-Development!"
    These notes are under active development! They're being posted as they're written -- it's more fun that way.
    You'll pretty easily find typos, blank pages, and mistakes. It's all part of the process!
    If you have any questions about these notes, don't hesitate to [email](mailto:jdcarpinelli@gmail.com)
    the author!

```@eval
pkgversion(m::Module) = Pkg.TOML.parsefile(joinpath(dirname(string(first(methods(m.eval)).file)), "..", "Project.toml")["version"]
import ControlTheoryNotes
md"""
!!! tip "Current Version: $(pkgversion(ControlTheoryNotes))"
    I'd like all of the topics outlined below to have complete drafts posted here by the
    end of 2021. No promises though! Note the version numbers on [GitHub](https://github.com/cadojo/ControlTheoryNotes.jl).
"""
```

## About these Notes
Welcome to publicly available notes, with working and run-able examples, which 
provide an overview to control theory. The intended audience are engineering students 
(undergraduate, early graduate) or new professionals who might want a refresher 
for fundamental control theory concepts. 

We'll walk through simple definitions, motivate controls as a topic, 
outline linear systems theory and why it is important, and 
discuss linear and nonlinear controller design and analysis. 
Throughout these notes, one system will be used as an example: a polynomial 
model for a sub-scale radio-controlled aircraft, developed by NASA. 

## Topics to Cover
* __Dynamics:__ definitions, nonlinear dynamics, and linear dynamics
* __Systems Theory:__ linear systems theory, introductory nonlinear systems theory
* __Controls:__ control design for linear and nonlinear systems
* __Analysis:__ frequency analysis & other linear analysis techniques, nonlinear analysis

## What's Next?
Move on to Chapter 1 for some motivation behind these notes, and an quick definitions!