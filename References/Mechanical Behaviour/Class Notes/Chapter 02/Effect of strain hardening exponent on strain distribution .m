%To plot e_a with e_b with strain hardening only - By Kamal K.

f=0.99;     %Initial area ratio
range_e_b=[0:0.005:0.55];
N = [0.1; 0.15; 0.2; 0.25; 0.3; 0.35; 0.4; 0.5];

for i = 1:size(N)
    n = N(i);
    old_e_a=0;      %Initial strain - first guess for solution of equation
    Data_bn=[];     %For storing data before the neck is becoming unstable
    Data_an=[];     %For storing data after the neck is unstable
    
    %Solving for e_a

    for e_b=range_e_b        %i.e., for all values of range of srain of necked region
        myfun=@(e_a) e_a^n-f*e_b^n *exp(e_a-e_b);   %definition function for whose root is e_a
        e_a=fsolve(myfun,old_e_a);              % calling inbuilt solver / root finder function - fsolve
        if(old_e_a<=e_a)                        %if it is in region where equation is valid or not
            Data_bn=[Data_bn;e_b e_a];      
        else
            Data_an=[Data_an;e_b e_a];
        end
        old_e_a=e_a;                            %update the guess for next root with current root or strain value
    end

%Plotting the data
%delete(gca);
    h1=plot(Data_bn(:,1),Data_bn(:,2),'b-','LineWidth',2.0);    %plotting before necking data with blue colored thick line
    axis([min(range_e_b) max(range_e_b) min(range_e_b) max(range_e_b)])
    axis square
    axis_limits=axis;
    line([axis_limits(1) axis_limits(2)],[axis_limits(3) axis_limits(4)],'color','k','LineStyle','--','linewidth',2.0)
    xlabel('{\epsilon}_b','fontsize',15);
    ylabel('{\epsilon}_a','fontsize',15);
    title(['Strain Localization with Holloman Equation with f=',num2str(f),'; '],'fontsize',15)
    set(gca,'fontsize',15);

%Plotting the unstable neck region if it exists
    if(size(Data_an,1)~=0)
        set(gca,'Nextplot','add');
        h2=plot(Data_an(:,1),Data_an(:,2),'r--','LineWidth',2.0);  %plotting after unstable necking or beyond fracture data with red colored thick line
        legend([h1 h2],'Stable neck','Unstable neck','Location','NorthWest');
    else
        legend(h1,'Stable neck','Location','NorthWest')
    end
    hold on;
end
