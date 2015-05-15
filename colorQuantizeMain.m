%Nathan Suh
im = imread('fish.jpg');
figure
subplot(2,2,1)
rbgIm5 = quantizeRGB(im, 5);
title('RGB quantized to 5 colors')
subplot(2,2,2)
rgbIm25 = quantizeRGB(im, 25);
title('RGB quantized to 25 colors')
subplot(2,2,3)
hsvIm5 = quantizeHSV(im, 5);
title('HSV quantized to 5 hues')
subplot(2,2,4)
hsvIm25 = quantizeHSV(im, 25);
title('HSV quantized to 25 hues')

computeQuantizationError(rgbIm5, im)
computeQuantizationError(rgbIm25, im)
computeQuantizationError(hsvIm5, im)
computeQuantizationError(hsvIm25, im)