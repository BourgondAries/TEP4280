clc;clear all;

if 1 % 2a and 2b
	disp('2a and 2b');
	a=0;b=input('t_{end}: ');range=[a b];init=[1 0 0];
	[t45,y45]=ode45(@ex3_2system,range,init);
	[t23,y23]=ode23s(@ex3_2system,range,init);
	[t15,y15]=ode15s(@ex3_2system,range,init);

	hold on;
	subplot(2,3,1);
	plot(t45,y45);
	legend('A','B','C');
	title('ode45');
	subplot(2,3,4);
	plot(t45,sum(y45,2));
	title('ode45 mass');
	subplot(2,3,2);
	plot(t23,y23);
	title('ode23');
	subplot(2,3,5);
	plot(t23,sum(y23,2));
	title('ode23 mass');
	subplot(2,3,3);
	plot(t15,y15);
	title('ode15');
	subplot(2,3,6);
	plot(t15,sum(y15,2));
	title('ode15 mass');
end

input('Press enter to continue to 2c');

if 1 % 2c

	disp('ode15 was used because the matlab manual states that it is good for stiff systems');
	a=1;b=1e11;range=[a b];init=[1 0 0];
	[t15,y15]=ode15s(@ex3_2system, range, init);
	for i=0:2
		subplot(1,4,1+i);
		semilogx(t15,y15(:,1+i));
		title(char('A'+i));
	end
	subplot(1,4,4);
	plot(t15,sum(y15,2));
	title('Mass');
end
