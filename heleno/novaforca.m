function F = novaforca (vx, vy, ux, uy, vxt, vyt, axt, ayt, ro, Cd, D)
[L,C] = MatrizesLC(vxt, vyt, ux, uy);

% for i=1:size(vx,2)
%     for j=1:size(vy,2)
%         FD1(j) = FD1(j) + 1/2*ro*Cd*D*((L(1,1)*vx(j)+L(1,2)*vy(j))+(C(1,1)*ux(j)+C(1,2)*uy(j)));
%         FD2 = FD2 
%     end
% end

for tt=1:1:100
    i=i+1;
    FD1(i) = 1/2*ro*Cd*D*((L(1,1)*vxt(i)+L(1,2)*vyt(i))+(C(1,1)*ux(tt)+C(1,2)*uy(tt)));
    FD2(i) = 1/2*ro*Cd*D*((L(2,1)*vxt(i)+L(2,2)*vyt(i))+(C(2,1)*ux(tt)+C(2,2)*uy(tt)));
end

%for j=1:size(vx,2)
    %FD1(j) = 1/2*ro*Cd*D*((L11*vx(j)+L12*vy(j))+(C11*ux(j)+C12*uy(j)));
    %FD2(j) = 1/2*ro*Cd*D*((L21*vx(j)+L22*vy(j))+(C21*ux(j)+C22*uy(j)));
%end

F = [FD1;FD2];

      