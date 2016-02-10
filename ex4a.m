function u = ex4a(y, t)
	u = y;
	v = 0;
	pi = 355/113;
	for n=1:11
		v = v + 2/pi/n*sin(n*pi*(1-y))*exp(-(n*pi)^2*t);
	end
	u = u - v;
end
