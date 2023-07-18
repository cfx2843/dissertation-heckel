clear all
%% Leitungsmatrix erstellen
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen

Leitungen=[1    2   57.1    380     2; %SH und HH
           3    1   31      380     2;
           4    3   29.4    380     2;
           3    5   28.4    380     2;
           6    7   40      380     2;
           8    9   8.1     380     2;
           2    10  5.33    380     2;
           10   9   9.65    380     1;
           7    11  22.76   380     2;
           9    6   50.9    380     2;
           6    12  63.19   220     2;
           6    1   62.6    220     2;
           6    13  24.6    220     1;
           8    14  21.87   220     1;
           2    14  18.25   220     1;
           12   11  35.35   220     2;
           1    8   49.12   220     1;
           1    14  51.81   220     1;
           1    15  48.78   220     2;
           16   1   19.29   220     1;
           6    17  45.37   220     1;
           13   18  28.15   110     2;
           13   19  28.34   110     2;
           13   20  32.44   110     2;
           18   12  47.69   110     2;
           12   21  33.72   110     2;
           12   22  45.29   110     2;
           22   23  35.65   110     2;
           23   14  44.85   110     2;
           14   24  38.12   110     2;
           24   25  15.9    110     2;
           25   26  30.39   110     2;
           26   15  23.53   110     2;
           15   20  56.17   110     2;
           15   27  28.9    110     2;
           4    28  5.67    110     7;
           28   29  5.39    110     5;
           29   30  7.36    110     2;
           29   31  12.1    110     2;
           31   3   6.79    110     2;
           3    32  12.65   110     2;
           1    33  22      110     2;
           1    34  12.54   110     4;
           33   30  5.84    110     2;
           32   1   14.05   110     2;
           5    35  87.5    380     1; %MVP
           5    36  111.4   380     1;
           35   37  71.6    380     1;
           36   37  47.1    380     1;
           38   39  52.1    380     1;
           39   40  94      380     1;
           38   41  56.2    380     2;
           41   37  93.6    380     1;
           41   42  100     380     1;
           37   42  100.3   380     1;
           39   43  200     380     1;
           44   37  35.6    380     1;
           45   46  29.5    220     1;
           47   46  61.9    220     1;
           46   37  151.1   220     2;
           48   37  52.3    220     1;
           49   37  194.5   220     1;
           48   49  142.3   220     1;
           44   37  35.6    220     1;
           50   44  55.9    110     2;
           50   51  33      110     2;
           51   52  29.2    110     2;
           51   48  40.1    110     2;
           44   53  73.2    110     2;
           44   37  43.5    110     2;
           54   46  53.4    110     2;
           46   41  77.6    110     2;
           41   53  51.4    110     2;
           53   55  34      110     2;
           55   38  17.2    110     2;
           51   37  58.7    110     2;
           54   37  80      110     2;
           56   57  47      380     1; %NDS und HB
           56   58  70      380     1;
           56   59  61      380     1;
           56   60  75      380     1;
           61   60  78      380     1;
           4    63  28.5    380     2;
           64   65  53.79   380     1;
           66   67  57.22   380     2;
           67   68  5.22    380     2;
           67   69  26.93   380     2;
           68   57  12.92   380     2;
           63   9   57.14   380     2;
           70   71  32.34   380     1;
           72   73  15.07   380     1;
           65   74  28.94   380     1;
           65   75  57.35   380     1;
           76   62  26.12   380     1;
           62   49  48.59   380     2;
           77   65  78.83   380     1;
           61   65  72.42   380     2;
           61   78  25.68   380     1;
           61   79  79.11   380     1;
           80   5   28.02   380     2;
           71   63  32.34   380     2;
           73   71  92      380     1;
           78   79  104.92  380     1;
           79   63  52.59   380     2;
           81   80  25.43   380     1;
           82   66  31.54   380     1;
           82   70  35.08   380     1;
           82   72  55.42   380     1;
           83   64  33.41   380     1;
           83   76  36.12   380     1;
           83   62  62.25   380     1;
           83   77  9.2     380     1;
           83   81  85.7    380     2;
           66   84  55.49   220     2;
           66   85  33.06   220     2;
           86   66  57.01   220     2;
           87   88  13.31   220     1;
           61   89  43.24   220     2;
           61   79  42.59   220     2;
           90   87  48.61   220     1;
           90   88  60.95   220     1;
           90   61  74.35   220     1;
           90   91  14.7    220     2;
           90   83  62.42   220     1;
           91   92  30.6    220     2;
           93   88  32.41   220     2;
           79   94  39.17   220     1;
           79   82  26.16   220     1;
           95   94  6.91    220     1;
           95   63  18.96   220     1;
           95   16  23.95   220     1;
           83   92  15.96   220     1;
           83   96  10.56   220     2;
           86   97  23.54   110     3;
           86   98  24.86   110     2;
           97   99  46.42   110     4;
           99   100 44      110     2;
           99   101 48.16   110     4;
           98   84  63.67   110     2;
           98   102 87.53   110     2;
           101  84  37.95   110     3;
           84   103 26.37   110     2;
           103  104 31.47   110     2;
           104  105 29.65   110     2;
           105  106 57.56   110     2;
           106  107 47.47   110     2;
           105  108 13.33   110     2;
           108  109 60.53   110     2;
           109  110 40.21   110     2;
           110  95  66.28   110     2;
           95   111 27.64   110     2;
           95   112 21.73   110     2;
           111  113 45.85   110     2;
           112  80  59.08   110     2;
           80   114 53.58   110     2;
           80   115 52.43   110     2;
           80   116 36.41   110     2;
           113  115 53.37   110     2;
           116  117 55      110     2;
           117  89  40.26   110     2;
           113  118 57.04   110     2;
           118  89  50.92   110     2;
           89   119 43.14   110     2;
           89   120 31.44   110     2;
           120  121 40.92   110     2;
           121  88  35.52   110     2;
           122  96  27.18   110     3;
           122  62  29.5    110     3;
           96   123 12.46   110     3;
           62   123 36.01   110     3;
           123  124 9.47    110     3;
           124  125 30.94   110     2;
           90   89  18.37   110     2;
           ];

       [AnzL,~]=size(Leitungen);

%% Knoten importieren
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5: Norddeutsch

%Art des Knotens: 1 Lastknoten 2 Generatorknoten

Knoten=[1   1   0   0   1; %Hamburg
        2   1   0   0   1; %Brunsbüttel
        3   1   0   0   1; %Hamburg-Ost
        4   1   0   0   1; %Hamburg-Süd
        5   1   0   0   1; %Krümmel
        6   1   0   0   1; %Audorf
        7   1   0   0   1; %Jardelund
        8   2   0   0   1; %Brokdorf
        9   1   0   0   1; %Wilster
        10  1   0   0   1; %Büttel
        11  1   0   0   0; %Dänemark
        12  1   0   0   1; %Flensburg
        13  1   0   0   1; %Kiel-West
        14  1   0   0   1; %Itzehoe
        15  1   0   0   1; %Lübeck
        16  1   0   0   1; %Kummerfeld
        17  2   0   0   1; %Kiel Kraftwerk
        18  1   0   0   1; %Eckernförde
        19  1   0   0   1; %Plön
        20  1   0   0   1; %Neumünster
        21  1   0   0   1; %Schleswig
        22  1   0   0   1; %Husum
        23  1   0   0   1; %Heide
        24  1   0   0   1; %Pinneberg
        25  1   0   0   1; %Norderstedt
        26  1   0   0   1; %Bad Oldesloe
        27  1   0   0   1; %Mölln
        28  1   0   0   1; %Harburg
        29  1   0   0   1; %Hamburg-Mitte
        30  1   0   0   1; %Eidelstedt
        31  1   0   0   1; %Bergedorf
        32  1   0   0   1; %Wandsbek
        33  1   0   0   1; %Altona
        34  1   0   0   1; %Hamburg-Nord
        35  1   0   0   1; %Görries
        36  1   0   0   1; %Wessin
        37  1   0   0   1; %Güstrow
        38  1   0   0   1; %Lubmin
        39  1   0   0   1; %Altentreptow
        40  1   0   0   1; %Gransee
        41  1   0   0   1; %Siedenbrünzow
        42  1   0   0   1; %Putliz
        43  1   0   0   1; %Malchow
        44  1   0   0   1; %Rostock
        45  1   0   0   1; %Bertikow
        46  1   0   0   1; %Pasewalk
        47  1   0   0   1; %Vierraden
        48  1   0   0   1; %Parchim
        49  1   0   0   1; %Wolmirstedt
        50  1   0   0   1; %Wismar
        51  1   0   0   1; %Schwerin
        52  1   0   0   1; %Hagenow
        53  1   0   0   1; %Stralsund
        54  1   0   0   1; %Neubrandenburg
        55  1   0   0   1; %Greifswald
        56  1   0   0   1; %Hanekenfähr
        57  1   0   0   1; %Meppen
        58  1   0   0   1; %Roxel
        59  1   0   0   1; %Gronau
        60  1   0   0   1; %Wehrendorf
        61  1   0   0   1; %Landesbergen
        62  1   0   0   1; %Helmstedt
        63  1   0   0   1; %Dollern
        64  1   0   0   1; %Algermissen
        65  1   0   0   1; %Grohnde
        66  1   0   0   1; %Conneforde
        67  1   0   0   1; %Diele
        68  1   0   0   1; %Dörpen
        69  1   0   0   1; %Meeden
        70  1   0   0   1; %Farge
        71  1   0   0   1; %Alfstedt
        72  1   0   0   1; %Ganderkesee
        73  1   0   0   1; %Niedervieland
        74  1   0   0   1; %Bergeshausen
        75  1   0   0   1; %Würgassen
        76  1   0   0   1; %Hattorf
        77  1   0   0   1; %Klein Ilsede
        78  1   0   0   1; %Ovenstedt
        79  1   0   0   1; %Sottrum
        80  1   0   0   1; %Lüneburg
        81  1   0   0   1; %Stadorf
        82  1   0   0   1; %Unterwese
        83  1   0   0   1; %Wahle
        84  1   0   0   1; %Cloppenburg
        85  1   0   0   1; %Maade
        86  1   0   0   1; %Emden
        87  1   0   0   1; %Godenau
        88  1   0   0   1; %Göttingen
        89  1   0   0   1; %Hannover-West
        90  1   0   0   1; %Lehrte
        91  1   0   0   1; %Mehrum
        92  1   0   0   1; %Hallendorf
        93  1   0   0   1; %Sandershausen
        94  1   0   0   1; %Abbenfleth
        95  1   0   0   1; %Stade
        96  1   0   0   1; %Braunschweig
        97  1   0   0   1; %Aurich
        98  1   0   0   1; %Leer
        99  1   0   0   1; %Wilhelmshaven
        100 1   0   0   1; %Brake
        101 1   0   0   1; %Oldenburg
        102 1   0   0   1; %Lingen
        103 1   0   0   1; %Vechta
        104 1   0   0   1; %Wildeshausen
        105 1   0   0   1; %Delmenhorst
        106 1   0   0   1; %Diepholz
        107 1   0   0   1; %Osnabrück
        108 1   0   0   1; %Bremen
        109 1   0   0   1; %Bremerhaven
        110 1   0   0   1; %Cuxhaven
        111 1   0   0   1; %Bremervörde
        112 1   0   0   1; %Seevetal
        113 1   0   0   1; %Ottersberg
        114 1   0   0   1; %Dannenberg
        115 1   0   0   1; %Soltau
        116 1   0   0   1; %Uelzen
        117 1   0   0   1; %Celle
        118 1   0   0   1; %Nienburg
        119 1   0   0   1; %Hamlen
        120 1   0   0   1; %Hildesheim
        121 1   0   0   1; %Northeim
        122 1   0   0   1; %Wolfsburg
        123 1   0   0   1; %Wolfenbüttel
        124 1   0   0   1; %Salzgitter
        125 1   0   0   1; %Goslar
        ];

[AnzK,~]=size(Knoten);

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

%% Weitere Reduktion mit der elektrischen Distanz
%Zielanzahl an Knoten:
zielAnzvec=10:5:125;
erel=zeros(length(zielAnzvec),1);
zaehlplot=1;
for zielAnz=10:5:125
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
            clusterKnoten(c2,:)=zeros(1,5);
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
    
    erel(zaehlplot)=e/(norm(Y,'fro'));
    
    zaehlplot=zaehlplot+1;
end


plot(zielAnzvec,erel,'k');
ylabel('Relative Error','FontSize',20);
xlabel('Number of Busses','FontSize',20);
set(gca,'Fontsize',14);
grid on;