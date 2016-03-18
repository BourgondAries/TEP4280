function value = charspeed(r0, r1)
	if r0 == r1
		value = 1 - 2*r0;
	else
		value = (r1*(1-r1) - r0*(1-r0)) / (r1 - r0);
	end
end
