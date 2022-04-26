% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that specifies the method and method specific options. 
% 
%           Input: method (struct); required (method.name)
%           Output: method (struct)
%
% Error(s): 
%   (1) if method not specified
%
function [method] = setMethod(method)

% take option according to a chosen method
switch method.name
    case 'GradientDescent'        
        method.options.alphaMax = 1;
        method.options.step_type = "Backtracking";
        method.options.tau = 1/2;
        method.options.c_1 = 1e-4;
    
     case 'GradientDescentW'
        method.options.step_type = "Wolfe";
        method.options.alphaInit = 1;
        method.options.c_1_ls = 0.1;
        method.options.c_2_ls = 0.9;
        method.options.alpha_low = 0;
        method.options.alpha_high = 1000;
        method.options.c = 0.5;

    case 'Newton'
        method.options.step_type = "Backtracking";
        method.options.tau = 1/2;
        method.options.alphaMax = 1;
        method.options.c_1 = 1e-4;
        
    case 'NewtonW'
        method.options.step_type = "Wolfe";
        method.options.alphaInit = 1;
        method.options.c_1_ls = 0.1;
        method.options.c_2_ls = 0.9;
        method.options.alpha_low = 0;
        method.options.alpha_high = 1000;
        method.options.c = 0.5;
        
    case 'TRNewtonCG'
        method.options.TR_radi_0 = 0.1;
        method.options.c_1_tr = 0.1;
        method.options.c_2_tr = 0.9;
        method.options.term_tol_CG = 0.001;
        method.options.max_iterations_CG = 1000;

    case 'TRSR1CG'
        method.options.TR_radi_0 = 0.1;
        method.options.yita = 1e-4;
        method.options.r = 1e-6;
        method.options.term_tol_CG = 0.001;
        method.options.max_iterations_CG = 1000;
     
     case 'BFGS'
        method.options.step_type = "Backtracking";    
        method.options.tau = 1/2;
        method.options.alphaMax = 1;
        method.options.c_1 = 1e-4;
        method.options.r = 1e-6;
        
    case 'BFGSW'
        method.options.step_type = "Wolfe";
        method.options.alphaInit = 1;
        method.options.c_1_ls = 0.1;
        method.options.c_2_ls = 0.9;
        method.options.alpha_low = 0;
        method.options.alpha_high = 1000;
        method.options.c = 0.5;
        method.options.r = 1e-6;
        
    case 'L_BFGS'
        method.options.step_type = "Backtracking";     
        method.options.tau = 1/2;
        method.options.alphaMax = 1;
        method.options.c_1 = 1e-4;
        method.options.r = 1e-6;

    case 'DFP'
        method.options.step_type = "Backtracking";     
        method.options.tau = 1/2;
        method.options.alphaMax = 1;
        method.options.c_1 = 1e-4;
        method.options.r = 1e-6;

    case 'DFPW'
        method.options.step_type = "Wolfe";
        method.options.alphaInit = 1;
        method.options.c_1_ls = 0.1;
        method.options.c_2_ls = 0.9;
        method.options.alpha_low = 0;
        method.options.alpha_high = 1000;
        method.options.c = 0.5;       
    
% check is method name specified
if ~isfield(method,'name')
    error('Method not specified!!!')
end

end