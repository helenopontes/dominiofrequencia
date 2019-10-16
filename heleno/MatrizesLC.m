function [L,C] = MatrizesLC(vx, vy, ux, uy)
L11=0;
L12=0;
L21=0;
L22=0;
Cx=0;
Cy=0;

S = cov(vx,vy);

setGlobalS(S);

svx = size(vx,2);
% %Cálculo dos elementos das matrizes L e C
% for i=2:size(vx,2)-1
%     deltavx = (vx(i)-vx(i-1));
%     for j=2:size(vy,2)-1
%         deltavy = (vy(j)-vy(j-1));
%         %Matriz L
%         L11=L11+2*((((vx(i)+ux(i))^2)+(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%         L12=L12+(((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%         L21=L21+(((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%         L22=L22+((((vx(i)+ux(i))^2)+2*(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%         %Matriz C
%         Cx=Cx+((1/ux(i))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%         Cy=Cy+((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S)*deltavx*deltavy;
%     end
% end
% L11 = L11 +(1/2)*((2*((((vx(svx)+ux(svx))^2)+(vy(svx)+uy(svx))^2)/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S)) +(2*((((vx(1)+ux(1))^2)+(vy(1)+uy(1))^2)/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S)))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
% L12=L12+(1/2)*((((vx(svx)+ux(svx))*(vy(svx)+uy(svx)))/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + (((vx(1)+ux(1))*(vy(1)+uy(1)))/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
% L21=L21+(1/2)*((((vx(svx)+ux(svx))*(vy(svx)+uy(svx)))/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + (((vx(1)+ux(1))*(vy(1)+uy(1)))/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
% L22=L22+ (1/2)*(((((vx(svx)+ux(svx))^2)+2*(vy(svx)+uy(svx))^2)/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + ((((vx(1)+ux(1))^2)+2*(vy(1)+uy(1))^2)/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
% Cx=Cx+ (1/2)*(((1/ux(svx))*(sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*(vx(svx)+ux(svx)))*VP(vx(svx),vy(svx),S) + ((1/ux(1))*(sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*(vx(1)+ux(1)))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
% Cy=Cy+ (1/2)*(((1/uy(svx))*(sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*(vy(svx)+uy(svx)))*VP(vx(svx),vy(svx),S) + ((1/uy(1))*(sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*(vy(1)+uy(1)))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=2:size(vx,2)-1
    deltavx = (vx(i)-vx(i-1));
    for j=2:size(vy,2)-1
        deltavy = (vy(j)-vy(j-1));
        %Matriz L
        L11=L11+(1/2)*(2*((((vx(i)+ux(i))^2)+(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S))*deltavx*deltavy;
        L12=L12+(1/2)*((((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S))*deltavx*deltavy;
        L21=L21+(1/2)*((((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S))*deltavx*deltavy;
        L22=L22+(1/2)*(((((vx(i)+ux(i))^2)+2*(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S))*deltavx*deltavy;
        %Matriz C
        Cx=Cx+(1/2)*(((1/ux(i))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S))*deltavx*deltavy;
        Cy=Cy+(1/2)*(((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S))*deltavx*deltavy;
    end
end
L11 = L11 +(1/2)*((2*((((vx(svx)+ux(svx))^2)+(vy(svx)+uy(svx))^2)/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S)) +(2*((((vx(1)+ux(1))^2)+(vy(1)+uy(1))^2)/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S)))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
L12=L12+(1/2)*((((vx(svx)+ux(svx))*(vy(svx)+uy(svx)))/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + (((vx(1)+ux(1))*(vy(1)+uy(1)))/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
L21=L21+(1/2)*((((vx(svx)+ux(svx))*(vy(svx)+uy(svx)))/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + (((vx(1)+ux(1))*(vy(1)+uy(1)))/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
L22=L22+ (1/2)*(((((vx(svx)+ux(svx))^2)+2*(vy(svx)+uy(svx))^2)/sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*VP(vx(svx),vy(svx),S) + ((((vx(1)+ux(1))^2)+2*(vy(1)+uy(1))^2)/sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
Cx=Cx+ (1/2)*(((1/ux(svx))*(sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*(vx(svx)+ux(svx)))*VP(vx(svx),vy(svx),S) + ((1/ux(1))*(sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*(vx(1)+ux(1)))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
Cy=Cy+ (1/2)*(((1/uy(svx))*(sqrt(((ux(svx)+vx(svx))^2)+(uy(svx)+vy(svx))^2))*(vy(svx)+uy(svx)))*VP(vx(svx),vy(svx),S) + ((1/uy(1))*(sqrt(((ux(1)+vx(1))^2)+(uy(1)+vy(1))^2))*(vy(1)+uy(1)))*VP(vx(1),vy(1),S))*((vx(svx)-vx(1)))*((vy(svx)-vy(1)));
%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Novo Cálculo
% for i=1:size(vx,2)
%     for j=1:size(vy,2)
%         %Matriz L
%         CL11(j) = 2*((((vx(i)+ux(i))^2)+(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%         CL12(j)=(((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%         CL21(j)=(((vx(i)+ux(i))*(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%         CL22(j)=((((vx(i)+ux(i))^2)+2*(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%         %Matriz C
%         CCx(j)=((1/ux(i))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S);
%         CCy(j)=((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S);
%     end
%     YL11(i) = trapz(vy,CL11);
%     YL12(i) = trapz(vy,CL12);
%     YL21(i) = trapz(vy,CL21);
%     YL22(i) = trapz(vy,CL22);
%     
%     YCx(i) = trapz(vy,CCx);
%     YCy(i) = trapz(vy,CCy);
% end
% 
% L11 = trapz(vx,YL11);
% L12 = trapz(vx,YL12);
% L21 = trapz(vx,YL21);
% L22 = trapz(vx,YL22);
% 
% Cx = trapz(vx,YCx)
% Cy = trapz(vx,YCy)

% %Novo Cálculo2
% L11 = dblquad(@CL11,1,100,1,100);
% L12 = dblquad(@CL12,1,100,1,100);
% L21 = dblquad(@CL21,1,100,1,100);
% L22 = dblquad(@CL22,1,100,1,100);
% 
% Cx = dblquad(@CCx,1,100,1,100);
% Cy = dblquad(@CCy,1,100,1,100);


L = [L11 L12;L21 L22];
C = [Cx 0;0 Cy];
