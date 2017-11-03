clear all; 
clc;

s = [100 200 0; 200 300 0;0 0 0];  % builds the stress tensor
n_1 = 1/sqrt(3)*[1 1 1]';       %a unit normal vector which is equally aligned to all axes

T_1 = s*n_1;        %Cauchy tetrahedron analysis - gives traction 

disp('Traction in original coordinate system is:   '); disp(T_1);   %display of traction in current coordinate system

theta = (pi/180)*input('Angle by which you want to rotate relative to z-axis (in Deg, CCW):');  %angle of rotation

A = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1]      %forming A matrix which for such coordinate transformation
T_1_n = A*T_1;      % directly transforming the traction to new coordinate system by using vector transformation rule

disp('Traction in new coordinate system is:   '); disp(T_1_n);  %display of traction in new coordinate system

s_n = A*s*A';        % transforming stress matrix into new coordinate system by using 2nd order tensor transformation rule

disp('Stress tensor in new coordinate system is:   '); disp(s_n); %displaying stress tensor as it looks in the new coordinate system

%calculating traction in new coordinate system using Cauchy tetrahedron
%analysis 
n_1_n = A*n_1;       % transforming the normal to new coordinate system by using vector transformation rule
T_1_n2 = s_n*n_1_n;     %Cauchy tetrahedron analysis in new coordinate system


disp('Traction in new coordinate system is (calculated by stress method):   '); disp(T_1_n2);    %display of traction in current coordinate system
