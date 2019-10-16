%function [vx,vy,ax,ay,vxt,vyt,axt,ayt] = novaonda(t)
%function [vxt,vyt,axt,ayt,H, T, W, phase, Ampw] = novaonda(t)
function [vxt,vyt] = novaonda(t)

%Parâmetros de Entrada:
d = 500;                %Lâmina de água em metros
ang = 0;                %Ângulo de incidência da onda em graus
Tz = 9.6;               %Calcular o Tp pela pg 34
% Tp = 9.2;                 %Período de pico em segundos

Tp = Tz/sqrt(6/12);

Hs = 7.6;                 %Altura significativa em metros
%RhoW = 1.025;           %Densidade da água em g/cm^3
Grav = 9.80665;         %Gravidade em m/s^2
NumberOfWaves = 100;     %Número de ondas
gama = 1.0;             %Parametro de forma para Jonswap
pos = [0,0,-10];          %Posição de interesse da superficie de elevacao

Wdi = 0.01;     %Limite inicial para discretizacao do espectro em Hz
Wdf = 2.0;      %Limite final em Hz

Zd = -10;        %Profundidade em que se deseja saber os espectros de velocidade

[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama);

[lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
vc = 2.0;
Cd = 1.2;
Di = 0.3048;

x = 0;

i=0;
% for tt=1:1:t
%     i=i+1;
%     vxt(i)=0;
%     vyt(i)=0;
%     axt(i)=0;
%     ayt(i)=0;
%     
%     for n=1:NumberOfWaves
%         if tt==1
%             vx(n) = Ampw(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d);
%             ax(n) = Ampw(n)*W(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d);
%             vy(n) = Ampw(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d);
%             ay(n) = Ampw(n)*W(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d);
%             if (isnan(vx(n)))
%                 vx(n) = 0;
%             end
%             if (isnan(vy(n)))
%                 vy(n) = 0;
%             end
%             if (isnan(ax(n)))
%                 ax(n) = 0;
%             end    
%             if (isnan(ay(n)))
%                 ay(n) = 0;
%             end
%         end
% %         Vxt = Ampw(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d)*cos(k(n)*x-W(n)*tt);
%          Axt = Ampw(n)*W(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d)*sin(k(n)*x-W(n)*tt);
% %         Vyt = Ampw(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d)*sin(k(n)*x-W(n)*tt);
%          Ayt = -Ampw(n)*W(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d)*cos(k(n)*x-W(n)*tt);
%         Vxt = (pi*H(n)/T(n))*exp(k(n)*Zd)*cos(k(n)*x-W(n)*tt);
%         Vyt = (pi*H(n)/T(n))*exp(k(n)*Zd)*sin(k(n)*x-W(n)*tt);
%     
% %         if (isnan(Vxt))
% %             Vxt = 0;
% %         end
%         
% %         if (isnan(Vyt))
% %             Vyt = 0;
% %         end
%         
%         if (isnan(Axt))
%             Axt = 0;
%         end
%         
%         if (isnan(Ayt))
%             Ayt = 0;
%         end
%         
%         vxt(i) = vxt(i)+Vxt;
%         vyt(i) = vyt(i)+Vyt;
%         axt(i) = axt(i)+Axt;
%         ayt(i) = ayt(i)+Ayt;
%         
%     end      
% 
% end

setGlobalWave(H, T, k, d, Zd, NumberOfWaves, Ampw, W, phase, pos);

for tt=1:1:t
    [Vx,Vy] = ComputeVelocityAndAcelerations1(tt,tt);
    vxt(tt) = Vx;
    vyt(tt) = Vy;
    %axt(tt) = 0; %Falta a implementação dos cálculos
    %ayt(tt) = 0;
end
