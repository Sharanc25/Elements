clear all;
clc;

n = 100;
x = zeros(n+1,1);
y = zeros(n+1,1);
z = zeros(n+1,1);
s11 = 1/2e11;
s44 = 1/1e11;
A = input('Give the value of A (>0): ');

for i = 1:n
    x (i+1) = i/n;
    y(i+1) = i/n;
end

for i = 1:n+1
    for j = 1:n+1
               z = sqrt(1-x(i)^2-y(j)^2);
            if imag(z)==0
                E(i,j) = 1/(s11-(A-1)*s44*(x(i)^2*y(j)^2+y(j)^2*z^2+z^2*x(i)^2));
            end
    end
end

surface(x,y,E)