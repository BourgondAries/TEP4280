clc; clear all;
u = [];
initCond; C = 0.75; u(:, 1) = uex(x); t_end = 0.5;
xl = 1; dx = xl/jmax;
c = 0.5; dt = dx*C/c;
steps = t_end/dt;
matrix = C*eye(jmax);
matrix = matrix + C/2*diag(ones(1, jmax-1), -1);
matrix = matrix - C/2*diag(ones(1, jmax-1), +1);

matrix = matrix + C^2/2*diag(ones(1, jmax-1), +1);
matrix = matrix - C^2*diag(ones(1, jmax),  0);
matrix = matrix + C^2*diag(ones(1, jmax-1), -1);
for i = 1:steps
	u(:, i+1) = matrix * u(:, i);
	plot(x, u(:, i+1));
	drawnow;
	pause(1);
end
% u(:, n+1) = u(:, n) - C*(u(:
% u^{n+1}_j = u^n_j - C/2u^n_{j+1} + C/2 u^n_{j-1}} + \frac{1}{2} C^2 [ u_i+1 - 2u_j + u_i-1 $$
