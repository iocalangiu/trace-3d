function [e_d] = naneuclidean(x,y,z)

e_d = NaN(1,size(x,2));

%/ x = [point1; point2]
if size(x,1) == 3
for ij = 1:size(x,2) %/length of point1/point2
    v1 = [x(1,ij) y(1,ij) z(1,ij)];
    v2 = [x(2,ij) y(2,ij) z(2,ij)];
    e_d(ij) = sqrt( sum( (v1-v2).^2 ) );
end
end

if size(x,1) == 2
for ij = 1:size(x,2) %/length of point1/point2
    v1 = [x(1,ij) y(1,ij)];
    v2 = [x(2,ij) y(2,ij)];
    e_d(ij) = sqrt( sum( (v1-v2).^2 ) );
end
end



end

