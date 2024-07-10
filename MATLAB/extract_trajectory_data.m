clear all
close all

% addpath and loads the data
addpath('outputRedNeuronal\');

file_name = '0';
load(['imagCochesOriginal_' file_name '.mat']); 

% shows the original data
figure
imshow(data) 
%%
% rounds the original data to 0's and 1's (threshold 0.5)
dataRounded = round(data);

% prints rounded data
figure
imshow(dataRounded)

% detects the perimeters of the trajectories
bounds = bwboundaries(dataRounded);

% shows rounded data with the perimeters detected
figure
imshow(dataRounded)
hold on
visboundaries(bounds)

% sets values to transform from pixels to meters or seconds
p_v = 0.8; % meters/pixel
p_h = 0.04; % seconds/pixel

% sets the stv variable
stv = [];
%%
for i = 1:length(bounds)
    oneBound = bounds{i}; % analyzes one car in each iteration
    halfOneBound = oneBound(1:floor((length(oneBound)-1)/2), :); % selects the trajectory [ from round trip --> to one way]
    halfOneBound(halfOneBound(1:end-1,2)==halfOneBound(2:end,2),:)=[]; % removes the rows where the time is not progessing
    halfOneBound(halfOneBound(:,1)<=3,:)=[]; % removes wrongs values: y = [1, 2, 3]
    halfOneBound(halfOneBound(:,2)<=3,:)=[]; % removes wrongs values: x = [1, 2, 3]
    halfOneBound(halfOneBound(:,1)==512,:)=[];% removes wrongs values from: y = 512
    halfOneBound(halfOneBound(:,2)==512,:)=[];% removes wrongs values from: X = 512
    if ~isempty(halfOneBound) && length(halfOneBound)>=5 % if trajectory is not empty and the length of the trayectory is larger than 5 pixeles
        speed = [0; diff(p_v*halfOneBound(:,1))./(diff(p_h*halfOneBound(:,2)))]; %
        stv = [stv; p_v*halfOneBound(:,1) halfOneBound(:,2) speed i*ones(length(halfOneBound),1),ones(length(halfOneBound),1)];
    end
end

% prints the trayectories build from stv
figure
scatter(stv(:,2),stv(:,1),5,stv(:,3),"filled");
colorbar

% saves the data in a .mat
save("data_stv\outputNN\image" + file_name + "cars.mat",'stv','-mat' );


%% THIS ONE
h = figure; set(h,'PaperSize',[19 19], 'PaperPosition',[0 0 19 19]);
hold on
box on
set(gca,'LineWidth',3);
set(gca,'Fontsize',18);

% imagen a imprimir
imshow(data)
%scatter(stv(:,2),stv(:,1),5,'k',"filled");

ylabel('space (m)', 'FontSize',18);
xlabel('time (s)', 'FontSize',18);
axis([0 500 0 400]);
print(h, ['row_data.pdf'], '-dpdf');


