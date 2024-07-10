%% Flow vs density
lanes = [1 2 3];

h=figure; set(h,'PaperSize',[19 19], 'PaperPosition',[0 0 19 19]);
hold on
box on
set(gca,'LineWidth',3);
xlabel('$k$ (vh/km)','interpreter','latex','FontWeight','bold');
ylabel('$Q$ (vh/h)','interpreter','latex','FontWeight','bold');
set(gca,'FontSize',20,'XTick',[0 25 50 75 100 125 150],'LineWidth',3);
%axis([0 100 0 3000]);


for la=lanes
    I1 = Rfw(:,4) == la;
    I2 = Rsw(:,4) == la;
    scatter(1000.*Rsw(I2,6),3600.*Rsw(I2,5),3,Rsw(I2,7),'filled'); %comment to remove sliding
    scatter(1000.*Rfw(I1,6),3600.*Rfw(I1,5),30,Rfw(I1,7),'filled');
end

%Averaging of all lanes
nl = 3; %Lane normalization
I1 = Rfw(:,4) == 0;
I2 = Rsw(:,4) == 0;
scatter(1000.*Rfw(I1,6)/nl,3600.*Rfw(I1,5)/nl,30,'k','filled');
%scatter(1000.*Rsw(I2,6)/nl,3600.*Rsw(I2,5)/nl,5,'k','filled');

% Optional: The Equilibrium Equation (Fundamental Diagram) of the IDM:
%x0 = 2;
%T  = 0.87;
%v0 = 135/3.6;
%l  = 8;
%xe = @(v)(x0+T.*v)./sqrt(1-(v./v0).^4);

%rhom  = 1/(l+x0);
%v     = 0:0.01:v0;
%x     = xe(v);
%rho_e = 1./(x+l);
%Q     = rho_e.*v;

%plot(1000.*rho_e,3600.*Q,'--k','linewidth',3);

a = colorbar('east');
clim([0 40]);
colormap(jet);
a.Label.String = '$\overline{v}_x$ (m/s)';
a.Label.Interpreter = 'Latex';
a.Label.FontSize = 20;

print(h,['output_plots/' tit '_flow_density_T' num2str(param.T_window) 's_K' num2str(param.K) 'm.eps'],'-depsc');

%% PAPER TIME SERIES:
lanes = [1 2 3];

%Speed:

h=figure; set(h,'PaperSize',[19 19], 'PaperPosition',[0 0 19 19]);
hold on
box on
set(gca,'LineWidth',3);
xlabel('t (s)','interpreter','latex','FontWeight','bold');
ylabel('$\overline{v}_x$ (m/s)','interpreter','latex','FontWeight','bold');
set(gca,'FontSize',20,'LineWidth',3);

for la=lanes   
    I1 = Rfw(:,4) == la;
    I2 = Rsw(:,4) == la;
    scatter(Rsw(I2,3),Rsw(I2,7),5,3600.*Rsw(I2,5),'filled');
    %scatter(Rfw(I1,3),Rfw(I,7),30,3600.*Rfw(I1,5),symbols{f});
end

I1 = Rfw(:,4) == 0;
I2 = Rsw(:,4) == 0;
scatter(Rsw(I2,3),Rsw(I2,7),10,'k','filled');
%scatter(Rfw(I1,3),Rfw(I1,7),30,'k',symbols{f});

xlim([0 max([1200;Rsw(I2,3)])]);
ylim([0 50])

clim([0 4000]);
a = colorbar('north');
a.Label.String = '$Q$ (vh/h)';
a.Label.Interpreter = 'Latex';
a.Label.FontSize = 20;

print(h,['output_plots/' tit '_speed_time_T' num2str(param.T_window) 's_K' num2str(param.K) 'm.eps'],'-depsc');
   