# Konzentrationszelle
Matlab GUI for simulation of electrochemical kinetics in a concentration cell.

One can visualize the resulting concentration, excess voltage ('Überspannungen') and molar fluxes in the chambers for a given set of start parameters. The default values represent a Ag/10-3 M Ag+ system containing a 1M HCLO4 as electrolyte at a temperature of 20°C.

Please feel free to change the characteristics of the materials and the the resulting dependencies.

For choosing various solvers please change line 95 in 'konz_zelle_main.m'. As we have a stiff system the default solver is ode15s (BDF, Multistep).

For default settings please use currents in the order of 0.02A to ensure stable integration.

Requirements: optimization toolbox.

Run GUI_konz_zelle.mlapp

**Equations:**

- ![\frac{dc^1_s}{dt}=-\frac{A_w}{V^1_c}r^1_{neg}+\frac{A_w}{V^1_c}r^1_{pos}-\frac{A_w}{V^1_c}\dot{n}_{pos}\;\;(1)](https://render.githubusercontent.com/render/math?math=%5Cfrac%7Bdc%5E1_s%7D%7Bdt%7D%3D-%5Cfrac%7BA_w%7D%7BV%5E1_c%7Dr%5E1_%7Bneg%7D%2B%5Cfrac%7BA_w%7D%7BV%5E1_c%7Dr%5E1_%7Bpos%7D-%5Cfrac%7BA_w%7D%7BV%5E1_c%7D%5Cdot%7Bn%7D_%7Bpos%7D%5C%3B%5C%3B(1))


- ![\frac{dc^2_s}{dt}=-\frac{A_w}{V^2_c}r^2_{neg}+\frac{A_w}{V^2_c}r^2_{pos}+\frac{A_w}{V^2_c}\dot{n}_{pos}\;\;(2)](https://render.githubusercontent.com/render/math?math=%5Cfrac%7Bdc%5E2_s%7D%7Bdt%7D%3D-%5Cfrac%7BA_w%7D%7BV%5E2_c%7Dr%5E2_%7Bneg%7D%2B%5Cfrac%7BA_w%7D%7BV%5E2_c%7Dr%5E2_%7Bpos%7D%2B%5Cfrac%7BA_w%7D%7BV%5E2_c%7D%5Cdot%7Bn%7D_%7Bpos%7D%5C%3B%5C%3B(2))


- ![r^i_{neg}=c^i_sk^0_{neg}e^{-\beta\cdot\frac{E_1F}{RT}},\;\;i\in{1,2}\;\;(3)](https://render.githubusercontent.com/render/math?math=r%5Ei_%7Bneg%7D%3Dc%5Ei_sk%5E0_%7Bneg%7De%5E%7B-%5Cbeta%5Ccdot%5Cfrac%7BE_1F%7D%7BRT%7D%7D%2C%5C%3B%5C%3Bi%5Cin%7B1%2C2%7D%5C%3B%5C%3B(3))


- ![r^i_{pos}=10^3\frac{mol}{m^3}k^0_{pos}e^{(1-\beta)\cdot\frac{E_2F}{RT}},\;\;i\in{1,2}\;\;(4)](https://render.githubusercontent.com/render/math?math=r%5Ei_%7Bpos%7D%3D10%5E3%5Cfrac%7Bmol%7D%7Bm%5E3%7Dk%5E0_%7Bpos%7De%5E%7B(1-%5Cbeta)%5Ccdot%5Cfrac%7BE_2F%7D%7BRT%7D%7D%2C%5C%3B%5C%3Bi%5Cin%7B1%2C2%7D%5C%3B%5C%3B(4))


- ![k^0_{neg}=k_0e^{\beta\cdot\frac{FE_0}{RT}}\;\;(5)](https://render.githubusercontent.com/render/math?math=k%5E0_%7Bneg%7D%3Dk_0e%5E%7B%5Cbeta%5Ccdot%5Cfrac%7BFE_0%7D%7BRT%7D%7D%5C%3B%5C%3B(5))


- ![k^0_{pos}=k_0e^{(\beta-1)\cdot\frac{FE_0}{RT}}\;\;(6)](https://render.githubusercontent.com/render/math?math=k%5E0_%7Bpos%7D%3Dk_0e%5E%7B(%5Cbeta-1)%5Ccdot%5Cfrac%7BFE_0%7D%7BRT%7D%7D%5C%3B%5C%3B(6))


- ![E_i=E^r_i+\eta_i\;\;i\in{1,2}\;\;(7)](https://render.githubusercontent.com/render/math?math=E_i%3DE%5Er_i%2B%5Ceta_i%5C%3B%5C%3Bi%5Cin%7B1%2C2%7D%5C%3B%5C%3B(7))


- ![E^r_i=E_0+\frac{RT}{F}log\left(\frac{c^s_i}{10^3\frac{mol}{m^3}}\right)\;\;(8)](https://render.githubusercontent.com/render/math?math=E%5Er_i%3DE_0%2B%5Cfrac%7BRT%7D%7BF%7Dlog%5Cleft(%5Cfrac%7Bc%5Es_i%7D%7B10%5E3%5Cfrac%7Bmol%7D%7Bm%5E3%7D%7D%5Cright)%5C%3B%5C%3B(8))


**Nomenclature:**
- ![V_1,V_2\[m^3\]](https://render.githubusercontent.com/render/math?math=V_1%2CV_2%5Bm%5E3%5D) Volume of rection chamber one and two

- ![A_w\[m^2\]](https://render.githubusercontent.com/render/math?math=A_w%5Bm%5E2%5D) Surface of electrode in electrolyte (assume to be the same in both chambers) 

- ![A_M\[m^2\]](https://render.githubusercontent.com/render/math?math=A_M%5Bm%5E2%5D) Orthogonal surface of the cation exchange membrane

- ![c^1_s,c^2_s\[mol/m^3\]](https://render.githubusercontent.com/render/math?math=c%5E1_s%2Cc%5E2_s%5Bmol%2Fm%5E3%5D) Electrolytes salt concentration in chamber one and two 

- ![r^1_{neg},r^2_{neg}\[mol/m^2s\]](https://render.githubusercontent.com/render/math?math=r%5E1_%7Bneg%7D%2Cr%5E2_%7Bneg%7D%5Bmol%2Fm%5E2s%5D) Partial anodic reaction in chamber one and two

- ![r^1_{pos},r^2_{pos}\[mol/m^2s\]](https://render.githubusercontent.com/render/math?math=r%5E1_%7Bpos%7D%2Cr%5E2_%7Bpos%7D%5Bmol%2Fm%5E2s%5D) Partial cathodic reaction in chamber one and two

- ![\dot{n}_{pos}\[mol/m^2s\]](https://render.githubusercontent.com/render/math?math=%5Cdot%7Bn%7D_%7Bpos%7D%5Bmol%2Fm%5E2s%5D) Positive molar flux through membrane

