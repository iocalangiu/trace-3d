function  plotting3D_axonsLowResolution(axons)
%plotting3D_axonsLowResolution.m

title('Reconstructed axons in 3-D','interpreter','latex')
set(gca,'BoxStyle','full','Box','on')
camproj perspective
camlight; lighting gouraud;
rotate3d on
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'YTickLabelMode', 'manual', 'YTickLabel', []);
set(gca, 'ZTickLabelMode', 'manual', 'ZTickLabel', []);
set(gca,'YTick',[])
set(gca,'ZTick',[])
set(gca,'XTick',[])
set(gcf,'Color','w');

ss=['y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b'];
no_neurons = length(axons);
no_iterations = round(no_neurons/length(ss))+1;
colours = [];
for ix = 1:no_iterations
    colours = [colours, ss];
end

n = length(axons);
for i =1:n
    %if axons(i).voxel == 50
    dir = [axons(i).directionx; axons(i).directiony; axons(i).directionz];
    fnplt(cscvn(dir),3,colours(i)) 
    %end
    %text(axons(i).directiony(1),axons(i).directionx(i),num2str(i));
end


end

