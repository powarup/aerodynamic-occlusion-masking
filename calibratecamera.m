%% import TIFF
tiffin = imread('B00001_3.tif');
toprow = 10;

tiffin = tiffin - prctile(tiffin,90,'all');
tiffin = tiffin / max(max(tiffin));
tiffin = double(tiffin);
tiffin = tiffin - 0.5;
tiffin = tiffin * 2;
idx = (tiffin < 0);
tiffin(idx) = 0;
imshow(1-tiffin,[0 max(max(tiffin))]);


generate_world_points;

%% find points to calibrate to

disp('click the corners');
cornerImagePoints = ginput(4)


disp('click the middle 27');
middleImagePoints = ginput(27)


disp('click the top 27');
topImagePoints = ginput(27)


disp('click the bottom 27');
bottomImagePoints = ginput(27)

allImagePoints = [cornerImagePoints;middleImagePoints;topImagePoints;bottomImagePoints];

%% calibrate

[P,params,rotationMatrix,translationVector] = tryitthefuckout(cornerImagePoints,cornerWorldPoints,tiffin);

%% reproject

worldPointsToProject = worldPoints;
groundTruth = allImagePoints;

allreprojected = zeros(size(worldPointsToProject,1),2);

for i=1:size(worldPointsToProject,1)

testPointW = [worldPointsToProject(i,:) 0 1];

testPointC = testPointW*P;
testPointC = testPointC / testPointC(3);

allreprojected(i,:) = [testPointC(1) testPointC(2)];
end

imshow(1-tiffin);
hold on;
scatter(allreprojected(:,1),allreprojected(:,2),1000,'rx');
hold off;

reprojectionError = mean(vecnorm(allreprojected - groundTruth,2,2));

%% save

save('camera4_calibration.mat','P','params','rotationMatrix','translationVector','cornerImagePoints','middleImagePoints','topImagePoints','bottomImagePoints','allImagePoints','cornerWorldPoints','middleWorldPoints','topWorldPoints','bottomWorldPoints','worldPoints','reprojectionError');