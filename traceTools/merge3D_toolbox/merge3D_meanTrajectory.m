function [xm,ym,zm] = merge3D_meanTrajectory(traces,stack)
%merge3D_meanTrajectory.m
%Description: this function aligns the traces that were found to be
%representing the same axonal length, and then takes the mean of the
%coordinates in order to create a single trace.
%--------------------------------------------------------------------------
%Input: traces - a 2-D matrix organized in the following way
%[coordinates_x for trace 1 ... NaN
% coordinates_y for trace 1 ... NaN
% coordinates_x for trace 1 ... NaN
%[coordinates_x for trace 2 ... NaN
% coordinates_y for trace 2 ... NaN
% coordinates_x for trace 2 ... NaN]
%Note: need to add NaNs, because the traces are not of the same length;
%      stack - 3-D data containing the volume from where the traces were
%              reconstructed.
%Output: xm, ym, zm - 1-D vectors containing the coordinates of the new
%                      merged trace.
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------

len_col=600000;
xp = nan(size(traces,1)/3, len_col);   
yp = nan(size(traces,1)/3, len_col);
zp = nan(size(traces,1)/3, len_col);

disp('Merging..')

start_x = traces(1,:);
start_y = traces(2,:);
start_z = traces(3,:);
xp(1,1:length(start_x)) = start_x;
yp(1,1:length(start_y)) = start_y;
zp(1,1:length(start_z)) = start_z;

m=4;
for i = 2:size(traces,1)/3
    
    xp_tmp = xp(i-1,:);
    yp_tmp = yp(i-1,:);
    
    Q = [xp_tmp', yp_tmp'];
    P = [traces(m,1) traces(m+1,1)];
    D = euclideanDistance(P,Q);

    [~,ll] = min(D(:));

    xp(i,ll:ll+length(traces(m,:))-1) = traces(m,:);
    yp(i,ll:ll+length(traces(m+1,:))-1) = traces(m+1,:);
    zp(i,ll:ll+length(traces(m+2,:))-1) = traces(m+2,:);
    m=m+3;
end

xp(xp==0)=nan;
yp(yp==0)=nan;
zp(zp==0)=nan;

direction = 1;

%/ Merging
xm = nanmean(xp, direction);
xm(isnan(xm))=[];
ym = nanmean(yp, direction);
ym(isnan(ym))=[];
zm = nanmean(zp, direction);
zm(isnan(zm))=[];



end

