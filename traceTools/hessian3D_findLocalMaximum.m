function [new_x,new_y,new_z] = hessian3D_findLocalMaximum(I,x,y,z,vx,vy,vz,radius)
% hessian3D_findLocalMaximum.m

% Description: Extracts a 2-D slice of the volume that is normal to the minor
% eigenvector. This is done with the function hessian3D_extractSlice.m. Then,
% on that 2-D plane it looks for the pixels with the highest intensity, and
% updates the new x,y,z coordinates to the coordinates of that found pixel.
%--------------------------------------------------------------------------
% Input: I - is the whole 3-D data set
%        x,y,z - the coordinates of the current step of the tracing
%        vx,vy,vz - the components of the minor eigenvector
% Output: new_x,new_y,new_z - the new coordinates
%--------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------

volume = I;
centerX = x;
centerY = y;
centerZ = z;
normX = vx;
normY = vy;
normZ = vz;
[slice, sliceInd, subX, subY, subZ] = hessian3D_extractSlice(volume,centerX,centerY,centerZ,normX,normY,normZ,radius);
n = length(slice(:));

good_dir = 0;
slice(isnan(slice))=0;
if ~isempty(slice)
    while ~isempty(n)
        [~,index_max]=max(slice(:));
        [m,n] = ind2sub(size(slice),index_max);
        new_x = round(subX(m,n));
        new_y = round(subY(m,n));
        new_z = round(subZ(m,n));
        if new_z>0 && new_x>0 && new_y>0
            tst_vx= [0 diff(x, new_x)];
            tst_vy =[0 diff(y, new_y)];
            tst_vz =[0 diff(z, new_z)];
            check_sign = dot([tst_vx,tst_vy,tst_vz],[vx,vy,vz]);
            if check_sign <0
                disp('negative dot')
                slice(m,n)=0;
                n=n-1;
            else
                good_dir = 1;
                break;
            end
            if good_dir == 0
                new_x = x;
                new_y = y;
                new_z = z;
            end
            
        else % new_z<0
            new_x = x;
            new_y = y;
            new_z = z;
            break;
        end % new_z<0
    end % while(~isempty(n))
else
    new_x = x;
    new_y = y;
    new_z = z;
end % if ~isempty(slice)


end

