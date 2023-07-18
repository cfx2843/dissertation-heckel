%Wichtig: Bitte Toleranz in ConvertoPSTLFNR_SimBench auf 1e-2 stellen

clear all;

start=220;%210;
%Mindestzahl= anzahl PV-Knoten (derzeit)

ende=600;

step=5;

stepvector=start:step:ende;

abwrelp=zeros(length(stepvector),1);

abwrelq=zeros(length(stepvector),1);

zaehlplot=1;

for lauf=start:step:ende
    
    
    lauf
    
    [clusterKnoten,clusterLeitungen,erelp,erelq,Par1,Qar1]=Advanced_Verfahren_SimBench_refbus_function(lauf);
    
    [clusterKnotenNEP,clusterLeitungenNEP,erelpNEP,Par1NEP,Qar1NEP]=Advanced_Verfahren_SimBench_NEP_refbus_function(lauf);
    
   
    
   
    
    %Pabw=abs(real(SLeitungr)-real(SLeitungrNEP));
    %Pabw=abs(real(Knotenfluss)-real(Knotenfluss_NEP));
    Pabw=abs(Par1-Par1NEP);
    % ????? ist abs sinnvoll????
    
    %Qabw=abs(imag(SLeitungr)-imag(SLeitungrNEP));
    %Qabw=abs(imag(Knotenfluss)-imag(Knotenfluss_NEP));
    Qabw=abs(Qar1-Qar1NEP);
    
    
    abwp = norm(Pabw,'fro');
    abwq = norm(Qabw,'fro');
%Frobeniusnorm ist aus orherigem script übrig geblieben, hat allerdings
%keine Auswirkung, da nur ein Eintrag vorhanden ist
    abwrelp(zaehlplot)=abwp/(norm(Par1,'fro'));
    abwrelq(zaehlplot)=abwq/(norm(Qar1,'fro'));
    
    
    zaehlplot=zaehlplot+1;
    
end

figure;
hold on;
plot(stepvector,abwrelp,'b');
plot(stepvector,abwrelq,'r');
hold off;
ylabel('Relative Deviation','FontSize',20);
xlabel('Number of Busses','FontSize',20);
legend('Active Power','Reactive Power','Location','northeast');
set(gca,'Fontsize',14);
grid on;
ylim([0,10]);


