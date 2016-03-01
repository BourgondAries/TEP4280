% Function declaration of initial condiiton for task 2e)
uex = @(x) -sin(4*pi*mod(x,1)).*(mod(x,1)>=1/4).*(mod(x,1)<=3/4);

% Plot initial condition to check that it is correct
jmax = 41;
x = linspace(0,1,jmax);
plot(x,uex(x))
title('Initial condition')
xlabel('x')
ylabel('p_0(x)')
