function [FdNL] = onda_riser_FDNL(t,pos)
global H k d Zd NumberOfWaves Ampw W phase RhoW Cd Di vc

[Vx] = ComputeVelocityAndAcelerations(H, k, d, Zd, NumberOfWaves, Ampw, W, phase, t, pos);
FdNL = (RhoW*1000/2)*Cd*Di*abs(Vx+vc)*(Vx+vc); %Desta forma a resposta sai em Newtons
