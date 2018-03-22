function [more_axons] = pullaxons(targetFolder)

myDir = dir(targetFolder);
more_axons = struct;
count = 1;

for in = 1: size(myDir,1)
    if myDir(in,1).isdir == 0
        
        load([targetFolder filesep myDir(in,1).name])
        
        for ij = 1: numel(axons)
            if ~isempty( axons(ij).directionx)
                more_axons(count).directionx = axons(ij).directionx;
                more_axons(count).directiony = axons(ij).directiony;
                more_axons(count).directionz = axons(ij).directionz;
                count = count + 1;
            end
        end
    end
end


end

