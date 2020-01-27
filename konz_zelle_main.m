function konz_zelle_main (hObject)

%Just do some foreplay
while true
    tic;
    clc
    disp('Simulation gestartet'); 
    disp('');
    disp('...');
    if exist('hObject') == 0
    clearvars
    close all
    end
    break
end

%Definition Parameter
while true
    
%Globale Variable
    global par
    global app
    global chambers
  
    
    % Default Parameter werden eingelesen
    par = konz_zelle_par();

    % Startwerte, wegen Elektroneutralit?t in den Kammern reicht es die
    % Salzkonzentration vorzugeben. cS10 = c_S_1_0
    % Konz_Salz_Kammer1(links)_Zeitpunkt0

    cS10    = 1000 ;   % [mol/m3]
    cS20    = 100 ;   % [mol/m3]
    %ode15s
    % Integrationszeit 
    t = 15.1*3600;

    break
end

%Wenn GUI laeuft ausgewaehlte Paras aus GUI nehmen & Plot Achsen setzten
while true
    if exist('hObject') == 1
        %% hObject global app zuweisen um aus cur_func auf GUI zu plotten 
        app = hObject;        
        %% Werte aus GUI importieren
        cS10 = hObject.C_S_1.Value;
        cS20 = hObject.C_S_2.Value;
        t = hObject.time.Value*3600;
        par.c_M = hObject.C_M.Value;
        
        par.V_R_1 = hObject.V_R_1.Value;
        par.V_R_2 = hObject.V_R_2.Value;
        
        par.Aw = hObject.A_El.Value;
        par.L = hObject.L_M.Value;
        par.A_M = hObject.A_M.Value;
        par.I_res = hObject.curr.Value;
        par.D_pos = hObject.Diff_pos.Value;
        par.D_neg = hObject.Diff_neg.Value;
        par.beta = hObject.beta.Value;
        par.k0 = hObject.k_0.Value; %In Gui hObject.i00.Value anlegen
        par.E0 = hObject.E_0.Value;
        par.T = hObject.Temp.Value;
        %% Anpassen GUI an Simulation
        hObject.Lamp.Color = [1 1 0];
        hObject.Lamp2.Color = [1 1 0];
        %% Umrechnung von i00 auf k0
        %par.k0 = hObject.i00.Value/par.F/1e3;
        % Plot erstellen
        while true
            y_max = 1.5*max(cS10,cS20)/1000;
            hObject.UIAxes2.XLim = [-par.L/5 par.L*6/5];
            hObject.UIAxes2.YLim = [0 y_max];
            chambers.v = linspace(0,10*y_max,200); %border
            chambers.xl = zeros(200,1); %boder left
            chambers.xr = linspace(par.L,par.L,200); %border right
            chambers.sl = linspace(-par.L/5,0,20); %space left chamber
            chambers.sr = linspace(par.L,6/5*par.L,20); %space right chamber
            hold(app.UIAxes,'off');
            hold(app.UIAxes3,'off');
            break
        end
    end
    break
end

%Integration
while true
%Set Startwerte    
    y0(1) = cS10; % Zeitpunkt null linker Rand
    y0(2) = cS20; % Zeitpunkt null rechter Rand
%Integrationsaufruf
    options = odeset('OutputFcn',@konz_zelle_OutputFcn);
    [t,y] = ode23s('konz_zelle_func',[0 t],y0,options);
    break
end

%Check for consistent vaules (c > 0)
while true
    temp = min(min(y(:,1)),min(y(:,2)));
    if temp < 0
        disp('WARNUNG: Physikalisch inkonsistente Werte ...');
            if exist('hObject') == 1
                hObject.Lamp2.Color = [1 0 0];
            end  
    else
        if exist('hObject') == 1
            hObject.Lamp2.Color = [0 1 0];
        end
    end
    break
end

%Ausgabe
while true
%Ohne GUI    
    if exist('hObject') == 0
    figure(1)
    hold on;
    plot(t/3600,y(:,1)/1000.,'-k','LineWidth',2,...
          'MarkerFaceColor','k'); 
    plot(t/3600,y(:,2)/1000.,'-r','LineWidth',2,...
          'MarkerFaceColor','r'); 
    grid on;
    %      axis([0 20 0 6]);
    xlabel('t [h]');
    ylabel('c_S [kmol/m^3]');
    end
    
% Mit GUI    
    if exist('hObject') == 1
    hObject.Lamp.Color = [0 1 0];
    end
    
% Zeitausgabe
    sim_time = toc;
    Sim = ['Simulation Ende ']; 
    disp(Sim);
    ZeitSim = ['Die Simulationszeit betraegt: ' num2str(sim_time) 's']; 
    disp(ZeitSim);
    break
end

end