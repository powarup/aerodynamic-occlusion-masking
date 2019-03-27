function matrices_out = smear_time(matrices,nSteps)
%SMEAR_TIME performs logical AND with kernel size nSteps in the 3rd
%dimension
%   Detailed explanation goes here
    
    totalTime = length(matrices);
    
    matrices_out = false(size(matrices));
    
    for t=1+nSteps:totalTime-1-nSteps
        matrices_out(:,:,t) = matrices(:,:,t);
        for s=1:nSteps
            matrices_out(:,:,t) = matrices_out(:,:,t) & matrices(:,:,t-s) & matrices(:,:,t+s);
        end
    end
            
end

