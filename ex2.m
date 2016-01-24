clc; clear all;
% Set up various variables and functions
r=1;
d=0.1*r;
du=@(x,y)-(x-(-r))/((x-(-r))^2+y^2+d^2)^(3/2)-(x-r)/((x-r)^2+y^2+d^2)^(3/2);
dv=@(x,y)-y/((x-(-r))^2+y^2+d^2)^(3/2)-y/((x-r)^2+y^2+d^2)^(3/2);
epot=@(x,y)-1./((x-(-r)).^2+y.^2+d.^2).^(1/2)-1./((x-r).^2+y.^2+d.^2).^(1/2);
ekin=@(u,v)(u.^2+v.^2)./2;
x=2.0;y=0.1;u=0;v=0;tmax=100;h=1e-3;
fprintf('Start total energy: %d\n', epot(x,y)+ekin(u,v));

% a i)
mat=[];
% Each iteration uses Euler's Method to find the next speed value
% The speed value is then multiplied by its time-increment to get the distance
for i=1:tmax/h
	u=u+h*du(x,y);
	v=v+h*dv(x,y);
	x=x+h*u;
	y=y+h*v;
	mat=[mat [x;y;u;v]];
end
fprintf('Euler''s total energy: %d\n', epot(x,y)+ekin(u,v));

% a ii)
matheun=[];
x=2.0;yv=0.1;u=0;v=0;
y=zeros(4,1);
y(1)=x;y(2)=yv;y(3)=u;y(4)=v;
f=@ex2diff;
for i=1:tmax/h
	y_pred=y+h.*f(h,y);
	y=y+h/2.*(f(h,y)+f(h,y_pred));
	matheun=[matheun [y(1);y(2);y(3);y(4)]];
end
hold on;
fprintf('Heun''s total energy: %d\n', epot(y(1),y(2))+ekin(y(3),y(4)));

% a iii)
options=odeset('RelTol',1e-4,'AbsTol',[1e-4 1e-4 1e-5 1e-5]);
[t,y]=ode45(f,[0 tmax],[2 .1 0 0],options);
fprintf('ode45''s total energy: %d\n', epot(y(end,1),y(end,2))+ekin(y(end,3),y(end,4)));

% b) Note the culling of nodes
if true
	for i=1:4 mat(:,2:2:end)=[]; end
	plot(mat(1,:),mat(2,:),'g*');
	for i=1:5 matheun(:,2:2:end)=[]; end
	plot(matheun(1,:),matheun(2,:),'bo');
	y(2:2:end,:)=[];
	plot(y(:,1),y(:,2),'r--');
	xlabel('x position');
	ylabel('y position');
else
	plot(1:tmax/h,epot(mat(1,:),mat(2,:))+ekin(mat(3,:),mat(4,:)),'g*');
	plot(1:tmax/h,epot(matheun(1,:),matheun(2,:))+ekin(matheun(3,:),matheun(4,:)),'bo');
	plot(t/h,epot(y(:,1),y(:,2))+ekin(y(:,3),y(:,4)),'r--');
	xlabel('time*h');
	ylabel('energy');
end
legend('Euler','Heun','ode45');

% c) See report
% d) Embedded, see report.
% e) -
% f)
if true
	[t,y]=ode45(f,[0 tmax],[2 .10001 0 0],options);
	fprintf('ode45''s total energy, f: %d\n', epot(y(end,1),y(end,2))+ekin(y(end,3),y(end,4)));
	hold on;
	y(2:2:end,:)=[]; plot(y(:,1),y(:,2),'cO');
	legend('Euler','Heun','ode45','ode45,2');
end
