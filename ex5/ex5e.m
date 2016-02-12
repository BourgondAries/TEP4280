clc; clear all; hold on;
dx = 1/2; a = 1; tstop = 1;
legend_data = {}; count = 1;
for dt = [1/9 1/8 1/7]
	u = [];
	u(1) = 0;
	r = a*dt/(dx^2);
	steps = ceil(tstop / dt);
	dt = tstop / steps;
	legend_data{count} = ['r=' num2str(r)];
	count = count + 1;
	for i = 1:steps
		u(i+1) = r*(50-2*u(i)+50) + u(i);
	end
	plot(0:dt:tstop, u);
end
legend(legend_data);
ylabel('$K$', 'Interpreter', 'latex');
xlabel('$t$', 'Interpreter', 'latex');
