function [masks] = assign_closest_seed(stack_out,seedsx,seedsy,seedsz)

n_z = round(size(stack_out,3)/2);
n_x = round(size(stack_out,1)/2);
n_y = round(size(stack_out,2)/2);
[X,Y,Z] = meshgrid(1:n_x:size(stack_out,1),1:n_y:size(stack_out,2),1:n_z:size(stack_out,3));

X_vector = X(:);
Y_vector = Y(:);
Z_vector = Z(:);
increment = 1:length(X_vector);
voxels = NaN(1,length(seedsx));

for in = 1:length(seedsx)
    this_x(1,1) = seedsx(in);
    this_y(1,1) = seedsy(in);
    this_z(1,1) = seedsz(in);
    distance = NaN(1,length(increment));
    for ij = increment
        this_x(2,1) = X_vector(ij);
        this_y(2,1) = Y_vector(ij);
        this_z(2,1) = Z_vector(ij);
        distance(ij) = naneuclidean(this_x,this_y,this_z);
    end
    [~,index_min] = min(distance);
    voxels(in) = index_min;
end

uniq_vox = unique(voxels);
masks = NaN(length(seedsx),length(uniq_vox));
for ik = 1:length(uniq_vox)
    masks(:,ik) = voxels ==uniq_vox(ik);
end
end

