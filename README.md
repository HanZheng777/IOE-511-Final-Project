# IOE 511 FinalProject by Minghao Chen, Han Zheng, Kechen Zhu, University of Michigan

## How to start
* script_CPU.mlx is an interactive solver terminal providing 10 algorithms to solve 12 different problems, results in \Output
* The result and plot will be found in output folder
* script.m is the m file edition to run the code
* script_BFGS_rosen.m is for our favorite BFGS running on the Rosenbrock problem, results in \Favorite
* script_line_search.mlx is to investigate the big question: how the parameter affect the line search method, results in \Experiment

## Set new problem
* Add problem in the setProblem.m file with initial value, problem dimension and computing method for gradient, Hessian matrix and function value.
* Also add corresponding options in the interactive solver to test.

## Set new method
* Add method in setMethod.m and corresponding options in the interactive solver
* Add the step function and keep the input and output consistent with OptSolver.m

