
%input de dados iniciais
vx = input('Insira o vetor das velocidades horizontais da onda:');
vy = input('Insira o vetor das velocidades verticais da onda:');
ux = input ('Insira o vetor das velocidades horizontais de corrente:');
uy = input ('Insira o vetor das velocidades verticais de corrente:');
ro = input ('Insira o');
Cd = input ('Insira o');
D = input ('Insira o');
%Verificar vetores
[vx,vy,ux,uy] = VerificarVetor(vx,vy,ux,uy);
%C�lculo da matriz de covari�ncias
% S = cov(vx,vy);
% disp ('Matriz S de covari�ncias:');
% disp (S);
%C�lculo da distribui��o gaussiana de probabilidades - fun��o P
% Ds = det(S);

F = Forca (vx, vy, ux, uy, ro, Cd, D);
