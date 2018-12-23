visibilitywidth = 500;

%% calculate the width of the model
    yoffset = size(slices,1)/2;

%% move the cameras into visibility space
    thiscamera3 = camera3;
    thiscamera4 = camera4;
    thiscamera3(:,1) = camera3(:,1) + visibilitywidth/2;
    thiscamera4(:,1) = camera4(:,1) + visibilitywidth/2;
    
%% move the model into visibility space

    visibilitymodel = false([visibilitywidth size(slices,2) size(slices,3)]);
    modelstart = (visibilitywidth - size(slices,1))/2;
    visibilitymodel(modelstart+1:visibilitywidth-modelstart,:,:) = slices;
    
    visibility_matrices_3 = false(size(visibilitymodel));
    visibility_matrices_4 = false(size(visibilitymodel));

    %visibilitymodel = gpuArray(visibilitymodel);
    
    %rays_3 = cell{}
    %s_slices = sparse(slices);
    
    %thiscamera3 = thiscamera3 + [0 0 300];
    %thiscamera4 = thiscamera4 + [0 0 300];
    
    timestart = datetime();
    for x=1:50%size(visibilitymodel,3)
        parfor z=1:size(visibilitymodel,2)
            col_3 = false([size(visibilitymodel,1) 1]);
            col_4 = false([size(visibilitymodel,1) 1]);
            for y=1:size(visibilitymodel,1)
                pixel = [y z x];
                ray_3 = UpRay(thiscamera3,pixel);
                col_3(y) = raycast3(ray_3,visibilitymodel);
                ray_4 = UpRay(thiscamera4,pixel);
                col_4(y) = raycast3(ray_4,visibilitymodel);
            end
            visibility_matrices_3(:,z,x) = col_3;
            visibility_matrices_4(:,z,x) = col_4;
        end
        datetime() - timestart
        thiscamera3 = thiscamera3 + [0 0 1];
        thiscamera4 = thiscamera4 + [0 0 1];
    end
    
    save('visibility_matrices.mat','visibility_matrices_3','visibility_matrices_4');
    
% %% read from STL
% [stlcoords] = READ_stl('baselinelorrymodel.STL');
% xco = squeeze( stlcoords(:,1,:) )';
% xrange = max(xco,[],'all') - min(xco,[],'all');
% yco = squeeze( stlcoords(:,2,:) )';
% yrange = floor(max(yco,[],'all') - min(yco,[],'all'));
% zco = squeeze( stlcoords(:,3,:) )';
% zrange = floor(max(zco,[],'all') - min(zco,[],'all'));
% [hpat] = patch(xco,yco,zco,'b');
% 
% %% translate into correct positions
% 
% % grab bottom left
% handleX = min(min(xco));
% handleY = min(min(yco));
% handleZ = max(max(zco));
% 
% % move model
% xco = xco - handleX;
% yco = yco - handleY;
% zco = zco - handleZ;
% 
% [pat2] = patch(xco,yco,zco,'r');
% 
% newstl = stlcoords;
% stlcoords(:,1,:) = xco';
% stlcoords(:,2,:) = yco';
% stlcoords(:,3,:) = zco';
% 
