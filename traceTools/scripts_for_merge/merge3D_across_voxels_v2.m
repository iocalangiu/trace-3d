function [axons] = merge3D_across_voxels_v2(Aaxons,index,step_trace)

ccount = 1;
axons =  struct;
stp_crit = 0;
for ij = 1:length(Aaxons)
    if Aaxons(ij).voxel == index
        axons(ccount).directionx = Aaxons(ij).directionx;
        axons(ccount).directiony = Aaxons(ij).directiony;
        axons(ccount).directionz = Aaxons(ij).directionz;
        axons(ccount).voxel = Aaxons(ij).voxel;
        ccount = ccount + 1;
    end
end


differences = [];
%while stp_crit == 0
for stop_itertations = 1:20
    
[~,pixel_length1] = trace3D_computeAxonalLength(axons,[1 1 1]);

new_axons = struct;
close_dots = 0;
tic
for ik = index;%1:length(a)
    disp('===============================================================')
    disp(['ik = ' num2str(ik)])
    [new_axons,close_dots_tmp] = create_pairs(axons,ik,step_trace);
    close_dots = close_dots_tmp + close_dots;
end
toc

axons_merged = struct;
count = 1;
%for ik = index;%1:length(a)
    if isfield(new_axons,'directionx')
    for ij = 1:length(new_axons)
        axons_merged(count).directionx = new_axons(1,ij).directionx;
        axons_merged(count).directiony = new_axons(1,ij).directiony;
        axons_merged(count).directionz = new_axons(1,ij).directionz;
        axons_merged(count).voxel = index;
        count=count+1;
    end
    end
%end

[~,pixel_length2] = trace3D_computeAxonalLength(axons_merged,[1 1 1]);

abs(pixel_length1-pixel_length2)
differences = [differences abs(pixel_length1-pixel_length2)];

if abs(pixel_length1-pixel_length2) < 1
    %stp_crit = 1;
    axons = axons_merged;
    break;
end

difference_in_pixels = abs(pixel_length1-pixel_length2);
if difference_in_pixels > 200
    step_trace = 10;
end

if difference_in_pixels < 200 && difference_in_pixels > 100
    step_trace = 6;
end

if difference_in_pixels < 100 && difference_in_pixels > 50
    step_trace = 4;
end

if difference_in_pixels < 50 
    step_trace = 2;
end

if length(differences) > 2 
    if differences(end) == differences(end-1)
        %stp_crit = 1;
        axons = axons_merged;
        break;
    end
end
clear Aaxons
axons = axons_merged;
end

end

