function dy=ex2diff(t,y)
	r=1;
	d=0.1*r;
	du=@(x,y)-(x-(-r))/((x-(-r))^2+y^2+d^2)^(3/2)-(x-r)/((x-r)^2+y^2+d^2)^(3/2);
	dv=@(x,y)-y/((x-(-r))^2+y^2+d^2)^(3/2)-y/((x-r)^2+y^2+d^2)^(3/2);
	dy=zeros(4,1);
	dy(1)=y(3);
	dy(2)=y(4);
	dy(3)=du(y(1),y(2));
	dy(4)=dv(y(1),y(2));
end
