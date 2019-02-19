clear;
clc;

t = 0:1/255:1;
x = sin(2*pi*120*t);
y = (ifft(fft(x)));

figure
plot(t,x)

figure
plot(t,y)