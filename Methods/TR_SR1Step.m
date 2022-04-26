function [x_new,f_new,g_new,H_new,TR_radi_new] = TR_SR1Step(x,f,g,H,TR_radi, problem,method,options)
%TR_SR1STEP Summary of this function goes here
%   Detailed explanation goes here

% solving the trust region subproblem using conjugate gradient
s = CG(f,g,H,TR_radi, problem,method,options);
y = problem.compute_g(x+s) - g;
ared = f - problem.compute_f(x+s);
pred = -(g'*s + 1/2*s'*H*s);

if ared/pred > method.options.yita
    x_new = x + s;
else
    x_new = x;
end

% compute function value and gradient at next step
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);

% trust region radius update
if ared/pred > 0.75

    if norm(s) < 0.8*TR_radi
        TR_radi_new = TR_radi;
    else
        TR_radi_new = 2*TR_radi;
    end

elseif (ared/pred < 0.75) && (ared/pred >= 0.1)
    TR_radi_new = TR_radi;

else
    TR_radi_new = 0.5*TR_radi;
end

% SR1 update
if abs(s'*(y-H*s)) >= method.options.r*norm(s)*norm(y-H*s)
    H_new = H + (y-H*s) * (y-H*s)'/((y-H*s)'*s);
else
    H_new = H;

end

