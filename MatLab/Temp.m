image = ('6.tif');

I = imread(image);
I = rgb2gray(I);
I = imnoise(I,'salt & pepper',0.0002);

% Threshold image - global threshold
BW = imbinarize(I);
BW = imcomplement(BW);

% Create masked image.
maskedImage = I;
maskedImage(~BW) = 0;

BW2 = bwmorph(BW,'remove');
figure
imshow(BW2);