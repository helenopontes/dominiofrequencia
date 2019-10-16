global H k d Zd NumberOfWaves Ampw W phase RhoW Cd Di vc B1 B2

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

% Cálculo do sigmaVx - pg57 - Tecnicas de Linearização Arrasto
% "Integração" do autoespectro

DeltaW = (Wdf - Wdi)/NumberOfWaves;

sigmaVxAux = SVx.*DeltaW;

sigmaVx = sqrt(sum(sigmaVxAux));

%Se a velocidade da corrente não for zero:
vc = 2.0;

alfa = vc/sigmaVx;

phiX = (1/sqrt(2*pi))*exp(-(alfa^2)/2);

%syms x           -        Tentando Integrar
%etaa(x) = int((1/sqrt(2*pi))*exp(-(x^2)/2),x,'IgnoreSpecialCases',-100,alfa);

%Processo de "Integração" do etaa - função cumulativa pg56 - Dantas
%Mestrado
%Fiz no maple
etaa = 0.997;

B1 = 4*sigmaVx*phiX + 2*vc*(2*etaa - 1);

B2 = 2*sigmaVx*phiX + vc*(1 + 1/(alfa^2))*(2*etaa - 1);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
Cd = 1.2;
Di = 0.3048;