% IOE 511/MATH 562, University of Michigan

% Function for Backtracking Line Search 

function [alpha] = Backtracking_Linesearch(x,d,problem,method)
alpha = method.options.alphaMax; % this is the maximum step length
tau = method.options.tau; % < 1 reduction factor of alpha
c_1 = method.options.c_1;
f = problem.compute_f(x);
g = problem.compute_g(x);
while problem.compute_f(x+alpha*d) > f + c_1*alpha*g'*d
    alpha = tau*alpha;
    if alpha < eps
        disp('Error in Line search - alpha close to working precision')
        if problem.compute_f(x + alpha*d) > f
             break
        end
    end
end

end