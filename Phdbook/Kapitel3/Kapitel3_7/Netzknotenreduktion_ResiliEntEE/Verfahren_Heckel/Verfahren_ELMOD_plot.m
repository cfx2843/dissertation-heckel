clear all
%% Leitungsmatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungsl�nge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen

%erste Tabelle �ffnen zum Auslesen der Netztopologie
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

%zweite Tabelle �ffnen zum Auslesen von Leitungsdaten
[gridtechnical,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_ELMOD','Grid_technical');

%Die L�nge steht in der sechsten Spalte
Leitungen(:,3)=gridtechnical(:,6);
%Die Spannungsebene steht in der vierten Spalte
Leitungen(:,4)=gridtechnical(:,4);
%Die Anzahl der parallelen Leitungen steht in der f�nften Spalte
Leitungen(:,5)=gridtechnical(:,5);

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  L�ngengrad
%Spalte 4:  Breitengrad
%Spalte 5: Norddeutsch

Knoten=zeros(AnzK,5);

%dritte Tabelle �ffnen zum Auslesen der Knotendaten
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

%L�gen und Breitengrad eintragen
Knoten(:,3)=node_data_num(:,11);
Knoten(:,4)=node_data_num(:,12);


% Zugeh�rigkeit zu Nordeutschland finden
for i=3:AnzK+2              %Sollte ein Knoten in den L�ndern: Schleswig-Holstein, Bremen, Hamburg, Mecklenburg-Vorpommern oder Niedersachen liegen, wird er zu Nordeutschland gez�hlt
    if node_data_txt(i,3)=="DE_HB"||node_data_txt(i,3)=="DE_HH"||node_data_txt(i,3)=="DE_MV"||node_data_txt(i,3)=="DE_NI"...
            ||node_data_txt(i,3)=="DE_SH"
        Knoten(i-2,5) = 1;
    end
end


%Landkreis bestimmen. Dieser wird in eine eigenes Array eingetragen.

load('Map.mat');
%Landkreis ist ein String-Array
Landkreis=strings(AnzK,1);

%�u�ere for-Schleife iteriert �ber die Leitungen
for i=1:AnzK
    
    posx=Knoten(i,4);
    posy=Knoten(i,3);
    
    %innere for-Schleife iteriert �ber die Map
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
for i = 1:AnzL   %Leitungsl�ngen eintragen in app.D
    c1=Leitungen(i,1);
    c2=Leitungen(i,2);
    Distanz(c1,c2)=Leitungen(i,3)/Y(c1,c2);  %elektrische Distanz �ber die Admittanzmatrix
    Distanz(c2,c1)=Leitungen(i,3)/Y(c1,c2);
end
%0 durch Nan ersetzen
Distanz(Distanz==0)=NaN;

%% Weitere Reduktion mit der elektrischen Distanz
%Zielanzahl an Knoten:
zielAnzvec=10:5:440;
erel=zeros(length(zielAnzvec),1);
zaehlplot=1;
for zielAnz=10:5:440
    %Die Clustermatrix wird erstellt
    %Die Claustermatrix beinhaltet die Zuordnung der Knoten zu Clustern. Jeder
    %Knoten beh�lt seine Nummer
    cluster=zeros(AnzK,AnzK);
    cluster(:,1)=Knoten(:,1);
    %In den folgenden Matritzen/String-Array befinden sich die redzierten
    %Knoten und Landkreise
    clusterKnoten=Knoten;
    %clusterLandkreis=strings(AnzK,1);
    %ClusterDistanz wird nur f�r das Distanzverfahren bentutz und daher erst
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
            %Index passt, da immer die gleichen Zeilen gel�scht wurden
            % Cluster bilden, indem c2 gel�scht wird
            %clusterLandkreis(c2)="";
            clusterKnoten(c2,:)=zeros(1,5);
            %Cluster c1 bleibt und Cluster c2 wird gel�scht
            clusterierstefreiereintrag=find(cluster(c1,:));
            clusterierstefreiereintrag=clusterierstefreiereintrag(end)+1;
            lengthclustereintrag=length(cluster(c1,clusterierstefreiereintrag:end));
            cluster(c1,clusterierstefreiereintrag:end)=cluster(c2,1:lengthclustereintrag);
            %Cluster l�schen
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
    
    
    
    %leere Eintr�ge von cluster l�schen
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
    % erst jetzt werden auch die Leitungen ver�ndert
    % In ELMOD-DE liegen keine nutzbaren Daten f�r eine Lastflussrechnung vor,
    % daher wird das Verfahren mit dem Zusammenfassen der Leitungen vereinfacht
    % durchgef�hrt
    
    %Zur Erinnerung der Aufbau der Leitungsmatrix
    %Spalte 1:  Startknoten
    %Spalte 2:  Endknoten
    %Spalte 3:  Leitungsl�nge [km]
    %Spalte 4:  Spannungsebene in V
    %Spalte 5:  Anzahl der Leitungen
    
    clusterLeitungen=Leitungen;
    
    %Hier werden die Leitungen auf die neuen Cluster gelegt
    %Iteration �ber die Leitungen
    for i=1:AnzL
        %iteration �ber die cluster
        for j=1:AnzCluster
            %Iteration �ber die geclusterten Knoten
            for jzwei=2:AnzK
                %Startknoten �ndern
                if cluster(j,jzwei)==Leitungen(i,1)
                    %Alles bleibt erhalten bis auf den Startknoten
                    clusterLeitungen(i,1)=cluster(j,1);
                end
            end
            %erneut iterieren, damit nichts vergessen wird
            for jzwei=2:AnzK
                %Endtknoten �ndern
                if cluster(j,jzwei)==Leitungen(i,2)
                    %Alles bleibt erhalten bis auf den Endknoten
                    clusterLeitungen(i,2)=cluster(j,1);
                end
            end
            
        end
    end
    
    
    %Jetzt m�sssen parallele Leitungen zusammengefasst werden
    %ab sofort wird nur noch mit clusterLeitungen gearbeitet
    
    for i=1:AnzL
        aktLeitungsverlauf1=[clusterLeitungen(i,1),clusterLeitungen(i,2)];
        aktLeitungsverlauf2=[clusterLeitungen(i,2),clusterLeitungen(i,1)];
        for j=i+1:AnzL
            if isequal(clusterLeitungen(j,1:2),aktLeitungsverlauf1)||isequal(clusterLeitungen(j,1:2),aktLeitungsverlauf2)
                %Leitung i, bleibt Leitung j wird gel�scht
                %Jetzt ist die Unterscheidung der Spannungsebenen
                %erforderlich
                %Es sollen die Spannungsebenen erhalten bleiben, damit
                %Trafos im fertigen Modell verwendet werden k�nnen
                if clusterLeitungen(i,4)==clusterLeitungen(j,4)
                    %erst einmal die �nderungen f�r Leitungen i
                    clusterLeitungen(i,3)=(clusterLeitungen(i,5)*clusterLeitungen(i,3)+clusterLeitungen(j,5)*clusterLeitungen(j,3))/(clusterLeitungen(i,5)+clusterLeitungen(j,5));
                    clusterLeitungen(i,5)=clusterLeitungen(i,5)+clusterLeitungen(j,5);
                    %nun wird die Leitung j gel�scht
                    clusterLeitungen(j,:)=zeros(1,5);
                end
            end
        end
    end
    
    %Jetzt m�ssen die Leitungen die im Kreis f�hren gel�scht werden
    
    for i=1:AnzL
        if clusterLeitungen(i,1)==clusterLeitungen(i,2)
            clusterLeitungen(i,:)=zeros(1,5);
        end
    end
    
    %Jetzt folgt das L�schen der leeren Zeilen
    %leere Eintr�ge von cluster l�schen
    loesch=zeros(AnzL,1);
    for i=1:AnzL
        if clusterLeitungen(i,1)==0
            loesch(i)=1;
        end
    end
    
    clusterLeitungen(loesch==1,:)=[];
    
    [AnzClusterLeitungen,~]=size(clusterLeitungen);
    
    %% Validierung
    
    %es wird noch eine Nummierung f�r die Erstellung der Admittanzmatrix
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
    
    erel(zaehlplot)=e/(norm(Y,'fro'));
    
    zaehlplot=zaehlplot+1;
end

hold on;
plot(zielAnzvec,erel,'r');
ylabel('Relative Error','FontSize',20);
xlabel('Number of Busses','FontSize',20);
set(gca,'Fontsize',14);
legend('SciGrid','ELMOD-DE')
grid on;