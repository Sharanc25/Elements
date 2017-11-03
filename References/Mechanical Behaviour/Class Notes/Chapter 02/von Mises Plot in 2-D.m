clear all;    %clear/erase all variables from the list
close all;    % close all open figure windows
clc;          %clean the MATLAB window

[X,Y]=meshgrid(-3:0.1:3,-3:0.1:3); %generate points separated by (0.1,0.1) in a square formed by (-3,-3) and (3,3) vertices 
F= X.^2+Y.^2-X.*Y; %the von Mises criteria - sig_1^2+sig_2^2-sig_1*sig_2 = sig_ys
YS=1.0001;                             %set the yield strength 1.0 does not give a closed ellipse
contour(X,Y,F,YS,'b'); %create the contour which satisfies F = YS using the (X,Y) points
axis([-2 2 -2 2]);   %limits on axis of plot - x min of -2 to x max of 2, and y min of -2 to y max of 2
xlabel('sigma_1');   % x-axis lable is sigma subscript 1
ylabel('sigma_2');   % y-axis lable is sigma subscript 2
grid on;              %turn on grid
