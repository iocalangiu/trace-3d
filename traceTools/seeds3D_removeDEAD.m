function [new_seed_x, new_seed_y, new_seed_z, dead_seed_x, dead_seed_y, dead_seed_z, vectors] = seeds3D_removeDEAD(seed_x_tmp, seed_y_tmp, seed_z_tmp, ...
                                                                                        x, y, z, ...
                                                                                       dead_seed_x, dead_seed_y, dead_seed_z,...
                                                                                       vx_minor, vy_minor, vz_minor, vectors)
%seeds3D_removeDEAD.m
%Description: If the inputs: x,y and z are found in the input lists: seed_x_tmp,seed_y_tmp and
%seed_z_tmp, then they are deleted from the current list and a new updated list is returned
%(new_seed), but also transfered from this list into a new list (dead). This dead list 
%contains seeds that were already discovered. The idea is not to trace later from these seeds,
%as they have been already reached.
%-------------------------------------------------------------------------------------------------
%Input - seed_y_tmp,seed_x_tmp,seed_z_tmp - 1-D vectors containing the coordinates of the seeds
%      - x,y,z - 1-D vectors containing the coordinates after which we look
%Output - new_seed_x,new_seed_y,new_seed_z - 1-D vectors containing the updated lists, w/out x,y,z
%       - dead_seed_x,dead_seed_y,dead_seed_z - 1-D vectors containing the
%         x,y,z coordinates of the already discovered seeds.
%-------------------------------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%-------------------------------------------------------------------------------------------------
ALIVE = table(seed_x_tmp',seed_y_tmp',seed_z_tmp','VariableNames',{'x' 'y' 'z'});
if size(x,1) == 1 && size(x,2) == 1
TRIAL = table(x,y,z,'VariableNames',{'x' 'y' 'z'});
end
if size(x,1) == 1 && size(x,2) ~= 1
TRIAL = table(x',y',z','VariableNames',{'x' 'y' 'z'});
end

Lia1 = ismember(ALIVE,TRIAL);
%1 - is member => found // 0 - not member => not found in the list
tmp1 = ~Lia1;
%0 - seeds to delete    // 1 - seeds that remain

seeds_to_put_dead_x = seed_x_tmp;
seeds_to_put_dead_y = seed_y_tmp;
seeds_to_put_dead_z = seed_z_tmp;

seed_x_tmp = seed_x_tmp.*tmp1';
seed_y_tmp = seed_y_tmp.*tmp1';
seed_z_tmp = seed_z_tmp.*tmp1';

rows_to_remove1 = (seed_x_tmp~=0);
rows_to_remove2 = (seed_y_tmp~=0);
rows_to_remove3 = (seed_z_tmp~=0);

%list without x,y,z
new_seed_x = seed_x_tmp(rows_to_remove1);
new_seed_y = seed_y_tmp(rows_to_remove2);
new_seed_z = seed_z_tmp(rows_to_remove3);

%list of dead seeds
dead_seed_x_tmp = seeds_to_put_dead_x(Lia1);
dead_seed_y_tmp = seeds_to_put_dead_y(Lia1);
dead_seed_z_tmp = seeds_to_put_dead_z(Lia1);

dead_seed_x = [dead_seed_x dead_seed_x_tmp];
dead_seed_y = [dead_seed_y dead_seed_y_tmp];
dead_seed_z = [dead_seed_z dead_seed_z_tmp];
vectors_tmp = repmat([vx_minor vy_minor vz_minor],size(dead_seed_z_tmp,2),1);
vectors = [vectors; vectors_tmp];

%if length(new_seed_x) == length(seed_x_tmp) - 1
    %disp('Just deleted one seed!')
%end

end

