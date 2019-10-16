function fCCy = CCy(tvx,tvy)

[vx,vy] = ComputeVelocityAndAcelerations1(tvx,tvy);

[ux1,uy1] = getGlobalCurrent();

fCCy=((1/uy1)*(sqrt(((ux1+vx)^2)+(uy1+vy)^2))*(vy+uy1))*VP(vx,vy,S);