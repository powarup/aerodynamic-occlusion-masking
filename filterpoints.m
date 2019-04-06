lorry = Output_Lorry;

nans = isnan(lorry.U_0);

min_z = 10000;
min_z_idx = [0 0 0];

for x=1:size(lorry.Y_0,2)
    for y=1:size(lorry.Y_0,1)
        for z=1:size(lorry.Y_0,3)
            if (~nans(y,x,z) && lorry.Z_0(y,x,z) < min_z)
                min_z = lorry.Z_0(y,x,z);
                min_z_idx = [y x z];
            end
        end
    end
end

mask = mask_or;

% following offsets are the co-ordinates in lorry space of the mask's 0,0,0
% point

%min_z = min_z; % override point if you want to manually set min_z

z_offset = min_z-1; % model space starts at the bottom, lorry space in middle
y_offset = -1 * size(mask,1)/2; % model space starts all the way left (negative)
x_offset = 0;

start = [y_offset x_offset z_offset]; % model origin in lorry space

% so to transform a lorry space (y,x,z) to model space, subtract start and
% then switch co-ordinates to (y,z,x) and you're ready to look up in the
% mask
tic
count = 0;
for x=1:size(lorry.Y_0,2)
    for y=1:size(lorry.Y_0,1)
        for z=1:size(lorry.Y_0,3)
            if (~nans(y,x,z))
                position_yxz = [lorry.Y_0(y,x,z) lorry.X_0(y,x,z) lorry.Z_0(y,x,z)] - start;
                position = round([position_yxz(1) position_yxz(3) position_yxz(2)]);
                if position(1) > size(mask,1) || mask(position(1),position(2),position(3))
                    count = count+1;
                    lorry.V_0(y,x,z) = NaN;
                    lorry.W_0(y,x,z) = NaN;
                    lorry.U_0(y,x,z) = NaN;
                    lorry.V_0_norm(y,x,z) = NaN;
                    lorry.W_0_norm(y,x,z) = NaN;
                    lorry.U_0_norm(y,x,z) = NaN;
                end
            end
        end
    end
end
toc
count
save('filtered_lorry.mat','lorry');rot90