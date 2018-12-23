parpool(8);

timestart = datetime();

spmd
    myrangestart = 1 + (labindex - 1)*8*62;
    myrangeend = 1 + labindex*8*55;
    if labindex == 8
        myrangeend = size(visibilitymodel,2);
    end
    for z=myrangestart:size(visibilitymodel,2)
        col_3 = false([size(visibilitymodel,1) 1]);
        col_4 = false([size(visibilitymodel,1) 1]);
        for y=1:size(visibilitymodel,1)
            pixel = [y z 300];
            ray_3 = UpRay(thiscamera3,pixel);
            col_3(y) = raycast(ray_3,ray_3.startVoxel,visibilitymodel,-1);
            ray_4 = UpRay(thiscamera4,pixel);
            col_4(y) = raycast(ray_4,ray_4.startVoxel,visibilitymodel,1);
        end
    end
end

datetime() - timestart