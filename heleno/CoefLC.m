function [CoefL11, CoefL12,CoefL21, CoefL22, CoefC11, CoefC22] = CoefLC (vx,vy,ux,uy)

CoefL11=2*((((vx+ux)^2)+(vy+uy)^2)/sqrt(((ux+vx)^2)+(uy+vy)^2))*VP(vx,vy,S)*deltavx*deltavy;
CoefL12=(((vx+ux)*(vy+uy))/sqrt(((ux+vx)^2)+(uy+vy)^2))*VP(vx,vy,S)*deltavx*deltavy;
CoefL21=(((vx+ux)*(vy+uy))/sqrt(((ux+vx)^2)+(uy+vy)^2))*VP(vx,vy,S)*deltavx*deltavy;
CoefL22=((((vx+ux)^2)+2*(vy+uy)^2)/sqrt(((ux+vx)^2)+(uy+vy)^2))*VP(vx,vy,S)*deltavx*deltavy;
        %Matriz C
CoefC11=((1/ux)*(sqrt(((ux+vx)^2)+(uy+vy)^2))*(vx+ux))*VP(vx,vy,S)*deltavx*deltavy;
CoefC22=((1/uy)*(sqrt(((ux+vx)^2)+(uy+vy)^2))*(vy+uy))*VP(vx,vy,S)*deltavx*deltavy;