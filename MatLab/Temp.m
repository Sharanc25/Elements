image = ('6.tif');

I = imread(image);
I = rgb2gray(I);
I= imnoise(I,'salt & pepper',0.2);

% Threshold image - global threshold
BW = imbinarize(I);
BW = imcomplement(BW);

BW2 = bwmorph(BW,'remove');
figure
imshow(BW2);