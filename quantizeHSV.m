function [outputImg, meanHues] = quantizeHSV(origImg, k)
    [x, y, z] = size(origImg);
    xy = x*y;
    outputImg = rgb2hsv(origImg);
    stretch = reshape(outputImg, [xy, 1,z]);  %stretch matrix into vector
    [assignedHue, meanHues] = kmeans(double(stretch(:,:,1)), k);  %running kmeans
    for i = 1:k  %for each cluster, assign the color
        i
        assignedHue(assignedHue == i) = meanHues(i);
    end
    %assignedHue = uint8(assignedHue);  %!!!!
    outputImg(:,:,1) = reshape(assignedHue, [x,y,1]);
    outputImg = hsv2rgb(outputImg);
    imshow(outputImg);