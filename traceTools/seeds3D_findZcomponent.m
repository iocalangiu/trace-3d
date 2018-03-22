function [new_seedsx,new_seedsy,new_seedsz] = seeds3D_findZcomponent(new_seed_x,new_seed_y,stack,size_3D_voxel,radius)


size_3D_voxel = (size_3D_voxel-1)/2;
width = size_3D_voxel(1);
widthz = size_3D_voxel(3);
new_seedsx = [];
new_seedsy = [];
new_seedsz = [];
maxI = max(stack(:));

for c = 1: numel(new_seed_x)
    
    tmp = stack(new_seed_x(c),new_seed_y(c),:);
    [~,idx] = max(tmp);
    %/update 01 November
    %x = seedsx(end);
    %y = seedsy(end);
    %z = seedsz(end);
    x = new_seed_x(c);
    y = new_seed_y(c);
    z = idx;
    
    im = stack(x-width:x+width,y-width:y+width,z-widthz:z+widthz);
    [uN] = preprocess3D_LocalContrastEnhancement3(im, maxI);
    direction = 1;%/does not matter; can be 1 or 2
    [u,v,w] = hessian3D_arrangeEigenVectors(uN,direction);
    
    if ~isempty(u)
    vx = u(1);
    vy = u(2);
    vz = u(3);
    [new_x,new_y,new_z] = hessian3D_findLocalMaximum(stack,x,y,z,vx,vy,vz,radius);
    new_seedsx = [new_seedsx new_x];
    new_seedsy = [new_seedsy new_y];
    new_seedsz = [new_seedsz new_z];
    
    end
end

end

