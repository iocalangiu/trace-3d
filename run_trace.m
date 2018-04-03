

%% Info to fill in: Imaging file to trace

fileName = 'testSlice.tif';
folderName = 'experiment1';

pathSaveTracingResults = 'E:\imperial_code\trace-3d\trunk\resultsTracing';

pathSaveTracingResults_mainFolder = fullfile(pathSaveTracingResults, folderName);
pathSaveTracing_resultsFolder = fullfile(pathSaveTracingResults, folderName, 'results');

%% Get result paths

seeds_file    = fullfile(pathSaveTracingResults_mainFolder, 'seedsStruct.mat');
spmstack_file = fullfile(pathSaveTracingResults_mainFolder, 'inputImageStruct.mat');
stack_file    = fullfile(pathSaveTracingResults_mainFolder, 'stackStruct.mat');

Q = imageStruct.stack;
stack = stackStruct.stack;

axons_file      = fullfile(pathSaveTracingResults_mainFolder, 'traced_axons.mat');
resolution_file = fullfile(pathSaveTracingResults_mainFolder, 'resolutions.mat');
log_file        = fullfile(pathSaveTracingResults_mainFolder, 'results.txt');

%% Run tracing

% trace
traceAll(seeds_file, spmstack_file, pathSaveTracing_resultsFolder);

% create one struct with all segments
[all_axonal_segments] = pullaxons(pathSaveTracing_resultsFolder);

save(axons_file ,'all_axonal_segments')

% compute axonal length
load(resolution_file)

resz = resolutions.z;
resx = resz; % because of the interpolation
resy = resz; % because of the interpolation

clc

[axonal_um,pixel_length] = trace3D_computeAxonalLength(all_axonal_segments,[resx resy resz]);
disp(['axonal length in um is ' num2str(axonal_um) ' for file: ' fileName])

% save axonal length
fileID = fopen(log_file,'w');
fprintf(fileID, ['axonal_length_um  = '], '%f', axonal_um);
fprintf(fileID, '%f \n', axonal_um);

fprintf(fileID, ['// and axonal_length_pixels  = ']);
fprintf(fileID, '%f \n', pixel_length);

fprintf(fileID, ['// and whole volume is: ' num2str(size(Q,1)*resz) ' x ' num2str(size(Q,2)*resz) ' x ' num2str(size(Q,3)*resz) ' um^3']);

fclose(fileID);

%% Plotting - optional

axons_file  = fullfile(pathSaveTracingResults_mainFolder, 'traced_axons.mat');

load(stack_file)
load(axons_file)

G = max(stack, [], 3); %/computes maximum projection of intensity => from 3-D data to 2-D data

figure;
imagesc(G);
title(fileName)
axis equal; axis off;
hold on
plotting2D_axons(all_axonal_segments)
hold off
