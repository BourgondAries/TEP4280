clear all; close all; clc;

% Derivative and function
f = @(x) tan(x);
df = @(x) tan(x)^2+1;

% Values
h = logspace(-16, -1, 100);
x = 1;

% Use finite differences
d1 = (f(x+h)-f(x-h))./(2.*h);
r1 = abs(d1-df(x));
fprintf('difference one: %s\n', r1);

% Second order finite difference
d2 = (-f(x+2.*h)+8.*f(x+h)-8.*f(x-h)+f(x-2.*h))./(12.*h);
r2 = abs(d2-df(x));
fprintf('difference two: %s\n', r2);

% Second order using single precision (32 bit)
h2 = single(h);
x = single(x);
d3 = (-f(x+2.*h2)+8.*f(x+h2)-8.*f(x-h2)+f(x-2.*h2))./(12.*h2);
r3 = abs(d3-df(single(x)));
fprintf('difference three: %s\n', r3);

% Define slopes
H1 = [1e-01 1e-10];
H2 = [1e-01 1e-06];
H3 = [1e-15 1e-05];
E3 = [1e-02 1e-12];
% Plot curves
loglog(1,1,1, 1,1,1, H1,H1,'--', H2,H2.^2,'--', H3,E3,'--', h,r1,'--',...
	h,r2,'--', h,r3,'--');
legend ('Single, 2. order','Double, 2. order','Double, 1. order',...
'1. order','2. order',' -1. order','Location','Best');
% Use a TeX - interpreter to get a nicer title
title ('$$\mathrm{d}(\tan x)/\mathrm{d}x = \tan^2(x)+1$$',...
'Interpreter','latex ');
xlabel ('h');
ylabel ('err = |( df/dx_ {FD} - df/dx_ {An })/df/dx_ {An }| ');
grid on;
