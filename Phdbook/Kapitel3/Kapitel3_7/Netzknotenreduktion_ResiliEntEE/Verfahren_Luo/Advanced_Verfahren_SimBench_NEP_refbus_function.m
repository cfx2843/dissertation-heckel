function [clusterKnoten,clusterLeitungen,erelp,erelq,Parslack,Qarslack,slacknumber] = Advanced_Verfahren_SimBench_NEP_refbus_function(zielAnz)

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5:  Norddeutsch
%Spalte 6:  Spannungsebene
%Spatle 7:  Knoten-Wirkleistung
%Spalte 8:  Knoten-Blindleistung

%Art des Knotens: 1 Lastknoten 2 Generatorknoten 3 Referenzknoten

nodes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Node.csv');

coordinatedata=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Coordinates.csv');

[AnzCoord,~]=size(coordinatedata);

charcoord=cell(AnzCoord,1);

for i=1:AnzCoord
    
    charcoord{i}={char(coordinatedata(i,1).id)};
    
end


[AnzK,~]=size(nodes);

Knoten=zeros(AnzK,6);

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
%Spalte 6:  Leitungstyp oder Trafotyp

gridtopo=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Line.csv');
linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');
gridtopotrans=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_Transformer.csv');
% trafotypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_TransformerType.csv');

[AnzL,~]=size(gridtopo);

[AnzT,~]=size(gridtopotrans);

AnzLT=AnzL+AnzT;

%Kombinierte Tabelle für Leitungen und Trafos

Leitungen=zeros(AnzL,6);

%Auslesen der Knotennummer im Namen

charknotennummer=cell(AnzK,1);

for i=1:AnzK
    
    charknotennummer{i}={char(nodes(i,1).id)};
    
end

[AnzLtypes,~]=size(linetypes);

%Auslesen der Leitungstypen aus der Tabelle

charlinetype=cell(AnzLtypes,1);

for i=1:AnzLtypes
    
    charlinetype{i}={char(linetypes(i,1).id)};
    
end

%Auslesen der Trafotypen aus der Tabelle

% [AnzTtypes,~]=size(trafotypes);
%
%
% chartrafotype=cell(AnzTtypes,1);
%
% for i=1:AnzTtypes
%
% chartrafotype{i}={char(trafotypes(i,1).id)};
%
% end

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

% %Leitungsmatrix mit den Informationen für die Trafos füllen
%
% for i=1:AnzT
%    string4=gridtopotrans(i,2);
%    string4=string4.nodeHV;
%    string4=char(string4);
%
%    for j=1:AnzK
%       if isequal(string4,char(charknotennummer{j}))
%           index3=j;
%       end
%    end
%
%    Leitungen(i+AnzL,1)=index3;
%
%    string5=gridtopotrans(i,3);
%    string5=string5.nodeLV;
%    string5=char(string5);
%
%    for j=1:AnzK
%       if isequal(string5,char(charknotennummer{j}))
%           index4=j;
%       end
%    end
%
%    Leitungen(i+AnzL,2)=index4;
%
%    Leitungen(i+AnzL,3)=1;
%
%    Leitungen(i+AnzL,4)=Knoten(index3,6);
%
%    Leitungen(i+AnzL,5)=1;
%
%    string5=gridtopotrans(i,4);
%    string5=string5.type;
%    string5=char(string5);
%
%    for j=1:AnzTtypes
%       if isequal(string5,char(chartrafotype{j}))
%           index5=j;
%       end
%    end
%
%    Leitungen(i+AnzL,6)=index5+AnzLtypes;
%
%
%
%
% end


%Knoten mit mehreren Spannungsebenen zusammenfassen

for i=1:AnzT
    
    string4=gridtopotrans(i,2);
    string4=string4.nodeHV;
    string4=char(string4);
    
    for j=1:AnzK
        if isequal(string4,char(charknotennummer{j}))
            index3=j;
        end
    end
    
    
    string5=gridtopotrans(i,3);
    string5=string5.nodeLV;
    string5=char(string5);
    
    for j=1:AnzK
        if isequal(string5,char(charknotennummer{j}))
            index4=j;
        end
    end
    
    %Knoten mit index3 bleibt, Knoten mit index 4 wird gelöscht
    
    for j=1:AnzL
        
        if Leitungen(j,1)==index4
            
            Leitungen(j,1)=index3;
            
        end
        if Leitungen(j,2)==index4
            
            Leitungen(j,2)=index3;
            
        end
        
    end
    
    Knoten(index4,:)=zeros(1,8);
    
end

%leere Einträge von Knoten löschen
loesch=zeros(AnzK,1);
for i=1:AnzK
    if Knoten(i,1)==0
        loesch(i)=1;
    end
end

Knoten(loesch==1,:)=[];
Landkreis(loesch==1,:)=[];

[AnzK,~]=size(Knoten);

Knotenneuenum=Knoten;
Leitungenneuenum=Leitungen;

Knotenneuenum(:,1)=1:AnzK;

for i=1:AnzL
    index1=find(Knoten(:,1)==Leitungenneuenum(i,1));
    index2=find(Knoten(:,1)==Leitungenneuenum(i,2));
    Leitungenneuenum(i,1)=Knotenneuenum(index1,1);
    Leitungenneuenum(i,2)=Knotenneuenum(index2,1);
    
end

Knoten=Knotenneuenum;
Leitungen=Leitungenneuenum;

%%
%Hier entweder den Datensatz inklusive NEP laden (dann bitte den Teil
%davor auskommentieren
%Alternativ: Hier den Teil einfügen, der die SimBench-Daten um die
%entsprechenden NEP-Daten ergänzt

[NEP25,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\NEP2025_Daten.xls','Tabelle1');
% Die NEP datei muss vollständig sein hinsichtlich start und Endpunkt,
% sonst kommt es zu einem error
% Wenn weder Neubau noch Ausbau eingesetzt werden, dann wird die Zeile
% nicht berücksichtigt

[AnzNEP,~]=size(NEP25);


Leitungenerweitert=Leitungen;

%Entscheidung ob Leitung geupgradet oder neueingebau wird
%Im ersten Teil werden Neubauten hinzugefügt

for i=1:1:AnzNEP
    if NEP25(i,5)==1
        Leitungentemp=[Leitungenerweitert;0 0 0 0 0 0];
        [AnzTemp,~]=size(Leitungentemp);
        Leitungentemp(AnzTemp,1)= NEP25(i,7);
        Leitungentemp(AnzTemp,2)= NEP25(i,8);
        Leitungentemp(AnzTemp,3)= NEP25(i,4);
        Leitungentemp(AnzTemp,4)= 380;
        Leitungentemp(AnzTemp,5)= 1 ;
        Leitungentemp(AnzTemp,6)= 9 ;
        Leitungenerweitert=Leitungentemp;
        
        %Wahl der Leitungsart fraglich? erst mal 9 genommen
        %5. zeile ist der parallelitätsfaktor
        %es wird im fall neubau eine variable eingeführt um eine
        %zusätzliche Zeile einzufügen und dann die entsprechden Werte in
        %die neue Zeile zu schreiben
        
    elseif NEP25(i,5)==2
       %im Ausbaufall muss geprüft werden ob in den Simbenchdaten die
       %Leitung bereits vorhanden ist, der counter dient dazu 
        aktLeitungsverlauf1=[NEP25(i,7),NEP25(i,8)];
        aktLeitungsverlauf2=[NEP25(i,8),NEP25(i,7)];
        counter=0;
        for j=1:AnzL
            if isequal(Leitungen(j,1:2),aktLeitungsverlauf1)||isequal(Leitungen(j,1:2),aktLeitungsverlauf2)
                
                Leitungenerweitert(j,5)=  Leitungenerweitert(j,5)+1;
                Leitungenerweitert(j,4)=380;
                % Annahme: beim Ausbau werden niedrigere Spannungsebenen
                % automatisch auf 380kV ausgebaut
                counter=counter+1;
                
            end
        end
        if counter==0 
            Leitungentemp=[Leitungenerweitert;0 0 0 0 0 0];
            [AnzTemp,~]=size(Leitungentemp);
            Leitungentemp(AnzTemp,1)= NEP25(i,7);
            Leitungentemp(AnzTemp,2)= NEP25(i,8);
            Leitungentemp(AnzTemp,3)= NEP25(i,4);
            Leitungentemp(AnzTemp,4)= 380;
            Leitungentemp(AnzTemp,5)= 1 ;
            Leitungentemp(AnzTemp,6)= 9 ;
            Leitungenerweitert=Leitungentemp;
        end
      % für den Fall,dass die Leitung in den Simbench daten nicht vorhanden
      % ist wird diese neu hinzugefügt mit dem gleichen code wie im ersten
      % teil
        
        
        
    end
end



Leitungen=Leitungenerweitert;

%%Es muss ausgeschlossen werden, dass eine Leitung zum Ausgangspunkt
%%zurückführt, was der golgende Abschnitt verhindern soll aber nicht
%%hinbekommt aus derzeit unbekannten grund
%Jetzt müssen die Leitungen die im Kreis führen gelöscht werden
[AnzL,~]=size(Leitungen);

for i=1:AnzL
    if Leitungen(i,1)==Leitungen(i,2)
        Leitungen(i,:)=zeros(1,6);
            end
end

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von Leitungen löschen
loesch=zeros(AnzL,1);
for i=1:AnzL
    if Leitungen(i,1)==0
        loesch(i)=1;
    end
end

Leitungen(loesch==1,:)=[];


[AnzL,~]=size(Leitungen);


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
%0 durch Nan ersetzen
Distanz(Distanz==0)=NaN;

%% LFR für Validierung

[~,~,Ua,dta] = ConverttoPSTLFNR_SimBench(Leitungen,Knoten,AnzL,AnzK);

% Leitungsparameter bestimmen

ue=380/220; %Übertragerverhältnis
ue2=380/110;

SLeitung=zeros(AnzL,1);

for i=1:AnzL
    
    linetypenum=Leitungen(i,6);
    
    R=linetypes(linetypenum,2);
    R=R.r;
    R=R*Leitungen(i,3);
    
    X=linetypes(linetypenum,3);
    X=X.x;
    X=X*Leitungen(i,3);
    
%     B=linetypes(linetypenum,4);
%     B=B.b*10^-6;
%     B=B*Leitungen(i,3);
%     
    if Leitungen(i,4)==220
        R=R*ue^2;
        X=X*ue^2;
%         B=B/ue^2;
    elseif Leitungen(i,4)==110
        R=R*ue2^2;
        X=X*ue2^2;
%         B=B/ue2^2;
        
    end
    
    yij = (inv(R+1i*X))*Leitungen(i,5);
    SLeitung(i)=(abs((Ua(Leitungen(i,1))*380000.*exp(1i*dta(Leitungen(i,1))))-(Ua(Leitungen(i,2))*380000.*exp(1i*dta(Leitungen(i,2)))))^2)*conj(yij);
    
end

%% System auf Norddeutschland reduzieren
% %Hier beginnt die eigentliche Netzknotenreduktion
% %erst einmal werden nur die Knoten reduziert
%Die Clustermatrix wird erstellt
%Die Claustermatrix beinhaltet die Zuordnung der Knoten zu Clustern. Jeder
%Knoten behält seine Nummer
% cluster=zeros(AnzK,AnzK);
% cluster(:,1)=Knoten(:,1);
%In den folgenden Matritzen/String-Array befinden sich die redzierten
%Knoten und Landkreise
% clusterKnoten=Knoten;
%clusterLandkreis=strings(AnzK,1);
%ClusterDistanz wird nur für das Distanzverfahren bentutz und daher erst
%nach dem Schritt mit der Reduktion auf einen Knoten pro Landkreis
%angepasst
% clusterDistanz=Distanz;

%% Weitere Reduktion mit der elektrischen Distanz
%Zielanzahl an Knoten:
% zielAnzvec=210:5:600;
% erelp=zeros(length(zielAnzvec),1);
% erelq=zeros(length(zielAnzvec),1);
% zaehlplot=1;

%Die Clustermatrix wird erstellt
%Die Claustermatrix beinhaltet die Zuordnung der Knoten zu Clustern. Jeder
%Knoten behält seine Nummer
cluster=zeros(AnzK,AnzK);
cluster(:,1)=Knoten(:,1);
%In den folgenden Matritzen/String-Array befinden sich die redzierten
%Knoten und Landkreise
clusterKnoten=Knoten;
%clusterLandkreis=strings(AnzK,1);
%ClusterDistanz wird nur für das Distanzverfahren bentutz und daher erst
%nach dem Schritt mit der Reduktion auf einen Knoten pro Landkreis
%angepasst
clusterDistanz=Distanz;


AnzKinreduc=AnzK;
if zielAnz<AnzK
    while AnzKinreduc>zielAnz
        % Dichteste Knoten finden
        minD = min(abs(clusterDistanz),[],'all');
        [c1,c2] = find(minD == abs(clusterDistanz));
        c1=c1(1); %Achtung: Index
        c2=c2(1); %Achtung: Index
        %Falls der zu löschende Knoten ein Generatorknoten ist, soll
        %der andere Knoten gelöscht werden
        c1old=c1;
        c2old=c2;
        if clusterKnoten(c2,2)==2
            c2=c1old;
            c1=c2old;
        end
        zaehladvanced=0;
        while (clusterKnoten(c2,2)==2 || clusterKnoten(c1,2)==2) && zaehladvanced<AnzK && AnzKinreduc>210
            clusterDistanztri=clusterDistanz(:);
            sortclusterDistanztri=sort(abs(clusterDistanztri));
            [c1,c2] = find(sortclusterDistanztri(3+zaehladvanced*2) == abs(clusterDistanz));
            c1=c1(1); %Achtung: Index
            c2=c2(1); %Achtung: Index
            zaehladvanced=zaehladvanced+1;
        end
        %Index passt, da immer die gleichen Zeilen gelöscht wurden
        %Cluster bilden, indem c2 gelöscht wird
        %Wichtig: Leistungen aufaddieren.
        clusterKnoten(c1,7)=clusterKnoten(c1,7)+clusterKnoten(c2,7);
        clusterKnoten(c1,8)=clusterKnoten(c1,8)+clusterKnoten(c2,8);
        clusterKnoten(c2,:)=zeros(1,8);
        %Cluster c1 bleibt und Cluster c2 wird gelöscht
        clusterierstefreiereintrag=find(cluster(c1,:));
        clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
        lengthclustereintrag=length(cluster(c1,clusterierstefreiereintrag:end));
        cluster(c1,clusterierstefreiereintrag:end)=cluster(c2,1:lengthclustereintrag);
        %Cluster löschen
        cluster(c2,:)=zeros(1,AnzK);
        AnzKinreduc=AnzKinreduc-1;
        
        
        for i=1:AnzK
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
        
        
        clusterDistanz(c2,:)=NaN(1,AnzK);
        clusterDistanz(:,c2)=NaN(AnzK,1);
        
        
        
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
% clusterLandkreis(loesch==1)=[];
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
SLeitungencluster=SLeitung;

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
            if clusterLeitungen(i,6)==clusterLeitungen(j,6)
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
                    SLeitungencluster(i)=SLeitungencluster(i)+SLeitungencluster(j);
                    %nun wird die Leitung j gelöscht
                    clusterLeitungen(j,:)=zeros(1,6);
                    SLeitungencluster(j)=0;
                end
            end
        end
        
        
    end
end

%Jetzt müssen die Leitungen die im Kreis führen gelöscht werden

for i=1:AnzL
    if clusterLeitungen(i,1)==clusterLeitungen(i,2)
        clusterLeitungen(i,:)=zeros(1,6);
        SLeitungencluster(i)=0;
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
SLeitungencluster(loesch==1)=[];

[AnzClusterLeitungen,~]=size(clusterLeitungen);

%% Validierung

%Die Validierung muss nun auch über eine LFR erfolgen

%Es wurden wahrscheinlich auch die Erzeugungsknoten entfernt
%Falls dies der Fall ist, wird der erste Knoten zum Generator und damit
%auch Referenzknoten

hasgenerator=0;

for i=1:AnzCluster
    if clusterKnoten(i,2)==2
        hasgenerator=1;
    end
end

if hasgenerator==0
    clusterKnoten(1,2)=2;
end


[~,~,Uar,dtar,~,Parslack,Qarslack,slacknumber] = ConverttoPSTLFNR_SimBench(clusterLeitungen,clusterKnoten,AnzClusterLeitungen,AnzCluster);


SLeitungr=zeros(AnzClusterLeitungen,1);


for i=1:AnzClusterLeitungen
    
    linetypenum=clusterLeitungen(i,6);
    
    R=linetypes(linetypenum,2);
    R=R.r;
    R=R*clusterLeitungen(i,3);
    
    X=linetypes(linetypenum,3);
    X=X.x;
    X=X*clusterLeitungen(i,3);
    
%     B=linetypes(linetypenum,4);
%     B=B.b*10^-6;
%     B=B*clusterLeitungen(i,3);
    
    if clusterLeitungen(i,4)==220
        R=R*ue^2;
        X=X*ue^2;
%         B=B/ue^2;
    elseif clusterLeitungen(i,4)==110
        R=R*ue2^2;
        X=X*ue2^2;
%         B=B/ue2^2;
        
    end
    
    yij = (inv(R+1i*X))*clusterLeitungen(i,5);
    SLeitungr(i)=(abs((Uar(clusterKnoten(:,1)==clusterLeitungen(i,1))*380000.*exp(1i*dtar(clusterKnoten(:,1)==clusterLeitungen(i,1))))-(Uar(clusterKnoten(:,1)==clusterLeitungen(i,2))*380000.*exp(1i*dtar(clusterKnoten(:,1)==clusterLeitungen(i,2)))))^2)*conj(yij);
    
end

%Jetzt müssen die Ergebnisse der ursprünglichen LFR reduziert werden nach
%dem Konzept aus der Arbeit

Pf=abs(real(SLeitungencluster)-real(SLeitungr));

Qf=abs(imag(SLeitungencluster)-imag(SLeitungr));

ep = norm(Pf,'fro');
eq = norm(Qf,'fro');

erelp=ep/(norm(SLeitungencluster,'fro'));
erelq=eq/(norm(SLeitungencluster,'fro'));






end

