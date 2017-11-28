image = ('6.tif');

I = imread(image);
I = rgb2gray(I);

% Threshold image - global threshold
BW = imbinarize(I);
%BW = imcomplement(BW);

BW2 = bwmorph(BW,'skel',Inf);
figure
imshow(BW2);