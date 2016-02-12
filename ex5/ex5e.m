clc; clear all; hold on;
dx = 1/2; a = 1; tstop = 10;
legend_data = {}; count = 1;
for dt = [1/6 1/5 1/4]
	u = [];
	u(1) = 100;
	r = a*dt/dx^2;
	steps = ceil(tstop / dt);
	dt = tstop / steps;
	legend_data{count} = num2str(r);
	count = count + 1;
	for i = 1:steps
		u(i+1) = r*(0-2*u(i)+0) + u(i);
	end
	plot(0:dt:tstop, u);
end
legend(legend_data);
