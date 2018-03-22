function [new_seed_x,new_seed_y,new_seed_z,dead_seed_x,dead_seed_y,dead_seed_z] = close_seeds2(x,y,z,seed_x,seed_y,seed_z,dead_seed_x,dead_seed_y,dead_seed_z)

widthx = 1;
widthz = 1;
count = 1;
for ix = x-widthx:x+widthx
    for iy = y-widthx:y+widthx
        for iz = z-widthz:z+widthz
            this_x(count)=ix;
            this_y(count)=iy;
            this_z(count)=iz;
            count=count+1;
        end
    end
end

ALIVE = table(seed_x',seed_y',seed_z','VariableNames',{'x' 'y' 'z'});
TRIAL = table(this_x',this_y',this_z','VariableNames',{'x' 'y' 'z'});

Lia1 = ismember(ALIVE,TRIAL);
%1 - is member => found // 0 - not member => not found in the list

if sum(Lia1(:))~=0
    
tmp1 = ~Lia1;
%0 - seeds to delete    // 1 - seeds that remain

seeds_to_put_dead_x = seed_x;
seeds_to_put_dead_y = seed_y;
seeds_to_put_dead_z = seed_z;

seed_x = seed_x.*tmp1';
seed_y = seed_y.*tmp1';
seed_z = seed_z.*tmp1';

rows_to_remove1 = (seed_x~=0);
rows_to_remove2 = (seed_y~=0);
rows_to_remove3 = (seed_z~=0);

%list without x,y,z
new_seed_x = seed_x(rows_to_remove1);
new_seed_y = seed_y(rows_to_remove2);
new_seed_z = seed_z(rows_to_remove3);

%list of dead seeds
dead_seed_x_tmp = seeds_to_put_dead_x(Lia1);
dead_seed_y_tmp = seeds_to_put_dead_y(Lia1);
dead_seed_z_tmp = seeds_to_put_dead_z(Lia1);

dead_seed_x = [dead_seed_x dead_seed_x_tmp];
dead_seed_y = [dead_seed_y dead_seed_y_tmp];
dead_seed_z = [dead_seed_z dead_seed_z_tmp];
else
    %list without x,y,z
    new_seed_x = seed_x;
    new_seed_y = seed_y;
    new_seed_z = seed_z;
    disp('no matching seeds found')
end

end

