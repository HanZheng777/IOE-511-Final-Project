% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the function value for the Rosenbrock function
%
%           Input: x
%           Output: f(x)
%
function [f] = rosen_func(x)

n=length(x)-1;
f = sum((ones(n,1) - x(1:n,1)).^2) + 100*sum((x(2:n+1,1) - x(1:n,1).^2).^2);

end