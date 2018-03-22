function [colour_channel] = chooseColourChannel(tif_stack,colour)
%chooseColourChannel.m
%Description: this function takes a stack of RGB colours and outputs a
%stack of images with only one colour channel (red, green or blue),
%depending which is the channel that contains the useful intensity information.
%-----------------------------------------------------------------------------
%Input: tif_stack - stack of RGB colours, is a cell type variable, each cell 
%                   containing a RGB 2-D image;
%       colour - specifies which colour to be extracted: 1 - Red
%                                                        2 - Green
%                                                        3 - Blue
%Output: colour_channel - a 3-D matrix containing 2-D images with only one
%                         channel.
%-----------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%-----------------------------------------------------------------------------
tmp1 = tif_stack{1}; %/load the first image to get the dimensions
m = size(tmp1,1);
n = size(tmp1,2);
n_colours = size(tmp1,3);
z = length(tif_stack);
colour_channel = zeros(m,n,z);

if n_colours>1
for i = 1:length(tif_stack)
  disp(['Extracting from slice ' num2str(i) '.'])
  tmp = tif_stack{i};
  tmp = cast(tmp,'double');
  colour_channel(:,:,i) = tmp(:,:,colour);  
end

else
    
for i = 1:length(tif_stack)
    disp(['Extracting from slice ' num2str(i) '.'])
    tmp = tif_stack{i};
    tmp = cast(tmp,'double');
    colour_channel(:,:,i) = tmp;  
end
end


end

