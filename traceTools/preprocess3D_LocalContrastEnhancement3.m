function [uN] = preprocess3D_LocalContrastEnhancement3(patchI, maxI)
%preprocess3D_LocalContrastEnhancement.m
%Description: this function performs local contrast enhancement.
%----------------------------------------------------------------
%Input: patchI - the input 3-D voxel
%       maxI - the maximum intensity found in the whole 3-D data
%Output: uN - the enhanced 3-D voxel
%----------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%----------------------------------------------------------------

Ivec = patchI(:);
maxPatchI = max(Ivec);
minPatchI = min(Ivec);
uN = zeros(size(patchI));
size(patchI);
for i = 1:size(patchI,1)
    for j = 1:size(patchI,2)
        for z = 1:size(patchI,3)
            uN(i,j,z) = (patchI(i,j,z)-minPatchI)*maxI/(maxPatchI-minPatchI);
        end
    end
end
end