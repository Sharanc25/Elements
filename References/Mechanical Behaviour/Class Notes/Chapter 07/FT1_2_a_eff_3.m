clear all; 
clc;

a = 15e-3; % initial crack length
w = 80e-3; % width of the sample
YS = 350e6; % yield strength of material

sigma_0 = 150e6;    %applied far field stress in Pa
t = 5e-3;           %thickness of the sample - to test if it requires correction

j = 0;          %dummy variable for escape while loop is convergece is achieved
i = 1;          % counter
error = 1e-3;   %Convergence criterion

% Checking if the problem is under plane strain condition

beta_0 = (1.99 - 0.41*(a/w) + 18.7*(a/w)^2 - 38.48*(a/w)^3 + 53.85*(a/w)^4)/sqrt(pi());    %calculate first beta value
K_I_0 = sigma_0*sqrt(pi()*a)*beta_0;    %first K_I based on last a value
r_p_0 = K_I_0^2/(pi()*YS^2);          %first guess for the plastic zone size
disp('Initial K_I value is equal to (in MPa.m^0.5):'); disp(K_I_0);


if t/r_p_0 > 40                        % if it is already in plane strain condition
   j = 1;
   disp('Problem is under plane strain condition. No need for correction.');
   K_I_eff = K_I(i);
   a_eff = a/2+0.5*r_p(i)/3;
   disp('K_I value is equal to (in MPa.m^0.5):'); disp(K_I_eff);
   disp('Crack length is equal to (in m):'); disp(a_eff);
end

% if it is in not in plane strain condition - then do the following until the convergence criterion is satisfied

beta_laststep = beta_0;
K_I_laststep = K_I_0;
r_p_laststep = r_p_0;

while j == 0
    beta(i) =  beta_laststep;   
    K_I(i) = K_I_laststep;    
    r_p(i) = r_p_laststep;          
    
    a_corr = a + r_p(i)/2;         %Update the crack length by adding half of plastic zone size
    beta(i+1) = (1.99 - 0.41*(a_corr/w) + 18.7*(a_corr/w)^2 - 38.48*(a_corr/w)^3 + 53.85*(a_corr/w)^4)/sqrt(pi());    %new beta value
    K_I(i+1) = sigma_0*sqrt(pi()*a_corr)*beta(i+1);  %Corrected K_I taking care of plastic zone
    r_p(i+1) = K_I(i+1)^2/(pi()*YS^2);                  %updated plastic zone size
    
    if  (K_I(i+1)-K_I(i))/K_I(i) < error  || i > 100      % if convergence is satisfied
        j = 1;                     %escape the while loop
        K_I_eff = K_I(i+1);             %final K_I value
        a_eff = a + r_p(i+1)/2;  %effectice crack length
        
        disp('Modified K_I value is equal to (in MPa.m^0.5):'); disp(K_I_eff);
        disp('Effective crack length is equal to (in m):'); disp(a_eff);
        disp('Number of steps to converge:'); disp(i);
    else
        beta_laststep = beta(i+1);
        K_I_laststep = K_I(i+1);
        r_p_laststep = r_p(i+1);
        i = i + 1;
    end
end

for m = 1:i+1
    x(m) = m;
end

plot(x,K_I,'o-');
xlabel('Number of Iteration');
ylabel('K_I (Pa m^0^.^5)');

