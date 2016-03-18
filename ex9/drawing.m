function drawing(f)
	for i = 0:0.008:10
		fplot(@(x) f(i,x), [-1, 1]);
		axis([-1, 1, 0, 1.5]);
		drawnow;
		pause(0.19);
	end
end
