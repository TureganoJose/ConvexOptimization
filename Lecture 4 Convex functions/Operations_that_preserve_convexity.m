
x=-100:1:100;
figure(5)
plot(x,exp(-x))




figure(1)
for a=-100:1:0
    plot(x, exp(-a.*sqrt(x)),'b')
    hold on
end

figure(2)
for a=0:0.1:100
    plot(x, exp(-a.*sqrt(x)),'r')
    hold on
end

figure(3)
for a=-1:0.001:1
    plot(x, exp(-a.*sqrt(x)),'g')
    hold on
end

figure(4)
for a=-100:0.1:-1
    plot(x, exp(-a.*sqrt(x)),'m')
    hold on
end