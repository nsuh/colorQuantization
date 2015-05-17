function [centers] = detectCircles(im, radius, useGradient)
    [xDim, yDim, zDim] = size(im);
    [fx, fy] = imgradient(rgb2gray(im));
    edges = edge(rgb2gray(im), 'canny');
    [x,y] = find(edges == 1);
    [numEdgePoints, junk] = size(find(edges == 1));
    houghSpace = zeros(xDim, yDim);
    if useGradient == 0
        for pixel = 1:numEdgePoints
            for theta = 1:360
                a = ceil(x(pixel) - radius*cos(degtorad(theta)));
                b = ceil(y(pixel) + radius*sin(degtorad(theta)));
                if (a <= 0) | (a > xDim)
                    continue
                end
                if b <= 0 | (b > yDim)
                    continue
                end
                houghSpace(a,b) = houghSpace(a,b) + 1;
            end
        end
    elseif useGradient == 1
        for pixel = 1:numEdgePoints
            theta = atan2(fy(x(pixel), y(pixel)), fx(x(pixel), y(pixel)));
            a = ceil(x(pixel) - radius*cos(degtorad(theta)));
            b = ceil(y(pixel) + radius*sin(degtorad(theta)));              
            if (a <= 0) | (a > xDim)
                continue
            end
            if (b <= 0) | (b > yDim)
                continue
            end
            houghSpace(a,b) = houghSpace(a,b) + 1;
        end
    end
    centers = houghpeaks(houghSpace, 3)
    
    imshow(uint8(houghSpace))
    hold on
    plot(centers(:,2), centers(:,1), 'o', 'MarkerSize', radius) 
    title(sprintf('%d', radius))

    %thresholding
    mask = false(size(houghSpace));
    mask(170,70) = true;
    
    
    
    
    
    