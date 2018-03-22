function [distance,min_distance] = euclideanDistance_sequential(X,Y)

distance = zeros(1,size(X,1));
for ij = 1:size(X,1)
   distance(ij) = pdist2(X(ij,:),Y(ij,:)); 
end

min_distance = min(distance);

end

