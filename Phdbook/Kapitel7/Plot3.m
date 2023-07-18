clear all
close all

res1=dym_loadResult('Nachbau.mat');
t1=dym_getResult(res1,'Time');
v1=dym_getResult(res1,'Load_6.epp.v');
q1=dym_getResult(res1,'pQBoundary_6.epp.Q');
q2=dym_getResult(res1,'Load_6.epp.Q');



figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Arial'); 
hold on;
plot(t1(1:end-1),v1(1:end-1)/1000,'b');
% xlim([190,300]);
ylabel('Sapnnung an Knoten 6 in kV','FontSize',20);
xlabel('Zeit in s','FontSize',20);
set(gca,'Fontsize',14);
grid on;
% legend({'Scenario 1','Scenario 2'},'FontSize',12,'Location','northeast');
hold off;

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Arial'); 
hold on;
plot(t1(1:end-1),(q1(1:end-1)+q2(1:end-1))/1e6,'r');
% plot(t1,v2,'r');
% xlim([190,300]);
ylabel('Blindleistung an Knoten 6 in MVAr','FontSize',20);
xlabel('Zeit in s','FontSize',20);
set(gca,'Fontsize',14);
grid on;
% legend({'Scenario 1','Scenario 2'},'FontSize',12,'Location','northeast');
hold off;
