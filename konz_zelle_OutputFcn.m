function status = konz_zelle_OutputFcn(t,y,flag)
%KONZ_ZELLE_OUTPUTFCN Summary of this function goes here
%   Detailed explanation goes here
    global I_res delta_E delta_Er eta1 eta2 
    global app chambers vec_x vec_c_neg n_dot_neg n_dot_pos
    global par

    
    switch(flag)
        case 'init'             
            status = false;
        case 'done'
            status = false;
        otherwise
%% Figures auskommentiert
while true
          % figure(2)
          % hold on
          % plot(t/3600,I_res,'o','MarkerEdgeColor','k');
          % xlabel('t [h]');
          % ylabel('i [A/m^2]');
          % drawnow
            
          % figure(3)
          % hold on
          % plot(t/3600,delta_E,'o','MarkerEdgeColor','k');
          % plot(t/3600,delta_Er,'x','MarkerEdgeColor','k');
          % xlabel('t [h]');
          % ylabel('\Delta E [V]');
          % drawnow
            
          % figure(4)
          % hold on
          % plot(t/3600,y,'o','MarkerEdgeColor','k');
          % xlabel('t [h]');
          % ylabel('konz');
          % drawnow
            
    %        figure(2)
            
    %        ax1 = subplot(2,1,1);
    %        hold on
    %        plot(ax1,t/3600,delta_E,'o')
          % xlabel('t [h]');
          % ylabel('\Delta E [V]');
            
            
    %        ax2 = subplot(2,1,2);
    %        hold on
    %        plot(ax2,t/3600,y,'x');
          % xlabel('t [h]');
          % ylabel('konz');
    %        drawnow
    break
end
%% Plot in GUI
while true
    if isempty(app) == 0
    app.n_dot_neg.Value = n_dot_neg;
    app.n_dot_pos.Value = n_dot_pos;
    
    
    app.conc_left.Value = y(1);
    app.conc_right.Value = y(2);
    
    
    app.delta_E.Value = delta_E;
    
    vec_c_pos = par.c_M + vec_c_neg;
    
    chambers.vl = linspace(y(1)/1000,y(1)/1000,20); %Conc left chamber     
    chambers.vr = linspace(y(2)/1000,y(2)/1000,20); %Conc right chamber
    cla(app.UIAxes2)
    hold(app.UIAxes2,'on')
    plot(app.UIAxes2,chambers.xl,chambers.v,'k:', ...
        chambers.xr,chambers.v,'k:', ...
        chambers.sl, chambers.vl,'r', ...
        chambers.sr, chambers.vr,'r')
    h1 = plot(app.UIAxes2,vec_x,vec_c_neg/1000,'g');
    h2 = plot(app.UIAxes2,vec_x,vec_c_pos/1000,'b');
    legend(app.UIAxes2,[h1,h2],'c_{-}^M','c_{+}^M','Location','best');
    
    pause(0.0001); %Philip fragen warum das nur mit pause geht   
    
  
    plot(app.UIAxes,t/3600,delta_E,'k*');
    hold(app.UIAxes,'on');
    plot(app.UIAxes,t/3600,delta_Er,'m*');
    legend(app.UIAxes,'E_c','E_r','Location','best');
    
    plot(app.UIAxes3, t/3600,eta1,'b*');
    hold(app.UIAxes3,'on');
    plot(app.UIAxes3, t/3600,eta2,'r*');
    legend(app.UIAxes3,'\eta_1','\eta_2','Location','best');
%     ylim(app.UIAxes3,[-1e-10 1e-10])
    
         
    end
    break
end
            
            status = false;
    end

end

