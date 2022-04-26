% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the gradient of the Rosenbrock function
%
%           Input: x
%           Output: g = nabla f(x)
%
function [g] = Datafit2_grad(x)

g = [2*(x(2)^2 - 1)*(x(1)*(x(2)^2 - 1) + 9/4) + 2*(x(2)^3 - 1)*(x(1)*(x(2)^3 - 1) + 21/8) + 2*(x(1)*(x(2) - 1) + 3/2)*(x(2) - 1);.....
     2*x(1)*(x(1)*(x(2) - 1) + 3/2) + 6*x(1)*x(2)^2*(x(1)*(x(2)^3 - 1) + 21/8) + 4*x(1)*x(2)*(x(1)*(x(2)^2 - 1) + 9/4)];

end

