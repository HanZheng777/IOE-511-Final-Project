% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the gradient of the function 3
%
%           Input: x
%           Output: g = nabla f(x)
%
function [g] = Exponential_10_grad(x)

x1 = x(1,1);
x(1,:) = [];
g_sub = 4.*(x - 1).^3;
g = [-(exp(-x1)*(2*exp(x1) - 19*exp(2*x1) + 1))/(10*(exp(x1) + 1)^2);
    g_sub];

end