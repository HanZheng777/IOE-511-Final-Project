% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that: (1) computes the BFGS step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,H_new,d,alpha] = BFGSStep(x,f,g,H,problem,method,options)

d = - H * g;
% determine step size
switch method.options.step_type
    case 'Constant'
        alpha = method.options.constant_step_size;
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        s = x_new - x;
        y = g_new - g;
        rho = 1/(y'*s);     
        if s'*y >= method.options.r*norm(s,2)*norm(y,2)   
            H_new = (eye(size(g,1))-rho*s*y')*H*(eye(size(g,1))-rho*y*s') + rho*(s*s');
        else
            H_new = H;
        end

    case 'Backtracking'
        alpha = Backtracking_Linesearch(x,d,problem,method);
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        s = x_new - x;
        y = g_new - g;
        rho = 1/(y'*s);     
        if s'*y >= method.options.r*norm(s,2)*norm(y,2)   
            H_new = (eye(size(g,1))-rho*s*y')*H*(eye(size(g,1))-rho*y*s') + rho*(s*s');
        else
            H_new = H;
        end
        
    case 'Wolfe'
        alpha = Wolfe_Linesearch(x,d,problem,method);
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        s = x_new - x;
        y = g_new - g;
        rho = 1/(y'*s);     
        if s'*y >= method.options.r*norm(s,2)*norm(y,2)   
            H_new = (eye(size(g,1))-rho*s*y')*H*(eye(size(g,1))-rho*y*s') + rho*(s*s');
        else
            H_new = H;
        end
        
        
end
end

