clear all; 
clc;

a0 = 1e-3*input('Give total length of physical central-crack, i.e., value of 2a (in mm): ');
a = a0/2;   %half crack length
w = 1e-3*input('Give the width of the sample (in mm): ');
YS = 1e6*input('Give the yield strength of material (in MPa): ');

sigma_0 = 150e6;    %applied far field stress in Pa
t = 5e-3;           %thickness of the sample - to test if it requires correction

j = 0;          %dummy variable for escape while loop is convergece is achieved
i = 1;          % counter
error = 1e-3;   %Convergence criterion


while j == 0    %i.e. till the convergence criterion is satisfied 
    
    beta(i) = 1 + 0.128*(2*a/w) - 0.288*(2*a/w)^2 + 1.523*(2*a/w)^3;    %calculate first beta value
    K_I(i) = sigma_0*sqrt(pi()*a)*beta(i);    %first K_I based on last a value
    r_p(i) = K_I(i)^2/(pi()*YS^2);          %first guess for the plastic zone size
    
    if t/r_p(i) > 40                        % if it is already in plane strain condition
        j = 1;
        disp('Problem is under plane strain condition. No need for correction.');
        K_I_eff = K_I(i);
        a_eff = a0/2+0.5*r_p(i)/3;
        disp('K_I value is equal to (in MPa.m^0.5):'); disp(K_I_eff);
        disp('Crack length is equal to (in m):'); disp(a_eff);
        break;
    else
        a_corr = a0/2 + r_p(i)/2;         %Update the crack length by adding half of plastic zone size
        beta(i+1) = 1 + 0.128*(2*a_corr/w) - 0.288*(2*a_corr/w)^2 + 1.523*(2*a_corr/w)^3;    %new beta value
        K_I(i+1) = sigma_0*sqrt(pi()*a_corr)*beta(i+1);  %Corrected K_I taking care of plastic zone
        r_p(i+1) = K_I(i+1)^2/(pi()*YS^2);                  %updated plastic zone size
    end
    
    if  (K_I(i+1)-K_I(i))/K_I(i) < error  || i > 100      % if convergence is satisfied
        j = 1;                     %escape the while loop
        K_I_eff = K_I(i+1);             %final K_I value
        a_eff = a0/2 + r_p(i+1)/2;  %effectice crack length
        
        disp('Modified K_I value is equal to (in MPa.m^0.5):'); disp(K_I_eff);
        disp('Effective crack length is equal to (in m):'); disp(a_eff);
    else
        a = a0/2 +r_p(i+1)/2;
        i = i + 2;
    end
end

