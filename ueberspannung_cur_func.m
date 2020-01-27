function Fx = ueberspannung_cur_func(x,cS)
%UEBERSPANNUNG_FUNC Summary of this function goes here
%   Detailed explanation goes here
    global par
    
    F = par.F;
    R = par.R;
    T = par.T;
    k0 = par.k0;
    E0 = par.E0;
    beta = par.beta;
    cS1 = cS(1);
    cS2 = cS(2);
    Aw = par.Aw;

    eta1 = x(1);
    eta2 = x(2);
    
    i1 = -par.I_res/Aw;
    i2 = par.I_res/Aw;
    
    % Austauschstromdichte im GG bei gegebenen Konzentrationen
    % Konzabh. der Austauschstromdichte nach Gl. (4.44) aus Carl H. Hamann
    % 4. Auflage
    i01 = F*k0*(cS1^(1-beta) * 1000^(beta));
    i02 = F*k0*(cS2^(1-beta) * 1000^(beta));  %??? woher
    
    % Ruhespannung
%     Er1 = E0 + R*T/F * log(cS1/1000);
%     Er2 = E0 + R*T/F * log(cS2/1000);
    
    % Austauschstromdichten
    Fx(1) = i01*(exp((1-beta) * F * eta1 /R/T) - exp(-beta*F*eta1/R/T)) - i1;
    Fx(2) = i02*(exp((1-beta) * F * eta2 /R/T) - exp(-beta*F*eta2/R/T)) - i2;
end

