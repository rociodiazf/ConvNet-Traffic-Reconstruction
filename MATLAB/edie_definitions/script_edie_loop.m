clear all
close all

ficheros = [11 12 13 14 25:57];

param.lanes = 1:3;
param.T_window = 10;
param.K = 50;
param.fs = 25;
%param.v0 = v0;
espiras = linspace(param.K/2,400-param.K/2,4);

for f = 1:numel(ficheros)

    disp([num2str(f) ' of ' num2str(numel(ficheros))]);
    
    disp(['loading ' num2str(ficheros(f)) ' sup']);
    fichero = num2str(ficheros(f));

    load(['data_stv/highd_' fichero '_sup.mat']);
    disp(['processing ' num2str(ficheros(f))]);

    %Classic loop sensor each G m:
    Rfw = {};
    Rsw = {};
    
    for j=1:numel(espiras)
        disp(['loop x=' num2str(espiras(j)) 'm']);
        [Rfw{j},Rsw{j}] = edie_definitions(1,stv,cn,espiras(j),param);
    end
    
    Rfw = cell2mat(Rfw');
    Rsw = cell2mat(Rsw');

    disp(['saving ...']);
    save(['data_edie/highd_' fichero '_sup_edie_T' num2str(param.T_window) 's_' num2str(param.K) 'm.mat'],...
          'Rfw','Rsw');

    disp(['loading ' num2str(ficheros(f)) ' inf']);
    fichero = num2str(ficheros(f));

    load(['data_stv/highd_' fichero '_inf.mat']);
    disp(['processing ' num2str(ficheros(f))]);

    %Classic loop sensor each G m:
    Rfw = {};
    Rsw = {};
    
    for j=1:numel(espiras)
        disp(['loop x=' num2str(espiras(j)) 'm']);
        [Rfw{j},Rsw{j}] = edie_definitions(1,stv,cn,espiras(j),param);
    end
    
    Rfw = cell2mat(Rfw');
    Rsw = cell2mat(Rsw');

    disp(['saving ...']);
    save(['data_edie/highd_' fichero '_inf_edie_T' num2str(param.T_window) 's_' num2str(param.K) 'm.mat'],...
          'Rfw','Rsw');
end