clear all;
close all;

res1=dym_loadResult('IES_EBoiler_lfail_real.mat');

t_start=-4;

%Erstes Kriterium: Knotenspannung

t=dym_getResult(res1,'Time');
t_min= (t-2.4004e+6)/60;
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
plot(t_min,va/1000)
plot(t_min,110*0.9*ones(length(t_min),1),'r--');
plot(t_min,110*1.1*ones(length(t_min),1),'r--');
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_min,Dekt1);
ylim([-0.1,1.1]);
xlim([t_start,20]);
ylabel('Kriterium Spannungsbetrag','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
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
plot(t_min,va/1000)
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_min,Dekt2);
ylim([-0.1,1.1]);
xlim([t_start,20]);
ylabel('Kriterium Spannungsgradient','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
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
plot(t_min,va/1000)
ylabel('Spannung in kV','FontSize',20);
yyaxis right
plot(t_min,Dekt3);
ylim([-0.1,1.1]);
xlim([t_start,20]);
ylabel('Kriterium Transformatorstufung','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Viertes Kriterium: Außentemperatur

Temp=dym_getResult(res1,'La_heating.thermalHeatConsumer_L3_1.T_amb');

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
plot(t_min,Temp-273.15)
ylabel('Temperatur in ° C','FontSize',20);
yyaxis right
plot(t_min,Dekt4);
ylim([-0.1,1.1]);
xlim([t_start,20]);
ylabel('Kriterium Außentemperatur','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
set(gca,'Fontsize',14);
%legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Fünftes Kriterium: Sektorenspezifisch: Temperaturen iM Heizsystem

Temp_ref=dym_getResult(res1,'La_heating.heatingCurve_60_40.T_supply')-273.15;
Temp_ist=dym_getResult(res1,'La_heating.electricBoilerImpedance.temperatureSensor_hex_coolant_out.T')-273.15;

Temp_diff_normiert=(Temp_ref-Temp_ist)./(Temp_ref);

Dekt5=zeros(length(tap),1);

for zeitzaehl=1:length(Temp_diff_normiert)
   if Temp_diff_normiert(zeitzaehl)> 0.0025
       Dekt5(zeitzaehl)=1;
   end
end

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_min,Temp_ref);
plot(t_min,Temp_ist);
ylim([72,77]);
% plot(t_min,COP)
%plot(t_stund,1.1311*COP_n(end)*ones(length(t_stund),1),'r--')
ylabel('Temperatur','FontSize',20);
yyaxis right
plot(t_min,Dekt5);
ylim([-0.1,1.1]);
xlim([t_start,20]);
ylabel('Kriterium Elektrokessel-Temperaturen','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
set(gca,'Fontsize',14);
legend({'Referenztemperatur','Tatsächliche Vorlauftemperatur'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

%Gesamtplot

Dekt_gesamt=Dekt1+Dekt2+Dekt3+Dekt4+Dekt5;

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t_min,Dekt_gesamt)
plot(t_min,2*ones(length(t_min),1),'y--')
plot(t_min,3*ones(length(t_min),1),'r--')
ylabel('Detektionszustand','FontSize',20);
% yyaxis right
% plot(t_stund,Dekt5);
ylim([-0.1,5.1]);
xlim([t_start,20]);
% ylabel('Kriterium Leistungszahl','FontSize',20);
xlabel('Zeit in Minuten','FontSize',20);
set(gca,'Fontsize',14);
legend({'Detektionszustand','Schwelle Warnung','Schwelle Alarm'},'FontSize',11,'Location','southeast');
grid on;
box on;
hold off;
