function [f_this] = seeds3D_distanceTransform(threshold,outputImage)
%seeds3D_distanceTransform.m
%Description: this function computes the distance transform of a binary 2-D
%image. This is a well known operation in image processing. Each forground
%pixel (1 in this case, 0 being the background) gets labelled to how far it
%is from the nearest forground pixel. Therefore, the pixels right next to
%the boundary will be labelled with '1', and the ones with '2'. In the end,
%the pixels with the highest value will be on the medial axis of the axons.
%--------------------------------------------------------------------------
%Input: threshold - the threshold that generates the 2-D binary image
%       outputImage - 2-D grayscale image
%Output: f_this - distance transform image
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------

outputImage=outputImage*255;
f0 = (outputImage>threshold);
M = size(outputImage,2);
N = size(outputImage,1);
f_last = f0;
for iterations = 1:20
    f_tmp = zeros(size(f0));
    for row = 2:M-1
        for column = 2:N-1
            if(f0(column,row) == 1)
               neighbours = [f_last(column-1,row-1) f_last(column-1,row) f_last(column,row+1) ...
                   f_last(column,row-1) f_last(column,row+1) ...
                   f_last(column+1,row-1) f_last(column+1,row) f_last(column+1,row+1)];
               min_neighbour = min(neighbours);
               f_tmp(column,row) = min_neighbour;
            end
        end
    end
   f_this = f0 + f_tmp;
   if f_this-f_last == 0
       break
   end
   f_last = f_this;
end

end

