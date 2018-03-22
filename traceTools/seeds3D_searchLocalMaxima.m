function [seed_x,seed_y] = seeds3D_searchLocalMaxima(f_this)
%seeds3D_searchLocalMaxima.m
%Description: based on the distance transform, checks the local maxim
%--------------------------------------------------------------------
%Input: f_this - distance transform 2-D image
%       blksze - the size of the window search, it can be 5, 10 or 15
%Output: seed_x,seed_y - the x and y coordinates of the seeds
%----------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%----------------------------------------------------------------------

blksze = 5;

switch blksze
    case 5
        thresh = 23;
    case 10
        thresh = 98;
    case 15
        thresh = 220;
end
count=1;
M = size(f_this,2);
N = size(f_this,1);
seed_x = [];
seed_y = [];
for row = 1:blksze:M-blksze
    for col = 1:blksze:N-blksze
        count=count+1;
        im_patch = f_this(col:col+blksze-1,row:row+blksze-1);
        bg_pxls = im_patch(im_patch==0);
        if length(bg_pxls) <thresh 
            tst = zeros(size(f_this,1),size(f_this,2));
            tst(col:col+blksze-1,row:row+blksze-1) = im_patch;
            [~, ind] = max(tst(:));
            [m,n] = ind2sub(size(tst),ind);
            seed_x = [seed_x m];
            seed_y = [seed_y n];
        end
    end
end
end

