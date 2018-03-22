function axons = assign_closest_reference(axons,X,Y,Z)

X_vector = X(:);
Y_vector = Y(:);
Z_vector = Z(:);
increment = 1:length(X_vector);

for in = 1:length(axons)
    this_x(1,1) = axons(in).middleCoord(1);
    this_y(1,1) = axons(in).middleCoord(2);
    this_z(1,1) = axons(in).middleCoord(3);
    distance = NaN(1,length(increment));
    for ij = increment
        this_x(2,1) = X_vector(ij);
        this_y(2,1) = Y_vector(ij);
        this_z(2,1) = Z_vector(ij);
        distance(ij) = naneuclidean(this_x,this_y,this_z);
    end
    [~,index_min] = min(distance);
    axons(in).voxel = index_min;
end


end

