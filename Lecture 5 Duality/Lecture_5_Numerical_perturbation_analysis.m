clc
clear all

cvx_begin
    variable x(2,1);
    dual variables gamma1 gamma2 gamma3
    
    P=[1 0;-1 2];
    minimize( quad_form(x,P)+[-1 0]*x )
    
    
    subject to              
    gamma1:[1 2]*x<=-2
    gamma2:[1 -4]*x<=-3
    gamma3:[-1 -1]*x<=5

cvx_end   

p_opt = cvx_optval;

delta1= [0 0 0 -0.1 -0.1 -0.1 0.1 0.1 0.1];
delta2= [0 -0.1 0.1 0 -0.1 0.1 0 -0.1 0.1];

for i=1:9
    cvx_begin
        variable x(2,1);

        P=[1 0;-1 2];
        minimize( quad_form(x,P)+[-1 0]*x )

        subject to              
        [1 2]*x<=-2+delta1(i)
        [1 -4]*x<=-3+delta2(i)
        [-1 -1]*x<=5

    cvx_end  
    p_exact(i)=cvx_optval;
    p_predict(i)=p_opt-gamma1*delta1(i)-gamma2*delta2(i)
end

dual_gap = p_exact - p_predict
