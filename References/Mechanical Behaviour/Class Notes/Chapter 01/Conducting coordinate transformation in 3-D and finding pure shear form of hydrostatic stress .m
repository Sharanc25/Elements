clear all;
clc;

%Finding the stress tensor in 3-D
s_11 = input('Enter the value of sigma 11 (MPa): ');
s_12 = input('Enter the value of sigma 12 (MPa): ');
s_13 = input('Enter the value of sigma 31 (MPa): ');
s_22 = input('Enter the value of sigma 22 (MPa): ');
s_23 = input('Enter the value of sigma 23 (MPa): ');
s_33 = input('Enter the value of sigma 33 (MPa): ');

 %building the stress tensor s
 s=[s_11 s_12 s_13;s_12 s_22 s_23;s_13 s_23 s_33];  


 %calculating principal stresses and directions
[V E]=eig(s);    

%storing principal stresses in a row
s_p = [E(1,1) E(2,2) E(3,3)];    

%maximum shear stress = 0.5*(max_normal stress - min_normal stress)
tau_max = 0.5*abs(max(s_p)-min(s_p)); 

% Illustration of transformation of a 3-D stress matrix - rotation along
% z-axis

theta = (pi/180)*input('Angle by which you want to rotate z-axis (in Deg, CCW):  ');
A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]; %direction cosines matrix
s_prime = A*s*A'; %stress values after rotation

disp('  ');
disp('Imput stress tensor: ');disp(s);
disp(sprintf(' Principal stresses are %5.5f, %5.5f, and %5.5f MPa',s_p(1), s_p(2), s_p(3))) %printing both principal stresses
disp(sprintf(' Maximum shear stress is %5.5f MPa',tau_max))
disp('the stress tensor in the new coordinate system is: ');disp(s_prime);

disp('--------    Pure shear form of deviatoric stress tensor   -------------');

%Finding the hydrostatic and deviatoric stress tensors
s_h = [trace(s)/3 0 0; 0 trace(s)/3 0; 0 0 trace(s)/3];     %hydrostatic component of stress tensor
s_d = s-s_h;                                                %deviatoric component of stress tensor
[V_d E_d]=eig(s_d);     %principal stresses and directions for deviatoric stress

disp('the deviatoric stress tensor is: ');disp(s_d);

%rotation so that the new x-axis is equi-axed from all coordinate axes.
%Thus, a11 = a12 = a13 = 1/sqrt(3). The other two axes are chosen randomly
%to form a cartesian coordinate system. New X-axis is [111], Y axis is [1
%-1 0], etc. 
a = 1/sqrt(3);  b = 1/sqrt(6);
Ad = [a 0 2*b;a -1/sqrt(2) -b; a 1/sqrt(2) -b]'; %note here a_ij = cosine of new i and old j

% Direction cosine matrix to transform the deviatoric stress to its principal state
A_s_d = V_d';    %i.e., A_s_d*s_d*A_s_d' will be the diagonal matrix with entries as principal stresses of s_d   

A_f = Ad*A_s_d;   %Af rotates the Eigen vector coordinate system to a new system which is equiaxed to it

% So, transformation of the deviatoric stress to this new coordinate system equiaxed to the principle stress 

s_d_s = A_f*s_d*A_f';    %s_d_s will have the first diagonal entry equal to zero hence, s_d_s can now be plotted/treated with help of Mohr circle

% the first entry corresponds to x-axis which is now equiaxed. Note that
% for principle form of deviatoric stress tensor sigma_d
% sigma_xx' = sigma_d_11*a1l^2+sigma_d_22*a12^2+sigma_d_33*a13^2 =
% (sigma_d_11+sigma_d_22+sigma_d_33)*a1l^2 as a11 = a12 = a13 

%angle from the normal stress axis in the above 2-D case in plane 2-3 or
%y-z
theta1 = 0.5*atan(2*abs((s_d_s(2,3)/(s_d_s(2,2)-s_d_s(3,3)))));   %note that the first diagonal entry is zero

%the angle by which we must rotate the x-axis for s_d_s to attain the maximum shear stress
theta2 = pi()/4 - theta1; % 45 - current theta

% coordinate transformation matrix / rotation by theta2 around x-axis
A1 = [1 0 0; 0 cos(theta2) sin(theta2); 0 -sin(theta2) cos(theta2)];  %direction cosines matrix
%in above also, a_ij = cosine of new i and old j


%final stress tensor which in pure shear
s_d_s1 = A1*s_d_s*A1'; 

% net transformation matrix
Q = A1*Ad*A_s_d;

%So deviatoric stress tensor written in the pure shear form
pure_shear = Q*s_d*Q'; 

disp('The net coordinate transformation matrix A which will transform deviatoric stress tensor into pure shear form   '); disp(Q);
disp('Pure Shear Form of Deviatoric Stress Tensor   '); disp(pure_shear);



