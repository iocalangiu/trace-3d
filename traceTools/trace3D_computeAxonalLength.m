function [axonal_um,pixel_length] = trace3D_computeAxonalLength(axons,resolution)
%trace3D_computeAxonalLength.m
%Description: computes teh axonal length in micrometers by first computing
%the unitless length of the traces and then multiplying with the resolution.
%Update: needs to be changed so that to multiply with one resolution across
%x-y and another one across z.
%--------------------------------------------------------------------------
%Input: axons - a struct containing all the traces;
%       resolutions - [res_x res_y res_z]
%Output: axonal_um - axonal length in micrometers;
%        pixel_length - axonal length unitless.
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------
res_x = resolution(1);
res_y = resolution(2);
res_z = resolution(3);
pixel_length = 0;
axonal_um = 0;
for ii = 1: numel(axons)
    clear data_set
    data_set = [axons(ii).directionx',axons(ii).directiony',axons(ii).directionz'];
    if ~isempty(data_set)
        l = size(data_set,1);
        len_um = sum( sqrt( sum( diff(data_set,1,1).^2.*[ones(l-1,1)*res_x ones(l-1,1)*res_y ones(l-1,1)*res_z].^2 ,2)) ,1);
        len = sum( sqrt( sum( diff(data_set,1,1).^2 ,2)) ,1);
        pixel_length = pixel_length + len;
        axonal_um = axonal_um + len_um;
    end
    
end

end

