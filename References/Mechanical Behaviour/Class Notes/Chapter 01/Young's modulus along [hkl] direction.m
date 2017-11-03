clc; 
clear all; 

% this works for a cubic system only. Hence, we need three different
% elastic moduli - namely s11, s12 and s44
s11 = input('value of S11 in crystal system (1/GPa): ');
s12 = input('value of S12 in crystal system (1/GPa): ');
s44 = input('value of S44 in crystal system (1/GPa): ');

% building the compliance tensor 
S = [s11 s12 s12 0 0 0;s12 s11 s12 0 0 0;s12 s12 s11 0 0 0; 0 0 0 s44 0 0; 0 0 0 0 s44 0; 0 0 0 0 0 s44];

% need for the primary direction along which we need to measure Young's
% modulus
x1 = input('direction cosine along which Youngs modulus [h k l] format: ');

%making up two direction perpendicular to x1 and each other
x2 = [-x1(2) x1(1) 0];    %just a random guess which will give a dot product with x1 = 0
x3 = cross(x1,x2);  %the third direction is then specified

%getting ortho-normal set of coordinate systems
e1 = x1/norm(x1);
e2 = x2/norm(x2);
e3 = x3/norm(x3);

%rotation matrix
A_T = [e1; e2; e3];   %transpose of A matrix as the original coordinate system is unitary
A = A_T';

sig = [1 0 0; 0 0 0; 0 0 0];  %uniaxial stress in the reference coordinate system
sig_crys = A*sig*A';  %stress tensor in crystal coordinate system

%Hooke's law in crystal coordiate system using Voigt's notation 
sig_voigt = [sig_crys(1,1); sig_crys(2,2); sig_crys(3,3); sig_crys(2,3); sig_crys(1,3);sig_crys(1,2)];
strain_voigt = S*sig_voigt;

strain_crys = [strain_voigt(1) 0.5*strain_voigt(6) 0.5*strain_voigt(5); 0.5*strain_voigt(6) strain_voigt(2) 0.5*strain_voigt(4); 0.5*strain_voigt(5) 0.5*strain_voigt(4) strain_voigt(3)];

strain = A'*strain_crys*A;  %strain tensor back in reference coordinate system

% calculation of Young's modulus and Poisson's ratios
E_hkl = sig(1,1)/strain(1,1);
neu_yy = -strain(2,2)/strain(1,1);
neu_zz = -strain(3,3)/strain(1,1);
ans1 = [E_hkl neu_yy neu_zz];

%displaying results
st = 'Young Modulus (GPa), Poisson Ratio 1 and Poisson Ratio 2 are';
st2 = 'respectively';
disp(st); disp(ans1);disp(st2);