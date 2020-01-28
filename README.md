# Konzentrationszelle
Matlab GUI for simulation of electrochemical kinetics in a concentration cell.

One can visualize the resulting concentration, excess voltage ('Überspannungen') and molar fluxes in the chambers for a given set of start parameters. The default values represent a Ag/10-3 M Ag+ system containing a 1M HCLO4 as electrolyte at a temperature of 20°C.

Please feel free to change the characteristics of the materials and the the resulting dependencies.

For choosing various solvers please change line 95 in 'konz_zelle_main.m'. As we have a stiff system the default solver is ode15s (BDF, Multistep).

For default settings please use currents in the order of 0.02A to ensure stable integration.

Requirements: optimization toolbox.

Run GUI_konz_zelle.mlapp
