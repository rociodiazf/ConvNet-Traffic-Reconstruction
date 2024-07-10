frames = unique(tracks(:,ct.frame));
h=figure('Menubar','none','toolbar','none','Position', [-300 1800 2550 700]);
ax1 = axes;
ax1.Position = [0.03 0.4 0.95 0.8];
hold on
caxis([-20 0]);
cx=colorbar('southoutside');
colormap(jet);
set(gca,'YDir','reverse');
box on
axis equal
axis([0 420 sy_min_track sy_max_track]);
objetos1 = [];
objetos2 = [];

ax2 = axes;
ax2.Position = [0.03 -0.2 0.95 0.8];
hold on
caxis([0 20]);
colorbar('southoutside');
colormap(jet);
%set(gca,'YDir','reverse');
box on
axis equal
axis([0 420 sy_min_up sy_max_up]);
%axis([0 400 sx_min sx_max]);
objetos3 = [];
objetos4 = [];

I = tracks(:,ct.laneId) >= 1 & tracks(:,ct.laneId) <= 5; 
temp1 = tracks(I,:);
I = stv_highd(:,cn.la) >=1 & stv_highd(:,cn.la) <= 5;
temp2 = stv_highd(I,:);

for f = 1:numel(frames)
    
    I = temp1(:,ct.frame) == frames(f);
    temp3 = temp1(I,:);
    I = temp2(:,cn.frame) == frames(f);
    temp4 = temp2(I,:);
    
    x1 = [temp3(:,ct.x)';...
          temp3(:,ct.x)' + (temp3(:,ct.width))';...
          temp3(:,ct.x)' + (temp3(:,ct.width))';...
          temp3(:,ct.x)'];

    y1 = [temp3(:,ct.y)';...
          temp3(:,ct.y)';...
          temp3(:,ct.y)' + temp3(:,ct.height)';...
          temp3(:,ct.y)' + temp3(:,ct.height)'];

    objetos1 = patch(ax1,x1,y1,temp3(:,ct.xVelocity));
    objetos2 = plot(ax1,temp3(:,ct.x),temp3(:,ct.y),'r*');
    
    x2 = [temp4(:,cn.sx)';...
          temp4(:,cn.sx)';...
          temp4(:,cn.sx)' + temp4(:,cn.le)';...
          temp4(:,cn.sx)' + temp4(:,cn.le)'];

    y2 = [temp4(:,cn.sy)' - (temp4(:,cn.w)/2)';...
          temp4(:,cn.sy)' + (temp4(:,cn.w)/2)';...
          temp4(:,cn.sy)' + (temp4(:,cn.w)/2)';...
          temp4(:,cn.sy)' - (temp4(:,cn.w)/2)'];

    objetos3 = patch(ax2,x2,y2,temp4(:,cn.vx));
    objetos4 = plot(ax2,temp4(:,cn.sx),temp4(:,cn.sy),'r*');
    
    drawnow;
    
    delete(objetos1);
    delete(objetos2);
    delete(objetos3);
    delete(objetos4);
    
end