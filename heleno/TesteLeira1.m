clear;clc;
%input de dados iniciais
%vx = input('Insira o vetor das velocidades horizontais da onda:');
%vy = input('Insira o vetor das velocidades verticais da onda:');
%ux = input ('Insira o vetor das velocidades horizontais de corrente:');
%uy = input ('Insira o vetor das velocidades verticais de corrente:');

%[vx,vy,ax,ay] = onda();
t = 100.0;
%[vx,vy,ax,ay,vxt,vyt,axt,ayt] = novaonda(t);
[vxt,vyt,axt,ayt,H, T, W, phase, Ampw] = novaonda(t);

ux = 2*ones([1,size(vxt,2)]);
uy = 2*ones([1,size(vxt,2)]);

%ro = input ('Insira o RhoW');
ro = 1025;
%Cd = input ('Insira o Cd');
Cd = 1.2;
%D = input ('Insira o D');
D = 0.3048;
%Verificar vetores
%[vx,vy,ux,uy] = VerificarVetor(vx,vy,ux,uy);

%F = Forca (vx, vy, ux, uy, ro, Cd, D);
%F = novaforca (vx, vy, ux, uy, vxt, vyt, axt, ayt, ro, Cd, D);
F = novaforca (ux, uy, vxt, vyt, axt, ayt, ro, Cd, D);
[FdNL,FdL,Vxt]=exemplo1(H, T, W, phase, Ampw);
ttt = 1:1:100;
plot(ttt,FdNL,'b--',ttt,FdL,'r--',ttt,-F(1,:),'k');
legend('FdNL','FdL','FLeira');
xlabel('Tempo (s)');
ylabel('Força (N)');

figure;
plot(ttt,vxt,'r')
hold on;
plot(ttt,Vxt,'b--');
legend('Vx Leira','Vx Francisco');
xlabel('Tempo (s)');
ylabel('Velocidade (m/s)');

% Passando a resposta do domínio da frequência para o tempo:
% Ft = real(ifft(F(1,:)));
% [FdNL,FdL,Vxt]=exemplo1();
% ttt = 1:1:100;
% plot(ttt,FdNL,ttt,FdL,ttt,Ft);
% legend('FdNL','FdL','FLeira');
% figure
% plot(ttt,FdNL,ttt,FdL);
% legend('FdNL','FdL');
% %Comparando as velocidades
% figure;
% vxwt = real(ifft(vx));
% plot(ttt,vxwt,ttt,Vxt);
% legend('vxwt','Vxt');
% VxtW = real(fft(Vxt));