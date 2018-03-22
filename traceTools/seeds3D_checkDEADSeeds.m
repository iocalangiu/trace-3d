function [stop_new] = seeds3D_checkDEADSeeds(x,y,z,dead_seed_x,dead_seed_y,dead_seed_z,dst,stop_current,stop_final)

%stop_current is current itr
%stop_final is the max number of iterations imposed
%stop_new is the new current itr/ may be changed or may be the same.

%seeds3D_checkCloseSeeds.m
%Description: Checks whether there are close seeds, depends on dst parameter of how close,
%near the input coordinates (x,y,z). If there are more than 1 close seeds, checks the closest.
%------------------------------------------------------------------------------------------------- 
%Input - x,y,z - current coordinates;
%      - seed_x,seed_y,seed_z - list of seeds, x,y,z coordinates;
%      - dst - distance that determines which seeds are CLOSE to be transformed into DEAD      
%Output: - closest_seed_x,closest_seed_y,closest_seed_z - the new (x,y,z) coordinates if there
%                                                         are any close seeds, if not they equal=[]
%------------------------------------------------------------------------------------------------- 
%Author: Ioana Calangiu, Imperial College London, 2015
%-------------------------------------------------------------------------------------------------
%dist_x = seed_x - ones(1,length(seed_x))*x;
%dist_y = seed_y - ones(1,length(seed_y))*y;
%dist_z = seed_z - ones(1,length(seed_z))*z;
[close_voxel_x, close_voxel_y, close_voxel_z] = meshgrid(x-dst:x+dst, y-dst:y+dst, z);

ALIVE = table(dead_seed_x',dead_seed_y',dead_seed_z','VariableNames',{'x' 'y' 'z'});
TRIAL = table(close_voxel_x(:),close_voxel_y(:),close_voxel_z(:),'VariableNames',{'x' 'y' 'z'});

Lia1 = ismember(ALIVE,TRIAL);
%1 - is member => found // 0 - not member => not found in the list
%tmp1 = Lia1;
%tmp1 = ~Lia1;
%0 - seeds to delete    // 1 - seeds that remain

if sum(Lia1)~=0
    stop_new = 1;
    disp('We-ve traced around here before...')
else
    stop_new = 0;
end


end

