%{
	1a)
		i and ii should cause a local discontinuity.
		i is the case of a shock wave.
		ii is the case where the shock wave is reversed.
		iii does not have a local discontinuity, and thus no shock wave.

	1b)
		The speed of the shock wave is given by the average of both speeds:
		(10 + 5) / 2 = 7.5

		The exact solution should be a shockwave propagating at this speed.
		(1-heaviside(-t*7.5+x))*(10) + heaviside(-t*7.5+x)*5;

	1c) We can't compute a shock speed because there is no shockwave (u_l < u_r, u_l, u_r > 0). There is only rarefaction.
		To compute a solution, we simply let each wave propage and interpolate the unused space.
		First: the heaviside part of u_l:
			u_l*(1-heaviside(x-u_l*t))
		The heaviside part of u_r:
			u_r*heaviside(x-u_r*t)
		Now the interpolating part:
			This is the part the specifies the middle of the two
				heaviside(x-u_l*t)*(1-heaviside(x-u_r*t)
			Now we multiply this by the interpolating x:
			But first, we need the value to start at u_l
				(x*((u_r-u_l)/(-(x-u_r*t)+(x-u_l*t)))) * ...
			This is simply the interpolating formula taking
			(Delta x) * dy/dx

	2a)
		I'd use a heaviside function to state that the boundary on the left is 2.2, and the one on the right is 0.2.
		For u_b I'd define the boundary as a continuous one, since the curve is symmetric on the given interval
%}

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
	% We consider the function u_t + u*(u_x) = 0
	% (u^{n+1} - u^n)/Dt + u^n_i * (u^n_i - u*n_{i-1})/Dx = 0
	% u^{n+1} = u^n - Dt/Dx * u^n_i * (u^n_i - u*n_{i-1})
	% Using the conservative form we get:
	% (u^{n+1}_i - u^n_i)/Dt + (f(u^n_i) - f(u^n_i_{i-1})/Dx = 0
	% Now we note that f = u^2/2, which gives us
	% (u^{n+1}_i - u^n_i)/Dt + 1/2((u^n_i)^2 - (u^n_i_{i-1})^2)/Dx = 0
	% This is the closest I get, I'm uncertain of how you want me to discretize
	% I studied the Lax-Wendroff method, as well as the upwind method.
	% I just can't find a way other than letting the generic function be
	% discretized. I've spent several hours reading the book, but there's nothing
	% on the upwind method regarding non-linear terms...
	% u^{n+1}_i = u^n_i - Dt/Dx/2((u^n_i)^2 - (u^n_i_{i-1})^2)
	% I can't seem to use a matrix on these due to the non-linear terms
	% Here's my attempt:
	% 2.2, x < -0.5
	% 0.2, x > -0.5
	jmax = 21;
	% u \Delta t / \Delta x <= Cmax = 1
	% This gives us a range for Delta t
	% We know that u_max = 2.2, \Delta x = 2/21 =>
	u_max = 2.2; length = 2; dx = length/jmax;
	dt = dx/u_max;
	dt = str2num(input(['Enter dt below ', num2str(dt), ', ideally a multiple of 0.25: '], 's'));
	m = dt/dx/2;
	% Plot for t = {0, 0.25, 0.5}
	speeds = linspace(-1, 1, jmax);
	domain = speeds;
	speeds(speeds >= -0.5) = 0.2;
	speeds(speeds < -0.5) = 2.2;
	u = speeds; v = u; t = 0;
	while true
		plot(domain, v);
		title(['t=', num2str(t)]);
		axis([-1, 1, 0, 3]);
		disp('Press enter to continue');
		u = v; pause;
		t = t + dt;
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

	% What I've chosen to do here is to propagate
	t = 0;
	while true
		plot(domain, v);
		title(['t=', num2str(t)]);
		axis([-1, 1, 0, 1]);
		disp('Press enter to continue');
		u = v; pause;
		t = t + dt;
		for i = 2:numel(u)
			v(i) = u(i) - m*(u(i)^2 - u(i-1)^2);
		end
		% Here we compute the loopback:
		v(1) = u(numel(u)) - m*(u(numel(u))^2 - u(numel(u)-1)^2);
	end
end
