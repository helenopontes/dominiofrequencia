function fCCx = CCx(tvx,tvy)

[vx,vy] = ComputeVelocityAndAcelerations1(tvx,tvy);

[ux1,uy1] = getGlobalCurrent();

fCCx=((1/ux1)*(sqrt(((ux1+vx)^2)+(uy1+vy)^2))*(vx+ux1))*VP(vx,vy,S);