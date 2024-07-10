%VERSION: x is longitudinal

stv_highd = []; %output matrix

stv_highd(:,cn.frame) = tracks(:,ct.frame);                                               %frame
stv_highd(:,cn.v)     = sqrt(tracks(:,ct.xVelocity).^2+tracks(:,ct.yVelocity).^2);        %speed (modulus) 
stv_highd(:,cn.a)     = sqrt(tracks(:,ct.xAcceleration).^2+tracks(:,ct.yAcceleration).^2);%acceleration (modulus)
stv_highd(:,cn.le)    = tracks(:,ct.width);                                               %vehicle lenght
stv_highd(:,cn.w)     = tracks(:,ct.height);                                              %vehicle width 
stv_highd(:,cn.id)    = tracks(:,ct.id);                                                  %vehicle ID
stv_highd(:,cn.la)    = tracks(:,ct.laneId);                                              %lane
stv_highd(:,cn.sh)    = tracks(:,ct.dhw);                                                 %spacehead
stv_highd(:,cn.th)    = tracks(:,ct.thw);                                                 %timehead

% Upper road:
I = tracks(:,ct.laneId) < 5;

%axis of "debug track script"
sy_min_track = min(tracks(I,ct.y));
sy_max_track = max(tracks(I,ct.y)+tracks(I,ct.height)); 

%new coordinates of velocity and acceleration:
stv_highd(I,cn.vx) = -tracks(I,ct.xVelocity);
stv_highd(I,cn.vy) = tracks(I,ct.yVelocity);
stv_highd(I,cn.ax) = -tracks(I,ct.xAcceleration);
stv_highd(I,cn.ay) = tracks(I,ct.yAcceleration);

%First: reference point in the middle of rear bumper
stv_highd(I,cn.sx) = tracks(I,ct.x)+tracks(I,ct.width);
stv_highd(I,cn.sy) = tracks(I,ct.y)+tracks(I,ct.height)/2;
stv_highd(I,cn.sy) = stv_highd(I,cn.sy)-min(stv_highd(I,cn.sy)-stv_highd(I,cn.w)/2);

%Second: mirror lanes
%stv_highd(I,cn.sy) = max(stv_highd(I,cn.sy)+stv_highd(I,cn.w)/2)-stv_highd(I,cn.sy);

%Third: reverse direction
stv_highd(I,cn.sx) = max(stv_highd(I,cn.sx))-stv_highd(I,cn.sx);

%limits width road
sy_min_up = min(stv_highd(I,cn.sy)-stv_highd(I,cn.w)/2);
sy_max_up = max(stv_highd(I,cn.sy)+stv_highd(I,cn.w)/2);

% bottom road 
I = ~I;
%stv_highd(I,:) = [];
%velocidad
stv_highd(I,cn.vx) = tracks(I,ct.xVelocity);
stv_highd(I,cn.vy) = -tracks(I,ct.yVelocity);
stv_highd(I,cn.ax) = tracks(I,ct.xAcceleration);
stv_highd(I,cn.ay) = -tracks(I,ct.yAcceleration);
% 
%space
stv_highd(I,cn.sx) = tracks(I,ct.x);                             
stv_highd(I,cn.sy) = tracks(I,ct.y);
stv_highd(I,cn.sy) = max(stv_highd(I,cn.sy))-stv_highd(I,cn.sy)+stv_highd(I,cn.w)/2;
 
%limits botton road
sy_min_down = min(stv_highd(I,cn.sy)-stv_highd(I,cn.w)/2);
sy_max_down = max(stv_highd(I,cn.sy)+stv_highd(I,cn.w)/2);

clear I