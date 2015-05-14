function [error] = computeQuantizationError(origImg,quantizedImg)
    error = sumsqr(double(origImg) - double(quantizedImg));