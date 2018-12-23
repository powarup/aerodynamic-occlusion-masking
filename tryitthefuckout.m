function [P,params,rotationMatrix,translationVector] = tryitthefuckout(camP,worldP,tiffin)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

triplicate = zeros(size(camP,1),2,3);
triplicate(:,:,1) = camP;
triplicate(:,:,2) = camP;
triplicate(:,:,3) = camP;

params = estimateCameraParameters(triplicate,worldP,'ImageSize',[size(tiffin,1),size(tiffin,2)])

[rotationMatrix,translationVector] = extrinsics(camP,worldP,params)

P = cameraMatrix(params,rotationMatrix,translationVector)
% 
% imshow(1-tiffin);
% hold on;
% 
% for i=1:length(worldP)
% 
% testPointW = [worldP(i,:) 0 1];
% 
% testPointC = testPointW*P;
% testPointC = testPointC / testPointC(3)
% 
% scatter(testPointC(1), testPointC(2), 1000,'rx');
% end
% hold off;
end

