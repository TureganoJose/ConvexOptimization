clc
clear all

%% No constrains
n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;


cvx_begin
    variable x(n);
  
    minimize( x'* S * x )

    subject to              
    pbar'*x == pbar'*x_unif
    ones(n,1)'*x==1
    %x>=0

cvx_end   

%Risk measured as standard deviation hence the square root
Simple_portfolio_risk = sqrt(x_unif' * S * x_unif)

Opt_portfolio_risk_no_constrains = sqrt(cvx_optval)



%% Long term
clear all

n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;

cvx_begin
    variable x(n);
  
    minimize( x'* S * x )

    subject to              
    pbar'*x == pbar'*x_unif
    ones(n,1)'*x==1
    x>=0

cvx_end  


Opt_portfolio_risk_long_only = sqrt(cvx_optval)

%% short term constrain
clear all

n=20;
rng(5,'v5uniform');
pbar = ones(n,1)*.03+[rand(n-1,1); 0]*.12;
rng(5,'v5normal');
S = randn(n,n);
S = S'*S;
S = S/max(abs(diag(S)))*.2;
S(:,n) = zeros(n,1);
S(n,:) = zeros(n,1)';
x_unif = ones(n,1)/n;

cvx_begin
    variable x(n);
  
    minimize( x'* S * x )

    subject to              
    pbar'*x == pbar'*x_unif
    ones(n,1)'*x==1
    ones(n,1)'*max([-x zeros(n,1)],[],2)<=0.5

cvx_end  


Opt_portfolio_risk_short = sqrt(cvx_optval)