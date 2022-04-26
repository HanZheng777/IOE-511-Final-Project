% IOE 511/MATH 562, University of Michigan

% Function for Wolfe Line Search 

function [alpha] = Wolfe_Linesearch(x,d,problem,method)
alpha = method.options.alphaInit;
c_1_ls = method.options.c_1_ls;
c_2_ls = method.options.c_2_ls;
alpha_low = method.options.alpha_low;
alpha_high = method.options.alpha_high;
c = method.options.c;
while 1
    f_new = problem.compute_f(x+alpha*d);
    if f_new <= problem.compute_f(x) + c_1_ls * alpha * problem.compute_g(x)' * d
        g_new = problem.compute_g(x+alpha*d);
        if g_new' * d >= c_2_ls * problem.compute_g(x)' * d
            break
        end
    end
   
    if f_new <= problem.compute_f(x) + c_1_ls * alpha * problem.compute_g(x)' * d
        alpha_low = alpha;
    else
        alpha_high = alpha;
    end
    
    alpha = c * alpha_low + (1 - c) * alpha_high; 
end

end