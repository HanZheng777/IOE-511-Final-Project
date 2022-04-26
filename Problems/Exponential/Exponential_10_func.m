% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the function value for the function 3
%
%           Input: x
%           Output: f(x)
%
function [f] = Exponential_10_func(x)

x1 = x(1,1);
x(1,:) = [];
Z = sum((x-1).^4);
f = (exp(x1)-1)/(exp(x1)+1) + .1*exp(-x1) + Z;

end