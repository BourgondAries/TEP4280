clc; clear all;

if input('Do you want to run the analytic solution? (y/n) (n): ', 's') == 'y'
	f = @(x,t) 1000*heaviside(x--0.8*t-1);
	endtime = 1;
	dt = 0.0066188118811881;
	steps = endtime/dt;
	for i=1:steps
		fplot(@(x) f(x, i*dt), [0, 1]);
		drawnow;
		pause(0.025);
	end
end

jmax = 101;
C = -1/2;
length = 1;
startTemp = 1000;
dx = length/jmax;
c = -0.8;
dt = dx*C/c;
endtime = str2num(input('Specify ending time (seconds): ', 's'));
steps = endtime/dt;

if input('Run the Upwind-Euler solver for 2d? (y/n) (n): ', 's') == 'y'
	% 2c)
	% 2d)
	matrix = zeros(jmax) + eye(jmax) * (1+C);
	matrix = matrix + -C * diag(ones(1, jmax-1), -1);
	matrix(1, 1:2) = [1, 0];  % Keep the temperature here constant

	temp = zeros(jmax, 1);
	temp(1) = startTemp;
	c2draw(temp, matrix, endtime, dt, steps);

end
if input('Run the FTCS solver for 2e? (y/n) (n): ', 's') == 'y'
	endtime = 0.3;
	steps = endtime/dt;
	matrix = zeros(jmax) + eye(jmax) * 1;
	matrix = matrix + -C/2 * diag(ones(1, jmax-1), -1);
	matrix = matrix + -C/2 * diag(ones(1, jmax-1), 1);
	matrix(1, 1:2) = [1, 0];  % Keep the temperature here constant

	temp = zeros(jmax, 1);
	temp(1) = startTemp;
	c2draw(temp, matrix, endtime, dt, steps);

end


