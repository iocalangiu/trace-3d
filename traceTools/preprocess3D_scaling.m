function im_cut_scale = preprocess3D_scaling(im_cut)
%preprocess3D_scaling
%Description: this function scales the intensity values across each 2-D
%image so that all of the will have the same intensity maximum and same
%intensity minimum.
%----------------------------------------------------------------------
%Input: im_cut - the 3-D volume
%Output: im_cut_scale - the scaled 3-D volume
%----------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%----------------------------------------------------------------------
% Updated 26.11 Ioana Calangiu
len_y = size(im_cut,2);
len_x = size(im_cut,1);
maxes = [];
mines = [];
for i = 1:size(im_cut,3)
    m = im_cut(:,:,i); %for demo, replace with your own matrix
    coldist = size(m, 2) / len_y * ones(1, len_y); %split the number of columns by 40 and replicate 40 times.
    splitmats = mat2cell(m, len_x, coldist);
    
    for jj = 1:length(splitmats)
       f1 = splitmats{jj};
       maxes = [maxes max(f1(:))];
       mines = [mines min(f1(:))]; 
    end
end

max_final = max(maxes);
if ~all(mines==0)
mines(mines==0)=[];
end
min_final = min(mines);
lm = size(im_cut,1);
n = size(im_cut,2);
z = size(im_cut,3);
im_cut_scale = zeros(lm,n,z);

for i = 1:size(im_cut,3)
    clear splitmats
    m = im_cut(:,:,i);
    coldist = size(m, 2) / len_y * ones(1, len_y); %split the number of columns by 40 and replicate 40 times.
    splitmats = mat2cell(m, len_x, coldist);
    nchunks = length(splitmats);
    min_current_slice = min(m(:));
    max_current_slice = max(m(:));
   
    pause(1)
    
    for jj = 1:nchunks
        f = splitmats{jj};
        a = (f -  min_current_slice)*(max_final-min_final)/(max_current_slice -  min_current_slice) + min_final;
        check = isnan(a);
        a(check) = 0;
        im_cut_scale(1:len_x,jj,i) = a;
    end
end



end