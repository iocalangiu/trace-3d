function [seed_x,seed_y,hfig] = seeds3D_main_short(stack_out,window_size)
%seeds3D_main.m
%Description: this function takes the maximum projection of intensity across the z dimension 
%onto the x-y plane and from this 2D image generates the seed points following the steps:
% 1. demo_seeds: In a GUI, the user can interactively choose the lower limit and upper 
% limit for thresholding => from here result a 2-D binary image
% 2. distance transform [on the binary image, each pixel is labeled with a value
%                        representing how far it is from the nearest boundary pixel]
% 3. seed search x,y coord [looking for local maxima within search windows of size: window_size]
% 4. z coord [adding the z coordinate by looking across the z dimension and
% choosing the level with the highest intensity. There we take a 3-D voxel
% surrounding that point, compute the ....
%-------------------------------------------------------------------------------------------------
%Input: stack_out - stack of slices (3-D data)
%       window_size - the size of the window into which you look for seeds (the bigger the window,
%                     the less the number of seeds
%       Q - the 3-D data blurred with the Gaussian (SPM)
%Output: seedsx,seedsy,seedsz - x,y,z coordinates of the seeds
%        f_this - the distance transform image
%-------------------------------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
%-------------------------------------------------------------------------------------------------
%size_3D_voxel = (size_3D_voxel-1)/2;

[binaryImage,lowThreshold,highThreshold] = gui_seeds3D_binarizeMAP(stack_out);
[f_this] = seeds3D_distanceTransform(1,binaryImage); % distance transform
[seed_x,seed_y] = seeds3D_searchLocalMaxima(f_this); % seed search
% [seedsx,seedsy,seedsz] = seeds3D_findZcomponent(seed_x,seed_y,Q,size_3D_voxel,radius); % creating z dimension
% 
% %/Plotting result
hfig = figure; imagesc(f_this); hold on; colormap gray; colorbar
title('x and y coordinates of the seeds plotted on top of the distance transform 2-D image')
xlabel('x axis','interpreter','latex')
ylabel('y axis','interpreter','latex')
axis equal
axis off
scatter(seed_y,seed_x,'r.')
hold off



end

