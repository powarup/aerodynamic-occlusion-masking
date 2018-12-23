[P,params,rotationMatrix,translationVector] = tryitthefuckout(cameraPoints,worldPoints,tiffin)

worldP = zeros(100,2);
idx = 1;
for x = 1:100
    for y = 1:100
        worldP(idx,:) = [x y];
        idx = idx + 1;
    end
end

worldP(:,1) = worldP(:,1) - 50;

worldP = worldP * 15;

worldP(:,2) = worldP(:,2) - 9;

allreprojected = zeros(length(worldP),2);

%%

slice = rot90(slices(:,:,800),3);

worldP = zeros(sum(slice,'all'),2);
idx = 1;

for x = 1:size(slice,1)    
    for y = 1:size(slice,2)
        if slice(x,y) 
            worldP(idx,:) = [x*0.5 y*0.5];
            idx = idx + 1;
        end
    end
end


worldP(:,1) = worldP(:,1) - 130;

%%

worldP = worldPoints;
allreprojected = zeros(size(worldP,1),2);

for i=1:size(worldP,1)

testPointW = [worldP(i,:) 0 1];

testPointC = testPointW*P;
testPointC = testPointC / testPointC(3);

allreprojected(i,:) = [testPointC(1) testPointC(2)];
end

imshow(1-tiffin);
hold on;
scatter(allreprojected(:,1),allreprojected(:,2),1000,'rx');
hold off;
