clear all; 
clc; 

pl = [1 1 1; 1 1 1; 1 1 1; 1 1 -1; 1 1 -1; 1 1 -1; 1 -1 1; 1 -1 1; 1 -1 1; -1 1 1; -1 1 1; -1 1 1];
dir = [1 -1 0; 0 1 -1; 1 0 -1; 1 -1 0; 0 1 1; 1 0 1;0 1 1; 1 1 0; 1 0 -1; 1 1 0; -1 0 -1; 0 1 -1];

%test for correct entries
% for i = 1:12
%     d = pl(1,:)*dir(1,:)';
% end

load_axes_in = input('Give loading vector in [x y z] format: ');
load_axes = load_axes_in/sqrt(load_axes_in*load_axes_in');

for i = 1:12
    cos_phi = (pl(i,:)/sqrt(3))*load_axes';
    cos_lambda = (dir(i,:)/sqrt(2))*load_axes';
    m(i) = cos_phi*cos_lambda;
end

disp(m);
disp('Maximum Schmid factor is '); disp(max(m));