%Wichtig: Bitte Toleranz in ConvertoPSTLFNR_SimBench auf 1e-2 stellen

clear all;

Sb=1700e6; %Bezugsleistung

start=585;%210;

ende=600;

step=5;

stepvector=start:step:ende;

abverlp=zeros(length(stepvector),1);

abverlq=zeros(length(stepvector),1);

zaehlplot=1;


for lauf=start:step:ende
    
    lauf
    
    [clusterKnoten,clusterLeitungen,erelp,erelq,Parslack,Qarslack,slacknumber]=Advanced_Verfahren_SimBench_function(lauf);
    
    [clusterKnotenNEP,clusterLeitungenNEP,erelpNEP,erelqNEP,ParslackNEP,QarslackNEP,slacknumberNEP]=Advanced_Verfahren_SimBench_NEP_function(lauf);
    
%     Pabw=abs(real(SLeitungr)-real(SLeitungrNEP));
% 
%     Qabw=abs(imag(SLeitungr)-imag(SLeitungrNEP));
% 
%     abwp = norm(Pabw,'fro');
%     abwq = norm(Qabw,'fro');
% 
%     abwrelp(zaehlplot)=abwp/(norm(SLeitungr,'fro'));
%     abwrelq(zaehlplot)=abwq/(norm(SLeitungr,'fro'));

    verlP=Parslack*Sb+clusterKnoten(slacknumber,7);
    verlPNEP=ParslackNEP*Sb+clusterKnotenNEP(slacknumberNEP,7);
    
   
     verlQ=Qarslack*Sb+clusterKnoten(slacknumber,8);
     verlQNEP=QarslackNEP*Sb+clusterKnotenNEP(slacknumberNEP,8);
     
     abverlp(zaehlplot)=abs(verlP-verlPNEP);
     abverlq(zaehlplot)=norm(verlQ-verlQNEP);


    
    
    zaehlplot=zaehlplot+1;
    
end

figure;
hold on;
plot(stepvector,abverlp,'b');
plot(stepvector,abverlq,'r');
hold off;
ylabel('Relative Deviation','FontSize',20);
xlabel('Number of Busses','FontSize',20);
legend('Active Power','Reactive Power','Location','northeast');
set(gca,'Fontsize',14);
grid on;
ylim([0,2]);


