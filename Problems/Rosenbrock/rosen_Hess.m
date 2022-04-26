% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that computes the Hessian of the function 2
%
%           Input: x
%           Output: H = nabla^2 f(x)
%
function [H] = rosen_Hess(x)


n=length(x)-1;

H = diag(-400*x(1:n,1),-1) + diag([0;200*ones(n,1)]+[2*ones(n,1)+1200*x(1:n,1).^2-400*x(2:n+1,1);0]) + diag(-400*x(1:n,1),1);


end