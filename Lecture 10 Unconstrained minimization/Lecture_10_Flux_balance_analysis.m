clear all; clc; close all;

% data file for flux balance analysis in systems biology
% From Segre, Zucker et al "From annotated genomes to metabolic flux
% models and kinetic parameter fitting" OMICS 7 (3), 301-316. 

% Stoichiometric matrix
S = [
%	M1	M2	M3	M4	M5	M6	
	1	0	0	0	0	0	%	R1:  extracellular -->  M1
	-1	1	0	0	0	0	%	R2:  M1 -->  M2
	-1	0	1	0	0	0	%	R3:  M1 -->  M3
	0	-1	0	2	-1	0	%	R4:  M2 + M5 --> 2 M4
	0	0	0	0	1	0	%	R5:  extracellular -->  M5
	0	-2	1	0	0	1	%	R6:  2 M2 -->  M3 + M6
	0	0	-1	1	0	0	%	R7:  M3 -->  M4
	0	0	0	0	0	-1	%	R8:  M6 --> extracellular
	0	0	0	-1	0	0	%	R9:  M4 --> cell biomass
	]';

[m,n] = size(S);
vmax = [
	10.10;	% R1:  extracellular -->  M1
	100;	% R2:  M1 -->  M2
	5.90;	% R3:  M1 -->  M3
	100;	% R4:  M2 + M5 --> 2 M4
	3.70;	% R5:  extracellular -->  M5
	100;	% R6:  2 M2 --> M3 + M6
	100;	% R7:  M3 -->  M4
	100;	% R8:  M6 -->  extracellular
	100;	% R9:  M4 -->  cell biomass
	];

cvx_begin
    variables v(9);
    dual variable gamma;
    cvx_quiet(true)
    maximize v(9)
    subject to
        gamma: v <= vmax
        v >= 0
        S*v == 0
cvx_end

max_growth = cvx_optval;
%% Essential genes
for ireact = 1:9
    cvx_begin
        variables v(9)
        cvx_quiet(true)
        maximize v(9)
        subject to
            v <= vmax
            v >= 0
            S*v == 0
            v(ireact) == 0 % killing reaction how it affects growth rate
    cvx_end
    if(cvx_optval<0.2*max_growth) %if below this threshold then it's esssential
        fprintf('Gene %d is essential \n',ireact)
    end
end


%% Lethal genes

for ireact = 2:8
    for jreact = 2:8 % terrible looping skills On2
        if ireact~=jreact
            cvx_begin
                variables v(9)
                cvx_quiet(true)
                maximize v(9)
                subject to
                    v <= vmax
                    v >= 0
                    S*v == 0
                    v(ireact) == 0
                    v(jreact) == 0
            cvx_end
            %fprintf('Genes %d and %d growth %f \n',ireact,jreact, cvx_optval)
            if(cvx_optval<0.2*max_growth) %if below this threshold then pair of genes is lethal
                fprintf('Genes %d and %d are lethal \n',ireact,jreact)
            end
        end
    end
end
