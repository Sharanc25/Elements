clear all;    %clear/erase all variables from the list
close all;    % close all open figure windows
clc;          %clean the MATLAB window

[X,Y,Z]=meshgrid(-3:0.1:3, -3:0.1:3,-3:0.1:3); %generate a points separated by (0.1,0.1,0.1) in the cube formed by (-3,-3,-3) and (3,3,3) vertices 
F= X.^2+Y.^2+Z.^2-X.*Y-Y.*Z-X.*Z; %the von Mises criteria - sig_1^2+sig_2^2+sig_3^2-sig_1*sig_2-sig_2*sig_3-sig_3*sig_1 = sig_ys
YS=1;                             %set the yield strength
p1=patch(isosurface(X,Y,Z,F,YS)); %create the surface p1 which satisfies F = YS using the (X,Y,Z) points
set(p1, 'FaceColor','r')          % color of the surface is set to blue color
view(3);                          % view the plot in 3-D
axis([-5 5 -5 5 -5 5]);
grid on;

alpha = linspace(-5.5,5.5,1000);     % generate 1000 points between -4 and 4
x1 = alpha/sqrt(3);              % x-coordinate of the hydrostatic line
y1 = alpha/sqrt(3);
z1 = alpha/sqrt(3);
p2 =line(x1,y1,z1);     %plot hydrostatic line with sigma 1 = sigma 2 = sigma 3

%view([1/sqrt(3) 1/sqrt(3) 1/sqrt(3)]); %view from the hydrostatic line