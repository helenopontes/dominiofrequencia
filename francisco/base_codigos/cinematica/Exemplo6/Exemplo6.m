clear; clc;
% Parâmetros de entrada
d = 500;            %Lâmina de água em metros
Hs = 5;             %Altura significativa em metros da onda irregular
Tp = 8.2;            %Período de pico da onda irregular em segundos
pos = [0,0,-10];	%Posição de interesse
% Outras informações necessárias
Wdi = 0;            %Limite inicial para discretizacao do espectro em Hz
Wdf = 1.0;          %Limite final em Hz (Limites do DOOLINES)
g = 9.80665;            %Gravidade em m/s^2
NumberOfWaves = 10;     %Número de ondas
gama = 1;           %Parametro de forma para Jonswap
% -------------------------------------------------------------------------
% Processo de cálculo
[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves,...
    Wdi, Wdf, Hs, gama);

[L, k] = ComputeLengthOfWave(d, T, NumberOfWaves, g);

% Informações para determinação dos tempos de cálculo da velocidade e desta
% forma permitir a plotagem do gráfico de velocidade.
fs = 10;                   %Frequência de amostragem (amostras/segundo)
Ts = 1/fs;                 %Taxa de amostragem
TempoTotal = 5*T(1)*T(2);       %Tempo total de amostragem
N = TempoTotal*fs;         %Número total de cálculos
n = 0:1:N-1;
%t = 0:Ts:(N-1)*Ts;
i = 1;
for t = 0:Ts:(N-1)*Ts
%Cálculo da velocidade na direção x
Vxaux = (pi.*H./T).*exp(k*pos(3)).*cos(k*pos(1) - 2*pi*t./T + phase);
Vx(i) = sum(Vxaux,2);
i = i+1;
end

% -------------------------------------------------------------------------
% Plotagem
figure;
t2 = 0:Ts:(N-1)*Ts;
plot(t2,Vx);
xlabel('Tempo(s)');
ylabel('Velocidade (m/s)');
xlim([0 100]);
% -------------------------------------------------------------------------
%% FFT da velocidade
VxFreq = fft(Vx);       %Transformada de Fourier da velocidade
% Magnitude
figure;
VxFreq_mag = abs(VxFreq);
Fbin = 0:1:N-1;
plot((fs/N).*Fbin,VxFreq_mag/(N/2),'linewidth',1);
xlim([0 0.2]);
xlabel('Frequência (Hz)');
ylabel('Magnitude');

%% Verificação da relação Tp e Hs - JONSWAP
if Tp/sqrt(Hs) < 5 && Tp/sqrt(Hs) > 3.6
    disp('Relacao 3.6 < Tp/sqrt(Hs) < 5.0 satisfeita');
else
    disp('Relacao 3.6 < Tp/sqrt(Hs) < 5.0 nao satisfeita');
end
