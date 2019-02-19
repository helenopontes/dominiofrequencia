function [Sj] = ComputeDensityEnergy(Wd, Hs, Tp, gama)
% Função para o cálculo do espectro de onda de JONSWAP
% S = Valor do espectro de onda na posicao de frequencia desejada Wd
% Wd = frequencia desejada, ponto em que desejasse calcular o espectro

Wp = 1/Tp;  %Frequencia de pico em Hertz (1/s)

sigma = 0.07;

if (Wd > Wp)
    sigma = 0.09;
end

%Variaveis auxiliar para Espectro Pierson Moskowitz (t1,t2,t3,t4)
t1 = (Hs*Hs)*(Wp*Wp*Wp*Wp);
t2 = 1/(Wd*Wd*Wd*Wd*Wd);
t3 = 1/((Wd/Wp)^4);
t4 = exp((-5/4)*t3);

Spm = (5/16)*t1*t2*t4;  %Espectro de Pierson Moskowitz

Agama = 1 - 0.287*log(gama);
aux1 = ((Wd - Wp)/(sigma*Wp))^2;
aux2 = exp(-0.5*aux1);
auxf = gama^aux2;

Sj = Agama*Spm*auxf;
end

