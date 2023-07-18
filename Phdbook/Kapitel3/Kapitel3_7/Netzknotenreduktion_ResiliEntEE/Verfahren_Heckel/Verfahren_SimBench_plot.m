clear all

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5:  Norddeutsch
%Spalte 6:  Spannungsebene

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
   
   Knoten(index4,:)=zeros(1,6);
    
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
% 
%% System auf Norddeutschland reduzieren
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
%clusterLandkreis=strings(AnzK,1);
%ClusterDistanz wird nur für das Distanzverfahren bentutz und daher erst
%nach dem Schritt mit der Reduktion auf einen Knoten pro Landkreis
%angepasst
clusterDistanz=Distanz;

%% Weitere Reduktion mit der elektrischen Distanz
%Zielanzahl an Knoten:
zielAnzvec=40:5:600;
erel=zeros(length(zielAnzvec),1);
zaehlplot=1;
for zielAnz=40:5:600
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
            %Index passt, da immer die gleichen Zeilen gelöscht wurden
            % Cluster bilden, indem c2 gelöscht wird
            %clusterLandkreis(c2)="";
            clusterKnoten(c2,:)=zeros(1,6);
            %Cluster c1 bleibt und Cluster c2 wird gelöscht
            clusterierstefreiereintrag=find(cluster(c1,:));
            clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
            lengthclustereintrag=length(cluster(c1,clusterierstefreiereintrag:end));
            cluster(c1,clusterierstefreiereintrag:end)=cluster(c2,1:lengthclustereintrag);
            %Cluster löschen
            cluster(c2,:)=zeros(1,AnzK);
            AnzKinreduc=AnzKinreduc-1
            
            
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
    
    %Jetzt müssen die Leitungen die im Kreis führen gelöscht werden
    
    for i=1:AnzL
        if clusterLeitungen(i,1)==clusterLeitungen(i,2)
            clusterLeitungen(i,:)=zeros(1,6);
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
    
    Ycluster=Admittanzmatrix_SimBench(clusterLeitungenneuenum,AnzCluster);
    
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
    
    erel(zaehlplot)=e/(norm(Y,'fro'));
    
    zaehlplot=zaehlplot+1;
end

hold on;
set(0,'DefaultAxesFontName','Arial'); 
plot(zielAnzvec,erel,'b');
ylabel('Relative Error','FontSize',20);
xlabel('Number of Busses','FontSize',20);
set(gca,'Fontsize',14);
grid on;
hold off;
