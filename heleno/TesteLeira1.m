
%input de dados iniciais
%vx = input('Insira o vetor das velocidades horizontais da onda:');
%vy = input('Insira o vetor das velocidades verticais da onda:');
%ux = input ('Insira o vetor das velocidades horizontais de corrente:');
%uy = input ('Insira o vetor das velocidades verticais de corrente:');
[vx,vy,ax,ay] = onda();
ux = 2*ones([1,size(vx,2)]);
uy = 2*ones([1,size(vx,2)]);
%ro = input ('Insira o RhoW');
ro = 1025;
%Cd = input ('Insira o Cd');
Cd = 1.2;
%D = input ('Insira o D');
D = 0.3048;
%Verificar vetores
[vx,vy,ux,uy] = VerificarVetor(vx,vy,ux,uy);
F = Forca (vx, vy, ux, uy, ro, Cd, D);
% Passando a resposta do domínio da frequência para o tempo:
Ft = real(ifft(F(1,:)));

%Fim do testeleira1
[FdNL,FdL,Vxt]=exemplo1();
ttt = 1:1:100;
plot(ttt,FdNL,ttt,FdL,ttt,Ft);
legend('FdNL','FdL','FLeira');
figure;
plot(ttt,FdNL,ttt,FdL);
legend('FdNL','FdL');
%Comparando as velocidades
figure;
vxwt = real(ifft(vx));
plot(ttt,vxwt,ttt,Vxt);
legend('vxwt','Vxt');
VxtW = real(fft(Vxt));