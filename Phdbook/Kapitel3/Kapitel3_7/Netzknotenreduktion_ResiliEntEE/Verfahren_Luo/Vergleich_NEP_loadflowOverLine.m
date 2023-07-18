%Wichtig: Bitte Toleranz in ConvertoPSTLFNR_SimBench auf 1e-2 stellen
%WICHTIG: Es muss AnzK in der function:
%Advanced_verfahren_Simbench_function als Augabe hinzugefügt werden
clear all;

start=5;%210;
%Mindestzahl= anzahl PV-Knoten (derzeit)

ende=600;

step=1;

stepvector=start:step:ende;

abwrelp=zeros(length(stepvector),1);

abwrelq=zeros(length(stepvector),1);

zaehlplot=1;


for lauf=start:step:ende
    
    lauf
    
    [clusterKnoten,clusterLeitungen,erelp,erelq,SLeitungr,AnzK]=Advanced_Verfahren_SimBench_function(lauf);
    
    [clusterKnotenNEP,clusterLeitungenNEP,erelpNEP,erelqNEP,SLeitungrNEP]=Advanced_Verfahren_SimBench_NEP_function(lauf);
    
    AnzLeitungen=length(SLeitungr);
    AnzLeitungenNEP=length(SLeitungrNEP);
    AnzLeitungenMAX=AnzK;
    %Abfrage zur Bestimmung der Größe der Matrizen
    Knotenfluss=zeros(AnzLeitungenMAX,AnzLeitungenMAX);
    Knotenfluss_NEP=zeros(AnzLeitungenMAX,AnzLeitungenMAX);
    %Zum vergleich werden 2 quadratische Matrizen in der Größe der Anzahl
    %der nicht reduzierten Knoten erstellt
    
    for i=1:AnzLeitungen
        a=clusterLeitungen(i,1);
        b=clusterLeitungen(i,2);
        Knotenfluss(a,b)=SLeitungr(i,1)+Knotenfluss(a,b); 
        %Bestimmung and Anfangs und Endknoten und das schreiben in die
        %Vergleichsmatrix mit den jeweiligen Lastflüssen und das
        %aufaddieren für den Fall, dass es mehr als eine Leitung gibt
        %zwischen 2 Knoten
    end    
    
    
     for i=1:AnzLeitungenNEP
        a=clusterLeitungenNEP(i,1);
        b=clusterLeitungenNEP(i,2);
        Knotenfluss_NEP(a,b)=SLeitungrNEP(i,1)+Knotenfluss_NEP(a,b);   
          %Bestimmung and Anfangs und Endknoten und das schreiben in die
        %Vergleichsmatrix für NEP
    end  
    
  
    
    %Pabw=abs(real(SLeitungr)-real(SLeitungrNEP));
    Pabw=abs(real(Knotenfluss)-real(Knotenfluss_NEP));
    %Differenzbildung der Wirkleistung für fro-Norm
    
    %Qabw=abs(imag(SLeitungr)-imag(SLeitungrNEP));
    Qabw=abs(imag(Knotenfluss)-imag(Knotenfluss_NEP));

    abwp = norm(Pabw,'fro');
    abwq = norm(Qabw,'fro');

    abwrelp(zaehlplot)=abwp/(norm(SLeitungr,'fro'));
    abwrelq(zaehlplot)=abwq/(norm(SLeitungr,'fro'));
    
    
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
% ylim([0,10]);
ylim([0,2]);


