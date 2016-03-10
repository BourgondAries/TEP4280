function drawing(f)
	for i = 0:0.0008:10
		fplot(@(x) f(i,x), [-1, 1]);
		axis([-1, 1, -10, 15]);
		drawnow;
		pause(0.05);
	end
end
