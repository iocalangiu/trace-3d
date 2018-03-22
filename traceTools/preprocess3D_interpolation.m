function [im_cut_interp] = preprocess3D_interpolation(im_cut_sc,resolution)
%interpolation.m
%Description: this function interpolates with a scale in the x-y plane to
%have the same resolution along all the three dimensions.
%------------------------------------------------------------------------
%Input: im_cut_sc - 3-D volume
%       resolution - resolution across z plane/resolution across x-y plane
%Output: im_cut_interp - new 3-D volume
%-------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015

N = size(im_cut_sc,3);
for i = 1:N
    F=griddedInterpolant(im_cut_sc(:,:,i));
    image=im_cut_sc(:,:,i);
    x=linspace(1,size(image,1),size(image,1)/resolution);
    y=linspace(1,size(image,2),size(image,2)/resolution);
    im_cut_interp(:,:,i) =  F({x,y});
end

end

