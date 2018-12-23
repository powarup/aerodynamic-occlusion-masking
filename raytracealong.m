function [visibility_matrices_3,visibility_matrices_4] = raytracealong(model,camera3,camera4)
%% generate visibility matrices for each slice passing by camera3 and camera4

    visibilitywidth = 500;

%% calculate the width of the model
    yoffset = size(model,1)/2;

%% move the cameras into visibility space
    camera3(:,1) = camera3(:,1) + visibilitywidth/2;
    camera4(:,1) = camera4(:,1) + visibilitywidth/2;
    
%% move the model into visibility space

    visibilitymodel = false([visibilitywidth size(model,2) size(model,3)]);
    modelstart = (visibilitywidth - size(model,1))/2;
    visibilitymodel(modelstart+1:visibilitywidth-modelstart,:,:) = model;
    
    plotModel(visibilitymodel);
    
%% make visibility matrices
    visibility_matrices_3 = true(size(model));
    visibility_matrices_4 = true(size(model));

    for x = 10:10%length(model)
        % for each pixel in slice, ray trace
        for y=1:size(model,1)
            for z=1:size(model,2)
                pixel = [y z x];
                ray_3 = UpRay(camera3,pixel);
                visibility_matrices_3(y,z,x) = raycast(ray_3,ray_3.startVoxel,model,-1);
                ray_4 = UpRay(camera4,pixel);
                visibility_matrices_4(y,z,x) = raycast(ray_4,ray_4.startVoxel,model,1);
            end
        end
        % move camera ready for next one
        camera3(:,3) = camera3(:,3) + 1;
        camera4(:,3) = camera4(:,3) + 1;
    end
    imshow(visibility_matrices_4);
end