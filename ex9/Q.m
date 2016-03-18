function value = Q(a, r0, r1)
	delta = max(2*(r0 - r1), 2*eps);
	if abs(a) > delta
		value = abs(a);
	else
		value = (abs(a)^2 + delta^2) / 2 / delta;
	end
end
