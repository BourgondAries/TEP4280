function c2draw(initial, matrix, endtime, dt, steps)
	h = animatedline;
	for i = 1:steps
		initial = matrix * initial;

		plot(linspace(0, 1, numel(initial)), fliplr(transpose(initial)));
		title(['Time: ', num2str(i*dt)]);
		ylabel('Temperature');
		xlabel('Position');
		drawnow;
		pause(0.025);
	end
end
