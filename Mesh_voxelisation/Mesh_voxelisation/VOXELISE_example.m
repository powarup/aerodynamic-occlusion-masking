
%Plot the original STL mesh:
figure
[stlcoords] = READ_stl('baseline_round_w.STL');
xco = squeeze( stlcoords(:,1,:) )';
xrange = max(xco,[],'all') - min(xco,[],'all');
yco = squeeze( stlcoords(:,2,:) )';
yrange = max(yco,[],'all') - min(yco,[],'all');
zco = squeeze( stlcoords(:,3,:) )';
zrange = max(zco,[],'all') - min(zco,[],'all');
[hpat] = patch(xco,yco,zco,'b');
axis equal

scale = 2;

%%

%Voxelise the STL:
[OUTPUTgrid] = VOXELISE(floor(xrange)*scale,floor(yrange)*scale,floor(zrange)*scale,'baseline_round_w.STL','xyz');

%%
originalModel = OUTPUTgrid;
movedModel = flip(flip(originalModel,3),1);

%%

plotModel = slices;

%Show the voxelised result:
figure;
subplot(1,3,1);
imagesc(squeeze(sum(plotModel,1)));
colormap(gray(256));
xlabel('Z-direction');
ylabel('Y-direction');
axis equal tight

subplot(1,3,2);
imagesc(squeeze(sum(plotModel,2)));
colormap(gray(256));
xlabel('Z-direction');
ylabel('X-direction');
axis equal tight

subplot(1,3,3);
imagesc(squeeze(sum(plotModel,3)));
colormap(gray(256));
xlabel('Y-direction');
ylabel('X-direction');
axis equal tight
