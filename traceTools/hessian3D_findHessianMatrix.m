function [H,V,D] = hessian3D_findHessianMatrix(I)
%hessian3D_findHessianMatrix.m

% Description: this function computes the Hessian matrix, using the second
% order gradient of a 3-D image
%------------------------------------------------------------------------
% Input: I - the 3-D voxel
% Output: H - the Hessian matrix
%        V - the eigenvectors (minor + 2 majors)
%        D - eigenvalues
%------------------------------------------------------------------------
% Author: Ioana Calangiu, Imperial College London, 2015

[gx,gy,gz] = gradient(I);
[gxx,gxy,gxz] = gradient(gx);
[gxy,gyy, gzy] = gradient(gy);
[gxz,gzy, gzz] = gradient(gz);
a = gxx(:);
a(a==Inf)=[];
a(isnan(a))=[];
clear gxx
gxx = a;
%--------------
a = gyy(:);
a(a==Inf)=[];
a(isnan(a))=[];
clear gyy
gyy = a;
%--------------
a = gzz(:);
a(a==Inf)=[];
a(isnan(a))=[];
clear gzz
gzz = a;
%--------------
a = gxy(:);
a(a==Inf)=[];
a(isnan(a))=[];
clear gxy
gxy = a;
%--------------
a = gzy(:);
a(a==Inf)=[];
a(isnan(a))=[];
clear gzy
gzy = a;
%--------------
if isempty(gzz) || isempty(gxx) || isempty(gyy) || isempty(gxy) || isempty(gzy)
    V = [];
    D = [];
    H = [];
else
    Hxx = mean(gxx(:));
    Hyy = mean(gyy(:));
    Hyx = mean(gxy(:));
    Hzx = mean(gxz(:));
    Hyz = mean(gzy(:));
    Hzz = mean(gzz(:));
    H = [Hxx Hyx Hzx; Hyx Hyy Hyz; Hzx Hyz Hzz];
    [V,D]=eig(H);
end

end

