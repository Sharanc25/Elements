clear all;
clc;

%Finding the stress tensor in 2-D
s_11 = input('Enter the value of sigma 11 (MPa): ');
s_22 = input('Enter the value of sigma 22 (MPa): ');
s_12 = input('Enter the value of sigma 12 (MPa): ');

s=[s_11 s_12;s_12 s_22];   %building the stress tensor

[V E]=eig(s);    %principal stresses and directions
s_p = [E(1,1) E(2,2)];    %first and second principal stresses
tau_max = abs((s_p(1)-s_p(2))/2); %maximum shear stress

theta = (pi/180)*input('Angle by which you want to rotate the planes (in Deg, CCW):  ');
A = [cos(theta) sin(theta); -sin(theta) cos(theta)];  %direction cosines matrix

s_prime = A*s*A'; %stress values after rotation

disp(sprintf(' Principal stresses are %5.5f and %5.5f MPa',s_p(1), s_p(2))) %printing both principal stresses
disp(sprintf(' Maximum shear stress is %5.5f MPa',tau_max))
disp('the stress tensor in the new coordinate system is: ');disp(s_prime);

%drawing Mohr Circle
xc = (s_11+s_22)/2; %x-coordinate of Mohr Cicle
yc = 0;        %y-coordinate of the Mohr circle
ra = 0.5*sqrt((s_11-s_22)^2+(2*s_12)^2); %radius of Mohar circle
pdecirc(xc,yc,ra); %draw a cicle with x,y as center and r as radius
