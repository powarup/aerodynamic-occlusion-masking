function matrices_out = smear_space(matrices,nCells)
%SMEAR_SPACE performs logical AND with square kernel of radius nCells in first 2 dimensions 
%   Detailed explanation goes here
    
    matrices_out = matrices;
    
    % smear in dimension 1
    for k=1:size(matrices,3) % for each slice
        for i=(1+nCells):(size(matrices,1)-1-nCells) % along first dimension
            for j=(1+nCells):(size(matrices,2)-1-nCells) % along second dimension
                for istep=nCells:-1:1
                    matrices_out(i,j,k) = matrices(i + istep,j,k) | matrices_out(i,j,k);
                end
                for istep=1:nCells
                    matrices_out(i,j,k) = matrices_out(i,j,k) | matrices(i + istep,j,k);
                end
            end
        end
    end
    
    
     % smear in dimension 2
    for k=1:size(matrices,3) % for each slice
        for j=(1+nCells):(size(matrices,2)-1-nCells) % along second dimension
            for i=(1+nCells):(size(matrices,1)-1-nCells) % along first dimension
                for jstep=nCells:-1:1
                    matrices_out(i,j,k) = matrices(i,j+jstep,k) | matrices_out(i,j,k);
                end
                for jstep=1:nCells
                    matrices_out(i,j,k) = matrices_out(i,j,k) | matrices(i,j+jstep,k);
                end
            end
        end
    end
end

