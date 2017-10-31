image_info = imfinfo(BW);

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
avg_area = mean(standard_deviation);

imshow(BW_out);

% The %f in the fprintf function prints the notation in decimals instead of
% exponentials
fprintf('Area Fraction = %f. Standard Deviation = %f. \n',area_fraction,standard_deviation);