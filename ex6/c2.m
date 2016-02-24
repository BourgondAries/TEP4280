clc; clear all;
jmax = 101;
C = -1/2;
length = 1;
startTemp = 1000;
dx = length/jmax;
steps = str2num(input('How many time steps do you want?', 's'));

matrix = zeros(jmax) + eye(jmax) * (1+C);
%matrix = matrix + -C/2 * diag(ones(1, jmax-1), 1);
matrix = matrix + -C * diag(ones(1, jmax-1), -1);
matrix(1, 1:2) = [1, 0];  % Keep the temperature here constant

temp = zeros(jmax, 1);
temp(1) = startTemp;

for i = 1:steps
	temp = matrix * temp;
end
temp
