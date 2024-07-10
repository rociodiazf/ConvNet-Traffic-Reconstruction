clear all
file_name = '26';
tit = ['highd_' file_name '_sup']; %change here sup or inf for upper or botton road
load(['data_stv/' tit '.mat']);

param.lanes = 1:3;
param.T_window = 10;
param.K = 50;
param.fs = fs;
%param.v0 = v0;
G = param.K;

%espiras = G/2:G:400-G/2;
detectors = 200;

%Classic loop sensor each G m:
Rfw = {};
Rsw = {};

for j=1:numel(detectors)
    disp(['loop x=' num2str(detectors(j)) 'm']);
    [Rfw{j},Rsw{j}] = edie_definitions(1,stv,cn,detectors(j),param);
end

Rfw = cell2mat(Rfw');
Rsw = cell2mat(Rsw');

script_figs_edie;