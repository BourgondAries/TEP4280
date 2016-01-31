clc;clear all;

% The original, analytic solution to the problem. Used for comparison.
original = @(t)1+t+9*exp(-100*t);

if input('Backwards Euler? (y/n): ', 's') == 'y' % 1d) Backwards Euler Method
	h=input('Step size: ');
	y(1)=10;i=1;to=input('T_{end}: ');
	y_next=@(t,y)(y+101*h*t+100*h)/(1+100*h);
	for t=0:h:to;
		y(i+1)=y_next(t,y(i));
		i=i+1;
	end
	plot(0:h:to,y(1:end-1));
	hold on;
	fplot(original,[0 to],'r+');
	legend('Approximation','Analytic');
	hold off;
	% 1e) Compare with the exact computation
	diff=abs(y(end-1)-original(to));
	fprintf('The computed error at the T_{end}: %f\n', diff);
end

if input('Explicit Euler? (y/n): ', 's') == 'y' % 1d) Explicit Euler Method
	h=input('Step size: ');
	y(1)=10;i=1;to=input('T_{end}: ');
	y_next=@(t,y)y+h*(101*t-100*y+1001);
	for t=0:h:to;
		y(i+1)=y_next(t,y(i));
		i=i+1;
	end
	plot(0:h:to,y(1:end-1));
	hold on;
	fplot(original,[0 to],'r+');
	legend('Approximation','Analytic');
	hold off;
	% 1e) Compare with the exact computation
	diff=abs(y(end-1)-original(to));
	fprintf('The computed error at the T_{end}: %f\n', diff);
end

% Trapezoid Method
if input('Trapezoid Method? (y/n): ', 's') == 'y'
	h=input('Step size: ');
	y(1)=10;i=1;to=input('T_{end}: ');
	y_next=@(t,y)(y+h/2*(-100*y+101*t+1001+101*(t+h)+1001))/(1+50*h);
	for t=1:h:to;
		y(i+1)=y_next(t,y(i));
		i=i+1;
	end
	plot(0:h:to,y(1:end-1));
	hold on;
	fplot(original,[0 to],'r+');
	hold off;
	% 1e) Compare with the exact computation
	diff=abs(y(end-1)-original(to));
	fprintf('The computed error at the T_{end}: %f\n', diff);
end
