% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the Hessian of the function3
%
%           Input: x
%           Output: H = nabla^2 f(x)
%
function [H] = Exponential_10_Hess(x)

x1 = x(1,1);
x(1,:) = [];
H1 = [(2*exp(x1) - 19*exp(2*x1) + 1)/(5*(exp(x1) + 1)^3) + (exp(-x1)*(2*exp(x1) - 19*exp(2*x1) + 1))/(10*(exp(x1) + 1)^2) + (exp(-x1)*(38*exp(2*x1) - 2*exp(x1)))/(10*(exp(x1) + 1)^2),zeros(1,length(x))];
H2 = [zeros(length(x),1),diag(12.*(x - 1).^2)];
H = [H1;H2];

end