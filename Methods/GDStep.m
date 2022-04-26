% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,H_new,d,alpha] = GDStep(x,f,g,H,problem,method,options)

% search direction is -g
d = -g;

% determine step size
switch method.options.step_type
    case 'Constant'
        alpha = method.options.constant_step_size;
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        H_new = problem.compute_H(x_new);

    case 'Backtracking'
        alpha = Backtracking_Linesearch(x,d,problem,method);
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        H_new = problem.compute_H(x_new);
        
    case 'Wolfe'
        alpha = Wolfe_Linesearch(x,d,problem,method);
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        H_new = problem.compute_H(x_new);
        
        
end
end

