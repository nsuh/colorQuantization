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
    centers = houghpeaks(houghSpace, 5)
    
    imshow(uint8(houghSpace))
    %imshow(houghSpace)
    hold on
    plot(centers(1,1), centers(1,2), 'o', 'MarkerSize', radius)
    hold on
    scatter(centers(:,1), centers(:,2))
    hold on
    plot(centers(1,1), centers(1,2), 'o', 'MarkerSize', radius)

%     Old function
%     function [centers] = detectCircles(im, radius, useGradient)
%     [xDim, yDim, zDim] = size(im);
%     edges = edge(rgb2gray(im), 'canny');
%     find(edges == 1)
%     numEdgePoints = unique(find(edges == 1))
%     houghSpace = zeros(numEdgePoints*360, 3)
%     
%     for i = 1:360
%         a = x - radius*cos(degtorad(i));
%         b = y + radius*sin(degtorad(i));
%         houghSpace(k
%     end
%     

% less old function
% function [centers] = detectCircles(im, radius, useGradient)
%     [xDim, yDim, zDim] = size(im);
%     edges = edge(rgb2gray(im), 'canny');
%     [x,y] = find(edges == 1);
%     [numEdgePoints, junk] = size(find(edges == 1));
%     houghSpace = zeros(numEdgePoints*360, 2);
%     
%     maxRadius = 1;
%     i = 1;
%     for pixel = 1:numEdgePoints
%         for theta = 1:360
%             a = x(pixel) - radius*cos(degtorad(theta));
%             b = y(pixel) + radius*sin(degtorad(theta));
%             houghSpace(i,:) = [a,b];
%             i = i+1;
%         end
%     end
%     

%even less old function
% function [centers] = detectCircles(im, radius, useGradient)
%     [xDim, yDim, zDim] = size(im);
%     [fx, fy] = imgradient(rgb2gray(im));
%     edges = edge(rgb2gray(im), 'canny');
%     [x,y] = find(edges == 1);
%     [numEdgePoints, junk] = size(find(edges == 1));
%     houghSpace = zeros(xDim + 2*radius, yDim + 2*radius);
%     if useGradient == 0
%         for pixel = 1:numEdgePoints
%             for theta = 1:360
%                 a = ceil(x(pixel) - radius*cos(degtorad(theta))) + radius;
%                 b = ceil(y(pixel) + radius*sin(degtorad(theta))) + radius;
%                 houghSpace(a,b) = houghSpace(a,b) + 1;
%             end
%         end
%     elseif useGradient == 1
%         for pixel = 1:numEdgePoints
%             theta = atan2(fy(x(pixel), y(pixel)), fx(x(pixel), y(pixel)));
%             a = ceil(x(pixel) - radius*cos(degtorad(theta))) + radius;
%             b = ceil(y(pixel) + radius*sin(degtorad(theta))) + radius;
%             houghSpace(a,b) = houghSpace(a,b) + 1;
%         end
%     end
%     centers = houghpeaks(houghSpace, 5)
%     
%     imshow(uint8(houghSpace))
%     imshow(houghSpace)
%     hold on
%     scatter(centers(:,1), centers(:,2))