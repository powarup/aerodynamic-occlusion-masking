%% import camera information
camera3_struct = load('camera3_calibration.mat','translationVector');
camera4_struct = load('camera4_calibration.mat','translationVector');
camera3 = camera3_struct.translationVector;
camera4 = camera4_struct.translationVector;
calibration_plate_thickness = 11.5;

camera3(:,1) = -camera3(:,1);
camera3(:,2) = -camera3(:,2);

camera4(:,2) = -camera4(:,2);
camera4(:,3) = -camera4(:,3) - calibration_plate_thickness;

%% import model information
addpath(genpath('Mesh_voxelisation'));
addpath(genpath('plane_line_intersect'));
[stlcoords] = READ_stl('baselinelorrymodel.STL');
xco = squeeze( stlcoords(:,1,:) )';
xrange = max(xco,[],'all') - min(xco,[],'all');
yco = squeeze( stlcoords(:,2,:) )';
yrange = floor(max(yco,[],'all') - min(yco,[],'all'));
zco = squeeze( stlcoords(:,3,:) )';
zrange = floor(max(zco,[],'all') - min(zco,[],'all'));
%[hpat] = patch(xco,yco,zco,'b');
%axis equal

zscale = 2;

%% import model and slice
load('voxelised.mat','model');
slices = false([floor(xrange) floor(yrange) ceil(zrange)]);

for i=1:floor(zrange*zscale)
    slicenumber = floor((i+1)/zscale);
    frommodel = model(:,:,i);
    slices(:,:,slicenumber) = slices(:,:,slicenumber) | frommodel;
end

visibilitywidth = 500;

%% calculate the width of the model
yoffset = size(slices,1)/2;

%% move the cameras into visibility space
startcamera3 = camera3;
startcamera4 = camera4;
startcamera3(:,1) = camera3(:,1) + visibilitywidth/2;
startcamera4(:,1) = camera4(:,1) + visibilitywidth/2;
    
%% move the model into visibility space

visibilitymodel = false([visibilitywidth size(slices,2) size(slices,3)]);
modelstart = (visibilitywidth - size(slices,1))/2;
visibilitymodel(modelstart+1:visibilitywidth-modelstart,:,:) = slices;

%% ray trace

visibility_matrices_3 = false(size(visibilitymodel));
visibility_matrices_4 = false(size(visibilitymodel));

%visibilitymodel = gpuArray(visibilitymodel);

%rays_3 = cell{}
%s_slices = sparse(slices);

timestart = datetime();

max_x = 12;
    
parfor x=1:max_x%size(visibilitymodel,3)
    camera3_position = startcamera3 + [0 0 x-1];
    camera4_position = startcamera4 + [0 0 x-1];
    frame_3 = false([size(visibilitymodel,1) size(visibilitymodel,2)]);
    frame_4 = false([size(visibilitymodel,1) size(visibilitymodel,2)]);
    for z=1:size(visibilitymodel,2)
        col_3 = false([size(visibilitymodel,1) 1]);
        col_4 = false([size(visibilitymodel,1) 1]);
        for y=1:size(visibilitymodel,1)
            pixel = [y z x];
            ray_3 = UpRay(camera3_position,pixel);
            frame_3(y,z) = raycast3(ray_3,visibilitymodel);
            ray_4 = UpRay(camera4_position,pixel);
            frame_4(y,z) = raycast3(ray_4,visibilitymodel);
        end
    end
    visibility_matrices_3(:,:,x) = frame_3;
    visibility_matrices_4(:,:,x) = frame_4;
    x;
end

(datetime() - timestart) / max_x

save('visibility_matrices.mat','visibility_matrices_3','visibility_matrices_4');