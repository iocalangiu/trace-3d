function traceAll(instructionSeeds, instructionQ, pathSaveTracingResults_dataFolder)


load(instructionSeeds)
load(instructionQ)

Q = imageStruct.stack;

listseedsx = cell(1,4);
listseedsy = cell(1,4);
listseedsz = cell(1,4);

for in = 1:4
    listseedsx{in} = seeds.x{in};
    listseedsy{in} = seeds.y{in};
    listseedsz{in} = seeds.z{in};
end


A = Q;
output = cell(1, numel(listseedsx));
%output_raw = cell(1, numel(listseedsx));

%parfor
for idx = 1: numel(listseedsx)
    
    seedsx = listseedsx{idx};
    seedsy = listseedsy{idx};
    seedsz = listseedsz{idx};
    
    %[axons,raw_traces] = traceIndividual(A, seedsx, seedsy, seedsz);
    output{idx} = traceIndividual(A, seedsx, seedsy, seedsz);    
end

for idx = 1: numel(listseedsx)
    
    clear axons
    axons = output{idx};
    save(fullfile(pathSaveTracingResults_dataFolder, ['out-' num2str(idx) '.mat']), 'axons')    
    %clear axons
    %axons = output_raw{idx};
    %save([path_to_folder filesep name_file filesep 'dataraw' filesep 'out-' num2str(idx) '.mat'],'axons');
end

end

