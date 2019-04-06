%% Assignment 4: Circuit Modelling
% Tyler Armstrong
% 101009324
%
%% Introduction
%
% The goal of this assignment was to model an RLC circuit, and use 
% modified nodal analysis to find the node voltages and currents in the 
% circuit. The equation used to calculate these is:
%
% $$V_j = A^{-1}(C\frac{V_{j-1}}{\Delta t}+F(t_j)-B(V_j))$$
%
% Where $V$ is the vector of node voltages and currents, $G$ contains the
% coefficients of non-derivative terms, $C$ contains the coefficients of
% 1st order time derivative terms, $B$ contains any nonlinear terms, $F(t)$
% is the input from any independent sources, and $A$ is:
%
% $$A = \frac{C}{\Delta t}+G$$
%
% The circuit simulated in this assignment contains only linear elements,
% so the $B$ matrix is zero. $V_0$ is known, so the equation can be solved
% by iterating over $j$.
%
%% Part 1: Constant Input Voltage
%
% In this section, the circuit will be simulated with a constant input
% voltage. The voltage was swept from -10V to 10V, and a plot was made of
% the node voltages at node 3 and node 5 (the output voltage). A second
% plot was made by sweeping the frequency for a constant AC voltage of 1V.
% The two plots are shown below. 
%
A4MNA1;
%%
%
% The order of the variables in the matrices is $V_1$, $I_s$, $V_2$, $V_3$,
% $I_L$, $I_\alpha$, $V_4$, and $V_5$. The matrices are: 
%
disp(G);
%%
%
disp(C);
%
%% Part 2: Transient Case
%
% In this section, the circuit is simulated with three different
% time-varying input signals. 
%
% * A 1V step function, with a delay at 0.03s
% * A 1V sine wave, with a frequency of 33.333Hz
% * A 1V Gaussian pulse with a delay of 0.06s and a standard deviation of
% 0.03s
%
% The plots of the output voltage and the frequency spectrum for each
% signal are shown below. In the voltage plots, the input function is shown
% in blue, and the output is in red. 
%
A4MNA2;
%%
%
% As expected, the sine wave's frequency spectrum has peaks at $\pm f$. The
% step function has a delta function at the centre, combined with a sinc
% function. The spectrum of the Gaussian pulse is also Gaussian. There is
% very little distortion in the signals. 
%
%% Part 3: Noise
%
% In this section, a capacitor $C_n$ and a current source $I_n$ were added
% in parallel with $R_3$. This models the noise of the signal across the
% resistor. $I_n$ had a magnitude of 1mA, with a Gaussian distribution. The
% plots of the output voltage and its frequency spectrum are given below.
%
A4MNA3;
%%
% There is significant noise visible in both plots.
%
% The new C matrix is:
%
disp(C);
%%
% The G matrix was unchanged. 
%
% The following two plots show the effects of varying the time step and the
% noise capacitor from their original values. 
%
A4MNA4;
%%
% The output voltage curves for $C_n$ and $10C_n$ are not visible behind
% the $0.1C_n$ curve, so the noise appears to increase as $C_n$ decreases. 
%
% Reducing the time step by a factor of 10 increased the output voltage by
% approximately the same factor. This makes the choice of time step very 
% important when designing a simulation.
%
%% Part 4: Nonlinear Elements
%
% If the current $I_\alpha$ is a nonlinear function, the simulation here no
% longer works. To fix this, the $B$ matrix would need to include the
% equation for $I_\alpha$. Since the $B$ matrix is now non-zero, the
% variables at each step need to be calculated using a root-finding
% algorithm. 