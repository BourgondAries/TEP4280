function c2draw(initial, matrix, endtime, dt, steps)
	h = animatedline;
	ylabel('Temperature');
	xlabel('Position');
	for i = 1:steps
		initial = matrix * initial;

		plot(linspace(0, endtime, numel(initial)), fliplr(transpose(initial)));
		title(['Time: ', num2str(i*dt)]);
		drawnow;
		pause(0.025);
	end
end
