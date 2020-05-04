clc
clear all

rng(0,'v5uniform');
n=100;
m=300;
A=rand(m,n);
b=A*ones(n,1)/2;
c=-rand(n,1);


cvx_begin
    variable x(n);
  
    minimize( c' * x )

    subject to              
    A*x <= b
    0<=x<=1

cvx_end   

counter=1;

for t=linspace(0,1,100)
    x_boolean = zeros(n,1);
    x_boolean(x>=t)=1;
    objective(counter) = c'*x_boolean;
    max_violation(counter) = max( A*x_boolean - b);
    
    counter = counter + 1;
end

U = min(objective(find(max_violation<=0)));

L = cvx_optval;

gap = U - L;