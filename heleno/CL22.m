function fCL22 = CL22(tvx,tvy)

[vx,vy] = ComputeVelocityAndAcelerations1(tvx,tvy);

[ux1,uy1] = getGlobalCurrent();

[S1] = getGlobalS();

fCL22=((((vx+ux1)^2)+2*(vy+uy1)^2)/sqrt(((ux1+vx)^2)+(uy1+vy)^2))*VP(vx,vy,S1);