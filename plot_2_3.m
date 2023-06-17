function [] = plot_2_3(const, x, t, PWA_v)

    figure(1)
    subplot(2,1,1)
    plot(t,PWA_v(:,2),"Color","r"); 
    hold on; 
    plot(t,x(:,2),"Color","b"); 
    yline(25.02)
    yline(18)
    title('Velocity');
    legend('P', 'V'); 
    xlabel('t [s]'); 
    ylabel('v [m/s]');

    subplot(2,1,2)
    deltav = x(:,2)- PWA_v(:,2); 
    hold on
    plot(t, deltav) ; yline(0)
    title('Difference in velocity between P and V')
    xlabel('t [s]'); 
    ylabel('v [m/s]')

    figure(2)
    subplot(2,1,1)
    plot(t,PWA(x(:,2), const),"Color","r");
    hold on; 
    plot(t,V_friction(x(:,2), const), "Color","b");
    title('Friction Force'); 
    legend('P','V');
    xlabel('t [s]'); 
    ylabel('F_{friction} [N]');

    subplot(2,1,2)
    deltaF = V_friction(x(:,2), const)- PWA(x(:,2), const); 
    hold on
    plot(t, deltaF) ; yline(0)
    title('Difference in friction force between P and V')
    xlabel('t [s]'); 
    ylabel('\Delta F_{friction} [N]')


end
