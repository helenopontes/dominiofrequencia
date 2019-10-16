%function F = novaforca (vx, vy, ux, uy, vxt, vyt, axt, ayt, ro, Cd, D)
function F = novaforca (ux, uy, vxt, vyt, ro, Cd, D)
%[L,C] = MatrizesLC(vx, vy, ux, uy);
%[L,C] = MatrizesLC(vxt, vyt, zeros(1,size(vxt,2)), zeros(1,size(vxt,2)));

%[L,C] = MatrizesLC(vxt, vyt, ux, uy);
[L,C] = MatrizesLCNovo(vxt, vyt, ux, uy);

% for i=1:size(vx,2)
%     for j=1:size(vy,2)
%         FD1(j) = FD1(j) + 1/2*ro*Cd*D*((L(1,1)*vx(j)+L(1,2)*vy(j))+(C(1,1)*ux(j)+C(1,2)*uy(j)));
%         FD2 = FD2 
%     end
% end
i=0;
for tt=1:1:100
    i=i+1;
    %FD1(i) = 1/2*ro*Cd*D*((L(1,1)*vxt(i)+L(1,2)*vyt(i))+(C(1,1)*axt(i)+C(1,2)*ayt(i)));
    %FD2(i) = 1/2*ro*Cd*D*((L(2,1)*vxt(i)+L(2,2)*vyt(i))+(C(2,1)*axt(i)+C(2,2)*ayt(i)));
    %FD1(i) = 1/2*ro*Cd*D*((L(1,1)*vxt(i)+L(1,2)*vyt(i)));
    %FD2(i) = 1/2*ro*Cd*D*((L(2,1)*vxt(i)+L(2,2)*vyt(i)));
    FD1(i) = 1/2*ro*Cd*D*((L(1,1)*vxt(i)+L(1,2)*vyt(i))+C(1,1)*ux(i));
    FD2(i) = 1/2*ro*Cd*D*((L(2,1)*vxt(i)+L(2,2)*vyt(i))+C(2,2)*uy(i));    
end

%for j=1:size(vx,2)
    %FD1(j) = 1/2*ro*Cd*D*((L11*vx(j)+L12*vy(j))+(C11*ux(j)+C12*uy(j)));
    %FD2(j) = 1/2*ro*Cd*D*((L21*vx(j)+L22*vy(j))+(C21*ux(j)+C22*uy(j)));
%end

F = [FD1;FD2];

        %CONTINUAR