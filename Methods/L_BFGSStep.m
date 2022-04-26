% IOE 511/MATH 562, University of Michigan
% Code written by: Minghao Chen

% Function that: (1) computes the BFGS step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, m, problem, method, options
%           Outputs: x_new, f_new, g_new, H_new, d, alpha
%
function [x_new,f_new,g_new,H_new,Y_new,S_new,k,d,alpha] = L_BFGSStep(x,f,g,Y,S,m,k,problem,method,options)


% determine step size
switch method.options.step_type
    case 'Constant'
        H = eye(size(g,1));
        A = zeros(m,1);
        q = g;
        if k == 0
            d = -H*g;
            H_new = H;
        elseif (k < m)
                 A = zeros(k,1);
                 for i = 1:k
                      A(k+1-i) = S{k+1-i,1}'*q/(Y{k+1-i,1}'*S{k+1-i,1});
                      q = q - A(k+1-i)*Y{k+1-i,1};
                 end
                 r = H*q;
                 for i = 1:k
                      B = Y{i,1}'*r/(Y{i,1}'*S{i,1});
                      r = r + S{i,1}*(A(i)-B);
                 end
                 d = -r;
                 H_new = r/g;
        else    
                 for i = 1:m
                      A(m+1-i) = S{m+1-i,1}'*q/(Y{m+1-i,1}'*S{m+1-i,1});
                      q = q - A(m+1-i)*Y{m+1-i,1};
                 end
                 r = H*q;
                 for i = 1:m
                      B = Y{i,1}'*r/(Y{i,1}'*S{i,1});
                      r = r + S{i,1}*(A(i)-B);
                 end
                 d = -r;
                 H_new = r/g;
        end    
            alpha = method.options.constant_step_size;
            x_new = x + alpha*d;
            f_new = problem.compute_f(x_new);
            g_new = problem.compute_g(x_new);
            s = x_new - x;
            y = g_new - g; 
            if s'*y >= method.options.r*norm(s,2)*norm(y,2)   
                if (k < m)
                     Y_new = [Y;y];
                     S_new = [S;s];
                else
                     Y(1) = []; 
                     S(1) = [];
                     Y_new = [Y;y];
                     S_new = [S;s];                  
                end
            else
                     S_new = S;
                     Y_new = Y;
                     k = k-1;
            end
         

    case 'Backtracking'
        H = eye(size(g,1));
        A = zeros(m,1);
        q = g;
        if k == 0
            d = -H*g;
            H_new = H;
        elseif (k < m)
                 A = zeros(k,1);
                 for i = 1:k
                      A(k+1-i) = S{k+1-i,1}'*q/(Y{k+1-i,1}'*S{k+1-i,1});
                      q = q - A(k+1-i)*Y{k+1-i,1};
                 end
                 r = H*q;
                 for i = 1:k
                      B = Y{i,1}'*r/(Y{i,1}'*S{i,1});
                      r = r + S{i,1}*(A(i)-B);
                 end
                 d = -r;
                 H_new = r/g;
        else    
                 for i = 1:m
                      A(m+1-i) = S{m+1-i,1}'*q/(Y{m+1-i,1}'*S{m+1-i,1});
                      q = q - A(m+1-i)*Y{m+1-i,1};
                 end
                 r = H*q;
                 for i = 1:m
                      B = Y{i,1}'*r/(Y{i,1}'*S{i,1});
                      r = r + S{i,1}*(A(i)-B);
                 end
                 d = -r;
                 H_new = r/g;
        end    

        %alphaMax = 1; % this is the maximum step length
        alpha = method.options.alphaMax;
        %tau = 1/2; % < 1 reduction factor of alpha
        %c_1 = 1e-4;
        while problem.compute_f(x+alpha*d) > f + method.options.c_1*alpha*g'*d
            alpha = method.options.tau*alpha;
            if alpha < eps
                disp('Error in Line search - alpha close to working precision');
                if problem.compute_f(x + alpha*d) > f
                    x_new = x + alpha*d;
                end
                break
            end
        end
        x_new = x + alpha*d;
        f_new = problem.compute_f(x_new);
        g_new = problem.compute_g(x_new);
        s = x_new - x;
        y = g_new - g;
        if s'*y >= method.options.r*norm(s,2)*norm(y,2)   
            if (k < m)
                 Y_new = [Y;y];
                 S_new = [S;s];
            else
                 Y(1) = []; 
                 S(1) = [];
                 Y_new = [Y;y];
                 S_new = [S;s];                  
            end
        else
            S_new = S;
            Y_new = Y;
            k = k-1;
        end
        
end
end

