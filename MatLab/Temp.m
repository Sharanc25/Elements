image = ('C:\Users\Sharan\Downloads\5_005.tif');

image_info = imfinfo(image);

I = imread(image);
I = rgb2gray(I);

% Threshold image - global threshold
BW = imbinarize(I);
BW = imcomplement(BW);
imshow(BW);