
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
%Cálculo da matriz de covariâncias
% S = cov(vx,vy);
% disp ('Matriz S de covariâncias:');
% disp (S);
%Cálculo da distribuição gaussiana de probabilidades - função P
% Ds = det(S);

F = Forca (vx, vy, ux, uy, ro, Cd, D);
