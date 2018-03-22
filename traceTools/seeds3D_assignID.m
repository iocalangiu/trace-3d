function [seeds_id] = seeds3D_assignID(seedsx,seedsy)
%seeds3D_assignID.m
%Description: this function takes the x and y coordinates and assigns an id
%to each unique (x,y) pair
%---------------------------------------------------------------------------
%Input: seedsx, seedsy - 1-D vectors containing the coordinates of the seeds.
%Output: seeds_id - the ids
%---------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%---------------------------------------------------------------------------

a = [seedsx; seedsy];
count_id = 1;
seeds_id = zeros(numel(seedsx),1);

for ix = 1: numel(seedsx)
    
    ax = seedsx(ix);
    ay = seedsy(ix);
    tf = ismember(a',[ax ay],'rows');
    
    if seeds_id(tf) == 0
        seeds_id(tf) = count_id;
        count_id = count_id + 1;
    end
    
end


end

