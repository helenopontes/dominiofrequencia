function [L,C] = MatrizesLC(vx, vy, ux, uy)
L11=0;
L12=0;
L21=0;
L22=0;
Cx=0;
Cy=0;

S = cov(vx,vy);

%Cálculo dos elementos das matrizes L e C
for i=2:size(vx,2)
    deltavx = vx(i)-vx(i-1);
    for j=2:size(vy,2)
        deltavy = vy(j)-vy(j-1);
        %Matriz L
        L11=L11+2*((((vx(i)+ux(i))^2)+(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
        L12=L12+(((vx(i)+ux(i))+(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
        L21=L21+(((vx(i)+ux(i))+(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
        L22=L22+((((vx(i)+ux(i))^2)+2*(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S)*deltavx*deltavy;
        %Matriz C
        CX=CX+((1/ux(i))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S)*deltavx*deltavy;
        CY=CY+((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S)*deltavx*deltavy;
    end
end
% 
% for i=1:size(vx,2);
%     for j=1:size(vy,2);
%         L12=L12+(((vx(i)+ux(i))+(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%     end
% end
% for i=1:size(vx,2);
%     for j=1:size(vy,2);
%         L21=L21+(((vx(i)+ux(i))+(vy(j)+uy(i)))/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%     end
% end
% for i=1:size(vx,2);
%     for j=1:size(vy,2);
%         L22=L22+((((vx(i)+ux(i))^2)+2*(vy(j)+uy(i))^2)/sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*VP(vx(i),vy(j),S);
%     end
% end

%Cálculo dos elementos da matriz C
% for i=1:size(vx,2);
%     for j=1:size(vy,2);
%         CX=CX+((1/ux(i))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vx(i)+ux(i)))*VP(vx(i),vy(j),S);
%         CY=CY+((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S);
%     end
% end
% for i=1:size(vx,2);
%     for j=1:size(vy,2);
%         CY=CY+((1/uy(j))*(sqrt(((ux(i)+vx(i))^2)+(uy(j)+vy(j))^2))*(vy(j)+uy(j)))*VP(vx(i),vy(j),S);
%     end
% end

L = [L11 L12;L21 L22];
C = [Cx 0;0 Cy];
