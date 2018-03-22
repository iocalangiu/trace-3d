function [u,v,w] = hessian3D_arrangeEigenVectors(im_gauss, direction)
% hessian3D_arrangeEigenVectors.m function

% Description: this function gets a 3-D image and computes Hessian matrix
% with the meanHessian3d.m function. After we get the Hessian matrix, we
% compute the eigenvectors and the eigenvalues with eig.m function. Having
% the eigenvalues, this function determines the one with the highest magnitude
% and selects the minor eigenvectors and the two major eigenvectors.
% ----------------------------------------------------------------------------
% Input: im_gauss - 3-D input voxel
%        direction - this algorithm traces in both directions from the
%                    starting point, therefore when direction = 1 it traces
%                    in the direction shown by the minor eigenvectors, when
%                    direction = 2 it traces in the opposite direction.
% Output: u,v,w - the eigenvectors, u contains the minor eigenvector and v
%                 and v, w the major eigenvectors
% ----------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015
% ----------------------------------------------------------------------------

ck = 0;
[H,V,D] = hessian3D_findHessianMatrix(im_gauss);
if isempty(V) || isempty(D)
    ck = 2;
end
tr = sum(D(:));

%// Stop condition
if tr > 0
    %disp('Stop condition #2, Trace positive')
    u = [];
    v = [];
    w = [];
    ck = 1;
end
detH = det(H);
%// Stop condition
if detH < 0
    check = D(:)<0;
    if check == 1
        %disp('Stop condition #3, Det(H) < 0, case 6')
        u = [];
        v = [];
        w = [];
        ck = 2;
    end
end

if ck == 0
    lambdas = [abs(D(1,1)),abs(D(2,2)),abs(D(3,3))];
    [~,D_indx] = min(lambdas);
    
    switch D_indx
        case 1
            vx_minor = V(1,1);
            vy_minor = V(2,1);
            vz_minor = V(3,1);
            
            vx_major_1 = V(1,2);
            vy_major_1 = V(2,2);
            vz_major_1 = V(3,2);
            
            vx_major_2 = V(1,3);
            vy_major_2 = V(2,3);
            vz_major_2 = V(3,3);
        case 2
            vx_minor = V(1,2);
            vy_minor = V(2,2);
            vz_minor = V(3,2);
            
            vx_major_1 = V(1,1);
            vy_major_1 = V(2,1);
            vz_major_1 = V(3,1);
            
            vx_major_2 = V(1,3);
            vy_major_2 = V(2,3);
            vz_major_2 = V(3,3);
        case 3
            vx_minor = V(1,3);
            vy_minor = V(2,3);
            vz_minor = V(3,3);
            
            vx_major_1 = V(1,2);
            vy_major_1 = V(2,2);
            vz_major_1 = V(3,2);
            
            vx_major_2 = V(1,1);
            vy_major_2 = V(2,1);
            vz_major_2 = V(3,1);
    end
    
    if nargin == 2
        if direction == 1
            u = [vy_minor, vx_minor, vz_minor]; % changed
            v = [vy_major_1 vx_major_1 vz_major_1];
            w = [vy_major_2 vx_major_2 vz_major_2];
        end
        if direction == 2
            u = [-vy_minor, -vx_minor, -vz_minor];
            v = [-vy_major_1 -vx_major_1 -vz_major_1];
            w = [-vy_major_2 -vx_major_2 -vz_major_2];
        end
    end
    
    if nargin == 1
        u = [vy_minor, vx_minor, vz_minor];
        v = [vy_major_1 vx_major_1 vz_major_1];
        w = [vy_major_2 vx_major_2 vz_major_2];
    end
    
end % end of ck

if ck == 2
    u = [];
    v = [];
    w = [];
end

end

