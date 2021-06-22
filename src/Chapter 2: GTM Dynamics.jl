# # GTM Flight Dynamics
# _How planes move!_

# ## Overview 
# We'll be analysing a polynomial approximation of 
# [GTM](https://www.nasa.gov/larc/airstar-for-the-sake-of-pilots-and-passengers/)
# dynamics throughout these notes, so it's worth spending some time 
# covering aircraft dynamics generically. 

# ## Generic Flight Dynamics 
# There are many __dynamical modes__ that affect airplanes throughout flight. 
# You can think of modes as oscillations in-time for _some_ subset of a system's 
# state space. Aircraft have dynamical modes which produce aircraft oscillations
# above and below the aircraft's _longitudinal axis_ (the line pointing
# forward from the nose) -- these are known as __longitudinal modes__. 
# Lateral modes (modes which rotate the aircraft about its longitudinally and 
# vertically oriented axes) also affect flight dynamics. General information
# about dynamical modes common to flight dynamics is available 
# on [Wikipedia](https://en.wikipedia.org/wiki/Aircraft_dynamic_modes#Longitudinal_modes). 

# Only analyzing one set of dynamical modes (only _some_ self-contained equations of motion)
# is common practice in early controls analysis. For simplicity, we'll do the same here 
# and throughout these notes! Just note that, at the end of the day, you _of course_
# need to test your system's performance relative to all modeled dynamics.

# The equations of motion for the longitudinal flight dynamics 
# associated with _any_ generic aircraft are shown below. These 
# are common equations, which are taught in many undergraduate 
# aerospace engineering programs. 

#=
$\begin{equation}
    x = \begin{bmatrix} V \\ \alpha \\ q \\ \theta \end{bmatrix},\ \ 
    u = \begin{bmatrix} \delta_{elev} \\ \delta_{th} \end{bmatrix}
\end{equation}$

$f(x) \triangleq \dot{x} = \begin{equation}\begin{align*}     
    \dot{V} &= \frac{1}{m}\left(-D - m g \sin{(\theta - \alpha)} + T_x \cos{\alpha} + T_z \sin{\alpha} \right) \\
    \dot{\alpha} &= \frac{1}{m V}\left(-L + m g \cos{(\theta - \alpha)} - T_x \sin{\alpha} + T_z \cos{\alpha}\right) + q \\
    \dot{q} &= \frac{M + T_m}{Iyy} \\
    \dot{\theta} &= q 
\end{align*}\end{equation}$
=#

# ## Approximated GTM Dynamics
# NASA's Generic Transport Model (GTM) is a radio-controlled model plane, which
# is a scaled-down version of a generic passenger plane (think, one of the 
# big jets you may fly on when you travel). This model is used for 
# flight controls research. According to Chakraborty et al, 
# aerodynamic coefficients are used by NASA to describe 
# atmospheric lift, drag, and aerodynamic moments. These 
# tables are __not__ publicly available. Still, Chakraborty et al
# published [publicly available](https://www.sciencedirect.com/science/article/abs/pii/S0967066110002595)
# polynomial _approximations_ of longitudinal GTM flight dynamics near select 
# trim conditions. We'll cover trim conditions (also known as equilibrium points)
# in future chapters. For now, its enough to understand that the polynomial approximation
# they made is only accurate near select flight conditions. Of course, even near these 
# select flight conditions, the approximation introduces error. Chakraborty et al
# tracked the magnitude of these errors, but we'll just (falsely) treat this polynomial
# approximation as fact throughout these notes. 
#
# If you're interested in reading more about the methodology behind these polynomial 
# approximations, read [Chakraborty et al's paper](https://www.sciencedirect.com/science/article/abs/pii/S0967066110002595),
# and check out a [Python implementation and associated paper](https://github.com/cadojo/Replicated-ROA-Analysis) 
# which was completed as part of a University of Maryland aerospace engineering course project. 
#
# !!! note 
#     These polynomial approximations were __also__ implemented with Julia as part of the 
#     [`PolynomialGTM.jl`](https://github.com/cadojo/PolynomialGTM.jl) package!
#
# The polynomial approximations, as derived and published by Chakraborty et al, are shown below. 
# I told you to be afraid!

# __Special thanks to Michael Livecchi, a good (and _patient_) friend who read 
# all of these equations out over the phone to make sure they were typed correctly!__

#=
$\begin{equation}
\begin{align*}
f_1(x,u) \approx &\ 1.233\times10^{-8}x_1^4x_3^2 + 4.853\times10^{-9}x_2^3u_2^3 \\
&+ 3.705\times10^{-5}x_1^3x_2 x_3 
- 2.184\times10^{-6}x_1^3x_3^2 \\
&+ 2.203\times10^{-2}x_1^2x_2^3 - 2.836\times10^{-6}x_2^3u_2^2 \\
& + 3.885\times10^{-7}x_2^2u_2^3 - 1.069\times10^{-6}x_1^3x_3 \\
& - 4.517\times10^{-2}x_1^2x_2^2
- 2.140\times10^{-3}x_1^2x_2u_1 \\
&- 3.282\times10^{-3}x_1^2x_2 x_3 - 8.901\times10^{-4}x_1^2u_1^2 \\
& + 9.677\times10^{-5}x_1^2x_3^2 - 2.037\times10^{-4}x_2^3u_2 \\
&- 2.270\times10^{-4}x_2^2u_2^2
- 2.912\times10^{-8}x_2u_2^3 \\
&+ 1.591\times10^{-3}x_1^2x_2 - 4.077\times10^{-4}x_1^2u_1 \\
& + 9.475\times10^{-5}x_1^2x_3 - 1.637x_2^3 \\
&- 1.631\times10^{-2}x_2^2u_2 + 4.903x_2^2x_4 \\
& -4.903x_2x_4^2 + 1.702\times10^{-5}x_2u_2^2 \\
&- 7.771\times10^{-7}u_2^3 + 1.634x_4^3  \\
&- 4.319\times10^{-4}x_1^2 - 2.142\times10^{-1}x_2^2 \\
&+ 1.222\times10^{-3}x_2u_2
+ 4.541\times10^{-4}u_2^2 \\
&+ 9.823x_2 + 3.261\times10^{-2}u_2 \\
&- 9.807x_4 + 4.282\times10^{-1}
\end{align*}
\end{equation}$

$\begin{equation}
\begin{align*}
f_2(x,u) \approx & -3.709\times10^{-11}x_1^5x_3^2 + 6.869\times10^{-11}x_1x_2^3u_2^3 \\
&+ 7.957\times10^{-10}x_1^4x_2 x_3 
+ 9.860\times10^{-9}x_1^4x_3^2 \\
&+ 1.694\times10^{-5}x_1^3x_2^3 - 4.015\times10^{-8}x_1x_2^3u_2^2 \\
& - 7.722\times10^{-12}x_1x_2^2u_2^3 - 6.086\times10^{-9}x_2^3u_2^3 \\
&- 2.013\times10^{-8}x_1^4x_3
- 5.180\times10^{-5}x_1^3x_2^2 \\
&- 2.720\times10^{-6}x_1^3x_2u_1 
- 1.410\times10^{-7}x_1^3x_2 x_3 \\
& + 7.352\times10^{-7}x_1^3u_1^2 - 8.736\times10^{-7}x_1^3x_3^2 \\
&- 1.501\times10^{-3}x_1^2x_2^3 
- 2.883\times10^{-6}x_1x_2^3u_2 \\
&+ 4.513\times10^{-9}x_1x_2^2u_2^2 - 4.121\times10^{-10}x_1x_2u_2^3 \\
& + 3.557\times10^{-6}x_2^3u_2^2 + 6.841\times10^{-10}x_2^2u_2^3 \\
&+ 4.151\times10^{-5}x_1^3x_2 + 3.648\times10^{-6}x_1^3u_1 \\
&+ 3.566\times10^{-6}x_1^3x_3 + 6.246\times10^{-6}x_1^2x_2 x_3 \\
& + 4.589\times10^{-3}x_1^2x_2^2 + 2.410\times10^{-74}x_1^2x_2u_1 \\
&- 6.514\times10^{-5}x_1^2u_1^2 
+ 2.580\times10^{-5}x_1^2x_3^2 \\
&- 3.787\times10^{-5}x_1x_2^3 + 3.241\times10^{-7}x_1x_2^2u_2 \\
& + 2.409\times10^{-7}x_1x_2u_2^2 + 1.544\times10^{-11}x_1u_2^3 \\
&+ 2.554\times10^{-4}x_2^3u_2 
- 3.998\times10^{-7}x_2^2u_2^2 \\
&+ 3.651\times10^{-8}x_2u_2^3 + 4.716\times10^{-7}x_1^3 \\
& - 3.677\times10^{-3}x_1^2x_2 - 3.231\times10^{-4}x_1^2u_1 \\
&- 1.579\times10^{-4}x_1^2x_3 + 2.605\times10^{-3}x_1x_2^2 \\
&+ 1.730\times10^{-5}x_1x_2u_2 - 5.201\times10^{-3}x_1x_2x_4 \\
&- 9.026\times10^{-9}x_1u_2^2 + 2.601\times10^{-3}x_1x_4^2 \\
&+ 3.355\times10^{-3}x_2^3 - 2.872\times10^{-5}x_2^2u_2 \\
&- 2.134\times10^{-5}x_2u_2^2 - 1.368\times10^{-9}u_2^3 \\
&- 4.178\times10^{-5}x_1^2 + 2.272\times10^{-4}x_1x_2 \\
&- 6.483\times10^{-7}x_1u_2 - 2.308\times10^{-1}x_2^2 \\
&- 1.532\times10^{-3}x_2u_2 + 4.608\times10^{-1}x_2x_4 \\
&- 2.304\times10^{-1}x_4^2 + 7.997\times10^{-7}u_2^2 \\
&- 5.210\times10^{-3}x_1  - 2.013\times10^{-2}x_2 \\
&+ 5.744\times10^{-5}u_2 + x_3 + 4.616\times10^{-1} 
\end{align*}
\end{equation}$

$\begin{equation}
\begin{align*}
f_3(x,u) \approx & - 6.573\times10^{-9}x_1^5x_3^3 + 1.747\times10^{-6}x_1^4x_3^3 \\
&- 1.548\times10^{-4}x_1^3x_3^3 - 3.569\times10^{-3}x_1^2x_2^3 \\
&+ 4.571\times10^{-3}x_1^2x_3^3 + 4.953\times10^{-5}x_1^3x_3 \\
& + 9.596\times10^{-3}x_1^2x_2^2 + 2.049\times10^{-2}x_1^2x_2u_1 \\
&- 2.431\times10^{-2}x_1^2x_2 - 3.063\times10^{-2}x_1^2u_1 \\
&- 4.388\times10^{-3}x_1^2x_3 - 2.594\times10^{-7}u_2^3 \\
& + 2.461\times10^{-3}x_1^2 + 1.516\times10^{-4}u_2^2 \\
&+ 1.089\times10^{-2}u_2 + 1.430\times10^{-1}
\end{align*}
\end{equation}$

$\begin{equation}
f_4(x,u) \approx x_3 
\end{equation}$
=#

# ## Example
# We can use `DifferentialEquations` and `PolynomialGTM` to simulate this system! 

using PolynomialGTM
using DifferentialEquations

problem   = ODEProblem(GTM) # there is a default flight condition stored in `GTM`
solutions = solve(problem, Tsit5(); reltol = 1e-12, abstol = 1e-12)

plot(solutions)

# ## What's Next?
# Now that we've covered our approximated GTM dynamics _specifically_, let's 
# describe how these (simplified and approximated) dynamics are _still_ 
# really hard to analyze! We'll find we need linear analysis techniques 
# to help us characterize the stability and performance of our system. 
# Future chapters will explain why! 😁