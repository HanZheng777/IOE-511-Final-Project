% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f,k,delta,norm_g] = optSolver(problem,method,options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
g = problem.compute_g(x);
if strcmp(method.name,'BFGS') || strcmp(method.name,'BFGSW') ...
    || strcmp(method.name,'L_BFGS')|| strcmp(method.name,'TRSR1CG')...
    || strcmp(method.name,'DFP') || strcmp(method.name,'DFPW')
        
    H = eye(size(g,1));
else
    H = problem.compute_H(x);
end

if strcmp(method.name,'TRNewtonCG') || strcmp(method.name,'TRSR1CG')
    TR_radi = method.options.TR_radi_0;
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
            [x_new,f_new,g_new,H_new,d,alpha] = GDStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
            
        case 'GradientDescentW'
            [x_new,f_new,g_new,H_new,d,alpha] = GDStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;

        case 'Newton'   
            [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
            
         case 'NewtonW'
            [x_new,f_new,g_new,H_new,d,alpha] = NewtonStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
            
        case 'BFGS'    
            [x_new,f_new,g_new,H_new,d,alpha] = BFGSStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
            
         case 'BFGSW'  
            [x_new,f_new,g_new,H_new,d,alpha] = BFGSStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;

        case 'L_BFGS'
            [x_new,f_new,g_new,H_new,Y_new,S_new,k,d,alpha] = L_BFGSStep(x,f,g,Y,S,m,k,problem,method,options);

        case 'TRNewtonCG'
            [x_new,f_new,g_new,H_new,TR_radi_new] = TR_NewtonStep(x,f,g,H,TR_radi, problem,method,options);
            Y_new = Y;S_new =S;

        case 'TRSR1CG'
            [x_new,f_new,g_new,H_new,TR_radi_new] = TR_SR1Step(x,f,g,H,TR_radi, problem,method,options);
            Y_new = Y;S_new =S;
            
        case 'DFP'  
            [x_new,f_new,g_new,H_new,d,alpha] = DFPStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
            
        case 'DFPW'
            [x_new,f_new,g_new,H_new,d,alpha] = DFPStep(x,f,g,H,problem,method,options);
            Y_new = Y;S_new =S;
        
            
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