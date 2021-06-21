# # Dynamics and Equations of Motion
# _How stuff moves!_

# ## Overview 
# Our end goal as controls engineers is to _affect_ a system in some desired way. 
# To do this, we'll need a mathematical description of our system. This mathematical 
# description is known as a _model_. 
# There's a famous [quote](https://en.wikipedia.org/wiki/All_models_are_wrong)
# about mathematical models: "all models are wrong, but some are useful". 
#
# This is really important. We are __always__ approximating our system by describing it with a model.
# The question we need to ask is "is our approximate description of our system (our model) good enough?"

# !!! tip "Definitions"
#     - __Model__ - a mathematical description of a system

# But what does this model _look like_? To answer this question, let's 
# first discuss system dynamics, and equations of motion.

# ## Dynamics
# If we want to _affect_ a system, then by definition, the system _should_ be affect-able (is that a word?)
# by external forces. These "forces" don't necessarily need to be physical forces: consider the affect 
# of introducing new predators in an ecosystem with the goal of affecting predator-prey populations.
#
# So we have a mathematical description, and we know we'll need some changing _parameter_ to affect
# the mathematical description. Sounds like we need equations! The equations that govern 
# our system are often called _equations of motion_. Any system that changes due to 
# some external "force" is known as a _dynamical_ system by definition. 
#
# The first step to any controls problem is identifying the _dynamics_; this usually 
# means defining the _equations of motion_ for our system. A set of _equations of motion_
# which describe our _dynamical_ system __is__ our model. 

## Model Example
# A really common system in engineering is known as the __spring-mass-damper__. 
# We can roughly describe this system as a block on a table, which 
# is connected to a spring. We can _force_ (a.k.a. _affect_) this system by pulling on 
# the block to extend or compress the spring. 
#
# Let's figure out our equations of motion. The following question is usually a useful 
# starting point: "what are the forces on our system?"
# 
# 