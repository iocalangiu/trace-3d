function  plotting2D_axons(axons)

%plotting2D_axons.m
%Description: plots the traces on top of the 2-D maximum intensity
%projection. It plots only the x and y components, without the z one.
%--------------------------------------------------------------------------
%Input: axons - struct containing the traces
%--------------------------------------------------------------------------
%Author: Ioana Calangiu, Imperial College London, 2015
%--------------------------------------------------------------------------

ss=['y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b'];
no_neurons = length(axons);
no_iterations = round(no_neurons/length(ss))+1;
colours = [];

for ix = 1: no_iterations
   colours = [colours, ss];
end

n = length(axons);
for ii = 1:n
    if ~isempty(axons(ii).directiony)
        dir = [axons(ii).directiony; axons(ii).directionx];
        fnplt(cscvn(dir),1,colours(ii)) 
    end
end

end

