vx = input('Insira o vetor das velocidades horizontais:');
vy = input('Insira o vetor das velocidades verticais:');
S = cov(vx,vy);
disp ('Matriz S de covariāncias:');
disp (S);

ts = S.';
disp (ts)