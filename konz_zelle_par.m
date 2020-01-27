function par = konz_zelle_par()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beipsiel fuer AgClO4 an Silberelektrode

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temperatur
par.T   =   273.15 + 25;    % [K]  Starttemperatur der Vorlage
% Angelegte Stromfluß
par.I_res   = 1e+0; %[A]
% par.I_res = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stoff- und Reaktordaten
par.V_R_1  = 1e-3;      % [m3] 
par.V_R_2  = 1e-3;      % [m3] 
par.Aw  = 1e-2;      % [m2]      Elektrodenfläche

% Naturkonstanten
par.R = 8.31447; % [J/mol/K] Gaskonstante
par.F = 96485.3; % [C/mol]  Faraday Konstante

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reaktionsparameter
par.beta   = 0.35;      % assymetry coefficient
par.i00    = 13.4e4;     %A/m^-2
par.k0 = par.i00/par.F/1e3; % Umrechnung auf k0
%par.k0    = 1.3889e-3;  % [m/s]     Geschwindigkeitskoeffizient bei Standardbedingungen
par.E0    = 0.8;     % [V]   Standardelektrodenpotential


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Protonenaustauschermembran (negativ geladene Festladungen)
par.c_M = 1000; %[mol /m³]

% Diffusionskoeffizienten für unendlich verdünnte Lösungen bei 25° [m^2/s]
% par.D_pos = 1.55e-9; % Ag+ % Johnsten and Spiro, The Faraday Society, 1967

par.D_pos = 1.334e-9; % Na+
par.D_neg = 2.032e-9; % Cl- % (Newmann, 1973, p230), Zitat aus Deen, 2012, p580)


% Membrangeometrie
par.L = 1e-4; %[m]
par.A_M = 1e-4; %[m²]

