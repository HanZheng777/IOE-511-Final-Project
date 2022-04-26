% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Run the BFGS on the Rosenbrock_2 problem

% Script to run code
% close all figures, clear all variables from workspace and clear command
% window
% close all
clear;clc;clf
format long
addpath(genpath('Methods'));
addpath(genpath('TrustRegion'));
addpath(genpath('Problems'));
addpath(genpath('Linesearch'));
addpath((genpath('Dataset')));
addpath((genpath('Output')));
addpath((genpath('Experiment')));
addpath((genpath('Favorite')));

tic
rng(0);
% set problem (minimal requirement: name of problem)
problem.name = "Rosenbrock_2"; % Rosenbrock_2 or 1000
problem.x0 = [-1.2;ones(1,1)]; % use ones(n,1) to get desired problem dimension (n+1)
problem.n = length(problem.x0);
problem.memory = 5;


% set method (minimal requirement: name of method)
method.name = 'BFGS'; % option

% set options   
options.term_tol = 0.000001; %default: 1e-6
options.max_iterations = 1000; %default: 1e3
% fstar = 4;

% h= waitbar(0,'Please wait...');
% run method and return x^* and f^*
[x,f,k,delta,norm_g] = optSolver(problem,method,options);

% output

fig_name = strcat(problem.name,'_',method.name,'_','.png');
result_name = strcat(problem.name,'_',method.name,'_','.mat');

timeElapsed = toc; 
fprintf('%15s %15s %15s %15s','Iteration','Func val','Norm Grad','CPU Seconds');
fprintf('%15d %15.4e %15.4e %15.4f',k,f,norm_g,timeElapsed); 

result = {'k','f','norm_g','timeElapsed';k,f,norm_g,timeElapsed};
save(strcat('Favorite/',result_name'), "result");



% plot the function value convergence
figure(1)
plot(0:k,delta(1:k+1),"LineWidth",2);
title("Function Value Convergence");
xlabel("iterations");
ylabel("f(x_k)");
box off
hold on
exportgraphics(gcf,strcat('Favorite\',fig_name'),'Resolution',500);