function [frame_3,frame_4] = computeFrame(visibilitymodel,x,camera3_position,camera4_position)
%computeFrame put it all in a function make it go fast parallel???
%   Detailed explanation goes here
    frame_3 = false([size(visibilitymodel,1) size(visibilitymodel,2)]);
    frame_4 = false([size(visibilitymodel,1) size(visibilitymodel,2)]);
    for z=1:size(visibilitymodel,2)
        for y=1:size(visibilitymodel,1)
            pixel = [y z x];
            ray_3 = UpRay(camera3_position,pixel);
            frame_3(y,z) = raycast3(ray_3,visibilitymodel);
            ray_4 = UpRay(camera4_position,pixel);
            frame_4(y,z) = raycast3(ray_4,visibilitymodel);
        end
    end
end

