% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Problem Number: 1
% Problem Name: quad_10_10
% Problem Description: A randomly generated convex quadratic function; the 
%                      random seed is set so that the results are 
%                      reproducable. Dimension n = 10; Condition number
%                      kappa = 10

% function that computes the gradient of the quad_10_10 function
function [g] = quartic_1_grad(x)

% Matrix Q
Q = [5 1 0 0.5;
     1 4 0.5 0;
     0 0.5 3 0;
     0.5 0 0 2];
 
% Set sigma value
sigma = 1e-4;


% compute function value
g = x + sigma*(Q*x)*(x'*Q*x);

end