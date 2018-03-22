function [Movie] = import_stack_tiff(fileName)

tiffInfo = imfinfo(fileName);  %# Get the TIFF file information
no_frame = numel(tiffInfo);    %# Get the number of images in the file
Movie = cell(no_frame,1);      %# Preallocate the cell array
for iFrame = 1:no_frame
  Movie{iFrame} = double(imread(fileName,'Index',iFrame,'Info',tiffInfo));
end

end

