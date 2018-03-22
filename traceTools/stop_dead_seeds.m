function [stop] = stop_dead_seeds(x,y,z,dead_seedsx,dead_seedsy,dead_seedsz,current_stop,vx_minor,vy_minor,vz_minor,im_patch,maxI)

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

ALIVE = table(dead_seedsx',dead_seedsy',dead_seedsz','VariableNames',{'x' 'y' 'z'});
TRIAL = table(this_x',this_y',this_z','VariableNames',{'x' 'y' 'z'});
disp('STOP FUNCTION')
Lia1 = ismember(ALIVE,TRIAL);
%1 - is member => found // 0 - not member => not found in the list
width = 5;
width2 = 4;
direction = 1;
if sum(Lia1(:))~=0
    
    %tmp1 = ~Lia1;
    %0 - seeds to delete    // 1 - seeds that remain
    for ix = 1:length(dead_seedsx)
        new_x = dead_seedsx(ix);
        new_y = dead_seedsy(ix);
        new_z = dead_seedsz(ix);
        im = im_patch(new_x-width:new_x+width,new_y-width:new_y+width,new_z-width2:new_z+width2);%/input voxel
        [uN] = preprocess3D_LocalContrastEnhancement3(im, maxI);
        [u,v,w] = hessian3D_arrangeEigenVectors(uN,direction);
        u_current = [vx_minor, vy_minor, vz_minor];
        dot_prod = dot(u,u_current);
        if abs(dot_prod)>0.9
            stop = 60;
            disp('Same direction')
        else
            stop = current_stop;
        end
    end  
else
    %list without x,y,z
    stop = current_stop;
end



end

