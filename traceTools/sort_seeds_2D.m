function [seeds] = sort_seeds_2D(Q,seed_x,seed_y)

size_3D_voxel = [11 11 9];
radius = 1;

sizeX = size(Q,1);
sizeY = size(Q,2);

centerX1 = round(sizeX/4);
centerY1 = round(sizeY/4);

centerX2 = round(sizeX/4);
centerY2 = round(3*sizeY/4);

centerX3 = round(3*sizeX/4);
centerY3 = round(3*sizeY/4);

centerX4 = round(3*sizeX/4);
centerY4 = round(sizeY/4);

list_x_1 = [];
list_y_1 = [];

list_x_2 = [];
list_y_2 = [];

list_x_3 = [];
list_y_3 = [];

list_x_4 = [];
list_y_4 = [];

for ij = 1:length(seed_x)
    
    v2 = [seed_x(ij) seed_y(ij)]';

    v1 = [centerX1, centerY1]';
    e_d1 = sqrt(sum((v1 - v2) .^ 2));
    
    v1 = [centerX2, centerY2]';
    e_d2 = sqrt(sum((v1 - v2) .^ 2));
    
    v1 = [centerX3, centerY3]';
    e_d3 = sqrt(sum((v1 - v2) .^ 2));
    
    v1 = [centerX4, centerY4]';
    e_d4 = sqrt(sum((v1 - v2) .^ 2));
    
    e_d = [e_d1 e_d2 e_d3 e_d4];
    [min_value,min_pos] = min(e_d);
    
    switch min_pos(1)
        
        case 1
            list_x_1 = [list_x_1 seed_x(ij)];
            list_y_1 = [list_y_1 seed_y(ij)];
            
        case 2 
            list_x_2 = [list_x_2 seed_x(ij)];
            list_y_2 = [list_y_2 seed_y(ij)];
            
        case 3
            list_x_3 = [list_x_3 seed_x(ij)];
            list_y_3 = [list_y_3 seed_y(ij)];
            
        case 4            
            list_x_4 = [list_x_4 seed_x(ij)];
            list_y_4 = [list_y_4 seed_y(ij)];
            
    end
end

[seedsx_1,seedsy_1,seedsz_1] = seeds3D_findZcomponent(list_x_1,list_y_1,Q,size_3D_voxel,radius); % creating z dimension

[seedsx_2,seedsy_2,seedsz_2] = seeds3D_findZcomponent(list_x_2,list_y_2,Q,size_3D_voxel,radius); % creating z dimension

[seedsx_3,seedsy_3,seedsz_3] = seeds3D_findZcomponent(list_x_3,list_y_3,Q,size_3D_voxel,radius); % creating z dimension

[seedsx_4,seedsy_4,seedsz_4] = seeds3D_findZcomponent(list_x_4,list_y_4,Q,size_3D_voxel,radius); % creating z dimension

listseedsx{1} = seedsx_1;
listseedsy{1} = seedsy_1;
listseedsz{1} = seedsz_1;

listseedsx{2} = seedsx_2;
listseedsy{2} = seedsy_2;
listseedsz{2} = seedsz_2;

listseedsx{3} = seedsx_3;
listseedsy{3} = seedsy_3;
listseedsz{3} = seedsz_3;

listseedsx{4} = seedsx_4;
listseedsy{4} = seedsy_4;
listseedsz{4} = seedsz_4;

seeds.x = listseedsx;
seeds.y = listseedsy;
seeds.z = listseedsz;

% e_d = NaN(1,length(seed_x));
% for ij = 1:length(seed_x)
%     v1 = [1,1]';
%     v2 = [seed_x(ij) seed_y(ij)]';
%     e_d(ij) = naneuclidean(v1,v2);
% end
% 
% [~,b] = sort(e_d);
% new_seed_x = seed_x(b);
% new_seed_y = seed_y(b);
end

