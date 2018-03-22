function [xs,ys,zs,am] = plotting3D_volumeData(stack_out,lowThreshold,highThreshold)

for i = 1:size(stack_out,3)
    grayImage = stack_out(:,:,i);
    minGL = double(min(grayImage(:)));
	maxGL = double(max(grayImage(:)));
	imageToThreshold = 20000 * mat2gray(grayImage) - 5000;
    binaryImage(:,:,i) = (imageToThreshold > lowThreshold) & (imageToThreshold < highThreshold);    
end

image_3d = binaryImage.*stack_out;
count = 1;
for row = 1:size(stack_out,1)
    for col = 1:size(stack_out,2)
        for depth = 1:size(stack_out,3)
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


end

