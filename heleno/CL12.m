function fCL12 = CL12(tvx,tvy)

[vx,vy] = ComputeVelocityAndAcelerations1(tvx,tvy);

[ux1,uy1] = getGlobalCurrent();

[S1] = getGlobalS();

fCL12=(((vx+ux1)*(vy+uy1))/sqrt(((ux1+vx)^2)+(uy1+vy)^2))*VP(vx,vy,S1);