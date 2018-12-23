function matrices_out = smear_space(matrices,nCells)
%SMEAR_SPACE performs logical AND with square kernel of side nCells in first 2 dimensions 
%   Detailed explanation goes here
    
    % create list of shifted matrices in a nCells by nCells square
    
    idx = 1;
    horizontalShifts = cell(1,nCells+1);
    horizontalShifts{idx} = matrices;
    
    idx = idx + 1;
    % shift horizontally
    for i=1:nCells
        horizontalShifts{idx} = circshift(matrices,i,2);
        idx = idx + 1;
        horizontalShifts{idx} = circshift(matrices,-i,2);
        idx = idx + 1;
    end
        
    % shift vertically
    jdx = 1;
    verticalShifts = cell(1,(nCells+1)^2);
    for i=1:length(horizontalShifts)
        thisHorizontal = horizontalShifts{i};
        verticalShifts{jdx} = thisHorizontal;
        jdx = jdx + 1;
        for j=1:nCells
            verticalShifts{jdx} = circshift(thisHorizontal,j,1);
            jdx = jdx + 1;
            verticalShifts{jdx} = circshift(thisHorizontal,-j,1);
            jdx = jdx + 1;
        end
    end
        
    totalAnd = matrices;
    for k=1:length(verticalShifts)
        totalAnd = totalAnd & verticalShifts{k};
    end
    
    matrices_out = totalAnd;
    
end

