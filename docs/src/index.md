# Control Theory Fundamentals
_Fundamental control theory concepts, and applications with a (rough) approximation of an aircraft model!_

```@eval
import Pkg
using Markdown
import ControlTheoryNotes
v = Pkg.TOML.parsefile(joinpath(dirname(string(first(methods(ControlTheoryNotes.eval)).file)), "..", "Project.toml"))["version"]
Markdown.Admonition("warning", "In-Development! Version $v", [
    md"These notes are under active development! They're being posted as they're written -- it's more fun that way.
    You'll pretty easily find typos, blank pages, and mistakes. It's all part of the process!
    If you have any questions about these notes, don't hesitate to [email](mailto:jdcarpinelli@gmail.com)
    the author!",
    md"I'd like all of the topics outlined below to have complete drafts posted here by the end of 2021. No promises though! Note the version numbers on [GitHub](https://github.com/cadojo/ControlTheoryNotes.jl)."])
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

## Ways to Read
These notes are available as a [website](https://jcarpinelli.dev/ControlTheoryNotes.jl/stable), and (soon) via PDF. 
If you have any questions, suggestions, or corrections, always feel free to email the author, [Joe Carpinelli](mailto:jdcarpinelli@gmail.com).

You can also host these notes locally! Simply execute the following commands in a Julia `REPL`.
```julia
julia> ]add https://github.com/cadojo/ControlTheoryNotes.jl
julia> import ControlTheoryNotes
julia> ControlTheoryNotes.serve()
```

## Topics to Cover
* __Dynamics:__ definitions, nonlinear dynamics, and linear dynamics
* __Systems:__ linear systems theory, introductory nonlinear systems theory
* __Controls:__ control design for linear and nonlinear systems
* __Analysis:__ frequency analysis & other linear analysis techniques, nonlinear analysis

## What's Next?
Move on to Chapter 1 for some motivation behind these notes, and an quick definitions!