function [new_ax] = plotting3D_roundCoordinates(ax)
%plotting3D_roundCoordinates.m

for i = 1:size(ax,2)
    clear all_dir
    clear A
    dirx = round(ax(i).directionx);
    diry = round(ax(i).directiony);
    dirz = round(ax(i).directionz);
    all_dir = [dirx',diry',dirz'];
    A = unique(all_dir,'rows','stable');
    new_ax(i).directionx = A(:,1)';
    new_ax(i).directiony = A(:,2)';
    new_ax(i).directionz = A(:,3)';
end

end

