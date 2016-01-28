function dy = ex3_2system(t,y)
	% Definitions
	k1 = 4e-2;
	k2 = 3e7;
	k3 = 1e4;
	dy = zeros(3, 1);
	dy(1) = -k1*y(1)+k3*y(2)*y(3);
	dy(2) = k1*y(1)-k2*y(2)^2-k3*y(2)*y(3);
	dy(3) = k2*y(2)^2;
end
