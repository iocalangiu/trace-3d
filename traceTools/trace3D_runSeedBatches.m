function [tracedAxons, unprocessedTracedAxons, out_deadSeedsCell, eigVectors, out_seedsCell] = ...
    trace3D_runSeedBatches(im_patch, in_seedsCell, in_deadSeedsCell, eigVectors, pars)

tracedAxons = struct;

seedsx = in_seedsCell{1};
seedsy = in_seedsCell{2};
seedsz = in_seedsCell{3};

dead_seed_x = in_deadSeedsCell{1};
dead_seed_y = in_deadSeedsCell{2};
dead_seed_z = in_deadSeedsCell{3};


[seeds_id] = seeds3D_assignID(seedsx,seedsy);
maxI = max(im_patch(:));

inputData.maxI       = maxI;
inputData.im_patch   = im_patch;
inputData.dst        = pars.dst;
inputData.radius     = pars.radius;
inputData.size_3D_voxel = pars.size_3D_voxel;
unprocessedTracedAxons = struct; % / not used

for iter = 1: 100
    
    x = seedsx(1);
    y = seedsy(1);
    z = seedsz(1);
    seedsx(1) = [];
    seedsy(1) = [];
    seedsz(1) = [];
    inputData.seedsx = seedsx;
    inputData.seedsy = seedsy;
    inputData.seedsz = seedsz;
    inputData.eigen_vectors = eigVectors;
    inputData.x = x;
    inputData.y = y;
    inputData.z = z;
    inputData.dead_seedsx = dead_seed_x;
    inputData.dead_seedsy = dead_seed_y;
    inputData.dead_seedsz = dead_seed_z;
     
    % >> TRACE << ---------------------------------------------------------
    [outputData] = trace3D_core(inputData);

    % local structure: rawNeurontrace, contains the newly traced
    % axons, and goes through the postprocessing pipeline: 
    clear rawNeurontrace
    rawNeurontrace.vxx = outputData.new_vxx;
    rawNeurontrace.vyy = outputData.new_vyy;
    rawNeurontrace.vzz = outputData.new_vzz;
    rawNeurontrace.seedsid = seeds_id(iter);
    rawNeurontrace.starting_points = [x y z];

    % ->>> new traces <<<-
    rawNeurontrace.directionx = outputData.new_trace_x;
    rawNeurontrace.directiony = outputData.new_trace_y;
    rawNeurontrace.directionz = outputData.new_trace_z;
    
    % >> FILTER VALID TRACES << -------------------------------------------
    if ~isempty(rawNeurontrace.vxx) && ~isempty(rawNeurontrace.directionx) && length(rawNeurontrace.vxx) == length(rawNeurontrace.directionx)
        
        %/ Delete duplcate coordinates
        clear axons
        [axon_noDuplicates] = trace3D_deleteDuplicateCoordinates(rawNeurontrace);
        
        if numel(axon_noDuplicates.directionx)>4
            
        %/ Interpolate and smooth
        clear processedNeurontrace
        [processedNeurontrace] = trace3D_interpolationCoordinates(axon_noDuplicates); 
        
        %/ Axons unmerged
        index_raw = size(unprocessedTracedAxons, 2);
        unprocessedTracedAxons(1, index_raw+1).directionx = processedNeurontrace.directionx;
        unprocessedTracedAxons(1, index_raw+1).directiony = processedNeurontrace.directiony;
        unprocessedTracedAxons(1, index_raw+1).directionz = processedNeurontrace.directionz;
        
        clear pair_x
        [pair_x] = matchCurrentAxonToPreviousTracedAxons(tracedAxons, processedNeurontrace);

        if ~isempty(pair_x)
            index_size = size(tracedAxons,2);
            
            tracedAxons(1, index_size+1).directionx = processedNeurontrace.directionx;
            tracedAxons(1, index_size+1).directiony = processedNeurontrace.directiony;
            tracedAxons(1, index_size+1).directionz = processedNeurontrace.directionz;
            
            [tracedAxons] = alignPreviousTracedAxons(tracedAxons, pair_x, index_size+1);
            [mergedTracedAxons] = nanmergev3(tracedAxons, pair_x, index_size+1);
            
        else
            index_size = size(tracedAxons,2);
            tracedAxons(1,index_size+1).directionx = processedNeurontrace.directionx;
            tracedAxons(1,index_size+1).directiony = processedNeurontrace.directiony;
            tracedAxons(1,index_size+1).directionz = processedNeurontrace.directionz; 
            mergedTracedAxons = tracedAxons;
        end

        [split_mergedTracedAxons] = trace3D_splitDifferentAzimuth(mergedTracedAxons);

        finalTracedAxons = struct;
        count = 1;
        for ij = 1: numel(split_mergedTracedAxons)
            if numel(split_mergedTracedAxons(ij).directionx)>2
                finalTracedAxons(count).directionx = split_mergedTracedAxons(ij).directionx;
                finalTracedAxons(count).directiony = split_mergedTracedAxons(ij).directiony;
                finalTracedAxons(count).directionz = split_mergedTracedAxons(ij).directionz;
                count = count+1;
            end
        end
        
        tracedAxons = finalTracedAxons;
        clear finalTracedAxons
        
        end
           
    seedsx = outputData.seedsx;
    seedsy = outputData.seedsy;
    seedsz = outputData.seedsz;
    eigVectors = outputData.eigen_vectors;
    dead_seed_x = outputData.dead_seedsx;
    dead_seed_y = outputData.dead_seedsy;
    dead_seed_z = outputData.dead_seedsz;
        
    if isempty(seedsx)
        break;
    end
    
    end

end

out_seedsCell{1} = seedsx;
out_seedsCell{2} = seedsy;
out_seedsCell{3} = seedsz;

out_deadSeedsCell{1} = dead_seed_x;
out_deadSeedsCell{2} = dead_seed_y;
out_deadSeedsCell{3} = dead_seed_z;

end
