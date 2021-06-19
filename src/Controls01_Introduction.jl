### A Pluto.jl notebook ###
# v0.15.0

using Markdown
using InteractiveUtils

# ╔═╡ b73d4185-8f75-4105-8a9b-b4d9e42297b3
using PlutoUI # provides fun interfaces!

# ╔═╡ dcdd8734-cf1d-11eb-11c8-9b1048bf58e7
md"""
# 🎢 Control Notes – Introduction (1)
_What are we going to do here?_

### Goals

1. Introduce control theory
2. Define common industry terms
3. Outline the rest of this note-set!

## Overview
Welcome to this public control-theory note-set! We'll cover lots of fundamental control concepts, and we'll do so with hands-on scientific-computing tools like the Julia Programming Language, Pluto.jl, ModelingToolkit.jl, ControlSystems.jl, and PolynomialGTM.jl. Let's get started! First, we'll need to install the dependencies we'll need. 

!!! tip
	If this is your first time using a Pluto notebook, welcome! Pluto notebooks are similar in-concept to Jupyter notebooks, but with some added improvements. In addition to a new design and fast & active development, Pluto provides a concept known as _reactivity_; when you run a code cell, every _dependent_ cell is re-run. As a result, there's no need to manually re-run the whole notebook when you make a critical change. Pluto handles this for you!

"""

# ╔═╡ a2d3ed99-4d67-416f-9283-dfc3bf00d889
md"""
## Dependencies

!!! note
	If you're using Pluto version 0.15 or higher, the dependencies are managed by the Pluto notebook file (this file) itself. You don't need to do anything!
"""

# ╔═╡ 41b93a2f-f147-4016-b8e6-1190083a1958
md"""
## What is Control Theory?

Our world is filled with human-made, and natural systems. We can model each system with _equations of motion_. These equations describe how each system's _state_ changes! A quick definition for _state_ is described below. We often want to __control__ the state in some way. Think about the populations of predators and prey in an ecosystem, inflation rates in an economy, the orientation of a rocket, the speed of a car, etc.

!!! definition
	__State__ – a set of values that _completely describe_ a system!

Over the years, smart people have developed a field known as __controls__. Control theory is a broad term which includes...

* the math used to describe systems you'd like to control
* the analysis tools you use to see how well your system behaves
* the strategies for developing controllers
* more stuff like this!

We'll need a few more definitions before we really get started. 

- __Plant__ – the system you'd like to control (a car, a rocket, etc.)
- __Input__ - parameter values in your equations which you can change to influence your system's state (often a force or a device which produces a force for physical systems)
- __Model__ - the equations you've been given, or you've chosen which represent your system (_model_ is synonymous with _equations of motion_)

- __Dynamics__ - math (equations) which descibe how a system's state changes due to external forces

- __Control Law__ - an equation which describes _how_ you change your input values (this is set by _you_, the controls engineer!)
- __Performance__ – how well your controller _controls_ your system (how fast does the system move towards your desired state values, is your controller robust to perturbations and noise, etc.)

We'll walk through common control theory concepts and strategies in this note-set. It helps to have a concrete example for a system to control, so let's use one! NASA has developed a model aircraft for research, and university researchers produced an approximated model to describe this aircraft. We will use this model throughout these notes. By working through these notes, you'll be learning to control (a very rough model of) an airplane!
"""

# ╔═╡ d51dc9ff-2cc1-410d-ad43-2d9cf7c65af8
md"""
## What System are we Using?

NASA has developed a sub-scale model aircraft (think RC model plane) for flight controls research. This model is called the Generic Transport Model: GTM for short!
You can learn more about this in an [overview page](https://www.nasa.gov/larc/airstar-for-the-sake-of-pilots-and-passengers/), or by checking out the following video. 

University researchers ([Chakraborty et al](https://www.sciencedirect.com/science/article/abs/pii/S0967066110002595)) used curve-fitting strategies to approximate the equations which describe airplane flight as low-order _polynomials_. Polynomial approximations for systems are valuable because computers can compute polynomials quickly! 

This approximate (read, ROUGH) model for GTM flight dynamics has been ported to Julia as the [`PolynomialGTM`](https://github.com/cadojo/PolynomialGTM.jl) package. `PolynomialGTM` only exports one variable: `GTM`, a `ModelingToolkit.ODESystem` instance which includes the polynomial-approximated equations of motion for NASA's GTM. 

"""

# ╔═╡ 1dbd6ba6-4ae5-42c7-9d97-54c51b169d58
html"""
<iframe width="560" height="315" src="https://www.youtube.com/embed/_3JSRvaTRIQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ dcc7afb3-084d-4c27-9c7d-aa871dfd0691
md"""
## What's Next?

Next, we'll look at _nonlinear dynamics_, and what these _models_ look like!
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.9"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "81690084b6198a2e1da36fcfda16eeca9f9f24e4"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.1"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "c8abc88faa3f7a3950832ac5d6e690881590d6dc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "1.1.0"

[[PlutoUI]]
deps = ["Base64", "Dates", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "Suppressor"]
git-tree-sha1 = "44e225d5837e2a2345e69a1d1e01ac2443ff9fcb"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.9"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "5f6c21241f0f655da3952fd60aa18477cf96c220"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Suppressor]]
git-tree-sha1 = "a819d77f31f83e5792a76081eee1ea6342ab8787"
uuid = "fd094767-a336-5f1f-9728-57cf17d0bbfb"
version = "0.2.0"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╟─dcdd8734-cf1d-11eb-11c8-9b1048bf58e7
# ╟─a2d3ed99-4d67-416f-9283-dfc3bf00d889
# ╠═b73d4185-8f75-4105-8a9b-b4d9e42297b3
# ╟─41b93a2f-f147-4016-b8e6-1190083a1958
# ╟─d51dc9ff-2cc1-410d-ad43-2d9cf7c65af8
# ╟─1dbd6ba6-4ae5-42c7-9d97-54c51b169d58
# ╟─dcc7afb3-084d-4c27-9c7d-aa871dfd0691
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
