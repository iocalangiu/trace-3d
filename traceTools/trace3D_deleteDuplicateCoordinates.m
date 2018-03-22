function [new_axons] = trace3D_deleteDuplicateCoordinates(axons)
%trace3D_deleteDuplicateCoordinates
%Description: this function checks the trajectory of each trace and deletes
%coordinates that appear more times in the same trace. In other words,
%makes sure that all the (x_i,y_i,z_i) pairs in a trace are unique pairs.
%--------------------------------------------------------------------------
%Input: axons - struct that contains all the traces
%Output: new_axons - new 'cleaned' struct
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015

%disp('Delete Duplicates Coordinates')
%disp('-----------------------------------------------------------')
new_axons = struct;
for ij = 1: size(axons,2)
    
    dirx = axons(ij).directionx;
    diry = axons(ij).directiony;
    dirz = axons(ij).directionz;
    
    vxx = axons(ij).vxx;
    vyy = axons(ij).vyy;
    vzz = axons(ij).vzz;
    
    all_dir = [dirx',diry',dirz',vxx',vyy',vzz'];
    all_dir(all_dir(:,1) == all_dir(:,2) == all_dir(:,3)) = [];
    
    new_axons(ij).directionx = all_dir(:,1);
    new_axons(ij).directiony = all_dir(:,2);
    new_axons(ij).directionz = all_dir(:,3);
    
    new_axons(ij).vxx = all_dir(:,4);
    new_axons(ij).vyy = all_dir(:,5);
    new_axons(ij).vzz = all_dir(:,6);
    
    new_axons(ij).seedsid= axons(ij).seedsid;
    new_axons(ij).starting_points = axons(ij).starting_points;
end

end

