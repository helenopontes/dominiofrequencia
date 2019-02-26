%Programa para cálculo de parâmetros de onda (IRREGULAR sem corrente).
%Francisco de Assis
function [vx,vy,ax,ay] = onda()

%Parâmetros de Entrada:
d = 735;                %Lâmina de água em metros
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

[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama);

[lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
vc = 0.0;
Cd = 1.2;
Di = 0.3048;

t=1;
n = 1;

%while (n <= NumberOfWaves)
for n=1:NumberOfWaves
    vx(n) = Ampw(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d);
    ax(n) = Ampw(n)*W(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d);
    vy(n) = Ampw(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d);	
	ay(n) = Ampw(n)*W(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d);	
    %FdNL(n) = (RhoW*1000/2)*Cd*Di*abs(Vxaux+vc)*(Vxaux+vc); %Desta forma a resposta sai em Newtons
    %FdL(n) = (RhoW*1000/2)*Cd*Di*sqrt(2/pi)*2*sigmak*Vxaux;
end


disp('onda!!');
%desvio1 = std(FdNL);
%media2 = mean(FdL);
%desvio2 = std(FdL);