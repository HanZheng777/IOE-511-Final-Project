% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f_tr,acc_tr,f_te,acc_te] = optSolverML(problem,method,options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);
if strcmp(method.name,'BFGS') || strcmp(method.name,'L_BFGS')
    H = eye(size(g,1));
else
    H = problem.compute_H(x);
end

norm_g = norm(g,inf);
norm_g_0 = norm_g;

% set initial iteration counter
k = 0;
delta = zeros(options.max_iterations,1);
delta = [f;delta];

% set memory
m = problem.memory;
Y = {};
S = {};

while k < options.max_iterations && norm_g >= options.term_tol*max(1,norm_g_0)
    
    % take step according to a chosen method
    switch method.name
        case 'GradientDescent'
            if mod(k,10) == 0
                fprintf('%15s %15s %15s %15s %15s\n','Iteration','Func val','Norm Grad','alpha','Norm d')
            end
            fprintf('%15s %15.5e %15.5e',k,f,norm_g);    
            [x_new,f_new,g_new,H_new,d,alpha] = GDStep(x,f,g,H,problem,method,options);
            fprintf(' %15.5e %15.5e\n',alpha,norm(d,inf));
            Y_new = Y;S_new =S;

        case 'Newton'
            if mod(k,10) == 0
                fprintf('%15s %15s %15s %15s %15s\n','Iteration','Func val','Norm Grad','alpha','Norm d')
            end
            fprintf('%15s %15.5e %15.5e',k,f,norm_g);    
            [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options);
            fprintf(' %15.5e %15.5e\n',alpha,norm(d,inf));
            Y_new = Y;S_new =S;
            
        case 'BFGS'
            if mod(k,10) == 0
                fprintf('%15s %15s %15s %15s %15s\n','Iteration','Func val','Norm Grad','alpha','Norm d')
            end
            fprintf('%15s %15.5e %15.5e',k,f,norm_g);    
            [x_new,f_new,g_new,H_new,d,alpha] = BFGSStep(x,f,g,H,problem,method,options);
            fprintf(' %15.5e %15.5e\n',alpha,norm(d,inf));
            Y_new = Y;S_new =S;

        case 'L_BFGS'
            if mod(k,10) == 0
                fprintf('%15s %15s %15s %15s %15s\n','Iteration','Func val','Norm Grad','alpha','Norm d')
            end
            fprintf('%15s %15.5e %15.5e',k,f,norm_g);    
            [x_new,f_new,g_new,H_new,Y_new,S_new,k,d,alpha] = L_BFGSStep(x,f,g,Y,S,m,k,problem,method,options);
            fprintf(' %15.5e %15.5e\n',alpha,norm(d,inf));
            
        otherwise
            
            error('Method not implemented yet!')
            
    end
    
    % update old and new function values
    x_old = x; f_old = f; g_old = g; H_old = H; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; H = H_new; norm_g = norm(g,inf);
    Y = Y_new; S = S_new;

    % increment iteration counter
    k = k + 1;
    
    delta(k+1) = f_new;
    % print the result

end


end