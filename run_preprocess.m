%% Set paths

fileName = 'jhs 18072015 - 17 days - slide #4-3 ipsi.lif - slide 4-3 CNIC 4 cells 0.25 0.50 - 2.tif';
folderName = 'experiment1';

cropImage = false;

%% Create folders to save results

pathSaveTracing_mainFolder = fullfile(pathSaveTracingResults, folderName);
pathSaveTracing_resultsFolder= fullfile(pathSaveTracingResults, folderName, 'results');
pathSaveTracing_rawDataFolder = fullfile(pathSaveTracingResults, folderName, 'rawdata');

[~,~,~] = mkdir(pathSaveTracing_mainFolder);
[~,~,~] = mkdir(pathSaveTracing_resultsFolder);
[~,~,~] = mkdir(pathSaveTracing_rawDataFolder);


%% SECTION 1: load data

resx = 0.28;
resy = resx;
resz = 0.5;
[reconstructedImages] = import_stack_tiff(fullfile(pathInputData, fileName));

%% SECTION 2: choosing the colour channel
%colour can be 1(Red), 2(Green), 3(Blue)
%reconstructedImages is the output from import_tif.m
colour = 3;
images = chooseColourChannel(reconstructedImages,colour);

%% SECTION 3: select ROI (optional)
%images is a 3-D matrix containing just one colour channel

if cropImage
    [imgportion_3d, stack_3d] = gui_crop(images, reconstructedImages);
else
    imgportion_3d = images;
    stack_3d = reconstructedImages;
end

%% SECTION 4: preprocess data
%imgportion_3d = images;
%stack_3d = reconstructedImages;

resolution = resz/resx;%/resolution across z/resolution across x or y
[stack_out,stack_out2] = preprocess3D_main(imgportion_3d,resolution);
stack = stack_out;

%% SECTION 5: Blurring with a Gaussian filter, using SPM software
sigma = 5;
stack_to_be_filtered = stack_out2; % copy inside this variable the data that will be filtered
m = size(stack_to_be_filtered,1); % size along x
n = size(stack_to_be_filtered,2); % size along y
z = size(stack_to_be_filtered,3); % size along z
Q=zeros(m,n,z); % variable where the SPM filtered data will be stored
spm_smooth(stack_to_be_filtered, Q, [sigma sigma sigma], 0); % SPM filtering


%% SECTION 6: Get seeds

seed_parameter = 5; %/can be 5,10 or 15
size_3D_voxel = [11 11 9];
radius = 1;
[seed_x,seed_y,hfig] = seeds3D_main_short(stack,size_3D_voxel);

seeds_fig = fullfile(pathSaveTracing_mainFolder, 'seeds_figure.png');
export_fig(hfig,seeds_fig);

seeds_fig = fullfile(pathSaveTracing_mainFolder, 'seeds_figure.fig');
savefig(hfig, seeds_fig);

close all;
[seeds] = sort_seeds_2D(Q,seed_x,seed_y);


%% SECTION 7: Save preprocessed image and seeds

seeds.filename = fileName;
seeds.pathInputData = pathInputData;

stackStruct.filename = fileName;
stackStruct.pathInputData = pathInputData;
stackStruct.stack = stack;

imageStruct.filename = fileName;
imageStruct.pathInputData = pathInputData;
imageStruct.stack = Q;

save(fullfile(pathSaveTracing_mainFolder, 'seedsStruct.mat'), 'seeds')
save(fullfile(pathSaveTracing_mainFolder, 'stackStruct.mat'),'stackStruct')
save(fullfile(pathSaveTracing_mainFolder, 'inputImageStruct.mat'),'imageStruct')

resolutions.x = resx;
resolutions.y = resy;
resolutions.z = resz;
resolutions.filename = fileName;
resolutions.pathInputData = pathInputData;

save(fullfile(pathSaveTracing_mainFolder, 'resolutions.mat'),'resolutions')

