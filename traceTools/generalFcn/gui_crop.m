function [imgportion_3d, stack_3d] = gui_crop(stack1_cropped, reconstructedImages)
%gui_crop.m
%% Introduction
%  This program select or crops a rectangular portion of any given image
%  The program displays a red rectangle on the portion selected
%  The program then displays the selected portion in a separate figure
%  Submitted By : Lufuno Vhengani
%  Email: Lvhengani@gmail.com / Lvhengani@csir.com
%  Date : 04-August-2011
%--------------------------------------------------------------------------
% This function was later modified by Ioana Calangiu to take a 3-D data and
% compute the maximum intensity projection. This 2-D MIP is then displayed
% and the user can select with a cursor the region of interest. Then, this
% algorithm crops the ROI from the 3-D data and returns it in two ways:
%   1. imgportion_3d - a 3-D matrix containing the ROI
%   2. stack_3d - a cell type variable, containing in each cell a 2-D RGB ROI
%   slice.
%--------------------------------------------------------------------------
% Input: stack1_cropped - 3-D matrix containing the data;
%        reconstructedImages - cell type variable containing in each cell a
%                              2-D RGB slice;
% Output: imgportion_3d - a 3-D matrix containing the ROI
%         stack_3d - a cell type variable, containing in each cell a 2-D RGB 
%         ROI slice.

set(0,'DefaultTextInterpreter','latex')
set(0,'defaultaxesfontsize',15)
img_max = max(stack1_cropped,[],3);
img = stack1_cropped;
[m n]= size(img_max);

CHOICE=0;
rep=1;

while CHOICE<2 %  While continue is not pressed redo this loop
   
close all;
g1=figure;
    
imagesc(img_max),title('Select Area To Sample'),hold on
axis equal
axis off
set(gcf,'color','w');
%% Crop Image Using Submatrix Operation
   [y,x] = ginput(2);                             %select two cursor points
   
   row1 = ceil(x(1,1)); col1 = ceil(y(1,1));      %get first cursor point = first corner of the rectangle
   row2 = floor(x(2,1)); col2 = floor(y(2,1));    %get second cursor point = second corner of the rectangle
   
%% Being Naughty
if (row1>row2)||(col1>col2)
    disp('The portion selection was confusing: Your first column or row was greater than the last column or row')
    disp('Nonetheless the software automatically selected the portion')
     vmessage=1;
     row1 = ceil(min(x)); col1 = ceil(min(y));      %get first cursor point = first corner of the rectangle
     row2 = floor(max(x)); col2 = floor(max(y));    %get second cursor point = second corner of the rectangle
end     
%% Cutting the portion
   imgportion = img_max(row1:row2,col1:col2,:);       %create the sub-matrix
   rectangle('Position', [col1 row1 (col2-col1) (row2-row1)],'EdgeColor','y','LineWidth',1),hold off
   
   g2=figure;
   imagesc(imgportion),title('Selected Area');                               %display croped image
   axis equal
   axis off
   set(gcf,'color','w');

CHOICE = menu('Image Area Selection','Select Area Again','Done');
switch CHOICE
  case 1
      vmessage=0;
      text = ['"Area selection repeat ',num2str(rep),' "'];
      disp(text),
  case 2 
    disp('"Area selection done"')
end % End Choice
rep=rep+1; 
end % End While

if CHOICE == 2
    imgportion_3d = img(row1:row2,col1:col2,:);       %create the sub-matrix
    % three colours
    for ind = 1:length(reconstructedImages)
        clear tmp
        tmp = reconstructedImages{ind};
        stack_3d{ind} = tmp(row1:row2,col1:col2,:);
    end
end
end