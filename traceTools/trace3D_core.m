function [outputData] = trace3D_core(inputData)

% trace3D_mergeLeftRight.m

% Description: this function calls the trace3D_computeHessian.m script two
% times for each seed, to trace in both directions of the minor eigenvector.
% Then, it merges the two traces as follows: <---------------x----------->
% where 'x' is the connection point.
% -----------------------------------------------------------------------------------------------------------------------------------
% Input: im_patch - 3-D whole volume data;
%       maxI - maximum intensity found in the whole 3-D volume data;
%       x,y,z - coordinates for the starting point;
%       direction - can be either 1 or 2, meaning if it traces right or left;
%       seed_x_tmp,seed_y_tmp,seed_z_tmp - vectors containing the remaining valid seeds;
%       dead_seed_x,dead_seed_y,dead_seed_z - vectors containing the DEAD seeds - the ones that do not need to be explored;
%       radius - determines the size of the 2-D plane (normal to the direction of the minor eigenvector) that is sliced
%                through the axon;
%       size_3D_voxel - [width_x width_y width_z] of the voxel in which the Hessian is computed;
%       dst -  parameter that decides what seeds are turned into DEAD. It is an Euclidean distance;
% Output: new_trace_x,new_trace_y,new_trace_z - vectors containing the coordinates of the traced trajectories;
%        new_vxx,new_vyy,new_vzz - vectors containing the minor eigenvectors;
%        seed_x_tmp,seed_y_tmp,seed_z_tmp - updated vectors containing the remaining valid seeds;
%        dead_seed_x,dead_seed_y,dead_seed_z - updated vectors containing the DEAD seeds - the ones that do not need to be explored;
% -----------------------------------------------------------------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
% -----------------------------------------------------------------------------------------------------------------------------------


direction = 1;% <--- (x,y,z)
[dirx,diry,dirz,vxx,vyy,vzz,inputData] = trace3D_computeHessian(inputData,direction);%/TRACE

direction = 2;% (x,y,z) --->
[dirx_l,diry_l,dirz_l,vxx_l,vyy_l,vzz_l,inputData] = trace3D_computeHessian(inputData,direction);%/TRACE

% MERGE TRACES
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%//the vectors
found_vxx = vxx;
found_vyy = vyy;
found_vzz = vzz;
current_vxx = -vxx_l;
current_vyy = -vyy_l;
current_vzz = -vzz_l;
%//the coordinates
found_trace_x = dirx;
found_trace_y = diry;
found_trace_z = dirz;
current_trace_x = dirx_l;
current_trace_y = diry_l;
current_trace_z = dirz_l;
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if ~isempty(current_trace_x) && ~isempty(found_trace_x)
    
    new_trace_x = [current_trace_x found_trace_x(2:end)];
    new_trace_y = [current_trace_y found_trace_y(2:end)];
    new_trace_z = [current_trace_z found_trace_z(2:end)];
    new_vxx = [current_vxx found_vxx(2:end)];
    new_vyy = [current_vyy found_vyy(2:end)];
    new_vzz = [current_vzz found_vzz(2:end)];
    %[new_trace_x, new_trace_y, new_trace_z, new_vxx, new_vyy, new_vzz] = merge3D_LeftRight(found_trace_x, found_trace_y, found_trace_z, ...
    %                                        current_trace_x, current_trace_y, current_trace_z, ...
    %                                        found_vxx, found_vyy, found_vzz, ...
    %                                        current_vxx, current_vyy, current_vzz);%/MERGE <---x------->
end

%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if isempty(found_trace_x) && ~isempty(current_trace_x)
    new_vxx = -current_vxx;
    new_vyy = -current_vyy;
    new_vzz = -current_vzz;
    new_trace_x = current_trace_x;
    new_trace_y = current_trace_y;
    new_trace_z = current_trace_z;
end
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
if ~isempty(found_trace_x) && isempty(current_trace_x)
    new_vxx = found_vxx;
    new_vyy = found_vyy;
    new_vzz = found_vzz;
    new_trace_x = found_trace_x;
    new_trace_y = found_trace_y;
    new_trace_z = found_trace_z;
end

outputData.dead_seedsx = inputData.dead_seedsx;
outputData.dead_seedsy = inputData.dead_seedsy;
outputData.dead_seedsz = inputData.dead_seedsz;

outputData.new_trace_x = new_trace_x;
outputData.new_trace_y = new_trace_y;
outputData.new_trace_z = new_trace_z;

outputData.new_vxx = new_vxx;
outputData.new_vyy = new_vyy;
outputData.new_vzz = new_vzz;

outputData.seedsx = inputData.seedsx;
outputData.seedsy = inputData.seedsy;
outputData.seedsz = inputData.seedsz;

outputData.eigen_vectors = inputData.eigen_vectors;

end

