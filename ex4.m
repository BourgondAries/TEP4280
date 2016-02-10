clc; clear all;

% a)
if input('Find when u(1/2, t) = 1/4? (y/n): ', 's') == 'y'
	u = @(y,t) ex4a(y, t);

	uz = @(t) u(1/2, t) - 1/4;
	range = [0 1e-1];
	fplot(uz, range);
	hold on;
	fplot(@(t) 1, range);
	fzero(uz, 1/2, [0 1])
	% ans = 0.094686934050575
end

% g, h, i)
if input('Run the implicit euler method? (y/n): ', 's') == 'y'

	% Set up various constants
	str = input('Choose dt (0.00125): ', 's');
	if  strcmp(str, '') dt = 0.00125;
	else dt = str2double(str); end
	str = input('Choose tstop (1): ', 's');
	if  strcmp(str, '') tstop = 1;
	else tstop = str2double(str); end
	nmax = ceil(tstop/dt);
	U = 1; L = 1; jmax = 21; dy = L/(jmax-1);

	% Set up the system
	r = dt/dy^2;
	A = diag(ones(jmax-1,1),1) * (-r) + ...
		diag(ones(jmax,1)) * (1+2*r) + ...
		diag(ones(jmax-1,1),-1) * (-r);

	% Because the speed at the top and bottom remain constant
	A(1,1) = 1;
	A(1,2) = 0;
	A(21,20) = 0;
	A(21,21) = 1;

	% Initialize with a constant speed of U at the top
	b = ones(21, 1) * 0;
	b(1) = U;

	% Continuously draw the next approximations
	for i=1:nmax
		b = A \ b;
		plot(b, 1:-dy:0);
		drawnow;
	end
end
