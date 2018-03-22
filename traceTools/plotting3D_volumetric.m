for i = 1:size(stack_out,3)
    grayImage = stack_out(:,:,i);
    minGL = double(min(grayImage(:)));
	maxGL = double(max(grayImage(:)));
	% Scale the image
	imageToThreshold = 20000 * mat2gray(grayImage) - 5000;
    binaryImage(:,:,i) = (imageToThreshold > lowThreshold) & (imageToThreshold < highThreshold);    
%     figure(1); imagesc(binaryImage)
%     title(num2str(i))
%     pause(2)
end

image_3d = binaryImage.*stack_out;
count = 1;
for row = 1:141
    for col = 1:140
        for depth = 1:60
            if binaryImage(row,col,depth) == 1
            xs(count) = row;
            ys(count) = col;
            zs(count) = depth;
            am(count) = image_3d(row,col,depth);
            count = count + 1;
            end
        end
    end
end

minGL = double(min(grayImage(:)));
maxGL = double(max(grayImage(:)));
% Scale the image
imageToThreshold = 20000 * mat2gray(grayImage) - 5000;
% Verify them
minDblGL = min(imageToThreshold(:));
maxDblGL = max(imageToThreshold(:));

binaryImage = (imageToThreshold > lowThreshold) & (imageToThreshold < highThreshold);
lowThreshold = -2.9869e+03;
highThreshold = 15000;

[binaryImage2] = gui_seeds3D_binarizeMAP(stack_out);

m = image_3d(:);
m = m/max(m);

xx = rand(1,length(xs));
%am = am/max(am(:));
figure; scatter3(xs,ys,zs,0.5,am); colormap(gray(length(unique(am)))); beta = .7;
brighten(beta)
set(gca,'color','black'); xlim([1 141]); ylim([1 140]); zlim([1 60]);



figure;
scatter3(ys,xs,zs,0.5,am); colormap(gray(length(unique(am)))); beta = .7;
brighten(beta)
set(gca,'color','black'); ylim([1 141]); xlim([1 140]); zlim([1 60]);
hold on
plotting3D_axonsLowResolution(axons);
view(3)
hold off








figure;
hold on
for c = 1:length(xs)
if binaryImage(xs(c),ys(c),zs(c))==1
    c
plot3(xs(c),ys(c),zs(c),1,...
    'MarkerFaceColor',[0 m(c) 0])
end
end
hold off
set(gca,'color','black')