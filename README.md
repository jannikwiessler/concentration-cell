# Konzentrationszelle
Matlab GUI for simulation of electrochemical kinetics in a concentration cell.

One can visualize the resulting concentration, excess voltage ('Überspannungen') and molar fluxes in the chambers for a given set of start parameters. The default values represent a Ag/10-3 M Ag+ system containing a 1M HCLO4 as electrolyte at a temperature of 20°C.

Please feel free to change the characteristics of the materials and the the resulting dependencies.

For choosing various solvers please change line 95 in 'konz_zelle_main.m'. As we have a stiff system the default solver is ode15s (BDF, Multistep).

For default settings please use currents in the order of 0.02A to ensure stable integration.

Requirements: optimization toolbox.

Run GUI_konz_zelle.mlapp

**Equations:**

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\frac{dc^1_s}{dt}=-\frac{A_w}{V^1_c}r^1_{neg}+\frac{A_w}{V^1_c}r^1_{pos}-\frac{A_w}{V^1_c}\dot{n}_{pos}\;\;(1)" title="\Large \frac{dc^1_s}{dt}=-\frac{A_w}{V^1_c}r^1_{neg}+\frac{A_w}{V^1_c}r^1_{pos}-\frac{A_w}{V^1_c}\dot{n}_{pos}" /> 

<img src="https://latex.codecogs.com/svg.latex?\Large&space;\frac{dc^2_s}{dt}=-\frac{A_w}{V^2_c}r^2_{neg}+\frac{A_w}{V^2_c}r^2_{pos}+\frac{A_w}{V^2_c}\dot{n}_{pos}\;\;(2)" title="\Large \frac{dc^2_s}{dt}=-\frac{A_w}{V^2_c}r^2_{neg}+\frac{A_w}{V^1_c}r^2_{pos}+\frac{A_w}{V^2_c}\dot{n}_{pos}" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;r^i_{neg}=c^i_sk^0_{neg}e^{-\beta\cdot\frac{E_1F}{RT}},\;\;i\in{1,2}\;\;(3)" title="ddd" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;r^i_{pos}=10^3\frac{mol}{m^3}k^0_{pos}e^{(1-\beta)\cdot\frac{E_2F}{RT}},\;\;i\in{1,2}\;\;(4)" title="ddd" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;k^0_{neg}=k_0e^{\beta\cdot\frac{FE_0}{RT}}\;\;(5)" title="ddd" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;k^0_{pos}=k_0e^{(\beta-1)\cdot\frac{FE_0}{RT}}\;\;(6)" title="ddd" />

<img src="https://latex.codecogs.com/svg.latex?\Large&space;E_i=E^r_i+\eta_i\;\;i\in{1,2}\;\;(7)" title="ddd" />


<img src="https://latex.codecogs.com/svg.latex?\Large&space;E^r_i=E_0+\frac{RT}{F}log\left(\frac{c^s_i}{10^3\frac{mol}{m^3}}\right)\;\;(8)" title="ddd" />

**Nomenclature:**

- <img src="https://latex.codecogs.com/svg.latex?\Large&space;V_1,V_2[m^3]" title="" /> Volume of rection chamber one and two
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;A_w[m^2]" title="" /> Surface of electrode in electrolyte (assume to be the same in both chambers) 
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;A_M[m^2]" title="" /> Orthogonal surface of the cation exchange membrane
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;c^1_s,c^2_s[mol/m^3]" title="" /> Electrolytes salt concentration in camber one and two 
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;r^1_{neg},r^2_{neg}[mol/m^2s]" title="" /> Partial anodic reaction in chamber one and two
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;r^1_{pos},r^2_{pos}[mol/m^2s]" title="" /> Partial cathodic reaction in chamber one and two
- <img src="https://latex.codecogs.com/svg.latex?\Large&space;\dot{n}_{pos}[mol/m^2s]" title="" /> Positive molar flux through membrane
