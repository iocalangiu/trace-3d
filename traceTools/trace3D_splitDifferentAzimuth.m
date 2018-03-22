function [new_axons] = trace3D_splitDifferentAzimuth(axons)
% trace3D_splitDifferentAzimut.m

% Description: this function computes for each step in a trace the dot
% product between the previous minor eigenvector and the current minor
% eigenvector. If this product is < 0.9 (meaning that the trace suddenly takes
% a change), then this function splits the original trace into more traces,
% for which all coordinates fulfill this constraint (of having the dot product
% between two consecutive minor eigenvectors > 0.9)

% Input: axons - struct containing the original traces.
% Output: new_axons - struct containing the updated traces.
% -------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
% -------------------------------------------------------------------------

count = 1;
step = 1;

for i = 1: numel(axons)
    vx = ( diff(axons(i).directionx(1:step:end)) );
    vy = ( diff(axons(i).directiony(1:step:end)) );
    vz = ( diff(axons(i).directionz(1:step:end)) );
    
    boundaries = [];
    
    for j = 2:length(vx)
        vec1 = [vy(j-1) vx(j-1) vz(j-1)];
        vec1 = vec1/norm(vec1);
        vec2 = [vy(j) vx(j) vz(j)];
        vec2 = vec2/norm(vec2);
        dot_prod = dot(vec1,vec2);
        
        if abs(dot_prod)<0.9
            boundaries = cat(1, boundaries, j-1);
        end
    end
    
    boundaries = cat(1, boundaries, numel(axons(i).directionx));
    start = 1;
    
    for ix = 1: numel(boundaries)
        new_axons(count).directionx = axons(i).directionx(start: boundaries(ix));
        new_axons(count).directiony = axons(i).directiony(start: boundaries(ix));
        new_axons(count).directionz = axons(i).directionz(start: boundaries(ix));
        start = boundaries(ix)+1;
        count=count+1;
    end
end



end

