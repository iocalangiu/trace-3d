function [D] = euclideanDistance(P,Q)
%euclideanDistance.m
%Description: this function computes the euclidian distance between all the
%possible combinations between the elements of two vectors.
%---------------------------------------------------------------------------
%Input: P,Q - two matrixes of the form
%       P/Q = [x_1 y_1 z_1   or P/Q = [x_1 y_1
%              x_2 y_2 z_2             x_2 y_2
%              -----------             -------
%              x_n y_n z_n]            x_n y_n]
%                 3-D                    2-D
%Output: D - the matrix of distances where D(r,c) is the distance of the rth
%            point in P from the cth point in Q.
%---------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%---------------------------------------------------------------------------

rows = size(P,1);
collumns = size(Q,1);
D = zeros(rows,collumns);

if size(P,2)==3 %/3-D
for r = 1:rows
    for c = 1:collumns
        D(r,c) = sqrt((P(r,1)-Q(c,1))^2+(P(r,2)-Q(c,2))^2+(P(r,3)-Q(c,3))^2);
    end
end
else %/2-D
for r = 1:rows
    for c = 1:collumns
        D(r,c) = sqrt((P(r,1)-Q(c,1))^2+(P(r,2)-Q(c,2))^2);
    end
end    
    
end

end

