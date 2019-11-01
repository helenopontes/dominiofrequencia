function [FdL] = onda_riser_FDL(t,pos)
global H k d Zd NumberOfWaves Ampw W phase RhoW Cd Di vc B1 B2

[Vx] = ComputeVelocityAndAcelerations(H, k, d, Zd, NumberOfWaves, Ampw, W, phase, t, pos);
FdL = (RhoW*1000/2)*Cd*Di*(B1*Vx + B2*vc);
