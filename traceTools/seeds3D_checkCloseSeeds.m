function [closest_seed_x,closest_seed_y,closest_seed_z] = seeds3D_checkCloseSeeds(x,y,z,seed_x,seed_y,seed_z, ...
    dead_seed_x,dead_seed_y,dead_seed_z,vectors,vx_minor,vy_minor,vz_minor,dst)
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
[close_voxel_x, close_voxel_y, close_voxel_z] = meshgrid(x-dst:x+dst, y-dst:y+dst, z-dst:z+dst);

ALIVE = table(seed_x',seed_y',seed_z','VariableNames',{'x' 'y' 'z'});
TRIAL = table(close_voxel_x(:),close_voxel_y(:),close_voxel_z(:),'VariableNames',{'x' 'y' 'z'});

Lia1 = ismember(ALIVE,TRIAL);
%1 - is member => found // 0 - not member => not found in the list
tmp1 = Lia1;
%tmp1 = ~Lia1;
%0 - seeds to delete    // 1 - seeds that remain

new_seed_x = seed_x(tmp1);
new_seed_y = seed_y(tmp1);
new_seed_z = seed_z(tmp1);
%distance = abs(dist_x) + abs(dist_y) + abs(dist_z);
%distance(distance>dst) = 0; %/ saves the seeds that are far
%distance = distance>0; %/ mask

%check_x = distance.*seed_x; 
%check_y = distance.*seed_y;
%check_z = distance.*seed_z;

%tmp_x = check_x>0;
%new_seed_x = seed_x(tmp_x);
%tmp_y= check_y>0;
%new_seed_y = seed_y(tmp_y);
%tmp_z= check_z>0;
%new_seed_z = seed_z(tmp_z);

ALIVE2 = table(dead_seed_x',dead_seed_y',dead_seed_z','VariableNames',{'x' 'y' 'z'});
Lia1 = ismember(ALIVE2,TRIAL);
find_members = find(Lia1==1);
v2 = [vx_minor, vy_minor, vz_minor];
% for ij = 1:length(find_members)
%     find_members(ij)
%     v1 = vectors(find_members(ij),:);
%     dot_ij = abs(dot(v1,v2));
%     if dot_ij > 0.9
%         stop = stop_final;
%         disp(['Stop is now.. ' num2str(stop)])
%         break;
%     end
% end
clear dist_x;
clear dist_y;
clear dist_z;

if ~isempty(new_seed_x)   
    closest_seed_x = new_seed_x;
    closest_seed_y = new_seed_y;
    closest_seed_z = new_seed_z;    
    %stop = stop + 5;
    %disp(['Close seeds.. ' num2str(length(new_seed_x))])
    %disp(['Stop is now.. ' num2str(stop)])
else
    closest_seed_x = [];
    closest_seed_y = [];
    closest_seed_z = [];
end

end

