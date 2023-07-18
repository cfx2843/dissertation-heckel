clear all
%% Leitungsmatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen

%erste Tabelle öffnen zum Auslesen der Netztopologie
[gridtopo,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SciGrid_Leitungen.xlsx','links_de_power_160718');
[AnzL,~]=size(gridtopo);

Leitungen=zeros(AnzL,5);

%Start- und Endknoten können direkt ausgelesen werden

Leitungen(:,1)=gridtopo(:,2);
Leitungen(:,2)=gridtopo(:,3);

%Auch die Länge und die Spannungsebene können direkt ausgelesen werden.

Leitungen(:,3)=gridtopo(:,11)/1000;
Leitungen(:,4)=gridtopo(:,4)/1000;

%Die Anzahl der Leitungen ist hier etwas aufwendiger zu bestimmen.
%cables in der Tabelle stellt die Anzahl der Leitungen dar. Dabei ist
%zubeachten, dass hier einfach gezählt wurde. Das heißt für ein
%Drehstromsystem gilt cables=3; usw.
%wires stellt die Anzahl der Bündelleiter dar. Da diese Information von
%Laienaus OpenStreetMap, die diese Information am Boden stehend gewonnen
%haben, stammt, kann diese Information ignoriert werden Es wird daher nur
%calbes genommen.
Leitungen(:,5)=ones(AnzL,1);

for i=1:AnzL
    if gridtopo(i,5)==6
        Leitungen(i,5)=2;        
    elseif gridtopo(i,5)==9
        Leitungen(i,5)=3;   
    elseif gridtopo(i,5)==12
        Leitungen(i,5)=4;   
    end
    
    
end


%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5: Norddeutsch

%zweite Tabelle öffnen zum Auslesen der Knotendaten
[node_data_num,node_data_txt,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SciGrid_Knoten.xlsx','vertices_de_power_160718');

[AnzK,~]=size(node_data_num);

Knoten=zeros(AnzK,5);

%Knotennummern bestimmen
Knoten(:,1)=node_data_num(:,1);

%Lägen und Breitengrad eintragen
Knoten(:,3)=node_data_num(:,2);
Knoten(:,4)=node_data_num(:,3);


%HVDC-Leitungen mit den dazugehörigen Knoten entfernen

for i=1:AnzL
   if Leitungen(i,4)~=380 && Leitungen(i,4)~=220 
       Leitungen(i,:)=zeros();
       
   end
end

loesch=zeros(AnzL,1);
for i=1:AnzL
    if Leitungen(i,1)==0
        loesch(i)=1;
    end
end

Leitungen(loesch==1,:)=[];

AnzLalt=AnzL;

[AnzL,~]=size(Leitungen);

Knotenverbvec=zeros(AnzK,1);


for i=1:AnzK
   for j=1:AnzL
     if Knoten(i,1)==Leitungen(j,1) || Knoten(i,1)==Leitungen(j,2)
         Knotenverbvec(i)=1;
     end
   end
end

Knoten(Knotenverbvec==0,:)=[];


AnzKalt=AnzK;

[AnzK,~]=size(Knoten);

%Knotennummern ändern von 1 bis AnzK

for i=1:AnzL
    sk=Leitungen(i,1);
    ek=Leitungen(i,2);
    indexK1=find(Knoten(:,1)==sk);
    indexK2=find(Knoten(:,1)==ek);
    
    Leitungen(i,1)=indexK1;
    Leitungen(i,2)=indexK2;    
    
end

Knoten(:,1)=1:AnzK;


% Knotenart bestimmen
%Art des Knotens: 1 Lastknoten 2 Generatorknoten

for i=2:AnzK+1
    if isequal(char(node_data_txt(i,4)),'substation')
        Knoten(i-1,2)=1;
    elseif isequal(char(node_data_txt(i,4)),'plant')
        Knoten(i-1,2)=2;
    elseif isequal(char(node_data_txt(i,4)),'generator')
        Knoten(i-1,2)=2;
    elseif isequal(char(node_data_txt(i,4)),'auxillary_T_node')
        Knoten(i-1,2)=1;
    else
        disp('kein Knotentyp');
        Knoten(i-1,2)=1;
    end
end





%Landkreis bestimmen. Dieser wird in eine eigenes Array eingetragen.

load('Map.mat');
%Landkreis ist ein String-Array
Landkreis=strings(AnzK,1);

%äußere for-Schleife iteriert über die Leitungen
for i=1:AnzK
    
    posx=Knoten(i,3);
    posy=Knoten(i,4);
    
    %innere for-Schleife iteriert über die Map
    for j=1:length(Map)
        if inpolygon(posx,posy,Map(j).WGS84_X,Map(j).WGS84_Y)
            Landkreis(i)=Map(j).GEN;
            %In dem Zuge wird auch das Bundesland ausgelesen, um die
            %Zugehörigkeit zu Norddeutschland zu ermitteln
            %Das Bundesland befindet sich in der Spalte RS und AGS in den
            %ersten beiden Ziffern
            %01 Schleswig-Holstein
            %02 Hamburg
            %03 Niedersachsen
            %04 Bremen
            %13 Mecklenburg-Vorpommern
            Bundeslandziffern=Map(j).RS;
            Bundeslandziffern=Bundeslandziffern(1:2);
            Bundeslandziffern=str2double(Bundeslandziffern);
             %Sollte ein Knoten un den Ländern: Schleswig-Holstein, Bremen,
             %Hamburg, Mecklenburg-Vorpommern oder Niedersachen liegen,
             %wird er zu Nordeutschland gezählt
            if Bundeslandziffern==1 || Bundeslandziffern==2 || Bundeslandziffern==3 ...
                || Bundeslandziffern==4 ||Bundeslandziffern==13
                Knoten(i,5) = 1;
            end
        end
        
    end
    
end


%% Admittanz- und Distanzmatrix erstellen
%benutze die Funktion, die die Admittanzmatrix bestimmt

Y=Admittanzmatrix_Heckel(Leitungen,AnzK);

Distanz=zeros(AnzK,AnzK);
for i = 1:AnzL   %Leitungslängen eintragen in app.D
    c1=Leitungen(i,1);
    c2=Leitungen(i,2);
    Distanz(c1,c2)=1/Y(c1,c2);  %elektrische Distanz über die Admittanzmatrix
    Distanz(c2,c1)=1/Y(c1,c2);
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
                   clusterLeitungen(i,3)=(clusterLeitungen(i,5)*clusterLeitungen(i,3)+clusterLeitungen(j,5)*clusterLeitungen(j,3))/(clusterLeitungen(i,5)+clusterLeitungen(j,5));
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
