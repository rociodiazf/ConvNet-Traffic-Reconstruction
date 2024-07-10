function plot_animation(stv,cn,param)

    frames = unique(stv(:,cn.frame));
    h=figure('Menubar','none','toolbar','none','Position', [-300 1800 2550 200]);
    ax1 = axes;
    ax1.Position = [0.03 0.1 0.95 0.8];
    hold on
    clim([0 40]);
    colorbar('northoutside');
    colormap(jet);
    %set(gca,'YDir','reverse');
    xlabel('x (m)');
    ylabel('y (m)');
    box on
    axis equal
    axis([0 420 0 13]);
    %xlim([0 420]);
   
    obj1 = [];
    obj2 = [];
    
    I = stv(:,cn.la) >= param.lane_min & stv(:,cn.la) <= param.lane_max;
    temp1 = stv(I,:);
    
    for f = 1:numel(frames)
        
        I = temp1(:,cn.frame) == frames(f);
        temp2 = temp1(I,:);
        
        x = [temp2(:,cn.sx)';...
              temp2(:,cn.sx)';...
              temp2(:,cn.sx)' + temp2(:,cn.le)';...
              temp2(:,cn.sx)' + temp2(:,cn.le)'];
    
        y = [temp2(:,cn.sy)' - (temp2(:,cn.w)/2)';...
              temp2(:,cn.sy)' + (temp2(:,cn.w)/2)';...
              temp2(:,cn.sy)' + (temp2(:,cn.w)/2)';...
              temp2(:,cn.sy)' - (temp2(:,cn.w)/2)'];
    
        obj1 = patch(ax1,x,y,temp2(:,cn.vx));
        obj2 = plot(ax1,temp2(:,cn.sx),temp2(:,cn.sy),'r*');
        
        drawnow;
        
        delete(obj1);
        delete(obj2);
          
    end
end