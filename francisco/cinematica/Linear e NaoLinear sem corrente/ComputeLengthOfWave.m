function [lambda, k] = ComputeLengthOfWave(d, T, NumberOfWaves, Grav)
%Função para o cálculo dos comprimentos de onda das ondas regulares que
%compoem a onda irregular. Procedimento descrito na norma DNV

for i=1:1:NumberOfWaves
    wn = (4*pi*pi*d)/(Grav*T(i)*T(i));
    f = 1 + 0.666*wn + 0.445*(wn*wn) - 0.105*(wn*wn*wn) + 0.272*(wn*wn*wn*wn);
    
    lambda(i) = T(i)*sqrt(Grav*d)*sqrt(f/(1 + wn*f));
    k(i) = 2*pi/lambda(i);
end

end

