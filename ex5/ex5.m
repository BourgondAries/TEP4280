clc; clear all; hold on;
amp{1} = {@(kdx, r) 1 - 4*r*sin(kdx/2)^2; 'FTCS'};
amp{2} = {@(kdx, r) 1 / (1 + 4*r*sin(kdx/2)^2); 'Implicit'};
amp{3} = {@(kdx, r) exp(-r*kdx^2); 'Exact'};

legend_data = {};
counter = 1;
for r=[1/6 1/2]
	for f=1:3
		func = @(kdx) amp{f}{1}(kdx, r);
		name = amp{f}{2};
		legend_data{counter} = [name '@r=' num2str(r)];
		counter = counter + 1;
		fplot(func, [0, pi]);
	end
end
legend(legend_data);
