close all;
clear 
clc

pathTracing = 'E:\imperial_code\v3_trace3D_DA';
%pathTracing = '/Users/ioanacalangiu/Dropbox/v3_trace3D_DA';

pathTracingScripts = fullfile(pathTracing, 'traceTools');
addpath(pathTracingScripts)
addpath(fullfile(pathTracingScripts, 'SPM', 'spm12'))
addpath(fullfile(pathTracingScripts, 'scripts_for_merge'))
addpath(fullfile(pathTracingScripts, 'generalFcn'))

pathInputData = 'E:\imperial_code\v3_trace3D_DA\InputData';
%pathInputData = '/Users/ioanacalangiu/Dropbox/v3_trace3D_DA/InputData';

pathSaveTracingResults = 'E:\imperial_code\v3_trace3D_DA\traceDATA';
%pathSaveTracingResults = '/Users/ioanacalangiu/Dropbox/v3_trace3D_DA/traceDATA';

% to do: 
% 1. transfer tif file from InputFolder to folderName/rawdata