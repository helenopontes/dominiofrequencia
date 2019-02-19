clear; clc;
% Par�metros de entrada
d = 500;            %L�mina de �gua em metros
Hs = 5;             %Altura significativa em metros da onda irregular
Tp = 8.2;            %Per�odo de pico da onda irregular em segundos
pos = [0,0,-10];	%Posi��o de interesse
% Outras informa��es necess�rias
Wdi = 0;            %Limite inicial para discretizacao do espectro em Hz
Wdf = 1.0;          %Limite final em Hz (Limites do DOOLINES)
g = 9.80665;            %Gravidade em m/s^2
NumberOfWaves = 10;     %N�mero de ondas
gama = 1;           %Parametro de forma para Jonswap
% -------------------------------------------------------------------------
% Processo de c�lculo
[H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves,...
    Wdi, Wdf, Hs, gama);

[L, k] = ComputeLengthOfWave(d, T, NumberOfWaves, g);

% Informa��es para determina��o dos tempos de c�lculo da velocidade e desta
% forma permitir a plotagem do gr�fico de velocidade.
fs = 10;                   %Frequ�ncia de amostragem (amostras/segundo)
Ts = 1/fs;                 %Taxa de amostragem
TempoTotal = 5*T(1)*T(2);       %Tempo total de amostragem
N = TempoTotal*fs;         %N�mero total de c�lculos
n = 0:1:N-1;
%t = 0:Ts:(N-1)*Ts;
i = 1;
for t = 0:Ts:(N-1)*Ts
%C�lculo da velocidade na dire��o x
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
xlabel('Frequ�ncia (Hz)');
ylabel('Magnitude');

%% Verifica��o da rela��o Tp e Hs - JONSWAP
if Tp/sqrt(Hs) < 5 && Tp/sqrt(Hs) > 3.6
    disp('Relacao 3.6 < Tp/sqrt(Hs) < 5.0 satisfeita');
else
    disp('Relacao 3.6 < Tp/sqrt(Hs) < 5.0 nao satisfeita');
end
