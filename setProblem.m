% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that specifies the problem. Specifically, a way to compute: 
%    (1) function values; (2) gradients; and, (3) Hessians (if necessary).
%
%           Input: problem (struct), required (problem.name)
%           Output: problem (struct)
%
% Error(s): 
%       (1) if problem name not specified;
%       (2) function handles (for function, gradient, Hessian) not found
%
function [problem] = setProblem(problem)

% check is problem name available
if ~isfield(problem,'name')
    error('Problem name not defined!!!')
end

% set function handles according the the selected problem
switch problem.name

    case 'Exponential_10'
        
        problem.x0 = [1;zeros(9,1)];
        problem.n = length(problem.x0);
        problem.compute_f = @Exponential_10_func;
        problem.compute_g = @Exponential_10_grad;
        problem.compute_H = @Exponential_10_Hess;
    
    case 'Exponential_1000'
        
        problem.x0 = [1;zeros(999,1)];
        problem.n = length(problem.x0);
        problem.compute_f = @Exponential_10_func;
        problem.compute_g = @Exponential_10_grad;
        problem.compute_H = @Exponential_10_Hess;

    case 'Datafit2'
        
        problem.x0 = [1;1];
        problem.n = length(problem.x0);
        problem.compute_f = @Datafit2_func;
        problem.compute_g = @Datafit2_grad;
        problem.compute_H = @Datafit2_Hess;

    case 'Rosenbrock_2'
        
        problem.x0 = [-1.2;1];
        problem.n = length(problem.x0);
        problem.compute_f = @rosen_func;
        problem.compute_g = @rosen_grad;
        problem.compute_H = @rosen_Hess;

    case 'Rosenbrock_1000'
        
        problem.x0 = [-1.2;ones(999,1)];
        problem.n = length(problem.x0);
        problem.compute_f = @rosen_func;
        problem.compute_g = @rosen_grad;
        problem.compute_H = @rosen_Hess;

    case 'Function2'
        
        problem.compute_f = @func2;
        problem.compute_g = @func2_grad;
        problem.compute_H = @func2_Hess;
        
    case 'Function3'
        
        problem.compute_f = @func3;
        problem.compute_g = @func3_grad;
        problem.compute_H = @func3_Hess;

    case 'quad_10_10'
        
        problem.x0 = 20*rand(10,1)-10;
        problem.n = length(problem.x0);
        problem.compute_f = @quad_10_10_func;
        problem.compute_g = @quad_10_10_grad;
        problem.compute_H = @quad_10_10_Hess;  

    case 'quad_1000_10'
        
        problem.x0 = 20*rand(1000,1)-10;
        problem.n = length(problem.x0);
        problem.compute_f = @quad_1000_10_func;
        problem.compute_g = @quad_1000_10_grad;
        problem.compute_H = @quad_1000_10_Hess;  

    case 'quad_10_1000'
        
        problem.x0 = 20*rand(10,1)-10;
        problem.n = length(problem.x0);
        problem.compute_f = @quad_10_1000_func;
        problem.compute_g = @quad_10_1000_grad;
        problem.compute_H = @quad_10_1000_Hess;  

    case 'quad_1000_1000'
        
        problem.x0 = 20*rand(1000,1)-10;
        problem.n = length(problem.x0);
        problem.compute_f = @quad_1000_1000_func;
        problem.compute_g = @quad_1000_1000_grad;
        problem.compute_H = @quad_1000_1000_Hess;  

    case 'genhumps_5'
        
        problem.x0 = [-506.2;506.2*ones(4,1)];
        problem.n = length(problem.x0);
        problem.compute_f = @genhumps_5_func;
        problem.compute_g = @genhumps_5_grad;
        problem.compute_H = @genhumps_5_Hess;  

    case 'quartic_1'
        
        problem.x0 = [cos(70);sin(70);cos(70);sin(70)];
        problem.n = length(problem.x0);
        problem.compute_f = @quartic_1_func;
        problem.compute_g = @quartic_1_grad;
        problem.compute_H = @quartic_1_Hess;  
        
    case 'quartic_2'
        
        problem.x0 = [cos(70);sin(70);cos(70);sin(70)];
        problem.n = length(problem.x0);
        problem.compute_f = @quartic_2_func;
        problem.compute_g = @quartic_2_grad;
        problem.compute_H = @quartic_2_Hess;        
        
    otherwise
        
        error('Problem not defined!!!')
end