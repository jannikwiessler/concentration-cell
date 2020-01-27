%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function f = konz_zelle_func(t,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition globaler Parameter
global par app chambers
global delta_E delta_Er eta1 eta2 I_res
global c_neg_0 c_neg_L n_dot_neg n_dot_pos vec_x vec_c_neg

% Verbesserung der Lesbarkeit (eigentlich unnötig)
T = par.T;

F = par.F;
R = par.R;
k0 = par.k0;
E0 = par.E0;
beta = par.beta;

Aw = par.Aw;
V_R_1 = par.V_R_1;
V_R_2 = par.V_R_2;

c_M = par.c_M;
A_M = par.A_M;
i_M = par.I_res / A_M;

k0_neg = k0 * exp(beta*F*E0/R/T);
k0_pos = k0 * exp((beta-1)*F*E0/R/T);
% E1 = E0 + eta1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition sinnvoller Variablennamen
cS1    = y(1);
cS2    = y(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reaktionsgeschwindigkeit berechnen
% i_0 = F * k0 * cS1 ^(1-beta) * 1000^(beta);

% Ruhespannung (Nernst Gleichung)
Er1 = par.E0 + par.R*par.T/par.F * log(cS1/1000);
Er2 = par.E0 + par.R*par.T/par.F * log(cS2/1000);
% eta_s = 0.5 * (par.V-(Er1-Er2));
% 
% eta1_0 = -eta_s;
% eta2_0 = +eta_s;
x0 = [0,0];

cS = [cS1,cS2];
func = @(x) ueberspannung_cur_func(x,cS); % function of dummy variable x

% problem.options = optimoptions('fsolve','Display','iter','MaxFunctionEvaluations',1000);
% problem.options = optimoptions('fsolve','Display','iter','MaxFunctionEvaluations',1000,'OptimalityTolerance',1e-4,'StepTolerance',1e-4);
problem.options = optimoptions('fsolve','MaxFunctionEvaluations',1000,'Display','off');
% problem.options = optimoptions('fsolve','Display','iter','Algorithm','levenberg-marquardt');

problem.objective = func;
problem.x0 = x0;
problem.solver = 'fsolve';

[out,fval] = fsolve(problem);

eta1 = out(1);
eta2 = out(2);

E1 = Er1 + eta1;
E2 = Er2 + eta2;

delta_Er = Er2 - Er1;
delta_E = E2 - E1;

i_neg_1 = -F*cS(1)*k0_neg*exp(-beta*F*E1/R/T);
i_pos_1 = F*1000*k0_pos*exp((1-beta)*F*E1/R/T);

I_res = (i_pos_1 + i_neg_1) * Aw;

r1_neg = cS1*k0_neg*exp(-beta*F*E1/R/T);
r1_pos = 1000*k0_pos*exp((1-beta) *F*E1/R/T);

r2_neg = cS2*k0_neg*exp(-beta*F*E2/R/T);
r2_pos = 1000*k0_pos*exp((1-beta) *F*E2/R/T);

%% Berechnung des Donnan Potentials
c_neg_0 =  0.5 * (-c_M + sqrt(c_M*c_M + 4*cS1*cS1));
c_neg_L =  0.5 * (-c_M + sqrt(c_M*c_M + 4*cS2*cS2));

phi_Don_0 = - R*T/F * log(cS1/c_neg_0);
phi_Don_L = - R*T/F * log(cS2/c_neg_L);

%% Optimierung
n_dot_neg_start = 0;
x0 = n_dot_neg_start;
% x = fminsearch(@optimalRHS,x0);
x = fsolve(@optimalRHS,x0,problem.options);

n_dot_pos = i_M / F + n_dot_neg;



%% Testplot
if isempty(app) == 0
    
end
%figure(5) 
%hold on
%plot(vec_x,vec_c_neg,'o','MarkerEdgeColor','k');
%drawnow


%% Definition der Bilanzgleichungen

%--------------------------------------------------
% dcA/dt =
f(1) = - Aw/V_R_1*r1_neg + Aw/V_R_1*r1_pos - A_M/V_R_1*n_dot_pos;
f(2) = - Aw/V_R_2*r2_neg + Aw/V_R_2*r2_pos + A_M/V_R_1*n_dot_pos;

%--------------------------------------------------

f = f';
