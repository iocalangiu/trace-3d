
current = what;


addpath(fullfile(current.path, 'traceTools'))
addpath(fullfile(current.path, 'traceTools', 'SPM', 'spm12'))
addpath(fullfile(current.path, 'traceTools', 'scripts_for_merge'))
addpath(fullfile(current.path, 'traceTools', 'generalFcn'))

[~,~,~] = mkdir(fullfile(current.path, 'InputData')); 

[~,~,~] = mkdir(fullfile(current.path, 'resultsTracing')); 

clear current;

% to do: 
% 1. transfer tif file from InputFolder to folderName/rawdata