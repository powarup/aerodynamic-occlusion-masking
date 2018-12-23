tiffin = imread('B00001_4.tif');
tiffin = tiffin - prctile(tiffin,[90],'all');
tiffin = tiffin / max(max(tiffin));
tiffin = double(tiffin);
tiffin = tiffin - 0.5;
tiffin = tiffin * 2;
idx = (tiffin < 0);
tiffin(idx) = 0;
imshow(1-tiffin,[0 max(max(tiffin))]);

%%

cornerImagePoints = detectHarrisFeatures(tiffin);
imshow(1-tiffin,[0 max(max(tiffin))]);
hold on;
numberwanted = 1900;
%strongest = corners.selectStrongest(numberwanted);
%strongest.plot
hold off;

%%

threshold = 15;

cornerPoints = strongest.Location;

%%

for i=1:numberwanted
    currentPoint = cornerPoints(i,:);
    moved = cornerPoints - currentPoint;
    distances = vecnorm(moved,2,2);
    %prune_idx = min(distances(distances>0))
    prune_idx = distances < threshold;
    prune_idx(i) = 0;
    cornerPoints(prune_idx,:) = 0;
end

cornerPoints = cornerPoints(any(cornerPoints,2),:);

imshow(tiffin,[0 max(max(tiffin))]);
hold on;
scatter(cornerPoints(:,1),cornerPoints(:,2),1000,'r.');
hold off;

%%

disp('click the corners');
cornerImagePoints = ginput(4)


disp('click the middle 27');
middleImagePoints = ginput(27)


disp('click the top 27');
topImagePoints = ginput(27)


disp('click the bottom 27');
bottomImagePoints = ginput(27)

%%

cameraPoints = [cornerImagePoints;middleImagePoints;topImagePoints;bottomImagePoints];
tripledCameraPoints = zeros(85,2,3);
tripledCameraPoints(:,:,1) = cameraPoints;
tripledCameraPoints(:,:,2) = cameraPoints;
tripledCameraPoints(:,:,3) = cameraPoints;

%%

tripledImagePoints = zeros(27,2,3);
tripledImagePoints(:,:,1) = imagePoints;
tripledImagePoints(:,:,2) = imagePoints;
tripledImagePoints(:,:,3) = imagePoints;

%%

