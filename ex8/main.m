prompt = @(text) input([text ' (y/n) (n): '], 's') == 'y';

if prompt('1b?')
	u_r = 5; u_l = 10;
	s = 7.5;
	f = @(t,x) (1-heaviside(x-t*s))*(u_l) + heaviside(x-t*s)*u_r;
	drawing(f);
end

if prompt('1c?')
	u_l = 5; u_r = 10;
	f = @(t,x) u_l*(1-heaviside(x-u_l*t)) + ...
		u_r*heaviside(x-u_r*t) + ...
		(x*((u_r-u_l)/(-(x-u_r*t)+(x-u_l*t)))) * ...
		heaviside(x-u_l*t)*(1-heaviside(x-u_r*t));
	drawing(f);
end

if prompt('2c?')
	jmax = 21; u_max = 2.2; length = 2; dx = length/jmax;
	dt = dx/u_max;
	dt = str2num(input(['Enter dt below ', num2str(dt), ', ideally a multiple of 0.25: '], 's'));
	m = dt/dx/2; speeds = linspace(-1, 1, jmax);
	domain = speeds; speeds(speeds >= -0.5) = 0.2;
	speeds(speeds < -0.5) = 2.2; u = speeds; v = u; t = 0;
	while true
		plot(domain, v);
		title(['t=', num2str(t)]);
		axis([-1, 1, 0, 3]);
		disp('Press enter to continue');
		u = v; pause; t = t + dt;
		for i = 2:numel(u)
			v(i) = u(i) - m*(u(i)^2 - u(i-1)^2);
		end
	end
end
if prompt('2d?')
	jmax = 81; u_max = 2.2; length = 2;
	dx = length/jmax; dt = dx/u_max;
	dt = str2num(input(...
		['Enter dt below ', num2str(dt),...
		', ideally a multiple of 0.25: '], 's'));
	m = dt/dx/2;
	init = @(x) cos(pi*x/2).^2;
	speeds = linspace(-1, 1, jmax);
	domain = speeds; speeds = arrayfun(init, speeds);
	u = speeds; v = u;
	t = 0;
	while true
		plot(domain, v); title(['t=', num2str(t)]);
		axis([-1, 1, 0, 1]);
		disp('Press enter to continue');
		u = v; pause; t = t + dt;
		for i = 2:numel(u)
			v(i) = u(i) - m*(u(i)^2 - u(i-1)^2);
		end
		% Here we compute the loopback:
		v(1) = u(numel(u)) - m*(u(numel(u))^2 - u(numel(u)-1)^2);
	end
end
