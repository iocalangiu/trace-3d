function [s1,s2] = hessian3D_angle2number(u, v, w)
%hessian3D_angle2number.m
%Description: quantizes the degrees in the range 0-360 to numbers 1-16. So,
%it divides the range [0, 360] into 16 sub-intervals, each one being replaced
%with one number [1 16].
%----------------------------------------------------------------------------
%Input: u, v, w - cartezian coordinates of a vector (normalised - [0 1])
%Output: s1 - number that represents the azimuth
%        s2 - number that represents the elevation
%----------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%----------------------------------------------------------------------------

if nargin == 3
[azimuth,elevation,z] = cart2sph(u,v,w);
azimuth = azimuth * 180/pi;
elevation = elevation * 180/pi;
if azimuth < 0
    azimuth = azimuth + 360;
end
if elevation < 0
    elevation = elevation + 360;
end

n = 32;
step = 360/n;
angles = zeros(1,n);
for ij = 1:n
    angles(ij)=step*(ij-1);
end
%/ Azimuth
this_azimuth = azimuth*ones(1,n);
find_azimuth = abs(angles-this_azimuth);
[~,s1]=min(find_azimuth);

%/ Elevation
this_elevation = elevation*ones(1,n);
find_elevation = abs(angles-this_elevation);
[~,s2]=min(find_elevation);
end
end





% if azimuth>=0 && azimuth<22.5
%     s1 = 1;
% end
% if azimuth>=22.5 && azimuth<45
%     s1 = 2;
% end
% if azimuth>=45 && azimuth<67.5
%     s1 = 3;
% end
% if azimuth>=67.5 && azimuth<90
%     s1 = 4;
% end
% if azimuth>=90 && azimuth<112.5
%     s1 = 5;
% end
% if azimuth>=112.5 && azimuth<135
%     s1 = 6;
% end
% if azimuth>=135 && azimuth<157.5
%     s1 = 7;
% end
% if azimuth>=157.5 && azimuth<180
%     s1 = 8;
% end
% if azimuth>=180 && azimuth<202.5
%     s1 = 9;
% end
% if azimuth>=202.5 && azimuth<225
%     s1 = 10;
% end
% if azimuth>=225 && azimuth<247.5
%     s1 = 11;
% end
% if azimuth>=247.5 && azimuth<270
%     s1 = 12;
% end
% if azimuth>=270 && azimuth<292.5
%     s1 = 13;
% end
% if azimuth>=292.5 && azimuth<315
%     s1 = 14;
% end
% if azimuth>=315 && azimuth<337.5
%     s1 = 15;
% end
% if azimuth>=337.5 && azimuth<360
%     s1 = 16;
% end
% 
% if elevation>=0 && elevation<22.5
%     s2 = 1;
% end
% if elevation>=22.5 && elevation<45
%     s2 = 2;
% end
% if elevation>=45 && elevation<67.5
%     s2 = 3;
% end
% if elevation>=67.5 && elevation<90
%     s2 = 4;
% end
% if elevation>=90 && elevation<112.5
%     s2 = 5;
% end
% if elevation>=112.5 && elevation<135
%     s2 = 6;
% end
% if elevation>=135 && elevation<157.5
%     s2 = 7;
% end
% if elevation>=157.5 && elevation<180
%     s2 = 8;
% end
% if elevation>=180 && elevation<202.5
%     s2 = 9;
% end
% if elevation>=202.5 && elevation<225
%     s2 = 10;
% end
% if elevation>=225 && elevation<247.5
%     s2 = 11;
% end
% if elevation>=247.5 && elevation<270
%     s2 = 12;
% end
% if elevation>=270 && elevation<292.5
%     s2 = 13;
% end
% if elevation>=292.5 && elevation<315
%     s2 = 14;
% end
% if elevation>=315 && elevation<337.5
%     s2 = 15;
% end
% if elevation>=337.5 && elevation<360
%     s2 = 16;
% end






