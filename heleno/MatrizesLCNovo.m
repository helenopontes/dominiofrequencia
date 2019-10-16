function [L,C] = MatrizesLCNovo(vx, vy, ux, uy)
L11=0;
L12=0;
L21=0;
L22=0;
Cx=0;
Cy=0;

S = cov(vx,vy);

setGlobalS(S);

%Novo Cálculo
% [Vx,Vy] = meshgrid(vx,vy);
% 
% CL11 = 2*((((Vx+2).^2)+(Vy+2).^2)./sqrt(((2+Vx).^2)+(2+Vy).^2)).*VP(Vx,Vy,S);
% CL12 =(((Vx+2).*(Vy+2))./sqrt(((2+Vx).^2)+(2+Vy).^2)).*VP(Vx,Vy,S);
% CL21 =(((Vx+2).*(Vy+2))./sqrt(((2+Vx).^2)+(2+Vy).^2)).*VP(Vx,Vy,S);
% CL22 =((((Vx+2).^2)+2*(Vy+2).^2)./sqrt(((2+Vx).^2)+(2+Vy).^2)).*VP(Vx,Vy,S);
% %Matriz C
% CCx =((1/2)*(sqrt(((2+Vx).^2)+(2+Vy).^2))*(Vx+2)).*VP(Vx,Vy,S);
% CCy =((1/2)*(sqrt(((2+Vx).^2)+(2+Vy).^2))*(Vy+2)).*VP(Vx,Vy,S);

for i=1:size(vx,2)
    for j=1:size(vy,2)
        %Matriz L
        CL11(i,j) = 2*((((vx(i)+ux(i))^2)+(vy(j)+uy(j))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
        CL12(i,j)=(((vx(i)+ux(i))*(vy(j)+uy(j)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
        CL21(i,j)=(((vx(i)+ux(i))*(vy(j)+uy(j)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
        CL22(i,j)=((((vx(i)+ux(i))^2)+2*(vy(j)+uy(j))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
        %Matriz C
        CCx(i,j)=((1/ux(i))*(sqrt(((ux(i)+vx(j))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S);
        CCy(i,j)=((1/uy(j))*(sqrt(((ux(i)+vx(j))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S);
    end
end


L11 = trapz(vy,trapz(vx,CL11,2));
L12 = trapz(vy,trapz(vx,CL12,2));
L21 = trapz(vy,trapz(vx,CL21,2));
L22 = trapz(vy,trapz(vx,CL22,2));

Cx = trapz(vy,trapz(vx,CCx,2));
Cy = trapz(vy,trapz(vx,CCy,2));

L = [L11 L12;L21 L22];
C = [Cx 0;0 Cy];