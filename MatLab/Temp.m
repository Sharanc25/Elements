image = ('5.tif');

I = imread(image);
I = rgb2gray(I);

% Threshold image - global threshold
BW = imbinarize(I);
BW = imnoise(BW,'salt & pepper',0.021);
BW = imcomplement(BW);



BW2 = bwmorph(BW,'remove');
figure
imshow(BW2);