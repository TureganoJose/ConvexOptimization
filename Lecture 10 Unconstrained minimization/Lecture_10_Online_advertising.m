clear all
clc

% data for online ad display problem
rand('state',0);
n=100;      %number of ads
m=30;       %number of contracts
T=60;       %number of periods

I=10*rand(T,1);  %number of impressions in each period
R=rand(n,T);    %revenue rate for each period and ad
q=T/n*50*rand(m,1);     %contract target number of impressions
p=rand(m,1);  %penalty rate for shortfall
Tcontr=(rand(T,m)>.8); %one column per contract. 1's at the periods to be displayed
for i=1:n
	contract=ceil(m*rand);
	Acontr(i,contract)=1; %one column per contract. 1's at the ads to be displayed
end




cvx_begin
    variable N(n,T)  
	for jContr =1:m
        contract_obligations =0;%Reset after each contract
        for iAd=1:n
            for iT=1:T
                if(Tcontr(iT, jContr)==1 && Acontr(iAd, jContr)==1)
                    contract_obligations=contract_obligations+N(iAd,iT);
                end
            end
        end
        s(jContr)=max(q(jContr)-contract_obligations,0)*p(jContr);
  	end
    maximize (sum(sum(R.*N))-sum(s))
    subject to
        ones(1,100)*N==I'
        N>=0
cvx_end

fprintf('net profit %f revenue %f penalty %f \n',cvx_optval,sum(sum(R.*N)),sum(s)   )


clear s contract_obligations N

cvx_begin
    variable N(n,T)  
    maximize (sum(sum(R.*N)))
    subject to
        ones(1,100)*N==I'
        N>=0
cvx_end

for jContr =1:m
    contract_obligations =0;%Reset after each contract
    for iAd=1:n
        for iT=1:T
            if(Tcontr(iT, jContr)==1 && Acontr(iAd, jContr)==1)
                contract_obligations=contract_obligations+N(iAd,iT);
            end
        end
    end
    s(jContr)=max(q(jContr)-contract_obligations,0)*p(jContr);
end

fprintf('net profit %f revenue %f penalty %f \n',sum(sum(R.*N))-sum(s),sum(sum(R.*N)),sum(s)   )



