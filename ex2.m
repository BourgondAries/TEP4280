% Set up various variables and functions
r=1;
d=0.1*r;
du=@(x,y)-(x-(-r))/((x-(-r))^2+y^2+d^2)^(3/2)-(x-r)/((x-r)^2+y^2+d^2)^(3/2);
dv=@(x,y)-y/((x-(-r))^2+y^2+d^2)^(3/2)-y/((x-r)^2+y^2+d^2)^(3/2);

x=2.0;y=0.1;u=0;v=0;tmax=10;h=10^(-3);
mat=[];

% Each iteration uses Euler's Method to find the next speed value
% The speed value is then multiplied by its time-increment to get the distance
for i=1:tmax/h
	u=u+h*du(x,y);
	v=v+h*dv(x,y);

	x=x+h*u;
	y=y+h*v;
	mat=[mat [x;y]];
end
[x y]  % Print the final value of x and y at t=tmax
plot(mat(1,:),mat(2,:));

mat=[];
% We first need to find two estimates for u and v
for i=1:tmax/h
	u_approx=u+h*du(x,y);
	v_approx=u+h*dv(x,y);

	% Normally we'd throw u and v approx in heun's method, but this is infeasible
	% because du depends on x and y.
	x_approx=x+u_approx*h;
	y_approx=y+v_approx*h;

	u=u+h/2*(du(x,y)+du(x+x_approx,y+y_approx));
	v=v+h/2*(dv(x,y)+dv(x+x_approx,y+y_approx));
	% Do we need to use Heun's here as well?
	% It seems infeasible, because we'd need
	% x=x+h/2*(u(x,y)+u(x+dx,y+dy))
	% Where would the dx and dy come from?
	x=x+h*u;
	y=y+h*v;
	mat=[mat [x;y]];
end
[x y]
hold on;
plot(mat(2,:),mat(2,:));

ode45(@ode,[0 10],[2 .1 0 0]);


