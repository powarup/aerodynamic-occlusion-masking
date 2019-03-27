function slices = convertModel(stlpath)
%convertModel converts an stl (provide path without extension) into a 1mm side 3D matrix of voxels
%   Detailed explanation goes here

    %% imports
    addpath(genpath('Mesh_voxelisation'));

    %% import .stl file
    [stlcoords] = READ_stl(strcat(stlpath,'.STL'));
    xco = squeeze( stlcoords(:,1,:) )';
    xrange = max(xco,[],'all') - min(xco,[],'all');
    yco = squeeze( stlcoords(:,2,:) )';
    yrange = floor(max(yco,[],'all') - min(yco,[],'all'));
    zco = squeeze( stlcoords(:,3,:) )';
    zrange = floor(max(zco,[],'all') - min(zco,[],'all'));
    % [hpat] = patch(xco,yco,zco,'b');
    % axis equal

    zscale = 2;

    %% voxelise

    [OUTPUTgrid] = VOXELISE(floor(xrange),floor(yrange),floor(zrange*zscale),strcat(stlpath,'.STL'),'xyz');

    %% fix axes

    model = flip(flip(OUTPUTgrid,3),1);

    %% slice it up

    slices = false([floor(xrange) floor(yrange) ceil(zrange)]);

    for i=1:floor(zrange*zscale)
        slicenumber = floor((i+1)/zscale);
        frommodel = model(:,:,i);
        slices(:,:,slicenumber) = slices(:,:,slicenumber) | frommodel;
    end
    
    %% save the model slices
    save(strcat(stlpath,'.mat'),'model');
    
    % plotModel(slices)

end