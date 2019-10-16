function P = VP(vx, vy, S)
%Ds = det(S);
%P = (1/(2*pi*sqrt(Ds)))*exp((-1/2)*(1/sqrt(Ds))*(((vx*S(2,2)-vy*S(2,1))*vx)+((-vx*S(1,2)+vy*S(1,1))*vy)));
%P = (1/(2*pi*sqrt(Ds)))*exp((-1/2)*(1/Ds)*(((vx*S(2,2)-vy*S(2,1))*vx)+((-vx*S(1,2)+vy*S(1,1))*vy)));
%REVISAR

%Nova proposta de P
vn = [vx,vy]';
invS = (1/det(S))*[S(2,2),-S(1,2);-S(2,1),S(1,1)];
P = (1/(2*pi*sqrt(det(S))))*exp((-1/2)*vn'*invS*vn);