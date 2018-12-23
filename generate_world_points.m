centre = [0 171];
stepsH = 11;
stepsV = 11;

yStep = 7.5;
zStep = 15;

worldPointCells = cell(45,23);
middleWorldPoints = zeros(45*23,2);

y = -22*yStep;
z = 11*zStep+171;

idx = 1;

for i=1:45
    x = (mod(i,2) - 1) * 7.5;
    for j=1:23
        worldPointCells{i,j} = [y z x];
        middleWorldPoints(idx,:) = [y z];
        idx = idx + 1;
        z = z - zStep;
    end
    z = 11*zStep+171;
    y = y + yStep;
end

%%

cornerWorldPoints = zeros(4,2);
cornerWorldPoints(1,:) = [-10*15 171+toprow*15];
cornerWorldPoints(2,:) = [10*15 171+toprow*15];
cornerWorldPoints(3,:) = [10*15 171-11*15];
cornerWorldPoints(4,:) = [-10*15 171-11*15];

%%

middleWorldPoints = zeros(27,2);
y = -4*15;
z = 171;
for k = 1:9
    middleWorldPoints(k,:) = [y z];
    y = y + 15;
end

y = y - 15;
z = z - zStep;

for k = 10:18
    middleWorldPoints(k,:) = [y z];
    y = y - 15;
end

y = y + 15;
z = z - zStep;

for k = 19:27
    middleWorldPoints(k,:) = [y z];
    y = y + 15;
end

%%

topWorldPoints = zeros(27,2);
y = -4*15;
z = 171+11*15;
for k = 1:9
    topWorldPoints(k,:) = [y z];
    y = y + 15;
end

y = y - 15;
z = z - zStep;

for k = 10:18
    topWorldPoints(k,:) = [y z];
    y = y - 15;
end

y = y + 15;
z = z - zStep;

for k = 19:27
    topWorldPoints(k,:) = [y z];
    y = y + 15;
end

%%

bottomWorldPoints = zeros(27,2);
y = -4*15;
z = 171-9*15;
for k = 1:9
    bottomWorldPoints(k,:) = [y z];
    y = y + 15;
end

y = y - 15;
z = z - zStep;

for k = 10:18
    bottomWorldPoints(k,:) = [y z];
    y = y - 15;
end

y = y + 15;
z = z - zStep;

for k = 19:27
    bottomWorldPoints(k,:) = [y z];
    y = y + 15;
end

%%

worldPoints = [cornerWorldPoints;middleWorldPoints;topWorldPoints;bottomWorldPoints];

%%
% 
% worldPoints3D = zeros(27,3);
% worldPoints3D(:,1:2) = middleworldPoints;
% 
% reprojected = zeros(27,3);
% 
% for n = 1:27
%     reprojected(n,:,1) = P * (worldPoints3D(n,:,1))'
% end