clc;
clear all; 

S = zeros(6,6);         % the complaince tensor is 6 x 6 matrix - initialize it to 0
s11 = (1/100/10^9);     % input the known components of the complaince tensor
s12 = -(0.3/100/10^9);
s44 = 0.007*10^-9;

sig = [10 30 0;30 20 0; 0 0 0]*10^9;   % building stress tensor for plane stress condition

% building compliance tensor by indentifying values of non-zero components
for i = 1:3     
    for j = 1:3
        if i == j
            S(i,j) = s11;       %s11 = s22 = s33
        else
            S(i,j) = s12;       %s12 = s21 = s13 = s31 = s23 = s32
        end
    end
end

for i = 4:6
    S(i,i) = s44;       %s44 = s55 = s66
end

disp('Compliance Tensor is:   '); disp(S);      %display built complaince tensor - check if everything so far is alright!

%stress tensor in Voigt's notation
for i = 1:3
    sig_v(i) = sig(i,i);        %first three terms are normal stresses
end

% shear stresses in Voigt's notation
sig_v(4) = sig(2,3);
sig_v(5) = sig(1,3);
sig_v(6) = sig(1,2);

%disp('stress in Voigt-s notation:   '); disp(sig_v');      %check if
%aissignment of values is alright

strain_v = S*sig_v';        %Hooke's law in 2-index notation

%building strain tensor 
strain = zeros(3,3);    %define the size of the strain matrix and initialize it with 0

%notmal strains
for i = 1:3
    strain(i,i) = strain_v(i);    
end

%shear strain - note 1/2 term on the right! the tensorial shear strains are
%half of corresponding engineering shear strains
strain(1,2) = 0.5*strain_v(6);
strain(1,3) = 0.5*strain_v(5);
strain(2,3) = 0.5*strain_v(4);

strain(2,1)= strain(1,2); strain(3,1) = strain(1,3); strain(3,2) = strain(2,3);

%disp('Strain tensor for cubic system:   '); disp(strain);      %check if
%everything looks fine

%calculation of Eigen values and vectors for stress and strain tensors
[strain_vec,strain_val] = eig(strain);          %strain_vec is principal axes for strain tensor
[stress_vec,stress_val] = eig(sig);          %stress_vec is principal axes for strain tensor

disp('Principle axes of stress tensor:   '); disp(stress_vec);      %displaying principal axes of stress tensor
disp('Principle axes of strain tensor:   '); disp(strain_vec);      %displaying principal axes of strain tensor
