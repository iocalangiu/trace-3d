function tif_stack = importTif(name_string,stop)
%importTif.m
%Description: this function imports the data into Matlab, when the
%fluorescent data was exported from Leica as whole 2-D slices
%------------------------------------------------------------------------
%Input: name_string - the string of characters found in the name of the
%files, before _zXX... For example: from: 'contra DCIC 2 cells nice_z01'
%name_string = 'contra DCIC 2 cells nice';
%       stop - the number on the last tif file/slice;
%Output: tif_stack - cell variable containing in each cell a RGB 2-D slice
%-------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
%-------------------------------------------------------------------------
stop=stop+1;
check = stop/100;
if check<1
for i = 1:10
tif_stack{i} = imread(strcat(name_string,'_z0',num2str(i-1),'.tif'));
end

for i = 11:stop
tif_stack{i} = imread(strcat(name_string,'_z',num2str(i-1),'.tif'));
end
end

if check>=1
for i = 1:10
tif_stack{i} = imread(strcat(name_string,'_z00',num2str(i-1),'.tif'));
end

for i = 11:100
tif_stack{i} = imread(strcat(name_string,'_z0',num2str(i-1),'.tif'));
end 

for i = 101:stop
tif_stack{i} = imread(strcat(name_string,'_z',num2str(i-1),'.tif'));
end
    
end


end

