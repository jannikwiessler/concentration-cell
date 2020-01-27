%% RHS der Optimierung der Relaxationszeit
function f = optimalRHS(x)

    global par
    global n_dot_neg c_neg_0 c_neg_L vec_x vec_c_neg
    
    L = par.L;
          
    n_dot_neg = x;
    [vec_x,vec_c_neg]=ode15s(@rhsSaltFlux, [0 L],c_neg_0); 

    df = vec_c_neg(end) - c_neg_L;
    
    f = abs(df);
end