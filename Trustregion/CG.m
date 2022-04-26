function d = CG(f,g,H,TR_radi, problem,method,options)
% Conjugate gadient method for trust region subproblem
% Original algorithm: Numerical Optimization, Algorithm 7.2
% input: funtion value, gradient, Hessian, trust region radius
% output: search direction for the trust region subproblem

z = 0;
r = g;
p = -g;

if norm(r) < method.options.term_tol_CG
    d = 0;
end

for i = 1:method.options.max_iterations_CG

    if p'*H*p <= 0
        syms tol
        eqn = (z + tol*p)'*(z + tol*p) == TR_radi^2;
        sol = solve(eqn, tol);
        tol_1 = double(sol(1,1));
        tol_2 = double(sol(2,1));
        d_1 = z + tol_1*p;
        d_2 = z + tol_2*p;
        if f + g'*d_1 + 1/2*d_1'*H*d_1 <  f + g'*d_2 + 1/2*d_2'*H*d_2
            d = d_1;
            break
        else
            d = d_2;
            break
        end
    end

    alpha = r'*r/(p'*H*p);
    z_old = z;
    z = z + alpha*p;

    if norm(z) > TR_radi
        syms tol
        eqn = (z_old + tol*p)'*(z_old + tol*p) == TR_radi^2;
        sol = solve(eqn, tol);
        tol_1 = double(sol(1,1));
        tol_2 = double(sol(2,1));
        d_1 = z_old + tol_1*p;
        d_2 = z_old + tol_2*p;
        if f + g'*d_1 + 1/2*d_1'*H*d_1 <  f + g'*d_2 + 1/2*d_2'*H*d_2
            d = d_1;
            break
        else
            d = d_2;
            break
        end
    end

    r_old = r;
    r = r + alpha*H*p;
    if norm(r) <= method.options.term_tol_CG
        d = z;
        break
    end

    beta = r'*r/(r_old'*r_old);
    p = -r + beta*p;

end

