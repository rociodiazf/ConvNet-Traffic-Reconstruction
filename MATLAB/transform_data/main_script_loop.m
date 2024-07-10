% SCRIPT TO CONVERT FROM ORIGINAL HIGHD DATA TO A COMMON COORDINATE SYSTEM
% This script parse the original HighD tracks and convert to a coordinate
% system common for the both roads. 
% MORE THAN ONE FILE
% April 2024

clear all
close all
%% 1) Abre y formatea el fichero:

%Init a structure to handle rows and columns of the data
init_columns;

% Sampling
fs = 25;   %Sampling freq. in Hz
dt = 1/fs; %Sampling period in s

all_file_names = [11 12 13 14 25:57];

for i=1:numel(all_file_names)

    %Init a structure to handle rows and columns of the data
    init_columns;

    file_name = num2str(all_file_names(i));
    disp(file_name);

    % Read track file
    tracks = importfile(['data_tracks/' file_name '_tracks.csv']);
    
    % Change coords of original HighD Data:
    transform;
    
    % Change lane numbers, clear data and save STVs
    clear tracks sy_min_track sy_max_track ct
    clear sy_max_down sy_max_up sy_min_up sy_min_down 
    
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
end