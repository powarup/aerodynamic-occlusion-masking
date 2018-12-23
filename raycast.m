function blocked = raycast(currentRay,currentVoxel,model,xDirection)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    stillgoing = true;
    
    while stillgoing

        currentY = currentVoxel(:,1);
        currentZ = currentVoxel(:,2);
        currentX = currentVoxel(:,3);

        adjacentVoxel = [currentY+currentRay.yDirection currentZ currentX];
        aboveVoxel = [currentY currentZ+1 currentX];

        endSlice = currentRay.endSlice;

        filledHere = model(currentY,currentZ,currentX);

        % if this is the slice level
        if filledHere
            blocked = filledHere;
            stillgoing = false;
        elseif currentX == endSlice
            blocked = filledHere;
            stillgoing = false;
        elseif currentRay.doesEnterSideOf(adjacentVoxel)
            currentVoxel = adjacentVoxel;
            if currentY > size(model,1) || currentY < 1
                blocked = false;
                stillgoing = false;
            end
        elseif currentRay.doesEnterFromBelow(aboveVoxel)
            currentVoxel = aboveVoxel;
            if currentZ > size(model,2) || currentZ < 1
                blocked = false;
                stillgoing = false;
            end
        else
            currentVoxel(3) = currentVoxel(3) + xDirection;
        end
    end
end

