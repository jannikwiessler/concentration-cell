function f = rhsSaltFlux(x,c_neg)

    global par
    global n_dot_neg
    
    D_pos = par.D_pos;
    D_neg = par.D_neg;
    c_M = par.c_M;
    F = par.F; 
   
    i_M = par.I_res / par.A_M;
    
    dc_negdx = (n_dot_neg + (D_neg * c_neg) / ((D_pos+D_neg) * c_neg + D_pos*c_M) * i_M/F) /...
        (-D_neg*(1+(D_pos-D_neg)*c_neg /((D_pos+D_neg)*c_neg+D_pos*c_M)));
    
    f = dc_negdx;
end