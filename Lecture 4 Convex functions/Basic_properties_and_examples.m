clear all
s
x=-100:0.1:-1.99;
f = (x.^2 +1 )./(x+2);
figure(1)
plot(x,f)
grid on

clear x f
x=-0.999:0.001:0.999;
f = 1./(1-x.^2);
figure(2)
plot(x,f)
grid on

clear x f
x=-100:1:100;
f = cosh(x);
figure(3)
plot(x,f)
grid on