tiffin = imread('B00001_3.tif');
tiffin = tiffin - prctile(tiffin,[90],'all');
corners = corner(tiffin);

imshow(tiffin,[0 max(max(tiffin))];
hold on;
scatter(corners(:,1), corners(:,2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);