clear all

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Breitengrad
%Spalte 4:  Längengrad
%Spalte 5:  Norddeutsch
%Spalte 6:  Spannungsebene
%Spatle 7:  Knoten-Wirkleistung
%Spalte 8:  Knoten-Blindleistung
%spalte 9:  Landkreis ID

%Art des Knotens: 1 Lastknoten 2 Generatorknoten 3 Referenzknoten

nodes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Node.csv');

coordinatedata=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Coordinates.csv');

[AnzCoord,~]=size(coordinatedata);

charcoord=cell(AnzCoord,1);

for i=1:AnzCoord
    
    charcoord{i}={char(coordinatedata(i,1).id)};
    
end


[AnzK,~]=size(nodes);

Knoten=zeros(AnzK,9);

Knoten(:,1)=1:AnzK;

Knoten(:,2)=ones(AnzK,1);

for i=1:AnzK
    
    
    spg=nodes(i,5);
    spg=spg.vmR;
    
    Knoten(i,6)=spg;
    
    coordchar=nodes(i,9);
    coordchar=coordchar.coordID;
    coordchar=char(coordchar);
    
    for j=1:AnzCoord
        if isequal(coordchar,char(charcoord{j}))
            index0=j;
        end
    end
    
    Knoten(i,3)=coordinatedata(index0,3).y;
    Knoten(i,4)=coordinatedata(index0,2).x;
    
end


%Auslesen der Knotennummer im Namen

charknotennummer=cell(AnzK,1);

for i=1:AnzK
    
    charknotennummer{i}={char(nodes(i,1).id)};
    
end

%Einlesen der Lastdaten

loaddata=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Load.csv');

[AnzLoads,~]=size(loaddata);

for i=1:AnzLoads
    stringload=loaddata(i,2);
    stringload=stringload.node;
    stringload=char(stringload);
    
    for j=1:AnzK
        if isequal(stringload,char(charknotennummer{j}))
            indexload=j;
        end
    end
    
    Pload=loaddata(i,4).pLoad;
    Knoten(indexload,7)=Pload*10^6;
    Qload=loaddata(i,5).qLoad;
    Knoten(indexload,8)=Qload*10^6;
    
end

%Einlesen der Erzeugungsdaten der erneuerbaren Erzeuger

resdata=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_RES.csv');

[AnzRES,~]=size(resdata);

for i=1:AnzRES
    stringres=resdata(i,2);
    stringres=stringres.node;
    stringres=char(stringres);
    
    for j=1:AnzK
        if isequal(stringres,char(charknotennummer{j}))
            indexres=j;
        end
    end
    
    Pres=resdata(i,6).pRES;
    Knoten(indexres,7)=-Pres*10^6+Knoten(indexres,7);
    Qres=resdata(i,7).qRES;
    Knoten(indexres,8)=-Qres*10^6+Knoten(indexres,8);
    
end

%Einlesen der konventionellen Kraftwerke

ppdata=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_PowerPlant.csv');

[Anzpp,~]=size(ppdata);

for i=1:Anzpp
    stringpp=ppdata(i,2);
    stringpp=stringpp.node;
    stringpp=char(stringpp);
    
    for j=1:AnzK
        if isequal(stringpp,char(charknotennummer{j}))
            indexpp=j;
        end
    end
    
    Knoten(indexpp,2)=2;
    
    Ppp=ppdata(i,7).pPP;
    Knoten(indexpp,7)=-Ppp*10^6+Knoten(indexpp,7);
    
    
end

%Landkreis bestimmen. Dieser wird in eine eigenes Array eingetragen.

load('Map.mat');
%Landkreis ist ein String-Array
Landkreis=strings(AnzK,1);

%äußere for-Schleife iteriert über die Leitungen
for i=1:AnzK
    
    posy=Knoten(i,3);
    posx=Knoten(i,4);
    
    %innere for-Schleife iteriert über die Map
    for j=1:length(Map)
        if inpolygon(posx,posy,Map(j).WGS84_X,Map(j).WGS84_Y)
            Landkreis(i)=Map(j).GEN;
            Knoten(i,9)=Map(j).KreisNummer;
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



%% Leitungsmatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen
%Spalte 6:  Leitungstyp

gridtopo=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Line.csv');
linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');

[AnzL,~]=size(gridtopo);

%Initialisierung Leitungsmatrix

Leitungen=zeros(AnzL,6);

[AnzLtypes,~]=size(linetypes);

%Auslesen der Leitungstypen aus der Tabelle

charlinetype=cell(AnzLtypes,1);

for i=1:AnzLtypes
    
    charlinetype{i}={char(linetypes(i,1).id)};
    
end

%Leitungsmatrix mit den Informationen für die Leitungen füllen

for i=1:AnzL
    string=gridtopo(i,2);
    string=string.nodeA;
    string=char(string);
    
    for j=1:AnzK
        if isequal(string,char(charknotennummer{j}))
            index=j;
        end
    end
    
    Leitungen(i,1)=index;
    
    string2=gridtopo(i,3);
    string2=string2.nodeB;
    string2=char(string2);
    
    for j=1:AnzK
        if isequal(string2,char(charknotennummer{j}))
            index2=j;
        end
    end
    
    Leitungen(i,2)=index2;
    
    laenge=gridtopo(i,5);
    
    laenge=laenge.length;
    
    Leitungen(i,3)=laenge;
    
    Leitungen(i,4)=Knoten(index,6);
    
    Leitungen(i,5)=1;
    
    string3=gridtopo(i,4);
    string3=string3.type;
    string3=char(string3);
    
    for j=1:AnzLtypes
        if isequal(string3,char(charlinetype{j}))
            index3=j;
        end
    end
    
    Leitungen(i,6)=index3;   
    
    
end

%% Trafomatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Spannung Primärseite in kV
%Spalte 4:  Spannung Sekundärseite in kV
%Spalte 5:  Anzahl der parallelen Trafos
%Spalte 6:  Trafotyp

gridtopotrans=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Transformer.csv');
trafotypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_TransformerType.csv');

[AnzT,~]=size(gridtopotrans);
[AnzTtypes,~]=size(trafotypes);

Trafos=zeros(AnzT,6);

%Auslesen der Trafotypen aus der Tabelle

chartrafotype=cell(AnzTtypes,1);

for i=1:AnzTtypes
    
    chartrafotype{i}={char(trafotypes(i,1).id)};
    
end

%Trafomatrix einlesen

for i=1:AnzT
    
    string4=gridtopotrans(i,2);
    string4=string4.nodeHV;
    string4=char(string4);
    
    for j=1:AnzK
        if isequal(string4,char(charknotennummer{j}))
            index3=j;
        end
    end
    
     Trafos(i,1)=index3;
    
    string5=gridtopotrans(i,3);
    string5=string5.nodeLV;
    string5=char(string5);
    
    for j=1:AnzK
        if isequal(string5,char(charknotennummer{j}))
            index4=j;
        end
    end
    
    Trafos(i,2)=index4;
   
    Trafos(i,3)=Knoten(index3,6);
    Trafos(i,4)=Knoten(index4,6);
    
    Trafos(i,5)=1;
    
    string6=gridtopotrans(i,4);
    string6=string6.type;
    string6=char(string6);
    
    for j=1:AnzTtypes
        if isequal(string6,char(chartrafotype{j}))
            index5=j;
        end
    end
    
    Trafos(i,6)=index5;
    
    
end



%% Admittanz- und Distanzmatrix erstellen
%benutze die Funktion, die die Admittanzmatrix bestimmt

Y=Admittanzmatrix_SimBench(Leitungen,AnzK);

Distanz=zeros(AnzK,AnzK);
for i = 1:AnzL   %Leitungslängen eintragen in app.D
    c1=Leitungen(i,1);
    c2=Leitungen(i,2);
    Distanz(c1,c2)=1/Y(c1,c2);  %elektrische Distanz über die Admittanzmatrix
    Distanz(c2,c1)=1/Y(c2,c1);
end
%0 durch Nan ersetzen, damit nicht vorhandene Leitungsverbindungen nicht
%zur kürzesten Verbindung werden
Distanz(Distanz==0)=NaN;

%% System auf Norddeutschland reduzieren entfällt hier, ansonsten den Teil aus Verfahren_SimBench kopieren und hier einfügen
% %Hier beginnt die eigentliche Netzknotenreduktion
% %erst einmal werden nur die Knoten reduziert
%Die Clustermatrix wird erstellt
%Die Claustermatrix beinhaltet die Zuordnung der Knoten zu Clustern. Jeder
%Knoten behält seine Nummer
cluster=zeros(AnzK,AnzK);
cluster(:,1)=Knoten(:,1);
%In den folgenden Matritzen/String-Array befinden sich die redzierten
%Knoten und Landkreise
clusterKnoten=Knoten;
clusterLandkreis=Landkreis;
%ClusterDistanz wird nur für das Distanzverfahren bentutz und daher erst
%nach dem Schritt mit der Reduktion auf einen Knoten pro Landkreis
%angepasst
clusterDistanz=Distanz;

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
                clusterKnoten(j,:)=zeros(1,9);
                %Cluster i bleibt und Cluster j wird gelöscht
                clusterierstefreiereintrag=find(cluster(i,:)); %Achtung: Index
                clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
                lengthclustereintrag=length(cluster(i,clusterierstefreiereintrag:end));
                cluster(i,clusterierstefreiereintrag:end)=cluster(j,1:lengthclustereintrag);
                %Wichtig: Leistungen aufaddieren.
                clusterKnoten(i,7)=clusterKnoten(i,7)+clusterKnoten(j,7);
                clusterKnoten(i,8)=clusterKnoten(i,8)+clusterKnoten(j,8);
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

AnzCluster=AnzLandkreise;

%% Reduktion auf die Landkreise, die extern vorgegeben werden

load Beispielregionalisierung.mat;

[AnzRegCluster,AnzReg]=size(Regions_Short);

%Leider gibt es Landkreise ohne elektrische Komponenten. Daher werden
%andere Landkreise als Cluster verwendet und in Regneu gespeichert.
Reg=Regions_Short(1,:)';
Regneu=zeros(AnzReg,1);

for laufReg=1:AnzReg
    
    
    indexReg=find(clusterKnoten(:,9)==Reg(laufReg));
    
    laufinReg=1;
    
    while isempty(indexReg)
        
    indexReg=find(clusterKnoten(:,9)==Regions_Short(laufinReg+1,laufReg)); 
 
        
        
        
        laufinReg=laufinReg+1;
    end
    
    Regneu(laufReg)=Regions_Short(laufinReg,laufReg);
    
end



for laufCluster=1:AnzCluster
    
    if isempty(find(Regneu==clusterKnoten(laufCluster,9), 1))
        
        if clusterKnoten(laufCluster,9)==0
            
            c1=find(clusterKnoten(:,9)==Regneu(1));
            
        else
            
            
            [indexReg1,indexReg2]=find(Regions_Short==clusterKnoten(laufCluster,9));
            
            c1=find(clusterKnoten(:,9)==Regneu(indexReg2));
            
        end
        
        
        c2=laufCluster;
        %Wichtig: Leistungen aufaddieren.
        clusterKnoten(c1,7)=clusterKnoten(c1,7)+clusterKnoten(c2,7);
        clusterKnoten(c1,8)=clusterKnoten(c1,8)+clusterKnoten(c2,8);
        %Cluster c1 bleibt und Cluster c2 wird gelöscht
        %Beim Clustern muss die Cluster-Matrix entsprechend zusammengesetzt
        %werden, dass diese sich auch aus mehreren Cluster ergeben kann.
        clusterierstefreiereintrag=find(cluster(c1,:));
        clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
        lengthclustereintrag=length(cluster(c1,clusterierstefreiereintrag:end));
        cluster(c1,clusterierstefreiereintrag:end)=cluster(c2,1:lengthclustereintrag);
        
        %Cluster löschen
        clusterKnoten(c2,:)=zeros(1,9);
        cluster(c2,:)=zeros(1,AnzK);
        clusterLandkreis(c2)='';
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

%Zur Erinnerung der Aufbau der Leitungsmatrix
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in V
%Spalte 5:  Anzahl der Leitungen
%Spalte 6:  Leitungstyp

clusterLeitungen=Leitungen;

clusterTrafos=Trafos;

%Hier werden die Leitungen auf die neuen Cluster gelegt
%Iteration über die Leitungen
for i=1:AnzL
    %iteration über die cluster
    for j=1:AnzCluster
        %Iteration über die geclusterten Knoten
        for jzwei=2:AnzK %Beginn in zweiter Spalte, da hier die geclusterten Knoten stehen
            %Startknoten ändern
            if cluster(j,jzwei)==Leitungen(i,1)
                %Alles bleibt erhalten bis auf den Startknoten
                clusterLeitungen(i,1)=cluster(j,1);
            end
        end
        %erneut iterieren, damit nichts vergessen wird
        for jzwei=2:AnzK
            %Endknoten ändern
            if cluster(j,jzwei)==Leitungen(i,2)
                %Alles bleibt erhalten bis auf den Endknoten
                clusterLeitungen(i,2)=cluster(j,1);
            end
        end
        
    end
end

%Selbiges auch für die Trafos

for i=1:AnzT
    %iteration über die cluster
    for j=1:AnzCluster
        %Iteration über die geclusterten Knoten
        for jzwei=2:AnzK
            %Startknoten ändern
            if cluster(j,jzwei)==Trafos(i,1)
                %Alles bleibt erhalten bis auf den Startknoten
                clusterTrafos(i,1)=cluster(j,1);
            end
        end
        %erneut iterieren, damit nichts vergessen wird
        for jzwei=2:AnzK
            %Endknoten ändern
            if cluster(j,jzwei)==Trafos(i,2)
                %Alles bleibt erhalten bis auf den Endknoten
                clusterTrafos(i,2)=cluster(j,1);
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
                if clusterLeitungen(i,6)>AnzLtypes || clusterLeitungen(j,6)>AnzLtypes %In diesem Fall handelt es sich um einen Trafo
                    if clusterLeitungen(i,6)>AnzLtypes || clusterLeitungen(j,6)>AnzLtypes
                        clusterLeitungen(i,3)=1;
                        clusterLeitungen(i,5)=2;
                        %nun wird die Trafo j gelöscht
                        clusterLeitungen(j,:)=zeros(1,6);
                    end
                else
                    %erst einmal die Änderungen für Leitungen i
                    clusterLeitungen(i,3)=(clusterLeitungen(i,5)*clusterLeitungen(i,3)+clusterLeitungen(j,5)*clusterLeitungen(j,3))/(clusterLeitungen(i,5)+clusterLeitungen(j,5));
                    clusterLeitungen(i,5)=clusterLeitungen(i,5)+clusterLeitungen(j,5);
                    
                    %nun wird die Leitung j gelöscht
                    clusterLeitungen(j,:)=zeros(1,6);
                end
            end
        end
        
        
    end
end

%Auch hier gilt, dass das Verfahren auch für die Trafos durchgeführt werden
%muss

for i=1:AnzT
    aktTrafoverlauf1=[clusterTrafos(i,1),clusterTrafos(i,2)];
    aktTrafoverlauf2=[clusterTrafos(i,2),clusterTrafos(i,1)];
    for j=i+1:AnzT
        
        
        if isequal(clusterTrafos(j,1:2),aktTrafoverlauf1)||isequal(clusterTrafos(j,1:2),aktTrafoverlauf2)
            %Trafo i, bleibt Trafo j wird gelöscht
            %Jetzt ist die Unterscheidung der Spannungsebenen
            %erforderlich
            %Es bleibt pro Umspannart eine Trafoart übrig
            if (clusterTrafos(i,3)==clusterTrafos(j,3)) &&  (clusterTrafos(i,4)==clusterTrafos(j,4))
                %erst einmal die Änderungen für Trafo i
                clusterTrafos(i,5)=clusterTrafos(i,5)+clusterTrafos(j,5);
                %nun wird die Leitung j gelöscht
                clusterTrafos(j,:)=zeros(1,6);
            end
        end        
    end
end


%Jetzt müssen die Leitungen die im Kreis führen gelöscht werden

GeloeschteLeitungen=zeros(AnzL,6);
GeloeschteTrafos=zeros(AnzT,6);

for i=1:AnzL
    if clusterLeitungen(i,1)==clusterLeitungen(i,2)
        %Zwischenspeichern der gelöschten Leitungen
        GeloeschteLeitungen(i,:)=clusterLeitungen(i,:);
        clusterLeitungen(i,:)=zeros(1,6);
    end
end

for i=1:AnzT
    if clusterTrafos(i,1)==clusterTrafos(i,2)
        %Zwischenspeichern der gelöschten Trafos
        GeloeschteTrafos(i,:)=clusterTrafos(i,:);
        clusterTrafos(i,:)=zeros(1,6);
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

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von cluster löschen
loesch=zeros(AnzT,1);
for i=1:AnzT
    if clusterTrafos(i,1)==0
        loesch(i)=1;
    end
end

clusterTrafos(loesch==1,:)=[];

[AnzClusterLeitungen,~]=size(clusterLeitungen);
[AnzClusterTrafos,~]=size(clusterTrafos);

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von GeloeschteLeitungen löschen
loesch=zeros(AnzL,1);
for i=1:AnzL
    if GeloeschteLeitungen(i,1)==0
        loesch(i)=1;
    end
end

GeloeschteLeitungen(loesch==1,:)=[];
[AnzGL,~]=size(GeloeschteLeitungen);

%Auswertung wie viel Leitung in jeder Spannungsebene gelöscht wurde:

Geloeschtekm380=0;
Geloeschtekm380gew=0;
Geloeschtekm220=0;
Geloeschtekm220gew=0;
Geloeschtekm110=0;
Geloeschtekm110gew=0;

for i=1:AnzGL
    if GeloeschteLeitungen(i,4)==380
        Geloeschtekm380=Geloeschtekm380+GeloeschteLeitungen(i,3);
        Geloeschtekm380gew=Geloeschtekm380gew+GeloeschteLeitungen(i,3)/GeloeschteLeitungen(i,5);
        
    elseif GeloeschteLeitungen(i,4)==220
        Geloeschtekm220=Geloeschtekm220+GeloeschteLeitungen(i,3);
        Geloeschtekm220gew=Geloeschtekm220gew+GeloeschteLeitungen(i,3)/GeloeschteLeitungen(i,5);
        
    else
        Geloeschtekm110=Geloeschtekm110+GeloeschteLeitungen(i,3);
        Geloeschtekm110gew=Geloeschtekm110gew+GeloeschteLeitungen(i,3)/GeloeschteLeitungen(i,5);
        
    end
    
end

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von GeloeschteTrafos löschen
loesch=zeros(AnzT,1);
for i=1:AnzT
    if GeloeschteTrafos(i,1)==0
        loesch(i)=1;
    end
end

GeloeschteTrafos(loesch==1,:)=[];
[AnzGT,~]=size(GeloeschteTrafos);

GeloeschteT380220=0;
GeloeschteT380110=0;
GeloeschteT220110=0;

for i=1:AnzGT
    if GeloeschteTrafos(i,3)==380 && GeloeschteTrafos(i,4)==220
        GeloeschteT380220=GeloeschteT380220+GeloeschteTrafos(i,5);

    elseif GeloeschteTrafos(i,3)==380 && GeloeschteTrafos(i,4)==110
        GeloeschteT380110=GeloeschteT380110+GeloeschteTrafos(i,5);
       
    else
        GeloeschteT220110=GeloeschteT220110+GeloeschteTrafos(i,5);
        
    end
    
end


%Hier muss nun noch einmal alles neu nummeriert werden, damit die Knoten
%dieselben Nummern haben wie die Landkreise von Oli/der externen Vorgabe

clusterKnotenSuperstructure=clusterKnoten;

clusterKnotenSuperstructure(:,9)=[];

for i=1:AnzCluster
    
    clusterKnotenSuperstructure(i,1)=Reg(Regneu==clusterKnoten(i,9));
    
    
end


clusterLeitungenSuperstructure=clusterLeitungen;

for i=1:AnzClusterLeitungen
    index1=find(clusterKnoten(:,1)==clusterLeitungenSuperstructure(i,1));
    index2=find(clusterKnoten(:,1)==clusterLeitungenSuperstructure(i,2));
    clusterLeitungenSuperstructure(i,1)=clusterKnotenSuperstructure(index1,1);
    clusterLeitungenSuperstructure(i,2)=clusterKnotenSuperstructure(index2,1);
    
end

clusterTrafosSuperstructure=clusterTrafos;

for i=1:AnzClusterTrafos
    index1=find(clusterKnoten(:,1)==clusterTrafosSuperstructure(i,1));
    index2=find(clusterKnoten(:,1)==clusterTrafosSuperstructure(i,2));
    clusterTrafosSuperstructure(i,1)=clusterKnotenSuperstructure(index1,1);
    clusterTrafosSuperstructure(i,2)=clusterKnotenSuperstructure(index2,1);
    
end


