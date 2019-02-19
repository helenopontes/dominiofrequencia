%Programa para c�lculo de par�metros de onda (IRREGULAR sem corrente).
%Francisco de Assis

clear;
clc;

%Par�metros de Entrada:
d = 500;                %L�mina de �gua em metros
ang = 0;                %�ngulo de incid�ncia da onda em graus
Tz = 9.6;               %Calcular o Tp pela pg 34
% Tp = 9.2;                 %Per�odo de pico em segundos

Tp = Tz/sqrt(6/12);

Hs = 7.6;                 %Altura significativa em metros
RhoW = 1.025;           %Densidade da �gua em g/cm^3
Grav = 9.80665;         %Gravidade em m/s^2
NumberOfWaves = 100;     %N�mero de ondas
gama = 1.0;             %Parametro de forma para Jonswap
pos = [0,0,-10];          %Posi��o de interesse da superficie de elevacao

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

[SVx] = ComputeVelocitySpectrum(W, k, d, Zd, NumberOfWaves, Hs, Tp, gama);

% C�lculo do sigmaVx - pg57 - Tecnicas de Lineariza��o Arrasto
% "Integra��o" do autoespectro

DeltaW = (Wdf - Wdi)/NumberOfWaves;

sigmaVxAux = SVx.*DeltaW;

sigmaVx = sqrt(sum(sigmaVxAux));

%Se a velocidade da corrente n�o for zero:
vc = 2.0;

alfa = vc/sigmaVx;

phiX = (1/sqrt(2*pi))*exp(-(alfa^2)/2);

%syms x           -        Tentando Integrar
%etaa(x) = int((1/sqrt(2*pi))*exp(-(x^2)/2),x,'IgnoreSpecialCases',-100,alfa);

%Processo de "Integra��o" do etaa - fun��o cumulativa pg56 - Dantas
%Mestrado
%Fiz no maple
etaa = 0.997;

B1 = 4*sigmaVx*phiX + 2*vc*(2*etaa - 1);

B2 = 2*sigmaVx*phiX + vc*(1 + 1/(alfa^2))*(2*etaa - 1);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
Cd = 1.2;
Di = 0.3048;

t=1;

while (t <= 1000)
    
    [Vx] = ComputeVelocityAndAcelerations(H, k, d, Zd, NumberOfWaves, Ampw, W, phase, t, pos);
    Vxt(t) = Vx;
    FdNL(t) = (RhoW*1000/2)*Cd*Di*abs(Vx+vc)*(Vx+vc); %Desta forma a resposta sai em Newtons
    FdL(t) = (RhoW*1000/2)*Cd*Di*(B1*Vx + B2*vc);
    
    t = t + 1;

end


media1 = mean(FdNL);
desvio1 = std(FdNL);
media2 = mean(FdL);
desvio2 = std(FdL);