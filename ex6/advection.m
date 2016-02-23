clc; clear all;
vec = linspace(0, 1);
xval = vec
vec = vec * 0;
vec(50:60) = 1;
plot(xval, vec);
hold on;
vec = vec * 0;
vec(40:50) = 1;
plot(xval, vec);

axis([0, 1, 0, 1.5]);
