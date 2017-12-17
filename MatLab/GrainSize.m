BW = [Top4,Top5,Top6];

%BW = [CS2,CS3,CS4];

[Height, Width] = size(BW);

BW_out = bwareafilt(BW, 500000);

% Get properties.
properties = regionprops(BW_out,'Area');

% Area of region of interest
roi_area = sum([properties.Area]);

% Area of the whole image
image_area = Width * Height;

% Area Fraction of the
area_fraction = (roi_area/image_area)*100;

% Average Area
avg_area = mean([properties.Area]);

% Standard Deviation
standard_deviation = std([properties.Area]);

% Error
numberOfPoints = numel(properties);
A = (standard_deviation/avg_area)^2;

Error = sqrt((1+A)/numberOfPoints);

% The %f in the fprintf function prints the notation in decimals instead of
% exponentials
fprintf('Area Fraction (percent) = %f. Error (percent) = %f. \n',area_fraction,Error*100);