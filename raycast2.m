function blocked = raycast2(currentRay,currentVoxel,model)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    stillgoing = true;
    blocked = false;
    currentPosition = currentVoxel;
    step = currentRay.vector / vecnorm(currentRay.vector);
    
    currentY = currentVoxel(:,1);
    nextY = max(1,currentY+currentRay.yDirection);
    currentZ = currentVoxel(:,2);
    maxZ = size(model,2);
    nextZ = min(currentZ+1,size(model,maxZ));
    currentX = currentVoxel(:,3);
    
    while stillgoing && currentX ~= currentRay.endSlice       
        if currentY > size(model,1) || currentY < 1 || currentZ > size(model,2) || currentZ < 1
            blocked = false;
            stillgoing = false;
        else
            filledHere = model(currentY,currentZ,currentX);
            if filledHere || model(nextY,currentZ,currentX) || model(currentY, nextZ, currentX)
                blocked = true;
                stillgoing = false;
            else
                currentPosition = currentPosition + step;
                currentVoxel = floor(currentPosition);
                currentY = currentVoxel(:,1);
                currentZ = currentVoxel(:,2);
                currentX = currentVoxel(:,3);
                nextY = max(1,currentY+currentRay.yDirection);
                nextZ = min(currentZ+1,size(model,maxZ));
            end
        end
    end

end

