function [axons_out] = trace3D_interpolationCoordinates(axons_in)
%interpolate_traces.m
%Description: this function takes each trace and interpolates the x,y,z
%coordinates and applies a smooth function, to make the final trace more
%smooth.
%-----------------------------------------------------------------------
%Input: axons_in - struct containing all the traces
%Output: axons_out - the new traces
%-----------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%-----------------------------------------------------------------------

%disp('Interpolate Coordinates')
%disp('-----------------------------------------------------------')
axons_out = struct;
span = 50;
ck = 1;
for el = 1: numel(axons_in)
    if numel(axons_in(el).directionx) > 4
        %// for coordinates
        x = axons_in(el).directionx;
        y = axons_in(el).directiony;
        z = axons_in(el).directionz;
        l = 1:length(x);
        li = 1 :0.1: l(end);
        %li = 1: 1: l(end);
        xi = interp1(l, x, li);
        yi = interp1(l, y, li);
        zi = interp1(l, z, li);
        xs = smooth(xi, span);
        ys = smooth(yi, span);
        zs = smooth(zi, span);
        axons_out(ck).directionx = xs';
        axons_out(ck).directiony = ys';
        axons_out(ck).directionz = zs';
        
        %// for vectors
        vx = axons_in(el).vxx;
        vy = axons_in(el).vyy;
        vz = axons_in(el).vzz;
        l = 1:length(vx);
        li = 1 :0.1: l(end);
        %li = 1 : 1 : l(end);
        vxi = interp1(l, vx, li);
        vyi = interp1(l, vy, li);
        vzi = interp1(l, vz, li);
        vxs = smooth(vxi, span);
        vys = smooth(vyi, span);
        vzs = smooth(vzi, span);
        axons_out(ck).vxx = vxs';
        axons_out(ck).vyy = vys';
        axons_out(ck).vzz = vzs';
        axons_out(ck).seedsid= axons_in(el).seedsid;
        axons_out(ck).starting_points = axons_in(el).starting_points;
        ck = ck + 1;
    end
end

end

