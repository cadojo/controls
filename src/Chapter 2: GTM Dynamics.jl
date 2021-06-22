# # Generic Aircraft Dynamics
# _How planes move!_

# ## Overview 
# We'll be analysing a polynomial approximation of 
# [GTM](https://www.nasa.gov/larc/airstar-for-the-sake-of-pilots-and-passengers/)
# dynamics throughout these notes, so it's worth spending some time 
# covering aircraft dynamics generically. 

# There are many __dynamical modes__ that affect airplanes throughout flight. 
# You can think of modes as oscillations in-time for _some_ subset of a system's 
# state space. Aircraft have dynamical modes which produce aircraft oscillations
# above and below the aircraft's _longitudinal axis_ (the line pointing
# forward from the nose) -- these are known as __longitudinal modes__. 
# Lateral modes (modes which rotate the aircraft about its longitudinally and 
# vertically oriented axes) also affect flight dynamics. General information
# about dynamical modes common to flight dynamics is available 
# on [Wikipedia](https://en.wikipedia.org/wiki/Aircraft_dynamic_modes#Longitudinal_modes). 

