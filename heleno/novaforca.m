function F = Forca (vxt, vyt, axt, ayt, ro, Cd, D)
[L,C] = MatrizesLC(vx, vy, ux, uy);

% for i=1:size(vx,2)
%     for j=1:size(vy,2)
%         FD1(j) = FD1(j) + 1/2*ro*Cd*D*((L(1,1)*vx(j)+L(1,2)*vy(j))+(C(1,1)*ux(j)+C(1,2)*uy(j)));
%         FD2 = FD2 
%     end
% end

for tt=0:1:100
    FD1(tt) = 1/2*ro*Cd*D*((L(1,1)*vxt(tt)+L(1,2)*vyt(tt))+(C(1,1)*axt(tt)+C(1,2)*ayt(tt)));
    FD2(tt) = 1/2*ro*Cd*D*((L(2,1)*vxt(tt)+L(2,2)*vyt(tt))+(C(2,1)*axt(tt)+C(2,2)*ayt(tt)));
end

%for j=1:size(vx,2)
    %FD1(j) = 1/2*ro*Cd*D*((L11*vx(j)+L12*vy(j))+(C11*ux(j)+C12*uy(j)));
    %FD2(j) = 1/2*ro*Cd*D*((L21*vx(j)+L22*vy(j))+(C21*ux(j)+C22*uy(j)));
%end

F = [FD1;FD2];

        %CONTINUAR