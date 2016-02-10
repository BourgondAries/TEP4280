% Solving the 1D diffusion equation: Start-up of Couette flow
% using Forward-Time-Central-Space (FTCS) scheme,
% and comparing with analytical solutions.

% The equation is non-dimensional.
clear all
close all
clc

% Number of grid points and cell size
jmax=21;
dy=1/(jmax-1);

% Initialize velocity array and set right B.C.
u=zeros(jmax,1);
u(jmax)=1;
nu=u;

% y-array for computation of exact solution
y=linspace(0,1,jmax);

% Time step and end of simulation
dt=0.00125;
tstop=1;
nmax=ceil(tstop/dt);

% Scale dt stop at tstop
dt=tstop/nmax;
% Stable for r <= 0.5
r=dt/dy^2;
for n=1:nmax
    for j=2:jmax-1
        nu(j)=u(j)*(1-2*r)+(u(j+1)+u(j-1))*r;
    end
    u=nu;

    t=dt*n;
    U=zeros(1,jmax);
    for i=1:15
        U=U+sin(i*pi*(1-y))*exp(-(i*pi)^2*t)/i;
    end
    U=y-2*U/pi;

    t=0.5/sqrt(t);
    U2=zeros(1,jmax);
    for i=0:5
        U2=U2+erfc((2*i+1-y)*t)-erfc((2*i+1+y)*t);
    end
    plot(u,y,U,y,'ro',U2,y,'g+')
    drawnow;

    % pause         % Use this if you want stepwise simulation
end

hold on
xlabel('u(y)')
ylabel('y')
% plot the steady state solution
plot(y,y,'r-.')
legend('FTCS','Analytical (2)','Analytical (3)','Steady state','Location','best')
hold off
