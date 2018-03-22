function [Aaxons,uniq_voxels] = merge3D_divide_voxels(n_x,n_y,n_z,stack_out,Aaxons)

[X,Y,Z] = meshgrid(1:n_x:size(stack_out,1),1:n_y:size(stack_out,2),1:n_z:size(stack_out,3));
[Aaxons] = create_middle_point(Aaxons);
Aaxons = assign_closest_reference(Aaxons,X,Y,Z);

voxels = NaN(1,length(Aaxons));
for ij = 1:length(Aaxons)
    voxels(ij) = Aaxons(ij).voxel; 
end

uniq_voxels = unique(voxels);
end

