clc
clear all

cvx_begin
    variable x;
    minimize( x^2+1 )
    
    
    subject to              
        (x-2)*(x-4)<=0

cvx_end   

% b section
x_plot = linspace(1,5,1000);

gamma =[-1 0 1 2 3];
C={'b','r','k','m','g'};
for i = 1:5
    plot(x_plot, (1+gamma(i)).*x_plot.^2-6.*gamma(i).*x_plot+8*gamma(i)+1,'color',C{i})
    grid on;hold on
end