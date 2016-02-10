function u = ex4a2(y, t)
	u = 0.0;
	for n=0:100
		u = u + erfc((2*n+1-y)/(2*sqrt(t))) - erfc((2*n+1+y)/(2*sqrt(t)));
	end
end

