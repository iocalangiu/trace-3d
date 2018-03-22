n_z = round(size(stack_out,3)/3);
n_x = round(size(stack_out,1)/3);
n_y = round(size(stack_out,2)/2);

[Aaxons,uniq_voxels_tmp] = merge3D_divide_voxels(n_x,n_y,n_z,stack_out,axons);

uniq_voxels = NaN(1,8);
for ik = 1:length(uniq_voxels)
    if ismember(ik,uniq_voxels_tmp)
        uniq_voxels(ik) = ik;
    else
        uniq_voxels(ik) = NaN;
    end
end

index = 1;
axons_index_1 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_1] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_1.mat','axons_index_1')

index = 2;
axons_index_2 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_2] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_2.mat','axons_index_2')

index = 3;
axons_index_3 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_3] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_3.mat','axons_index_3')

index = 4;
axons_index_4 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_4] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_4.mat','axons_index_4')
mytoday


index = 5;
axons_index_5 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_5] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_5.mat','axons_index_5')

index = 6;
axons_index_6 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_6] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_6.mat','axons_index_6')

index = 7;
axons_index_7 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_7] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_7.mat','axons_index_7')

index = 8;
axons_index_8 = struct;
if ~isnan(uniq_voxels(index))
[axons_index_8] = merge3D_main_v2(Aaxons,stack_out,uniq_voxels(index));
end
save('axons_index_8.mat','axons_index_8')
mytoday


axons_all_indeces = struct;
count = 1;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_2;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_3;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end
axons_index_1 = axons_index_4;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_5;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_6;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_7;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_index_1 = axons_index_8;
if length(axons_index_1)>1
for ij = 1:length(axons_index_1)
    axons_all_indeces(count).directionx = axons_index_1(ij).directionx;
    axons_all_indeces(count).directiony = axons_index_1(ij).directiony;
    axons_all_indeces(count).directionz = axons_index_1(ij).directionz;
    count=count+1;
end
end

axons_all_indeces1 = axons_all_indeces;
save('axons_all_indeces1.mat','axons_all_indeces1')
