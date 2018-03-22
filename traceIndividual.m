function [tracedAxons] = traceIndividual(Q, seedsx, seedsy, seedsz)

%% tracing
pars.dst = 1;%/ the parameter that decides which seeds are close enough to be considered DEAD
pars.radius = 3;
pars.size_3D_voxel = [11 11 9];

seedsCell{1} = seedsx;
seedsCell{2} = seedsy;
seedsCell{3} = seedsz;

%[axons,raw_traces] = trace3D_main(Q,seedsx,seedsy,seedsz,dst,radius,size_3D_voxel);

[tracedAxons] = trace3D_initiateSeedBatches(Q, seedsCell, pars);

end

% Functions //

function [axons] = trace3D_initiateSeedBatches(Q,seedsCell,pars)

size_3D_voxel = (pars.size_3D_voxel-1)/2;
pars.size_3D_voxel = size_3D_voxel;

%dead_seed_x=[];
%dead_seed_y=[];
%dead_seed_z=[];

deadSeedsCell = cell(1, 3);
eigVectors = [];
count = 1;
axons = struct;

for ix = 1: 1000000
    clear new_axons_tmp
    
    [new_axons_tmp, ~, deadSeedsCell, eigVectors, seedsCell] = trace3D_runSeedBatches(Q, seedsCell, deadSeedsCell, eigVectors, pars);
    
    for l = 1: numel(new_axons_tmp)
        
        axons(count).directionx = new_axons_tmp(l).directionx;
        axons(count).directiony = new_axons_tmp(l).directiony;
        axons(count).directionz = new_axons_tmp(l).directionz;
        count = count + 1;
        
    end

    if isempty(seedsCell{1})
        break;
    end
    
    disp(['Iteration ' num2str(ix) ' ended successfully!'])
end

end
