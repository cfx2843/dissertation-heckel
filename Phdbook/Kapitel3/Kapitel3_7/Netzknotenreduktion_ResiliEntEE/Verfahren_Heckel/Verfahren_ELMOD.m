clear all
%% Leitungsmatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen

%erste Tabelle öffnen zum Auslesen der Netztopologie
[gridtopo,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Grid_topology');
[AnzL,AnzK]=size(gridtopo);

Leitungen=zeros(AnzL,5);

for i=1:AnzL   %geht die Matrix durch und bestimmt Startknoten (1) und Endknoten (-1).
    for j=1:AnzK
        if gridtopo(i,j)==-1
            Leitungen(i,2)=j;
        elseif gridtopo(i,j)==1
            Leitungen(i,1)=j;
        end
    end
end

%zweite Tabelle öffnen zum Auslesen von Leitungsdaten
[gridtechnical,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Grid_technical');

%Die Länge steht in der sechsten Spalte
Leitungen(:,3)=gridtechnical(:,6);
%Die Spannungsebene steht in der vierten Spalte
Leitungen(:,4)=gridtechnical(:,4);
%Die Anzahl der parallelen Leitungen steht in der fünften Spalte
Leitungen(:,5)=gridtechnical(:,5);

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5: Norddeutsch

Knoten=zeros(AnzK,5);

%dritte Tabelle öffnen zum Auslesen der Knotendaten
[~,node_data_txt,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Node_Data');

%Knotennummern bestimmen
Knoten(:,1)=1:AnzK;

% Knotenart bestimmen
%Art des Knotens: 1 Lastknoten 2 Generatorknoten

%markiert erst einmal alle Knoten als Lastknoten
Knoten(:,2)=ones(AnzK,1);

[~,plant_txt] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Plant_con');
for i=3:AnzK+2          %alle Generatorknoten werden im zweiten Schritt umbenannt
    charknoten=char(plant_txt(i,3));
    k=str2double(charknoten(2:end));
    Knoten(k,2)=2;
end

%dritte Tabelle als Zahl importieren.
[node_data_num,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Node_Data');

%Lägen und Breitengrad eintragen
Knoten(:,3)=node_data_num(:,11);
Knoten(:,4)=node_data_num(:,12);


% Zugehörigkeit zu Nordeutschland finden
for i=3:AnzK+2              %Sollte ein Knoten in den Ländern: Schleswig-Holstein, Bremen, Hamburg, Mecklenburg-Vorpommern oder Niedersachen liegen, wird er zu Nordeutschland gezählt
    if node_data_txt(i,3)=="DE_HB"||node_data_txt(i,3)=="DE_HH"||node_data_txt(i,3)=="DE_MV"||node_data_txt(i,3)=="DE_NI"...
            ||node_data_txt(i,3)=="DE_SH"
        Knoten(i-2,5) = 1;
    end
end


%Landkreis bestimmen. Dieser wird in eine eigenes Array eingetragen.

load('Map.mat');
%Landkreis ist ein String-Array
Landkreis=strings(AnzK,1);

%äußere for-Schleife iteriert über die Leitungen
for i=1:AnzK
    
    posx=Knoten(i,4);
    posy=Knoten(i,3);
    
    %innere for-Schleife iteriert über die Map
    for j=1:length(Map)
        if inpolygon(posx,posy,Map(j).WGS84_X,Map(j).WGS84_Y)
            Landkreis(i)=Map(j).GEN;
        end
        
    end
    
end

%% Admittanz- und Distanzmatrix erstellen
%benutze das die Funktion, die die Admittanzmatrix bestimmt

Y=Admittanzmatrix_Heckel(Leitungen,AnzK);

Distanz=zeros(AnzK,AnzK);
for i = 1:AnzL   %Leitungslängen eintragen in app.D
    c1=Leitungen(i,1);
    c2=Leitungen(i,2);
    Distanz(c1,c2)=Leitungen(i,3)/Y(c1,c2);  %elektrische Distanz über die Admittanzmatrix
    Distanz(c2,c1)=Leitungen(i,3)/Y(c1,c2);
end
%0 durch Nan ersetzen
Distanz(Distanz==0)=NaN;

%% System auf Norddeutschland reduzieren
%Hier beginnt die eigentliche Netzknotenreduktion
%erst einmal werden nur die Knoten reduziert
%Die Clustermatrix wird erstellt
%Die Claustermatrix beinhaltet die Zuordnung der Knoten zu Clustern. Jeder
%Knoten behält seine Nummer
cluster=zeros(AnzK,AnzK);
%In den folgenden Matritzen/String-Array befinden sich die redzierten
%Knoten und Landkreise
clusterKnoten=zeros(AnzK,5);
clusterLandkreis=strings(AnzK,1);
%ClusterDistanz wird nur für das Distanzverfahren bentutz und daher erst
%nach dem Schritt mit der Reduktion auf einen Knoten pro Landkreis
%angepasst
clusterDistanz=Distanz;
%Falls noch kein Cluster besteht müssen die zu clusterenden Knoten
%zwischengespeichert werden
clustersave=zeros(1,AnzK);
%eine zusätzliche Iterationsvariable wird benötigt
jzwei=1;
%Iteration über alle Knoten
for i=1:AnzK
    %Falls Knoten in Norddeutschland liegt, wird er in die entsprechenden
    %Matritzen aufgenommen
    if Knoten(i,5)==1
        cluster(i,1)=Knoten(i,1);
        clusterKnoten(i,:)=Knoten(i,:);
        clusterLandkreis(i)=Landkreis(i);
        jeins=i;
        jzwei=1;
        %Falls der Knoten nicht in Norddeutschland liegt, wird der Knoten dem
        %letzten Cluster bzw. dem ersten Cluster (über Zwischenspeicher, weil
        %noch unbekannt, welches das erste Cluster sein wird) zugeordnet
    else
        if cluster(:,1)==zeros(length(cluster),1) %Zuordnung zu erstem Cluster
            clustersave(jzwei+1)=Knoten(i,1);
        else %Zuordnung zum letzten Cluster jeins, über jwei werden weitere Einträge erstellt, damit diese nicht überschrieben werden
            cluster(jeins,jzwei+1)=Knoten(i,1);
        end
        jzwei=jzwei+1;
    end
    
end

%Finden des ersten Clusters
i=find(cluster(:,1));
i=i(1);

%Leeren des Zwischenspeichers an die richtige Stelle in der Clustermatrix
cluster(i,2:end)=clustersave(2:end);

%% System auf ein Knoten pro Landkreis reduzieren
%auch hier werden nur Knoten reduziert
%erste Iteration für den neuen Landreis
for i=1:AnzK
    %Ist der Landkreis leer, ist hier kein Cluster mehr vorhanden.
    if cluster(i,1)~=0
        aktLandkreis=clusterLandkreis(i);
        for j=i+1:AnzK
            if clusterLandkreis(j)==aktLandkreis
                clusterLandkreis(j)="";
                clusterKnoten(j,:)=zeros(1,5);
                %Cluster i bleibt und Cluster j wird gelöscht
                clusterierstefreiereintrag=find(cluster(i,:)); %Achtung: Index
                clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
                lengthclustereintrag=length(cluster(i,clusterierstefreiereintrag:end));
                cluster(i,clusterierstefreiereintrag:end)=cluster(j,1:lengthclustereintrag);
                %Cluster löschen
                cluster(j,:)=zeros(1,AnzK);
                for lauf=1:AnzK
                    if lauf~=i
                        if any(clusterDistanz(lauf,j))
                            if any(clusterDistanz(lauf,i))
                                clusterDistanz(lauf,i)=(clusterDistanz(lauf,i)+clusterDistanz(lauf,j))/2;
                                clusterDistanz(i,lauf)=clusterDistanz(lauf,i);
                            else
                                clusterDistanz(lauf,i)=clusterDistanz(lauf,j);
                                clusterDistanz(i,lauf)=clusterDistanz(lauf,i);
                            end
                        end
                    end
                end
                
                
        clusterDistanz(j,:)=NaN(1,AnzK);
        clusterDistanz(:,j)=NaN(AnzK,1);
            end
            
        end
    end
end

%leere Einträge von cluster löschen
loesch=zeros(AnzK,1);
for i=1:AnzK
    if clusterKnoten(i,1)==0
        loesch(i)=1;
    end
end

clusterKnoten(loesch==1,:)=[];
clusterLandkreis(loesch==1)=[];
cluster(loesch==1,:)=[];

clusterDistanz(loesch==1,:)=[];
clusterDistanz(:,loesch==1)=[];

AnzLandkreise=length(clusterKnoten);


%% Weitere Reduktion mit der elektrischen Distanz
%Zielanzahl an Knoten:
zielAnz=20;
AnzKinreduc=AnzLandkreise;
if zielAnz<AnzLandkreise
    while AnzKinreduc>zielAnz
        % Dichteste Knoten finden
        minD = min(abs(clusterDistanz),[],'all');
        [c1,c2] = find(minD == abs(clusterDistanz));
        c1=c1(1); %Achtung: Index
        c2=c2(1); %Achtung: Index
        %Index passt, da immer die gleichen Zeilen gelöscht wurden
        % Cluster bilden, indem c2 gelöscht wird
        clusterLandkreis(c2)="";
        clusterKnoten(c2,:)=zeros(1,5);
        %Cluster i bleibt und Cluster j wird gelöscht
        clusterierstefreiereintrag=find(cluster(c1,:));
        clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
        lengthclustereintrag=length(cluster(c1,clusterierstefreiereintrag:end));
        cluster(c1,clusterierstefreiereintrag:end)=cluster(c2,1:lengthclustereintrag);
        %Cluster löschen
        cluster(c2,:)=zeros(1,AnzK);
        AnzKinreduc=AnzKinreduc-1;
        
        
        for i=1:AnzLandkreise
            if i~=c1
                if any(clusterDistanz(i,c2))
                    if any(clusterDistanz(i,c1))
                        clusterDistanz(i,c1)=(clusterDistanz(i,c1)+clusterDistanz(i,c2))/2;
                        clusterDistanz(c1,i)=clusterDistanz(i,c1);
                    else
                        clusterDistanz(i,c1)=clusterDistanz(i,c2);
                        clusterDistanz(c1,i)=clusterDistanz(i,c1);
                    end
                end
            end
        end        
        
        
        clusterDistanz(c2,:)=NaN(1,AnzLandkreise);
        clusterDistanz(:,c2)=NaN(AnzLandkreise,1);

        
        
    end
    
end



%leere Einträge von cluster löschen
loesch=zeros(AnzLandkreise,1);
for i=1:AnzLandkreise
    if clusterKnoten(i,1)==0
        loesch(i)=1;
    end
end

clusterKnoten(loesch==1,:)=[];
clusterLandkreis(loesch==1)=[];
cluster(loesch==1,:)=[];

[AnzCluster,~]=size(cluster);

%% passende Leitungsdaten zu der Clusterung finden
% erst jetzt werden auch die Leitungen verändert
% In ELMOD-DE liegen keine nutzbaren Daten für eine Lastflussrechnung vor,
% daher wird das Verfahren mit dem Zusammenfassen der Leitungen vereinfacht
% durchgeführt

%Zur Erinnerung der Aufbau der Leitungsmatrix
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in V
%Spalte 5:  Anzahl der Leitungen

clusterLeitungen=Leitungen;

%Hier werden die Leitungen auf die neuen Cluster gelegt
%Iteration über die Leitungen
for i=1:AnzL
    %iteration über die cluster
    for j=1:AnzCluster
        %Iteration über die geclusterten Knoten
        for jzwei=2:AnzK
            %Startknoten ändern
            if cluster(j,jzwei)==Leitungen(i,1)
                %Alles bleibt erhalten bis auf den Startknoten
                clusterLeitungen(i,1)=cluster(j,1);
            end
        end
        %erneut iterieren, damit nichts vergessen wird
        for jzwei=2:AnzK
            %Endtknoten ändern
            if cluster(j,jzwei)==Leitungen(i,2)
                %Alles bleibt erhalten bis auf den Endknoten
                clusterLeitungen(i,2)=cluster(j,1);
            end
        end
        
    end
end
  
      
%Jetzt müsssen parallele Leitungen zusammengefasst werden
%ab sofort wird nur noch mit clusterLeitungen gearbeitet

for i=1:AnzL
    aktLeitungsverlauf1=[clusterLeitungen(i,1),clusterLeitungen(i,2)];
    aktLeitungsverlauf2=[clusterLeitungen(i,2),clusterLeitungen(i,1)];
        for j=i+1:AnzL
            if isequal(clusterLeitungen(j,1:2),aktLeitungsverlauf1)||isequal(clusterLeitungen(j,1:2),aktLeitungsverlauf2)
               %Leitung i, bleibt Leitung j wird gelöscht
               %Jetzt ist die Unterscheidung der Spannungsebenen
               %erforderlich
               %Es sollen die Spannungsebenen erhalten bleiben, damit
               %Trafos im fertigen Modell verwendet werden können
               if clusterLeitungen(i,4)==clusterLeitungen(j,4)
                   %erst einmal die Änderungen für Leitungen i
                   clusterLeitungen(i,3)=(clusterLeitungen(i,3)+clusterLeitungen(j,3))/2;
                   clusterLeitungen(i,5)=clusterLeitungen(i,5)+clusterLeitungen(j,5);
                   %nun wird die Leitung j gelöscht
                   clusterLeitungen(j,:)=zeros(1,5);
               end   
            end   
        end    
end

%Jetzt müssen die Leitungen die im Kreis führen gelöscht werden

for i=1:AnzL
    if clusterLeitungen(i,1)==clusterLeitungen(i,2)
        clusterLeitungen(i,:)=zeros(1,5);
    end
end

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von cluster löschen
loesch=zeros(AnzL,1);
for i=1:AnzL
    if clusterLeitungen(i,1)==0
        loesch(i)=1;
    end
end

clusterLeitungen(loesch==1,:)=[];

[AnzClusterLeitungen,~]=size(clusterLeitungen);

%% Validierung

%es wird noch eine Nummierung für die Erstellung der Admittanzmatrix
%gebraucht

clusterKnotenneuenum=clusterKnoten;
clusterLeitungenneuenum=clusterLeitungen;

clusterKnotenneuenum(:,1)=1:AnzCluster;

for i=1:AnzClusterLeitungen
    index1=find(clusterKnoten(:,1)==clusterLeitungenneuenum(i,1));
    index2=find(clusterKnoten(:,1)==clusterLeitungenneuenum(i,2));
    clusterLeitungenneuenum(i,1)=clusterKnotenneuenum(index1,1);
    clusterLeitungenneuenum(i,2)=clusterKnotenneuenum(index2,1);
end

Ycluster=Admittanzmatrix_Heckel(clusterLeitungenneuenum,AnzCluster);

%Reduktion der Matrix Y

KUeb=cluster(:,1);
KRed=cluster(:,2:end);
KRed=KRed(:);

loesch=zeros(length(KRed),1);
for i=1:length(KRed)
    if KRed(i)==0
        loesch(i)=1;
    end
end

KRed(loesch==1)=[];

KRed=sort(KRed);

Yr=Y;

% Matrix-Reduktion
Y11 = Yr(KUeb,KUeb);
Y12 = Yr(KUeb,KRed);
Y21 = Yr(KRed,KUeb);
Y22 = Yr(KRed,KRed);

Yred = Y11-Y12*(Y22\Y21);

Yf=abs(Yred-Ycluster);

e = norm(Yf,'fro');

erel=e/(norm(Y,'fro'));
