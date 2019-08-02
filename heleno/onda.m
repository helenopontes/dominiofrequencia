%Programa para c�lculo de par�metros de onda (IRREGULAR sem corrente).
%Francisco de Assis

function [vx,vy,ax,ay] = onda()

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

[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama);

[lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
vc = 2.0;
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
    
    if (isnan(vx(n)))
        vx(n) = 0;
    end
    if (isnan(vy(n)))
        vy(n) = 0;
    end
    if (isnan(ax(n)))
        ax(n) = 0;
    end
    if (isnan(ay(n)))
        ay(n) = 0;
    end
%   vx(n) = Ampw(n)*W(n)*exp(k(n)*Zd);
%   vy(n) = Ampw(n)*W(n)*exp(k(n)*Zd);
%   ax(n) = Ampw(n)*W(n)*W(n)*exp(k(n)*Zd);
%   ay(n) = -Ampw(n)*W(n)*W(n)*exp(k(n)*Zd);
    %FdNL(n) = (RhoW*1000/2)*Cd*Di*abs(Vxaux+vc)*(Vxaux+vc); %Desta forma a resposta sai em Newtons
    %FdL(n) = (RhoW*1000/2)*Cd*Di*sqrt(2/pi)*2*sigmak*Vxaux;
end

%desvio1 = std(FdNL);
%media2 = mean(FdL);
%desvio2 = std(FdL);