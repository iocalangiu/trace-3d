function [new_seedsx,new_seedsy,new_seedsz] = arrange_seeds(seedsx,seedsy,seedsz,Q)

for ix = 1:length(seedsx)
    intensity(ix) = Q(seedsx(ix),seedsy(ix),seedsz(ix));
end

[~,index] = sort(intensity);

new_seedsx = seedsx(index);
new_seedsy = seedsy(index);
new_seedsz = seedsz(index);



end

