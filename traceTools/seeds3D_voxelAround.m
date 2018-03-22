function [seeds_info] = seeds3D_voxelAround(seedsx,seedsy,seedsz)
dst = 10;
close_seeds = NaN(1,length(seedsx));

for ij = 1:length(seedsx)
    [close_voxel_x,close_voxel_y,close_voxel_z]=meshgrid(seedsx(ij)-dst:seedsx(ij)+dst,seedsy(ij)-dst:seedsy(ij)+dst,seedsz(ij)-dst/2:seedsz(ij)+dst/2);
    
    ALIVE = table(seedsx',seedsy',seedsz','VariableNames',{'x' 'y' 'z'});
    TRIAL = table(close_voxel_x(:),close_voxel_y(:),close_voxel_z(:),'VariableNames',{'x' 'y' 'z'});
    
    Lia1 = ismember(ALIVE,TRIAL);
    close_seeds(ij) = sum(Lia1);
end

stops = round(300*ones(1,length(seedsx))./close_seeds);
seeds_info = [seedsx', seedsy', seedsz', close_seeds', stops'];

end

