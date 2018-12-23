function blocked = raycast4(scene)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    currentRay = scene.ray;
    currentVoxel = currentRay.startVoxel;
    model = scene.model;
    stillgoing = true;
    currentPosition = currentVoxel;
    step = currentRay.vector / vecnorm(currentRay.vector);
    
    currentY = currentVoxel(:,1);
    currentZ = currentVoxel(:,2);
    currentX = currentVoxel(:,3);
    
    blocked = model(currentY,currentZ,currentX);
    
    while stillgoing && currentX ~= currentRay.endSlice
        blocked = model(currentY,currentZ,currentX);
        if blocked
            stillgoing = false;
        else
            currentPosition = currentPosition + step;
            currentVoxel = floor(currentPosition);
            currentY = currentVoxel(:,1);
            currentZ = currentVoxel(:,2);
            currentX = currentVoxel(:,3);
            if currentY > size(model,1) || currentY < 1 || currentZ > size(model,2) || currentZ < 1
                stillgoing = false;
            end
        end
    end

end

