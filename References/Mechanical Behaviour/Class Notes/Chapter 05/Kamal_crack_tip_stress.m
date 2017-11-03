sigma=100;%in MPa
a=5;%in mm

K1=sigma*sqrt(pi*a);

r=[0.01,0.01:0.01:0.2]*a; % range of r
th=(0:1:360)*pi/180; % range of theta
[TH,R]=meshgrid(th,r);
[X,Y]=pol2cart(TH,R);

%Plotting stress_y
sigma_y=(K1./sqrt(2*pi*R)) .* cos(TH/2) .* (1+sin(TH/2).*sin(3*TH/2) );
sigma_x=(K1./sqrt(2*pi*R)) .* cos(TH/2) .* (1-sin(TH/3).*sin(3*TH/2) );
tau_xy =(K1./sqrt(2*pi*R)) .* sin(TH/2) .* cos(3*TH/2) ;

c_stress={sigma_x,sigma_y,tau_xy};
p_title={'$\sigma_x$','$\sigma_y$','$\tau_{xy}$'}
for i=1:3
    figure(i);
    h=surf(X,Y,c_stress{i});
    set(h,'edgecolor','none','facecolor','interp');
    axis square
    l_axis=axis;
    line([-2*a 0],[0 0],'linewidth',2,'color','k')
    axis(l_axis)
    view(2)
    colorbar
    title({['Contour plot of ',p_title{i}],['a=',num2str(a),'mm; $\sigma=$',num2str(sigma),'MPa;']},'fontsize',15,'interpreter','latex')
    xlabel('x1 (in mm)','fontsize',15)
    ylabel('x2 (in mm)','fontsize',15)
end