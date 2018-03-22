function [Aaxons] = merge3D_across_voxels(n_x,n_y,n_z,stack_out,Aaxons,step_trace)

[X,Y,Z] = meshgrid(1:n_x:size(stack_out,1),1:n_y:size(stack_out,2),1:n_z:size(stack_out,3));
a = X(:);
stp_crit = 0;

varname = cell(1,length(a));
for ik = 1:length(a)
    varname{ik} = ['patch' num2str(ik)];
end

differences = [];
while stp_crit == 0

[Aaxons] = create_middle_point(Aaxons);
Aaxons = assign_closest_reference(Aaxons,X,Y,Z);

[~,pixel_length1] = trace3D_computeAxonalLength(Aaxons,[1 1 1]);

new_axons = struct;
close_dots = 0;
tic
for ik = 1:length(a)
    disp('===============================================================')
    disp(['ik = ' num2str(ik)])
    [new_axons.(varname{ik}),close_dots_tmp] = create_pairs(Aaxons,ik,step_trace);
    close_dots = close_dots_tmp + close_dots;
end
toc

axons_merged = struct;
count = 1;
for ik = 1:length(a)
    if isfield(new_axons.(varname{ik}),'directionx')
    for ij = 1:length(new_axons.(varname{ik}))
        axons_merged(count).directionx = new_axons.(varname{ik})(1,ij).directionx;
        axons_merged(count).directiony = new_axons.(varname{ik})(1,ij).directiony;
        axons_merged(count).directionz = new_axons.(varname{ik})(1,ij).directionz;
        count=count+1;
    end
    end
end

[~,pixel_length2] = trace3D_computeAxonalLength(axons_merged,[1 1 1]);

abs(pixel_length1-pixel_length2)
differences = [differences abs(pixel_length1-pixel_length2)];

if abs(pixel_length1-pixel_length2) < 1
    stp_crit = 1;
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
        stp_crit = 1;
    end
end
clear Aaxons
Aaxons = axons_merged;
end

end

