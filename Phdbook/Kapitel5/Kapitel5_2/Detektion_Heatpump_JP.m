clear all;
close all;

res1=dym_loadResult('IES_Coupled_HeatpumpCharline_lfail_Real.mat');

t_start=-4;

%Erstes Kriterium: Knotenspannung

t=dym_getResult(res1,'Time');
t_stund= (t-2225000)/3600;
va=dym_getResult(res1,'La_load.epp.v');

Dekt1=zeros(length(va),1);

for zeitzaehl=1:length(va)
   if va(zeitzaehl)<110000*0.9 || va(zeitzaehl)>110000*1.1
       Dekt1(zeitzaehl)=1;
   end
end

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,va/1000)
plot(t_stund,110*0.9*ones(length(t_stund),1),'r--');
plot(t_stund,110*1.1*ones(length(t_stund),1),'r--');
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_stund,Dekt1);
ylim([-0.1,1.1]);
xlim([t_start,9]);
ylabel('Kriterium Spannungsbetrag','FontSize',20);
%yticks('auto','color',[0.85 0.33 0.1]);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
legend({'Spannung an Knoten A','Toleranzband'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Zweites Kriterium: Spannungsgradient

vagrad=gradient(va);

envelopelength=10;

[~,vagradlower]=envelope(vagrad,envelopelength,'peak');

Dekt2=zeros(length(vagradlower),1);

meanlength=200;

for zeitzaehl=meanlength+1:length(vagradlower)-1
   if mean(vagradlower(zeitzaehl-meanlength:zeitzaehl)) > vagradlower(zeitzaehl+1)
       Dekt2(zeitzaehl+1)=1;
   end
end




figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,va/1000)
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_stund,Dekt2);
ylim([-0.1,1.1]);
xlim([t_start,9]);
ylabel('Kriterium Spannungsgradient','FontSize',20);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Drittes Kriterium: Letzte Trafostufung erreicht

tap=dym_getResult(res1,'OLTC_L_a.currentTap');

tapmax=11;

Dekt3=zeros(length(tap),1);

for zeitzaehl=1:length(tap)
   if tap(zeitzaehl)<=- tapmax || tap(zeitzaehl)>= tapmax
       Dekt3(zeitzaehl)=1;
   end
end

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,va/1000)
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_stund,Dekt3);
ylim([-0.1,1.1]);
xlim([t_start,9]);
ylabel('Kriterium Transformatorstufung','FontSize',20);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Viertes Kriterium: Außentemperatur

Temp=dym_getResult(res1,'La_heating.thermalHeatConsumer_CHP.T_amb');

Dekt4=zeros(length(Temp),1);

meanlength=20;

for zeitzaehl=meanlength+1:length(Temp)-1
   if mean(Temp(zeitzaehl-meanlength:zeitzaehl)) > Temp(zeitzaehl+1) 
       Dekt4(zeitzaehl+1)=1;
   end
end

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,Temp-273.15)
ylabel('Temperatur in ° C','FontSize',20);
yyaxis right
plot(t_stund,Dekt4);
ylim([-0.1,1.1]);
xlim([t_start,9]);
ylabel('Kriterium Außentemperatur','FontSize',20);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Fünftes Kriterium: Sektorenspezifisch: COP

COP=dym_getResult(res1,'La_heating.heatPumpElectricCharlineDG_real_testinertia.COP');
% COP_n=dym_getResult(res1,'La_heating.heatPumpElectricCharlineDG_real_testinertia.COP_n');

Dekt5=zeros(length(COP),1);

meanlength=20;

for zeitzaehl=meanlength+1:length(COP)-1
   if mean(COP(zeitzaehl-meanlength:zeitzaehl)) > COP(zeitzaehl+1) 
       Dekt5(zeitzaehl+1)=1;
   end
end

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,COP)
%plot(t_stund,1.1311*COP_n(end)*ones(length(t_stund),1),'r--')
ylabel('Leistungszahl','FontSize',20);
yyaxis right
plot(t_stund,Dekt5);
ylim([-0.1,1.1]);
xlim([t_start,9]);
ylabel('Kriterium Leistungszahl','FontSize',20);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Gesamtplot

Dekt_gesamt=Dekt1+Dekt2+Dekt3+Dekt4+Dekt5;

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_stund,Dekt_gesamt)
plot(t_stund,2*ones(length(t_stund),1),'y--')
plot(t_stund,3*ones(length(t_stund),1),'r--')
ylabel('Detektionszustand','FontSize',20);
% yyaxis right
% plot(t_stund,Dekt5);
ylim([-0.1,5.1]);
xlim([t_start,9]);
% ylabel('Kriterium Leistungszahl','FontSize',20);
xlabel('Zeit in h','FontSize',20);
set(gca,'Fontsize',14);
legend({'Detektionszustand','Schwelle Warnung','Schwelle Alarm'},'FontSize',11,'Location','southeast');
grid on;
box on;
hold off;
