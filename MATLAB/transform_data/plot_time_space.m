for i = lane_show
    
    %figure size
    h=figure; set(h,'PaperSize',[19 19], 'PaperPosition',[0 0 19 19]);
    hold on
    box on
    set(gca,'LineWidth',3);

    %ticks
    ticks_x = 0:200:2000;
    set(gca,'XTick',ticks_x);
    set(gca,'FontSize',20);

    %labels
    xlabel('t (s)','interpreter','latex','FontWeight','bold');
    ylabel('x (m)','interpreter','latex','FontWeight','bold');
    zlabel('v (m/s)','interpreter','latex','FontWeight','bold');
    titulo = ['HighD-File-' num2str(file_name) '-Lane-' num2str(i)];
    %title(titulo);
    
    %color
    clim([0 40]);
    a=colorbar;
    ylabel(a,'v (m/s)','interpreter','latex');

    %plot
    I = stv_highd(:,cn.la) == i;
    scatter3(stv_highd(I,cn.frame)./fs,stv_highd(I,cn.sx),stv_highd(I,cn.v),3,stv_highd(I,cn.v),'filled');
    axis([-20 (max(stv_highd(I,cn.frame)))/fs+20 -10 420 0 40]);
    view(0,90);

    %save plots
    if save_plot
        print(h,['output_plots/' titulo '.pdf'],'-dpdf');
    end
end
