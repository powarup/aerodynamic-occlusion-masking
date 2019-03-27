function plotModel(model)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%Show the voxelised result:
figure;
subplot(1,3,1);
imagesc(squeeze(sum(model,1)));
colormap(gray(256));
xlabel('Z-direction (Isabel''s X)');
ylabel('Y-direction');
axis equal tight

subplot(1,3,2);
imagesc(0,-130,squeeze(sum(model,2)));
colormap(gray(256));
xlabel('Z-direction (Isabel''s X)');
ylabel('X-direction');
axis equal tight

subplot(1,3,3);
imagesc(0,-130,squeeze(sum(model,3)));
colormap(gray(256));
xlabel('Y-direction');
ylabel('X-direction');
axis equal tight
end

