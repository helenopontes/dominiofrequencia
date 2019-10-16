function fCL11 = CL11(tvx,tvy)

[vx,vy] = ComputeVelocityAndAcelerations1(tvx,tvy);

[ux1,uy1] = getGlobalCurrent();

[S1] = getGlobalS();

fCL11 = 2*((((vx+ux1)^2)+(vy+uy1)^2)/sqrt(((ux1+vx)^2)+(uy1+vy)^2))*VP(vx,vy,S1);