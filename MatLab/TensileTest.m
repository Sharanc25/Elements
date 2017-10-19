filename = 'D:\PhD\Thesis\Tensile Test\Ti6242-1.4-TS.xlsx';
extension = xlsread(filename,'C:C');
load = xlsread(filename,'D:D');
d0 = 4; % Diamter (in mm) of the tensile specimen
L0 = 20; % Gauge length (in mm) of the tensile specimen
%%
% The file which data is initialized.
A0=pi*(d0/2)^2;
stress=F_deltaL(:,1)*1000/A0;
% units: kN*1000/mm^2 -> MPa 
strain=F_deltaL(:,2)/L0;  
figure(1); 
plot(strain,stress,'LineWidth',2); 
grid  on;
xl=xlabel('strain, \epsilon (%)');
yl=ylabel('stress, \sigma (MPa)');
ti=title('Stress-Strain Curve');
set(xl,'fontsize',14,'fontweight','bold');
set(yl,'fontsize',14,'fontweight','bold') 
set(ti,'fontsize',14,'fontweight','bold') axis([0 0.25 0 650]) %  Axis  limits figure(3) 
plot(strain,stress,'LineWidth',2)
grid on
xl=xlabel('strain, \epsilon (%)'); yl=ylabel('stress, \sigma (MPa)');
ti=title('Stress-Strain Curve');
set(xl,'fontsize',14,'fontweight','bold');
set(yl,'fontsize',14,'fontweight','bold'); 
set(ti,'fontsize',14,'fontweight','bold') axis([0 0.1 0  650]) %  Axis  limits
hold on;
plot(0.002,0,'d','MarkerFaceColor','b');
plot(0.022,177,'d','MarkerFaceColor','b');
X=linspace(0,0.08,100);
E=8850;
Y=X*E;
plot((X+0.002),Y,'r');
plot(0.064,550.7,'o','MarkerFaceColor','b')
