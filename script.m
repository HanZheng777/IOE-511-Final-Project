% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen
% main script to run the solver

% Script to run code
% close all figures, clear all variables from workspace and clear command
% window
% close all
clear;clc;clf
format long
addpath(genpath('Methods'));
addpath(genpath('Trustregion'));
addpath(genpath('Problems'));
addpath(genpath('Linesearch'));
addpath((genpath('Dataset')));
addpath((genpath('Output')));
 
tic
rng(0);
% set problem (minimal requirement: name of problem)
problem.name = "Rosenbrock_2";
problem.memory = 5;
% set method (minimal requirement: name of method)
method.name = 'DFPW'; % option: GradientDescent, Newton, BFGS, L-BFGS
%method.options.constant_step_size = 1e-3;

% set options   
options.term_tol = 0.000001;
options.max_iterations = 1000;
% fstar = 0;

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
save(strcat('Output\',result_name'), "result");

% plot fx v.s. iterations^*
figure(1)
plot(0:k,delta(1:k+1));
%title("Function Value");
xlabel("iterations");
ylabel("f(x_k)");
box off
hold on

exportgraphics(gcf,strcat('Output\',fig_name'),'Resolution',500);