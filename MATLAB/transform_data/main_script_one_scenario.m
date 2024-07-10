% SCRIPT TO CONVERT FROM ORIGINAL HIGHD DATA TO A COMMON COORDINATE SYSTEM
% This script parse the original HighD tracks and convert to a coordinate
% system common for the both roads. 
% ONE FILE
% April 2024

clear all
close all

%% 1) Open and format file:

%Init a structure to handle rows and columns of the data
init_columns;

% Sampling
fs = 25;   %Sampling freq. in Hz
dt = 1/fs; %Sampling period in s

%Choose file:
file_name = '25';

% Read track file
tracks = importfile(['data_tracks/' file_name '_tracks.csv']);

% Change coords of original HighD Data:
transform;

%% 2) Plot animations 

plot_on = 1;
save_plot = 0;

% 2.1) Animation of upper road:
if plot_on
    param.sy_min = sy_min_up; 
    param.sy_max = sy_max_up;
    param.lane_min = 2;
    param.lane_max = 4;
    plot_animation(stv_highd,cn,param);
end

% 2.2) Animation of botton road:
if plot_on
    param.sy_min = sy_min_up; 
    param.sy_max = sy_max_up;
    param.lane_min = 5;
    param.lane_max = 10;
    plot_animation(stv_highd,cn,param);
end

%% 3) Plot time-space diagrams

plot_on = 1;
save_plot = 0;

if plot_on
    % 3) Draw time-space diagrams
    lane_show = [2 3 4 6 7 8];
    plot_time_space;
end

%% 4) Change lane numbers, clear data and save in new format
clear tracks sy_min_track sy_max_track ct 
clear sy_max_down sy_max_up sy_min_up sy_min_down 
clear plot_on save_plot h

stv = [];

I = stv_highd(:,cn.la) == 2;
temp = stv_highd(I,:);
temp(:,cn.la) = 1;
stv = [stv; temp];

I = stv_highd(:,cn.la) == 3;
temp = stv_highd(I,:);
temp(:,cn.la) = 2;
stv = [stv; temp];

I = stv_highd(:,cn.la) == 4;
temp = stv_highd(I,:);
temp(:,cn.la) = 3;
stv = [stv; temp];

clear temp I 
save(['data_stv/highd_' file_name '_sup.mat']);

stv = [];
I = stv_highd(:,cn.la) == 8;
temp = stv_highd(I,:);
temp(:,cn.la) = 1;
stv = [stv; temp];

I = stv_highd(:,cn.la) == 7;
temp = stv_highd(I,:);
temp(:,cn.la) = 2;
stv = [stv; temp];

I = stv_highd(:,cn.la) == 6;
temp = stv_highd(I,:);
temp(:,cn.la) = 3;
stv = [stv; temp];

clear temp I 
save(['data_stv/highd_' file_name '_inf.mat']);
