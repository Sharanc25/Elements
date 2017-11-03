clear all;
clc;

%initial conditions
p = 2;  %pressure
r = 20; %radius of the sphere
t = 1;  %thickness of sphere wall r/t = 20

%initialization of strain tensor
e_1 = 0;    
e_2 = 0;
e_3 = 0;

curr_e_eff = 0;     %storing the effective strain after some interations

dummy = 1;      %so that we can exit the while loop
i = 1;    %number of steps taken to reach convergence

while dummy == 1
    r_by_t = r/t;   
    s1 = 0.5*p*r_by_t;      %stress calculations
    s2 = s1;
    s3 = 0;
    
    s_eff = sqrt(0.5*(s1^2+s2^2+s3^2));  %effective stress at current pressure
    e_eff = (s_eff/25)^4;           %expected effective strain as by Holloman's equation
 
    if curr_e_eff/e_eff < 0.99     %check if the current set of strains or the effective strain is consistent with the consititutive equation 
        d_e_eff = 0.01;        % assignment of very small del_strain_eff - smaller it is, better it is. we assume here that stresses do not change if strains change by 0.01 or 1%
    else
        dummy = 0;              %i.e., if we are already very close to the expected effective strain for the given stress values
    end
    
    d_e_1 = (s1-0.5*(s2+s3))*d_e_eff/s_eff;      % Levy-Mises equations in differential form
    d_e_2 = d_e_1;
    d_e_3 = -(d_e_1+d_e_2);
    
    e_1 = e_1 + d_e_1;          %updating strains
    e_2 = e_2 + d_e_2;
    e_3 = e_3 + d_e_3;
    curr_e_eff = sqrt(2/3*(e_1^2+e_2^2+e_3^2)); %calculating current effective strain 
    
    %recording current data for plots
    P(i) = p;
    E_eff(i) = curr_e_eff;
    S_eff(i) = s_eff;
    
    %updating radius and thickness of sphere and pressure (assuming
    %product of pressure and volume, i.e. PV, remains constant
    r = r*(1+d_e_1);
    t = t*(1+d_e_3);
    p = p/(1+d_e_1)^3;
    
    i = i + 1;  %increase counter
end

plot(E_eff, P);
xlabel('Effective strain');
ylabel('Pressure (ksi)');

disp('Value of effective strain is: '); disp(curr_e_eff);
disp ('Strain tensor in principle axes is : '); disp([e_1 e_2 e_3]);