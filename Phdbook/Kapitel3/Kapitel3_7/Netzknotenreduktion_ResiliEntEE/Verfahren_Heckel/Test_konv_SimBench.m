clear all;

start=5;

n=602;

konvfehlerspeicher=zeros(n,1);

AnzSpeicher=start:n;

for lauf=start:n
    
    lauf
    
    [clusterKnoten,clusterLeitungen]=Verfahren_SimBench_function(lauf);
    
    % Stationäre Voruntersuchung
    
    [AnzK,~]=size(clusterKnoten);
    
    [AnzL,~]=size(clusterLeitungen);
    
    %Knoten neu sortieren, um die SimBench-Nummerierung zu entfernen
    
    Knotenneuenum=clusterKnoten;
    Leitungenneuenum=clusterLeitungen;
    
    Knotenneuenum(:,1)=1:AnzK;
    
    for i=1:AnzL
        index1=find(clusterKnoten(:,1)==Leitungenneuenum(i,1));
        index2=find(clusterKnoten(:,1)==Leitungenneuenum(i,2));
        Leitungenneuenum(i,1)=Knotenneuenum(index1,1);
        Leitungenneuenum(i,2)=Knotenneuenum(index2,1);
        
    end
    
    %Admittanzmatrix bestimmen
    
    Y=Admittanzmatrix_SimBench(Leitungenneuenum,AnzK);
    
    % Output of the admittance matrix in magnitude and phase
    
    Y_out=abs(Y);
    theta_out=angle(Y);
    
    %Leistung erhöhen
    
    % Knotenneuenum(:,7:8)=Knotenneuenum(:,7:8)*1.3;
    
    %LFR für Spannungsprofil
    
    [~,~,Ua,Dta,konvfehler] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenneuenum,AnzL,AnzK);
    
    konvfehlerspeicher(lauf)=konvfehler;
    
    
end

plot(AnzSpeicher,konvfehlerspeicher);