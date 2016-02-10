% Solving the 1D diffusion equation: Start-up of Couette flow
% using Forward-Time-Central-Space (FTCS) scheme,
% and comparing with analytical solutions.

% The equation is non-dimensional.
clear all; close all; clc;

response = input('Grid refinement study on cells, time, none, or instability? (c/t/n/i): ', 's');
skipdraw = input('Skip drawing intermediates? (y/n): ', 's') == 'y';
% The speed values captured from u
values = [];
range_start = 0;
range_end = 7;

refinement_grid = response == 'c';
refinement_time = response == 't';
refinement_none = ~refinement_grid && ~refinement_time;
instability = response == 'i';

if refinement_grid
	range_start = 1;
	range_end = 8;
elseif refinement_time
	range_start = 0;
	range_end = 7;
else
	range_start = 0;
	range_end = 0;
end

for m=range_start:range_end
	% Number of grid points and cell size

	if refinement_grid
		jmax = 2^m + 1;
	elseif refinement_time
		jmax = 33;
	else
		jmax = 21;
	end
	dy=1/(jmax-1);

	% Initialize velocity array and set right B.C.
	u=zeros(jmax,1);
	u(jmax)=1;
	nu=u;

	% y-array for computation of exact solution
	y=linspace(0,1,jmax);

	% Time step and end of simulation
	% c)
	if instability
		dt = 0.00130;  % Instability 1/2/20^2 = 0.0013 <= dt
	elseif refinement_time
		dtmax = 1/2*dy^2;
		dt = 2^(-m)*dtmax;
	elseif refinement_grid
		dt = 7e-6;
	else
		dt = 0.00125;
	end
	tstop=1;
	nmax=ceil(tstop/dt);

	% Scale dt stop at tstop
	dt=tstop/nmax;
	% Stable for r <= 0.5
	if refinement_time
		r = 1/2;
	else
		r = dt/dy^2;
	end
	for n=2:nmax
			for j=2:jmax-1
					nu(j)=u(j)*(1-2*r)+(u(j+1)+u(j-1))*r;
			end
			u=nu;

			t=dt*n;
			U=zeros(1,jmax);
			for i=1:15
					U=U+sin(i*pi*(1-y))*exp(-(i*pi)^2*t)/i;
			end
			U=y-2*U/pi;

			t=0.5/sqrt(t);
			U2=zeros(1,jmax);
			for i=0:5
					U2=U2+erfc((2*i+1-y)*t)-erfc((2*i+1+y)*t);
			end

			if skipdraw == false
				plot(u,y,U,y,'ro',U2,y,'g+')
				drawnow;
			end

			% pause         % Use this if you want stepwise simulation
	end

	values = [values; middle(u)];
	fprintf('At y=1/2, t=tstop: %d\n', middle(u));

	if skipdraw == false
		hold on
		xlabel('u(y)')
		ylabel('y')
		% plot the steady state solution
		plot(y,y,'r-.')
		legend('FTCS','Analytical (2)','Analytical (3)','Steady state','Location','best')
		hold off
	end
end

if refinement_grid || refinement_time
	input('Press any key to compute the relative error', 's');
	% Calculate the relative error, and plot it
	realval = 1/2;
	rerror = [];
	cells = [];

	addone = 0;
	if range_start == 0
		addone = 1;
	end
	for i=range_start:range_end
		rerror = [rerror abs(1-values(i+addone,1)/realval)];
		if refinement_time
			cells = [cells ceil(tstop/2^(-i))];
		elseif refinement_grid
			cells = [cells 2^i + 1];
		end
	end
	loglog(cells, rerror);
	xlabel('Grid Cells');
	ylabel('Relative Error');
end
