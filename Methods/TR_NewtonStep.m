function [x_new,f_new,g_new,H_new,TR_radi_new] = TR_NewtonStep(x,f,g,H,TR_radi, problem,method,options)
%TR_NEWTONSTEP Summary of this function goes here
%   Detailed explanation goes here

% solving the trust region subproblem using conjugate gradient
d = CG(f,g,H,TR_radi, problem,method,options);
f_d = problem.compute_f(x+d);
m_d = f + g'*d + 1/2*d'*H*d;

ratio = (f-f_d)/(f-m_d);

% trust region radius update
if ratio > method.options.c_1_tr
    x_new = x + d;

    if ratio > method.options.c_2_tr
        TR_radi_new = 2* TR_radi;
    else
        TR_radi_new = TR_radi;
    end
     
else
    x_new = x;
    TR_radi_new = 1/2 * TR_radi;
end

% compute function value and gradient at next step
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
H_new = problem.compute_H(x_new);


end

