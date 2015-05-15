function [outputImg, meanColors] = quantizeRGB(origImg, k)
    [x, y, z] = size(origImg);
    xy = x*y;
    stretch = reshape(origImg, [xy, 1,z]);  %stretch matrix into vector
    colors(:,1) = double(stretch(:,:,1));
    colors(:,2) = double(stretch(:,:,2));
    colors(:,3) = double(stretch(:,:,3));
    [pixelGroups, meanColors] = kmeans(colors, k);
    
    for i = 1:k  %for each color
         colors(pixelGroups == i, :) = repmat(meanColors(i, :), sum(pixelGroups == i), 1);  %replace original colors with quantized
    end
    
    outputImg = reshape(colors, [x,y,z]);
    outputImg = uint8(outputImg);
    imshow(outputImg);
    
    

