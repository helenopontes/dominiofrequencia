vx = input('Insira o vetor das velocidades horizontais:');
vy = input('Insira o vetor das velocidades verticais:');
S = cov(vx,vy);
disp ('Matriz S de covariâncias:');
disp (S);

ts = S.';
disp (ts)