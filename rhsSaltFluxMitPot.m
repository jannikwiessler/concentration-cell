function f = rhsSaltFluxMitPot(x,y)

    global J_neg D_pos D_neg c_m F i_c R T
    
    % Sinnvolle Benennung
    c_neg = y(1);
    phi   = y(2);
    
    dc_negdx = (J_neg + (D_neg * c_neg) / ((D_pos+D_neg) * c_neg + D_pos*c_m) * i_c/F) /...
        (-D_neg*(1+(D_pos-D_neg)*c_neg /((D_pos+D_neg)*c_neg+D_pos*c_m)));
    
    dphidx = (i_c + F*dc_negdx*(D_pos-D_neg))/...
        (-F*F/R/T*(D_pos*(c_neg+c_m)+D_neg*c_neg));
%     dphidx = R*T/F*(J_neg+i_c/F*D_neg/(D_neg-D_pos))/...
%         ((D_neg-(D_neg*D_neg+D_pos*D_neg)/(D_neg-D_pos))*c_neg - D_pos*D_neg/(D_neg-D_pos)*c_m);
    
    f(1) = dc_negdx;
    f(2) = dphidx;
    f=f';
end