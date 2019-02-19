%Programa para cálculo de parâmetros de onda (IRREGULAR sem corrente).
%Francisco de Assis

clear;
clc;

%Parâmetros de Entrada:
d = 500;                %Lâmina de água em metros
ang = 0;                %Ângulo de incidência da onda em graus
Tz = 9.6;               %Calcular o Tp pela pg 34
% Tp = 9.2;                 %Período de pico em segundos

Tp = Tz/sqrt(6/12);

Hs = 7.6;                 %Altura significativa em metros
RhoW = 1.025;           %Densidade da água em g/cm^3
Grav = 9.80665;         %Gravidade em m/s^2
NumberOfWaves = 100;     %Número de ondas
gama = 1.0;             %Parametro de forma para Jonswap
pos = [0,0,-10];          %Posição de interesse da superficie de elevacao

Wdi = 0.01;     %Limite inicial para discretizacao do espectro em Hz
Wdf = 2.0;      %Limite final em Hz

Zd = -10;        %Profundidade em que se deseja saber os espectros de velocidade


% w = 0:0.01:1;
% for i=1:1:101
%     Wd = (i-1)/100;
%     Sj(i) = ComputeDensityEnergy(Wd,Hs,Tp,gama);
% end

[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama);

[lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav);

% [SVx] = ComputeVelocitySpectrum(W, k, d, Zd, NumberOfWaves, Hs, Tp, gama);
% 
% % Cálculo do sigmaVx - pg57 - Tecnicas de Linearização Arrasto
% % "Integração" do autoespectro
% 
% DeltaW = (Wdf - Wdi)/NumberOfWaves;
% 
% sigmaVxAux = SVx.*DeltaW;
% 
% sigmaVx = sqrt(sum(sigmaVxAux));
% 
% % Se Ux for 0, ou seja, não tiver corrente. Então:
% 
% phiX = 1/sqrt(2*pi);
% 
% B1 = 4*sigmaVx*phiX;
% 
% B2 = 2*sigmaVx*phiX;

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
vc = 0.0;
Cd = 1.2;
Di = 0.3048;

t=1;
n = 1;

while (n <= NumberOfWaves)
    Vxaux2 = Ampw(n)*W(n)*exp(k(n)*Zd);
    Vx2(n) = Vxaux2;
    n = n+1;
end
sigmak = sqrt(sum(Vx2));
n = 1;

while (n <= NumberOfWaves)
    
    %[Vx] = ComputeVelocityAndAcelerations(H(n), k(n), d, Zd, NumberOfWaves, Ampw(n), W(n), phase(n));
    Vxaux = Ampw(n)*W(n)*exp(k(n)*Zd);
    Vx(n) = Vxaux;
    FdNL(n) = (RhoW*1000/2)*Cd*Di*abs(Vxaux+vc)*(Vxaux+vc); %Desta forma a resposta sai em Newtons
    FdL(n) = (RhoW*1000/2)*Cd*Di*sqrt(2/pi)*2*sigmak*Vxaux;
    
    n = n + 1;

end


media1 = mean(FdNL);
desvio1 = std(FdNL);
media2 = mean(FdL);
desvio2 = std(FdL);