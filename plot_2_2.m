function [] = plot_2_2(x,P,V, const)
v = linspace(0,const.v_max,100);

patch([v fliplr(v)],[P fliplr(V)], [0.7 0.7 0.7], 'HandleVisibility','off')
hold on
plot(v, P, 'Color', 'r','DisplayName','P', 'LineWidth',2);
hold on
plot(v, V, 'Color',"b" , "DisplayName" ,"V", "LineWidth",2);
legend('Location', 'eastoutside');

plot([const.alpha, const.alpha], [0,const.beta], 'k--', 'HandleVisibility','off')
plot([0, const.alpha], [const.beta,const.beta], 'k--', 'HandleVisibility','off')

text(const.alpha+0.5,const.beta/5,'α')
text(const.alpha/100,const.beta+50,'β')

plot([const.v_max, const.v_max], [0,const.c*const.v_max^2], 'k--', 'HandleVisibility','off')
plot([0, const.v_max], [const.c*const.v_max^2,const.c*const.v_max^2], 'k--', 'HandleVisibility','off')

text(const.v_max+0.5,const.beta/2,'v_{max}')
text(const.alpha/10,const.c*const.v_max^2+50,'cv_{max}^2')

title('P and V')
xlabel('v ')
ylabel('cv_{max}^2')

end
