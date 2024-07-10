function [Rfw,Rsw] = edie_definitions(scenario_id,stv,cn,xc,param)

    lanes    = param.lanes;
    T_window = param.T_window;
    fs       = param.fs;
    K        = param.K;
    
    T_samples = T_window*fs;
    
    Af = T_samples*K;
    A  = T_window*K; 

    frame_vector = unique(stv(:,cn.frame));
    num_frames = numel(frame_vector);
    num_lanes = numel(lanes);
    
    time_fw = 1:T_samples:num_frames; %fixed window
    time_sw = T_samples/2:1:num_frames-T_samples/2; %sliding window
    num_fw = numel(time_fw);
    num_sw = numel(time_sw);

    x0 = [xc-K/2 xc+K/2];
    
    Rfw = zeros(num_lanes*(num_fw-1),7);
    Rsw  = zeros(num_lanes*(num_sw),7);

    I = stv(:,cn.sx) >= x0(1) & stv(:,cn.sx) <= x0(2);
    stv_space_window = stv(I,:);

    kk = 1;

    disp('Averaging by fixed window');
    %Averaging fixed window:
    for i = 1:num_fw-1
        I = stv_space_window(:,cn.frame) >= time_fw(i) & stv_space_window(:,cn.frame) < time_fw(i+1);
        stv_st_window = stv_space_window(I,:);
        
        cars = unique(stv_st_window(:,cn.id));
        num_cars = numel(cars);
        
        if num_cars > 0
            %Edie:
            x = 0;
            t = 0;
            for ca=1:num_cars
                I = stv_st_window(:,cn.id) == cars(ca);
                x = x + (max(stv_st_window(I,cn.sx))-min(stv_st_window(I,cn.sx)));
                t = t + (max(stv_st_window(I,cn.frame))-min(stv_st_window(I,cn.frame)));
            end
            %Flow
            q = x/A;
            %Density
            k = t/Af;
            %Speed
            v = q/k;
        else
            %Flow
            q = 0;
            %Density
            k = 0;
            %Speed
            v = NaN;
        end
            
        Rfw(kk,:) = [scenario_id xc (i-1)*T_window+(T_window/2) 0 q k v];
        kk = kk+1;

        for la=1:num_lanes
            I = stv_st_window(:,cn.la) == lanes(la);
            stv_lane = stv_st_window(I,:);

            cars_lane = unique(stv_lane(:,cn.id));
            num_cars_lane = numel(cars_lane);
            
            if num_cars_lane > 0
                %Edie:
                x = 0;
                t = 0;
                for ca=1:num_cars_lane
                    I = stv_lane(:,cn.id) == cars_lane(ca);
                    x = x + (max(stv_lane(I,cn.sx))-min(stv_lane(I,cn.sx)));
                    t = t + (max(stv_lane(I,cn.frame))-min(stv_lane(I,cn.frame)));
                end
                %Flow
                q = x/A;
                %Density
                k = t/Af;
                %Speed
                v = q/k;
            else
                %Flow
                q = 0;
                %Density
                k = 0;
                %Speed
                v = NaN;
            end
            
            Rfw(kk,:) = [scenario_id xc (i-1)*T_window+(T_window/2) la q k v];
            kk = kk+1;
        end
    end

    disp('Averaging by sliding window');
    kk = 1;
    %Averaging sliding window:
    for i = 1:num_sw
        I = stv_space_window(:,cn.frame) >= time_sw(i)-T_samples/2 & stv_space_window(:,cn.frame) < time_sw(i)+T_samples/2;
        stv_st_window = stv_space_window(I,:);
        
        cars = unique(stv_st_window(:,cn.id));
        num_cars = numel(cars);

        if num_cars > 0
            %Edie:
            x = 0;
            t = 0;
            for ca=1:num_cars
                I = stv_st_window(:,cn.id) == cars(ca);
                x = x + (max(stv_st_window(I,cn.sx))-min(stv_st_window(I,cn.sx)));
                t = t + (max(stv_st_window(I,cn.frame))-min(stv_st_window(I,cn.frame)));
            end
            %Flow
            q = x/A;
            %Density
            k = t/Af;
            %Speed
            v = q/k;
        else
            %Flow
            q = 0;
            %Density
            k = 0;
            %Speed
            v = NaN;
        end

        Rsw(kk,:) = [scenario_id xc time_sw(i)/fs 0 q k v];
        kk = kk+1;

        for la=1:num_lanes
            I = stv_st_window(:,cn.la) == lanes(la);
            stv_lane = stv_st_window(I,:);

            cars_lane = unique(stv_lane(:,cn.id));
            num_cars_lane = numel(cars_lane);
            
            if num_cars_lane > 0
                %Edie:
                x = 0;
                t = 0;
                for ca=1:num_cars_lane
                    I = stv_lane(:,cn.id) == cars_lane(ca);
                    x = x + (max(stv_lane(I,cn.sx))-min(stv_lane(I,cn.sx)));
                    t = t + (max(stv_lane(I,cn.frame))-min(stv_lane(I,cn.frame)));
                end
                %Flow
                q = x/A;
                %Density
                k = t/Af;
                %Speed
                v = q/k;
            else
                %Flow
                q = 0;
                %Density
                k = 0;
                %Speed
                v = NaN;
            end
            
            Rsw(kk,:) = [scenario_id xc time_sw(i)/fs la q k v];
            kk = kk+1;
        end
        
        %time control
        if mod(i,1000) == 0
            fprintf('%s ', '.');
        end
    end
    disp(' ');
end