function [H, T, W, phase, Ampw] = CreateComponentsOfWaves(Tp, NumberOfWaves, Wdi, Wdf, Hs, gama)
% Função para criar compinentes das ondas regulares que compoem a onda
% irregular, ou seja, em cada ponto do espectro.
DeltaW = (Wdf - Wdi)/NumberOfWaves;
Wp = 1/Tp;
numWaves = 1;
freq = Wdi;

while (numWaves <= NumberOfWaves)
    RandNumber = (1/32767)*(randi(32767));
    W(numWaves) = freq + DeltaW/2;
    phase(numWaves) = RandNumber*2*pi;  %Em radianos
    
    Sj = ComputeDensityEnergy(W(numWaves), Hs, Tp, gama);
    
    Area = Sj*DeltaW;
    
    H(numWaves) = sqrt(2*Area)*2;
    Ampw(numWaves) = H(numWaves)/2;
    T(numWaves) = 1/W(numWaves);
    
    freq = freq + DeltaW;
    numWaves = numWaves + 1;      
end

for i = 1:1:NumberOfWaves
    W(i) = W(i)*2*pi;   %Passando para rad/s
end

Wp = 2*pi*Wp;

end

