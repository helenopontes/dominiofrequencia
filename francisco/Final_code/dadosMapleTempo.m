function x = dadosMapleTempo()
i = 0;
for t = 0:0.0025:1.2775
    i = i+1;
if t<1/40
    x(i) = -(491/2477500)*exp(-6*t)*sin(2*sqrt(991)*t)*sqrt(991)+(3/2500)*exp(-6*t)*cos(2*sqrt(991)*t)+(2/5)*t-3/2500;
elseif t<1/20
    x(i) = -(491/2477500)*exp(-6*t)*sin(2*sqrt(991)*t)*sqrt(991)+(3/2500)*exp(-6*t)*cos(2*sqrt(991)*t)-(2/5)*t+53/2500-(3/1250)*exp(-6*t+3/20)*cos(2*sqrt(991)*t-(1/20)*sqrt(991))+(491/1238750)*sqrt(991)*exp(-6*t+3/20)*sin(2*sqrt(991)*t-(1/20)*sqrt(991));
else
    x(i) = -(491/2477500)*exp(-6*t)*sin(2*sqrt(991)*t)*sqrt(991)+(3/2500)*exp(-6*t)*cos(2*sqrt(991)*t)-(3/1250)*exp(-6*t+3/20)*cos(2*sqrt(991)*t-(1/20)*sqrt(991))+(3/2500)*exp(-6*t+3/10)*cos(2*sqrt(991)*t-(1/10)*sqrt(991))+(491/1238750)*sqrt(991)*exp(-6*t+3/20)*sin(2*sqrt(991)*t-(1/20)*sqrt(991))-(491/2477500)*sqrt(991)*exp(-6*t+3/10)*sin(2*sqrt(991)*t-(1/10)*sqrt(991));
end
end