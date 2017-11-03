 %With both strain sensitivity and strain-exponent
 
 % x - e_b
 % y - e_a
 
 %Initial Conditions
f=0.95; n=0.1;
min_e_b=0.001;% minimum value of e_b
max_e_b=0.5 ;% maximum value of e_b

M = [0.05; 0.1; 0.2; 0.3; 0.4; 0.5; 1];

for i = 1:size(M)
    m = M(i);
%Solving for e_a
    f_xy=@(x,y) f^(1/m) * exp((y-x)/m) * (x/y)^(n/m);
    [e_b e_a]=ode23(f_xy,[min_e_b max_e_b],min_e_b);

%Plotting the graph
    plot([0 ; e_b],[ 0 ; e_a],'b-','LineWidth',2.0)
    axis([min_e_b max_e_b min_e_b max_e_b]);
    axis square
    axis_limits=axis;
    line([axis_limits(1) axis_limits(2)],[axis_limits(3) axis_limits(4)],'color','k','LineStyle','--','linewidth',2.0)
    xlabel('${\epsilon}_b$','fontsize',15,'interpreter','latex');
    ylabel('${\epsilon}_a$','fontsize',15,'interpreter','latex');
    title(['n=',num2str(n),'; f=',num2str(f),'; '],'fontsize',15)
    set(gca,'fontsize',15); 
    hold on; 
end