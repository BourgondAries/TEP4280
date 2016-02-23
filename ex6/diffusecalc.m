f = @(x) exp(-40*(x-0.5)^2)/2;
fplot(f, [0, 1]);
axis([0, 1, 0, 1.5]);

hold on;
vec = linspace(0, 1);
xval = vec;
vec = vec * 0;
vec(46:55) = 1;
plot(xval, vec);
