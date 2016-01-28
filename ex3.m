clc; clear all;

yz = @(t) 1+t+9*exp(-100*t);
if 1 % 1d) Backwards Euler
	h = 1/100;
	f = @(t, y) (y+101*h*t+100*h)/(1+100*h);
	y(1) = 10;
	i=1;
	to=2;
	for t=0:h:to;
		y(i+1) = f(t, y(i));
		i = i+1;
	end
	plot(0:h:to, y(1:end-1));
	hold on;
	fplot(yz, [0 to], 'r+');
end

% Explicit Euler Method
if 0
	h = 1.0/500.0;
	g = @(t,y)y+h*(101*t-100*y+1001);
	y(1) = 10;
	i = 1;
	to=200;
	for t=0:h:to;
		y(i+1) = g(t, y(i));
		i = i+1;
	end
	plot(0+1000*h:h:to, y(1+1000:end-1));
	hold on;
	fplot(yz, [199 to], 'r+');
end

if 0
	h = 100000;
	f = @(t,y)(y+h/2*(-100*y+101*t+1001+101*(t+h)+1001))/(1+50*h);
	y(1) = 10;
	i = 1;
	to=20000000;
	for t=0:h:to;
		y(i+1) = f(t, y(i));
		i = i+1;
	end
	plot(0:h:to, y(1:end-1));
	hold on;
	fplot(yz, [0 to], 'r+');
end
