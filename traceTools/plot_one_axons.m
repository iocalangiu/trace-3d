function [X,Y,Z,V] = plot_one_axons(VesselAxisGT,N,M,O)
%plot_one_axons.m plots with isosurface

A = 5; % Brightness of vessel
Radius = 0.5;
%NBigSteps = 8;

dx = 1; %micron
dy = 1;
dz = 1;

% Make a 3D space in which to drop the vessel intensities
% xlocs = dx*(-N/2:N/2);
% ylocs = dy*(-M/2:M/2);
% zlocs = dz*(-O/2:O/2);

xlocs = dx*(1:N);
ylocs = dy*(1:M);
zlocs = dz*(1:O);

% xRange = xlocs(end)-xlocs(1);
% yRange = ylocs(end)-ylocs(1);
% zRange = zlocs(end)-zlocs(1);
% StepSize = sqrt(xRange^2+yRange^2+zRange^2)/NBigSteps;
tic
[X,Y,Z] = meshgrid(xlocs,ylocs,zlocs);
toc

%% Make a volumetric red channel
V = zeros(size(X));
for n = 1:size(VesselAxisGT,2)
    disp(['Coordinate ' num2str(n) '.'])
    mx=VesselAxisGT(1,n);
    my=VesselAxisGT(2,n);
    mz=VesselAxisGT(3,n);
    r2 = (X - mx).^2 + (Y - my).^2 + (Z - mz).^2;
    V = V + A./(1+(r2/Radius).^4); % 4th order butterworth characteristic
end


end

