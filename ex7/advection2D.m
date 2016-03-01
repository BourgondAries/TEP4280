clear all
close all
clc

jmax=33;        % Grid points in each direction
h=1/(jmax-1);   % Grid spacing

F=zeros(jmax);  % Initialize solutions matrix
                % Note: Bottom boundary condition set equal to zero in
                % initialization
F(1,2:jmax)=1;  % Left boundary condition
F2=F;           % Initialize solutions matrix for central differencing method

for i=2:jmax
    for j=2:jmax
        F(i,j)=(F(i-1,j)+F(i,j-1))/2;
    end
end

% Plotting domain
x = linspace(0,1,jmax);
y = linspace(0,1,jmax);
% Set values for contours
v=.1:.1:.9;

% Plot results
contour(x,y,F',v)
axis square
xlabel('x')
ylabel('y')
colorbar
title('Upwind method')

for i=2:jmax-1
    for j=2:jmax-1
        F2(i,j+1)=-F2(i+1,j)+F2(i-1,j)+F2(i,j-1);
    end
end
figure(2)

% Plot results using the same plotting domain as for upwind method
contour(x,y,F2',v)
axis square
xlabel('x')
ylabel('y')
colorbar
title('Central difference method')


