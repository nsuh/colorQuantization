function [outputImg, meanColors] = quantizeRGB(origImg, k)
    [x, y, z] = size(origImg);
    xy = x*y
    stretch = reshape(origImg, [xy, 1,z]);
    assignedR = zeros(xy, 1);
    assignedG = zeros(xy, 1);
    assignedB = zeros(xy, 1);
    [assignedR, valuesR] = kmeans(double(stretch(:,:,1)), k);
    [assignedG, valuesG] = kmeans(double(stretch(:,:,2)), k);
    [assignedB, valuesB] = kmeans(double(stretch(:,:,3)), k);
    
    for i = 1:k
        assignedR(assignedR == i) = uint8(valuesR(i));
        assignedG(assignedG == i) = uint8(valuesG(i));
        assignedB(assignedB == i) = uint8(valuesB(i));
    end
    outputImg = zeros(xy, 1, z);
    outputImg(:,:,1) = assignedR;
    outputImg(:,:,2) = assignedG;
    outputImg(:,:,3) = assignedB;
    outputImg = reshape(outputImg, [x,y,z]);
    outputImg = uint8(outputImg);
    imshow(outputImg);
    