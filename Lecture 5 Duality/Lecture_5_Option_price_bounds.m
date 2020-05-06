clc
clear all

r=1.05;
m=200;
n=7;
V=zeros(m,n); 
V(:,1) = r; 
V(:,2) = linspace(0.5,2,m);
V(:,3) = pos(V(:,2) - 1.1);
V(:,4) = pos(V(:,2) - 1.2);
V(:,5) = pos(0.8-V(:,2));
V(:,6) = pos(0.7-V(:,2));


F=0.9;C=1.15;
V(:,7) = min(max(V(:,2)-1,F-1),C-1);
p = [1; 1; 0.06; 0.03; 0.02; 0.01]; 

cvx_begin
    variables p_collar y(m)
    minimize p_collar
    %maximize p_collar
    y>=0
    V'*y== [p; p_collar]
cvx_end
