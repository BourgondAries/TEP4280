clc; clear all; hold off;
initCond; C = 0.75; u = transpose(uex(x));
t_end = str2num(input('t_end: ', 's'));
xl = 1; dx = xl/jmax;
c = 0.5; dt = dx*C/c;
steps = t_end / dt;
matrix = eye(jmax);
matrix = matrix + C/2*diag(ones(1, jmax-1), -1);
matrix = matrix - C/2*diag(ones(1, jmax-1), +1);

matrix = matrix + C^2/2*diag(ones(1, jmax-1), +1);
matrix = matrix - C^2*diag(ones(1, jmax), 0);
matrix = matrix + C^2/2*diag(ones(1, jmax-1), -1);

for i = 1:steps
	u = matrix * u;
	plot(x, u);
	drawnow;
	pause(0.1);
end

hold on;
initCond;
