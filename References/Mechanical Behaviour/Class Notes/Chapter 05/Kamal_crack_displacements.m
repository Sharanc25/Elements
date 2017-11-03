%Plane strain and Plane stress condition

sigma=100;%in MPa
a=5;%in mm
E=200e3;%in MPa
nu=1/3;%Poisson ratio

r=[0:0.01:0.2]*a; % range of r
th=(0:1:360)*pi/180; % range of theta
[TH,R]=meshgrid(th,r);
[X,Y]=pol2cart(TH,R);

%Displacements in plane stress condition
u_pe = ( 2*(1+nu)*K1/(E*sqrt(2*pi)) ) * sqrt(R) .* cos(TH/2) .* (1-2*nu+sin(TH/2).^2);
v_pe = ( 2*(1+nu)*K1/(E*sqrt(2*pi)) ) * sqrt(R) .* sin(TH/2) .* (2-2*nu-cos(TH/2).^2);
u_ps =  ( (1+nu)*K1*sqrt(2/pi)/E )    * sqrt(R) .* cos(TH/2) .* ( (1-nu)/(1+nu) + sin(TH/2).^2 );
v_ps =  ( (1+nu)*K1*sqrt(2/pi)/E )    * sqrt(R) .* sin(TH/2) .* ( 2/(1+nu) - cos(TH/2).^2);

dp={u_pe,v_pe,u_ps,v_ps};
p_title={'u (plane strain)','v (plane strain)','u (plane stress)','v (plane stress)'};
for i=1:4
    figure(i);
    h=surf(X,Y,dp{i});
    set(h,'edgecolor','none','facecolor','interp');
    axis square
    %For getting a good plot
    l_axis=axis;
    axis([l_axis(1:4) min(min(dp{i}))-0.0001 max(max(dp{i}))+0.0001])  ;
    view(2)
    %%%
    colorbar
    title({['Contour plot of ',p_title{i}],['a=',num2str(a),'mm; $\sigma=$',num2str(sigma),'MPa;']},'fontsize',15,'interpreter','latex')
    xlabel('x1 (in mm)','fontsize',15)
    ylabel('x2 (in mm)','fontsize',15)
end
