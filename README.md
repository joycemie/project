# MATLAB

A water tank has shape shown in Figure 1. Water is delivered to this tank through the bottom. The water volume in the system is given by a function V (t), such that V (0) = 0 (here V (t) denotes the volume of water delivered to the system by the time t).
In this assignment you will simulate the process of filling up this tank. There are several reasonable questions to answer:
At what time water will reach the top of the tank?
At what time water reaches particular level?
and so on.

What to compute?
Your code should first find and print times TA,TB,TC and TD when water reaches the levels A,B,C and D (top of the tank).
After this, calculate and plot dependency t(h) where h is the height of water level 0 ≤ h ≤ 2r1 +l1 +l2 +r2, and t(h) is time when water reaches level h. For this, Set H = 2r1 + l1 + l2 + r2 , divide interval [0, H ] into N equal subintervals and compute t(hi ), where hi =iNH,i=0,1,...,N, and t(hi) is the earliest time when the water level reaches the height hi.
Your code must have a function named simulate that takes tank parameters r1,l1,l2,r2, integer value N and tolerance as arguments and produces necessary for plotting data along with the plot.(including values r_1 = 2, l_1 = 3, l_2 = 3, r_2= 4, N = 100, tolerance 10^(-4) ).
