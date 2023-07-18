%% Erstellen eines Netzes mit n Knoten

clear all;

test_gleich=zeros(223,1);
test_Qcrit=zeros(223,1);
test_index=zeros(223,1);
test_indexSB=zeros(223,1);
test_typeofindex=zeros(223,1);

for n=9:1:50

% n=89;


[clusterKnoten,clusterLeitungen]=Verfahren_SimBench_function_LK(n);

clusterKnoten(:,7)=clusterKnoten(:,7)*1.3;  clusterKnoten(:,8)=clusterKnoten(:,8)*1.3; 

%% Stationäre Voruntersuchung

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

%LFR für Spannungsprofil

konvfehler=0;

[~,~,Ua,dta,konvfehler] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenneuenum,AnzL,AnzK);

konvfehler

sortUa=sort(Ua);

indexUa=find(Ua==sortUa(1));


%Blindlesitung am Konten indexUa erhöhen

erhoehungszaehl=0;

Knotenerhoeht=Knotenneuenum;

konvfehler=0;

while ~konvfehler
    
    Knotenerhoeht(indexUa,8)=Knotenerhoeht(indexUa,8)+0.5*10^7;
    
    [~,~,Ua,~,konvfehler] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenerhoeht,AnzL,AnzK);
    
    konvfehler
    
    min(Ua);
    
    erhoehungszaehl=erhoehungszaehl+1;
end

Knotenerhoeht=Knotenneuenum;
Knotenerhoeht(indexUa,8)=Knotenneuenum(indexUa,8)+0.5*(erhoehungszaehl-1)*10^7;

[Pa,Qa,Ua,~,konvfehler2] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenerhoeht,AnzL,AnzK);

konvfehler2

V_bus=Ua*380e3;


Sb=1700e6;


Q_bus=Qa*Sb;



for iteration1=1:AnzK
    denominator=0;
    for iteration2=1:AnzK
        if iteration1 == iteration2
        else
            sumMVSI=V_bus(iteration2)*Y_out(iteration1,iteration2)*sin(theta_out(iteration1,iteration2));
            denominator=sumMVSI+denominator;
        end
    end
    
    MVSI(iteration1)= (4*(Q_bus(iteration1)*Y_out(iteration1,iteration1)*sin(theta_out(iteration1,iteration1)))/(denominator^2));
    
end

sortMVSI=sort(MVSI);

indexMVSI=find(MVSI==sortMVSI(end));

critMVSI=sortMVSI(end);

critQ=Q_bus(indexMVSI);

BusSimBench=clusterKnoten(indexMVSI,1);

if indexUa==indexMVSI
   
    test_gleich(n)=1;
    
    
end

test_Qcrit(n)=critQ;

test_index(n)=indexMVSI;

test_indexSB(n)=BusSimBench;

test_typeofindex(n)=clusterKnoten(indexMVSI,2);

end
