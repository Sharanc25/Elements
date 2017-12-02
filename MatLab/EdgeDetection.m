image = ('3.tif');

image_info = imfinfo(image);

I = imread(image);
I = rgb2gray(I);

% Threshold image - global threshold
BW = imbinarize(I);

% Invert mask
BW = imcomplement(BW);

% Create masked image.
maskedImage = I;
maskedImage(~BW) = 0;

%{
BW = edge(BW,'canny');

% Make tempoprary line.
%BW(end, :) = true;
% arm is sealed off.  Now we can fill.
BW = imfill(BW, 'holes');
% Erase temporary line.
%BW(end,:) = false;
%}

BW_out = bwareafilt(BW, 15000);

% Get properties.
properties = regionprops(BW_out, {'Area', 'Eccentricity', 'EquivDiameter', 'EulerNumber', 'MajorAxisLength', 'MinorAxisLength', 'Orientation', 'Perimeter'});

% Area of region of interest
roi_area = sum([properties.Area]);

% Area of the whole image
image_area = image_info.Width * image_info.Height;

% Area Fraction of the 
area_fraction = (roi_area/image_area)*100;

% Standard Deviation
standard_deviation = std([properties.Area]);

% Average Area
avg_area = mean([properties.Area]);

% Error
numberOfPoints = numel(properties);
A = (standard_deviation/avg_area)^2;

Error = sqrt((1+A)/numberOfPoints);

imshow(BW_out);

% The %f in the fprintf function prints the notation in decimals instead of
% exponentials
fprintf('Area Fraction = %f. Error = %f. \n',area_fraction,Error*100);