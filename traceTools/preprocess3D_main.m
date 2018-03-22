function [stack_out,stack_out2] = preprocess3D_main(stack_in,resolution)
% preprocess3D_main.m
% Description: this function preprocesses the stack of slices following the
% steps: 1. scaling [the intensities in each slice are brought to the same range min - max]
%        2. padding [two extra slices are addded up and below the stack to allow tracing 
%                    within voxels at the boundaries of the stack]
%        3. interpolation [bring the distance between two pixels to be equal across all 3 dims]
%----------------------------------------------------------------------------------------------
% Input: stack_in - raw stack
%        resoltution - resolution across z/resoltution across x-y
% Output: stack_out - processed stack
%----------------------------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
%----------------------------------------------------------------------------------------------

offset = 5;%/how much we padd around the exterior
im_tmp = preprocess3D_scaling(stack_in); %/scaling
%im_tmp2 = imgaussian(im_tmp,[1 1],[2 2]); %/padding-removed at 31 October
images_interpolated = preprocess3D_interpolation(im_tmp,resolution); %/interpolation
im_tmp2 = preprocess3D_medfilt3(images_interpolated,[3,3,3],'circular',10);

disp('with medfilt3')
stack_out = preprocess3D_Zeropad3DImage(im_tmp2, offset);
disp('-----------------------------------------------------------')
disp('without medfilt3')
stack_out2 = preprocess3D_Zeropad3DImage(images_interpolated,offset);
disp('__Preprocessing terminated with no errors__')

end

