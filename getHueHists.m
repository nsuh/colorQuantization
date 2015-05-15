function [histEqual, histClustered] = getHueHists(im, k)
    [im, hues] = quantizeHSV(im, k);
    [x, y, z] = size(im);
    xy = x*y;
    hsvImg = rgb2hsv(im);
    colors = reshape(hsvImg(:,:,1), [xy, 1,1]);
    uniqueColors = unique(single(colors));  %stupid precision error
    figure
    subplot(2,1,1)
    hist(single(colors), k)
    title('K equally spaced bins')
    subplot(2,1,2)
    hist(colors, uniqueColors(uniqueColors ~= 0)) %get rid of the zero  
    title('Bins determined by unique hues')