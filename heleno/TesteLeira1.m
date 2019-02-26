
%input de dados iniciais
%vx = input('Insira o vetor das velocidades horizontais da onda:');
%vy = input('Insira o vetor das velocidades verticais da onda:');
%ux = input ('Insira o vetor das velocidades horizontais de corrente:');
%uy = input ('Insira o vetor das velocidades verticais de corrente:');
[vx,vy,ax,ay] = onda();
ux = zeros([1,size(vx,2)]);
uy = zeros([1,size(vx,2)]);
%ro = input ('Insira o RhoW');
ro = 1.025;
%Cd = input ('Insira o Cd');
Cd = 1.2;
%D = input ('Insira o D');
D = 0.3048;
%Verificar vetores
[vx,vy,ux,uy] = VerificarVetor(vx,vy,ux,uy);
F = Forca (vx, vy, ux, uy, ro, Cd, D);
