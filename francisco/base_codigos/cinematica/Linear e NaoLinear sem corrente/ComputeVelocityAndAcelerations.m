function [Vxaux] = ComputeVelocityAndAcelerations(H, k, d, Zd, NumberOfWaves, Ampw, W, phase)
%Fun��o para oc�lculo das velocidades e acelera��es do fluido

%Vxaux = Ampw*W*exp(k*Zd);

% n = 1;
% 
% while(n <= NumberOfWaves)
%     Vxaux(n) = Ampw(n)*W(n)*exp(k(n)*Zd);
%     
%     %Vx2aux(n) = (H(n)/2)*W(n)*(cosh(k(n)*(Zd + d))/sinh(k(n)*d))*cos(k(n)*pos(1) - W(n)*t + phase(n));
%     
%     n = n + 1;
% end

%Vx = sum(Vxaux);
%Vx2 = nansum(Vx2aux);

end

