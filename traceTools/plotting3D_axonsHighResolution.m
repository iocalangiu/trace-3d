function plotting3D_axonsHighResolution(data,new_axons,xs,ys,zs,am)
%plotting3D_axonsHighResolution.m

N = size(data,1);
M = size(data,2);
O = size(data,3);
ss=['y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b','y','m','c','r','g','b'];
no_neurons = length(new_axons);
no_iterations = round(no_neurons/length(ss))+1;
colours = [];
for ix = 1:no_iterations
    colours = [colours, ss];
end
n=1;
hf=figure;
scatter3(zs,ys,xs,1,am); colormap(gray(length(unique(am)))); beta = .7;
brighten(beta)
set(gca,'color','black'); zlim([1 size(data,1)]); ylim([1 size(data,2)]); xlim([1 size(data,3)]);
hold on
for i = 1:length(new_axons)
    disp(['Plotting axon ' num2str(i) '.'])
    VesselAxisGT = [new_axons(i).directionz(1:n:end); new_axons(i).directiony(1:n:end); new_axons(i).directionx(1:n:end)];
    [X,Y,Z,V] = plot_one_axons(VesselAxisGT,O,M,N);
    p1 = patch(isosurface(X, Y, Z, V, 0.5));
    isonormals(X,Y,Z,V, p1);
    
    xlim([1 O])
    ylim([1 M])
    zlim([1 N])
    set(gca,'ZDir','Reverse')
    set(gca,'XDir','Reverse')
    set(gca,'YDir','Reverse')
    view (3)
    set(p1,'FaceColor',colours(i));
    set(p1,'EdgeColor','none');
    view(3)
    %Viz params
    daspect([1 1 1])
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
    set(hf,'Color','w');
end
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 6.25 7.5]);

set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperSize', [6.25 7.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 6.25 7.5]);

set(gcf, 'renderer', 'painters');
hold off


end

