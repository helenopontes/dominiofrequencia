% Cálculo de resposta no domínio do tempo a partir de cálculo feito no
% domínio da frequência.

clear;
clc;

%Número de pontos:
N = 512;

%Intervalo de tempo:
DeltaT = 0.0025;

%Comprimento do intervalo de truncamento:
Tp = DeltaT*N;

%Intervalo de separação:
DeltaW = 2*pi/Tp;

n = 0:1:N-1;

t = n*DeltaT;

p1 = 0:40:400;
p2 = 360:-40:0;
p3 = zeros(1,491);
p4 = horzcat(p1, p2);
p = horzcat(p4, p3);
% p = [p1 p2 p3]

%Passando o carregamento que encotra-se no domínio do tempo para a freque
Pw = fft(p);

% Tabela de frequências discretas
m = 0:1:N-1;
mim1 = 0:1:N/2;
mim2 = -(N/2 - 1):+1:-1;
mim = horzcat(mim1, mim2);
wm = mim*DeltaW;

% Dados da estrutra 1gl:
% Massa:
MM = 10000/1000;

% Rigidez:
KK = 40000;

% Amortecimento:
CC = 120;


% Calculando a função complexa de resposta na frequência H(w):
Hw = 1./(-wm.*wm*MM + KK + 1i*wm*CC);

%Deslocamento:
Vw = Pw.*Hw;

% Passando a resposta do domínio da frequência para o tempo:
%Vt = real(ifft(Vw));
Vt = ifft(Vw);
xTempo = dadosMapleTempo();

figure1 = figure;
axes1 = axes('Parent',figure1);
plot(t,Vt,t,xTempo,'--k','linewidth',1.5)
xlabel('Time (s)','FontName','Bookman Old Style');
ylabel('Displacement (m)','FontName','Bookman Old Style');
xlim([0 0.4])
grid on
set(axes1,'FontName','Bookman Old Style','FontSize',14);
legend('Frequency domain', 'Time domain')


figure2 = figure;
axes2 = axes('Parent',figure2);
plot(t,p,'linewidth',1.5)
xlabel('Tempo (s)','FontName','Bookman Old Style');
ylabel('Força (kN)','FontName','Bookman Old Style');
xlim([0 0.06])
grid on
set(axes2,'FontName','Bookman Old Style','FontSize',14);








