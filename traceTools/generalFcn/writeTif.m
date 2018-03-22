function writeTif(stack, name_tif_stack)
%writeTif.m
%Description: this function creates a stack of 2-D slices in 'tif' format
%--------------------------------------------------------------------------
%Input: stack - cell variable, each cell contains an RGB 2-D slice
%       name_tif_stack - string with the name of the 'tif' file
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------
offset = 5;
for j = 1:length(stack)
    tmp = stack{j};
    stack_out2 = preprocess3D_Zeropad3DImage(tmp,offset);
end
imwrite(stack{1}, name_tif_stack)
for k = 2:length(stack)
    imwrite(stack{k}, name_tif_stack , 'writemode', 'append');
end
end

