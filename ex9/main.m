query = @(str) input([str, ': '], 's') == 'y';
if query('Run 1b')
	f = @(t, x) (1-heaviside(x+0.2*t)) * 0.2 + heaviside(x+0.2*t)
	drawing(f);
end
if query('Run 1c')
	u_l = -1; l_h = 1;
	u_r = 0.6; r_h = 0.2;
	f = @(t,x) l_h*(1-heaviside(x-u_l*t)) + ...
		r_h*heaviside(x-u_r*t) + ...
		(l_h + (x-u_l*t) * (r_h - l_h)/(-(x-u_r*t)+(x-u_l*t))) * ...
		heaviside(x-u_l*t)*(1-heaviside(x-u_r*t));
	drawing(f);
end
if query('Run 2d')
	jmax = 51; left = -30; right = 30; len = right - left;
	dx = len/jmax; dt = dx; mesh = linspace(left, right, jmax);
	meshvals = mesh * 0; meshvals(mesh < 0) = 0.2;
	meshvals(mesh >= 0) = 1; nextmesh = meshvals;

	F = @(r) r*(1-r); a = @charspeed;
	% I know, expensive, but it's simple and straightforward
	flux = @(r0, r1) 1/2*(F(r0) + F(r1) - abs(a(r0, r1)) * (r1 - r0));
	t_end = str2num(input('Enter ending time: ', 's'));
	m = meshvals;
	nextmesh = m;
	for i = 0:dt:t_end
		plot(mesh, m);
		axis([left, right, 0, 1.5]);
		title(['Time=', num2str(i)]);
		drawnow;
		for j = 2:numel(m)-1
			nextmesh(j) = m(j) - dt/dx * (flux(m(j), m(j+1)) - flux(m(j-1), m(j)));
		end
		nextmesh(end) = nextmesh(end - 1);
		nextmesh(1) = nextmesh(2);
		m = nextmesh;
		pause(0.1);
	end
end
if query('Run 2e')
	jmax = 51; left = -30; right = 30; len = right - left;
	dx = len/jmax; dt = dx; mesh = linspace(left, right, jmax);
	meshvals = mesh * 0; meshvals(mesh < 0) = 1;
	meshvals(mesh >= 0) = 0.2; nextmesh = meshvals;

	F = @(r) r*(1-r); a = @charspeed;
	flux = @(r0, r1) 1/2*(F(r0) + F(r1) - abs(a(r0, r1)) * (r1 - r0));
	t_end = str2num(input('Enter ending time: ', 's'));
	m = meshvals;
	nextmesh = m;
	for i = 0:dt:t_end
		plot(mesh, m);
		axis([left, right, 0, 1.5]);
		title(['Time=', num2str(i)]);
		drawnow;
		for j = 2:numel(m)-1
			nextmesh(j) = m(j) - dt/dx * (flux(m(j), m(j+1)) - flux(m(j-1), m(j)));
		end
		nextmesh(end) = nextmesh(end - 1);
		nextmesh(1) = nextmesh(2);
		m = nextmesh;
		pause(0.1);
	end
end
if query('Run 2f')
	jmax = 51; left = -30; right = 30; len = right - left;
	dx = len/jmax; dt = dx; mesh = linspace(left, right, jmax);
	meshvals = mesh * 0; meshvals(mesh < 0) = 1;
	meshvals(mesh >= 0) = 0.2; nextmesh = meshvals;

	F = @(r) r*(1-r); a = @charspeed;
	flux = @(r0, r1) 1/2*(F(r0) + F(r1) - Q(a(r0, r1), r0, r1) * (r1 - r0));
	t_end = str2num(input('Enter ending time: ', 's'));
	m = meshvals;
	nextmesh = m;
	for i = 0:dt:t_end
		plot(mesh, m);
		axis([left, right, 0, 1.5]);
		title(['Time=', num2str(i)]);
		drawnow;
		for j = 2:numel(m)-1
			nextmesh(j) = m(j) - dt/dx * (flux(m(j), m(j+1)) - flux(m(j-1), m(j)));
		end
		nextmesh(end) = nextmesh(end - 1);
		nextmesh(1) = nextmesh(2);
		m = nextmesh;
		pause(0.1);
	end
end
if query('Run 2g')
	jmax = 51; left = -30; right = 30; len = right - left;
	dx = len/jmax; dt = dx; mesh = linspace(left, right, jmax);
	meshvals = arrayfun(@(x) 0.2 + 0.8 * exp(-(x/10)^2), mesh)

	F = @(r) r*(1-r); a = @charspeed;
	flux = @(r0, r1) 1/2*(F(r0) + F(r1) - Q(a(r0, r1), r0, r1) * (r1 - r0));

	t_end = str2num(input('Enter ending time: ', 's'));
	m = meshvals;
	nextmesh = m;
	for i = 0:dt:t_end
		plot(mesh, m);
		axis([left, right, 0, 1.5]);
		title(['Time=', num2str(i)]);
		drawnow;

		nextmesh(1) = m(1) - dt/dx * (flux(m(1), m(2)) - flux(m(end), m(1)));
		for j = 2:numel(m)-1
			nextmesh(j) = m(j) - dt/dx * (flux(m(j), m(j+1)) - flux(m(j-1), m(j)));
		end
		nextmesh(end) = m(end) - dt/dx * (flux(m(end), m(1)) - flux(m(end-1), m(end)));

		m = nextmesh;
		pause(0.1);
	end
end
