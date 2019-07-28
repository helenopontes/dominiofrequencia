function [vx,vy,ax,ay,vxt,vyt,axt,ayt] = onda(t)

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

[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama);

[lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav);

%Considerando pw = 1.025 g/cm3, Cd = 0.7, D = 0.5 metros, vc = 2 m/s
vc = 2.0;
Cd = 1.2;
Di = 0.3048;

t=1;
n = 1;
x = 0;

%while (n <= NumberOfWaves)
for tt=0:1:100
    vxt(tt)=0;
    vyt(tt)=0;
    axt(tt)=0;
    ayt(tt)=0;
    
    for n=1:NumberOfWaves
        vxt(n) = Ampw(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d)*cos(k*t+W(n)*t);
        axt(n) = Ampw(n)*W(n)*W(n)*cosh(k(n)*(Zd+d))/sinh(k(n)*d)*sin(k*t+W(n)*t);
        vyt(n) = Ampw(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d)*sin(k*t+W(n)*t);
        ayt(n) = Ampw(n)*W(n)*W(n)*sinh(k(n)*(Zd+d))/sinh(k(n)*d)*cos(k*t+W(n)*t);
    
        if (isnan(vxt(n)))
            vxt(n) = 0;
        end
        
        if (isnan(vyt(n)))
            vyt(n) = 0;
        end
        
        if (isnan(axt(n)))
            axt(n) = 0;
        end
        
        if (isnan(ayt(n)))
            ayt(n) = 0;
        end
        
        vxt = vxt(tt)+vxt(n);
        vyt = vyt(tt)+vyt(n);
        axt = axt(tt)+axt(n);
        ayt = ayt(tt)+ayt(n);
        
    end      

end
