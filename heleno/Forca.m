function F = Forca (vx, vy, ux, uy, ro, Cd, D)
[L,C] = MatrizesLC(vx, vy, ux, uy);
% for i=1:size(vx,2)
%     for j=1:size(vy,2)
%         FD1(j) = FD1(j) + 1/2*ro*Cd*D*((L(1,1)*vx(j)+L(1,2)*vy(j))+(C(1,1)*ux(j)+C(1,2)*uy(j)));
%         FD2 = FD2 
%     end
% end
for j=1:size(vx,2)
   FD1(j) = 1/2*ro*Cd*D*((L(1,1)*vx(j)+L(1,2)*vy(j))+(C(1,1)*ux(j)+C(1,2)*uy(j)));
   FD2(j) = 1/2*ro*Cd*D*((L(2,1)*vx(j)+L(2,2)*vy(j))+(C(2,1)*ux(j)+C(2,2)*uy(j)));
end

%for j=1:size(vx,2)
    %FD1(j) = 1/2*ro*Cd*D*((L11*vx(j)+L12*vy(j))+(C11*ux(j)+C12*uy(j)));
    %FD2(j) = 1/2*ro*Cd*D*((L21*vx(j)+L22*vy(j))+(C21*ux(j)+C22*uy(j)));
%end

F = [FD1;FD2];
        %CONTINUAR