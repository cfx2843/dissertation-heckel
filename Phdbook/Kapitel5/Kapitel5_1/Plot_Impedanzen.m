%% CLEAR ALL
clear all
close all

%% Data import
% pcpath = 'C:\Users\tilhi\OneDrive\TUHH\MASTER\Matlab'; % Tower PC
% pcpath = 'C:\hillebrecht\matlab'; % Institutsrechner
% dataset = dym_loadResult('GridN5AreaFirstVoltageCollapse_110n.mat');
dataset = dym_loadResult('GridN5AreaFirstIncreseLoad.mat');

t = dym_getResult(dataset,'Time');
P_node = dym_getResult(dataset,'Transformer_L_a.epp_p.P');
delta_node = dym_getResult(dataset,'Transformer_L_a.epp_p.delta');
v_node = dym_getResult(dataset,'Transformer_L_a.epp_p.v');
Q_node = dym_getResult(dataset,'Transformer_L_a.epp_p.Q');

%% Basisgrößen

[Z_k,S,U,I] = basisgroessen(t,P_node,Q_node,v_node,delta_node);


[Z_k_Telle,Z_th_Telle,ISI_Telle,S,I] = calc_ISI(t,P_node,Q_node,v_node,delta_node);
%% 
nt = size(t,1);
% counteri = 1;
new_step = true;
erg = zeros(4,nt);
index = false(nt,1);

for fori = 1:nt-1
    if new_step
        g = real(I(fori));
        h = imag(I(fori));
        u = real(U(fori));
        w = imag(U(fori));
        g2 = real(I(fori+1));
        h2 = imag(I(fori+1));
        u2 = real(U(fori+1));
        w2 = imag(U(fori+1));
        new_step = false;
    end
%     if true
%     if abs(u+1i.*w-u2-1i.*w2) > 0%abs(U(1)).*0.15
    if abs(u-u2) >0
        index(fori) = true;
        erg(:,fori) = [1,0,-g,h;0,1,-h,-g;1,0,-g2,h2;0,1,-h2,-g2]\[u;w;u2;w2];
        t_th(fori,1) = t(fori+1);
        counteri = fori + 1;
        new_step = true;
    else
        g2 = real(I(fori+1));
        h2 = imag(I(fori+1));
        u2 = real(U(fori+1));
        w2 = imag(U(fori+1));
    end
end
% [E_r;E_i;R_th;X_th] = erg;
E_r = erg(1,:)';
E_i = erg(2,:)';
R_th = erg(3,:)';
X_th = erg(4,:)';
Z_th = R_th + X_th.*1i;

ISI = (abs(Z_k) - abs(Z_th))./abs(Z_k);

%% plots
figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Calibri'); 
hold on;
plot(t,abs(Z_k))
plot(t(index),abs(Z_th(index)));
plot(t,abs(Z_k_Telle),'--');
plot(t(2:end),abs(Z_th_Telle),'--');
%xlim([380,570]);
xlim([90,420]);
ylabel('Imepdanz in \Omega','FontSize',20);
xlabel('Zeit in s','FontSize',20);
set(gca,'Fontsize',14);
legend({'Lastimpedanz nach Verfahren 1','Thévenin-Impedanz nach Verfahren 1','Lastimpedanz nach Verfahren 2','Thévenin-Impedanz nach Verfahren 2'},'FontSize',11,'Location','northeast');
grid on;
box on;
hold off;

figure('Color',[1 1 1]);
set(0,'DefaultAxesFontName','Helvetica'); 
hold on;
plot(t,P_node);
plot(t,Q_node);
%xlim([380,570]);
xlim([0,420]);
ylabel('Leistung in W bzw. VAr an Knoten A','FontSize',12);
xlabel('Zeit in s','FontSize',12);
set(gca,'Fontsize',12);
legend({'Wirkleistung','Blindleistung'},'FontSize',12,'Location','southeast');
grid on;
box on;
hold off;

%%


% figure('Color',[1 1 1]); set(0,'DefaultAxesFontName','Arial');
% hold on; plot(t1,v1,'b'); xlim([0,200]);
% ylabel('Voltage at Bus A','FontSize',20);
% xlabel('Time in s','FontSize',20);,
% set(gca,'Fontsize',14);
% grid on;,
% hold off;

figure
grid on
hold on
plot(t(index),ISI(index))

% figure
% plot(t_th,abs(E_r+1i.*E_i))