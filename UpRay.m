classdef UpRay
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        cameraPoint, endPoint, endSlice, yDirection, startVoxel, vector
    end
    
    methods
        function obj = UpRay(cameraPoint,endPoint)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.cameraPoint = cameraPoint;
            obj.endPoint = endPoint;
            obj.endSlice = endPoint(:,3);
            obj.vector = endPoint - cameraPoint;
            
            if (cameraPoint(1) < endPoint(1))
                obj.yDirection = 1;
            else
                obj.yDirection = -1;
            end
            
            V0 = [1 1 1];
            n = [0 1 0];
            startPoint = plane_line_intersect(n,V0,cameraPoint,endPoint);
            if (startPoint(3) < 1)
                n = [0 0 1];
                startPoint = plane_line_intersect(n,V0,cameraPoint,endPoint);
            end
            obj.startVoxel = floor(round(startPoint,10));
        end
        
        function enters = doesEnterSideOf(obj,voxel)            
            % choose plane to try intersecting with
            if (obj.yDirection == -1)   
                voxel(1) = voxel(1) + 1;
            end
            n = [1 0 0];
            
            % find intersection point
            I = plane_line_intersect(n,voxel,obj.cameraPoint,obj.endPoint);
            pointX = I(3);
            pointZ = I(2);
            
            % if intersection point is within x and z boundaries
            enters = (pointX > voxel(3)) && (pointX < voxel(3) + 1) && (pointZ > voxel(2)) && (pointZ < voxel(2) + 1);
        end
        
        function enters = doesEnterFromBelow(obj,voxel)
            voxelY = voxel(1);
            %voxelZ = voxel(2);
            voxelX = voxel(3);
            
            % define plane to intersect with
            n = [0 1 0];
            
            % find intersection point
            I = plane_line_intersect(n,voxel,obj.cameraPoint,obj.endPoint);
            pointX = I(3);
            pointY = I(1);
                        
            % if intersection point is within y and x boundaries
            enters = (pointY > voxelY) && (pointY < voxelY + 1) && (pointX > voxelX) && (pointX < voxelX + 1);
        end
        
    end
end

