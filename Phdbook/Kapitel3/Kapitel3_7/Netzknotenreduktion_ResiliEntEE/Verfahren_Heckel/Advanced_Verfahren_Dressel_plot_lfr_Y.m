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
%Spalte 5:  Norddeutsch
%Spalte 6:  Knoten-Wirkleistung
%Spalte 7:  Knoten-Blindleistung

%Art des Knotens: 1 Lastknoten 2 Generatorknoten 3 Referenzknoten

%Lastdaten aus Inselnetz-Szenario

Knotenisoliert=[
    1   1   0   0   1   0           0;          %Hamburg
    2   1   0   0   1   0           0;          %Brunsbüttel
    3   1   0   0   1   0           0;          %Hamburg-Ost
    4   2   0   0   1   -800e6      0;          %Hamburg-Süd
    5   1   0   0   1   0           0;          %Krümmel
    6   1   0   0   1   0           0;          %Audorf
    7   1   0   0   1   0           0;          %Jardelund
    8   2   0   0   1   -1339.5e6   0;          %Brokdorf
    9   1   0   0   1   0           0;          %Wilster
    10  2   0   0   1   -533.5e6    0;          %Büttel
    11  1   0   0   0   0           0;          %Dänemark
    12  1   0   0   1   63.1e6      20.75e6;    %Flensburg
    13  1   0   0   1   182e6       59.84e6;    %Kiel-West
    14  1   0   0   1   -3.3e6      -1.08e6;    %Itzehoe
    15  1   0   0   1   138.8e6     45.64e6;    %Lübeck
    16  1   0   0   1   0           0;          %Kummerfeld
    17  2   0   0   1   -161.5e6    0;          %Kiel Kraftwerk
    18  1   0   0   1   -15.2e6     -5e6;       %Eckernförde
    19  1   0   0   1   -12.9e6     -4.24e6;    %Plön
    20  1   0   0   1   55.3e6      18.18e6;    %Neumünster
    21  1   0   0   1   -49.4e6     -16.24e6;   %Schleswig
    22  1   0   0   1   -52.8e6     -17.36e6;   %Husum
    23  1   0   0   1   -30.2e6     -9.93e6;    %Heide
    24  1   0   0   1   137.1e6     45.08e6;    %Pinneberg
    25  1   0   0   1   64.3e6      21.14e6;    %Norderstedt
    26  1   0   0   1   96.6e6      31.8e6;     %Bad Oldesloe
    27  1   0   0   1   3.1e6       1.02e6;     %Mölln
    28  1   0   0   1   297.5e6     97.81e6;    %Harburg
    29  1   0   0   1   606.3e6     199.34e6;   %Hamburg-Mitte
    30  1   0   0   1   111.2e6     36.56e6;    %Eimsbüttel
    31  2   0   0   1   -43.7e6      0;         %Bergedorf
    32  1   0   0   1   220.5e6     72.5e6;     %Wandsbek
    33  1   0   0   1   57.2e6      18.8e6;     %Altona
    34  1   0   0   1   199.6e6     65.63e6;    %Hamburg-Nord
    35  1   0   0   1	0           0;          %Görries
    36  1   0   0   1   0           0;          %Wessin
    37  1   0   0   1   23.5e6      7.73e6;     %Güstrow
    38  2   0   0   1   -105e6      0;          %Lubmin
    39  1   0   0   1   0           0;          %Altentreptow
    40  1   0   0   0   0           0;          %Gransee
    41  1   0   0   1   0           0;          %Siedenbrünzow
    42  1   0   0   0   0           0;          %Putliz
    43  1   0   0   0   0           0;          %Malchow
    44  2   0   0   1   -402.2e6    0;          %Rostock
    45  1   0   0   0   0           0;          %Bertikow
    46  1   0   0   1   0           0;          %Pasewalk
    47  1   0   0   1   0           0;          %Vierraden
    48  1   0   0   1   0           0;          %Parchim
    49  1   0   0   0   0           0;          %Wolmirstedt
    50  1   0   0   1   23.4e6      7.70e6;     %Wismar
    51  1   0   0   1   120e6       39.45e6;    %Schwerin
    52  1   0   0   1   -11.5e6     -3.78e6;    %Hagenow
    53  1   0   0   1   29.6e6      9.73e6;     %Stralsund
    54  1   0   0   1   29.6e6      9.73e6;     %Neubrandenburg
    55  1   0   0   1   16.4e6      5.39e6;     %Greifswald
    56  1   0   0   1   0           0;          %Hanekenfähr
    57  1   0   0   1   0           0;          %Meppen
    58  1   0   0   0   0           0;          %Roxel
    59  1   0   0   0   0           0;          %Gronau
    60  1   0   0   1   0           0;          %Wehrendorf
    61  1   0   0   1   0           0;          %Landesbergen
    62  1   0   0   1   118.5e6     38.96e6;    %Helmstedt
    63  1   0   0   1   0           0;          %Dollern
    64  1   0   0   1   0           0;          %Algermissen
    65  2   0   0   1   -1297.7e6   0;          %Grohnde
    66  1   0   0   1   0           0;          %Conneforde
    67  2   0   0   1   -360.6e6    0;          %Diele
    68  2   0   0   1   -479.7e6    0;          %Dörpen
    69  1   0   0   0   0           0;          %Meeden
    70  2   0   0   1   -175e6      0;          %Farge
    71  1   0   0   1   0           0;          %Alfstedt
    72  1   0   0   1   0           0;          %Ganderkesee
    73  2   0   0   1   -449.8e6    0;          %Niedervieland
    74  1   0   0   0   0           0;          %Bergeshausen
    75  1   0   0   0   0           0;          %Würgassen
    76  1   0   0   1   0           0;          %Hattorf
    77  1   0   0   1   0           0;          %Klein Ilsede
    78  1   0   0   0   0           0;          %Ovenstedt
    79  1   0   0   1   0           0;          %Sottrum
    80  1   0   0   1   79.7e6      26.20e6;    %Lüneburg
    81  1   0   0   1   0           0;          %Stadorf
    82  2   0   0   1   -128.4e6    0;          %Unterweser
    83  1   0   0   1   0           0;          %Wahle
    84  1   0   0   1   119.8e6     39.39e6;    %Cloppenburg
    85  2   0   0   1   -744e6      0;          %Maade
    86  1   0   0   1   72.9e6      23.97e6;    %Emden
    87  1   0   0   1   0           0;          %Godenau
    88  1   0   0   1   77.5e6      25.48e6;    %Göttingen
    89  1   0   0   1   805.7e6     264.9e6;    %Hannover(-West)
    90  1   0   0   1   0           0;          %Lehrte
    91  2   0   0   1   -345e6      0;          %Mehrum
    92  1   0   0   1   0           0;          %Hallendorf
    93  1   0   0   0   0           0;          %Sandershausen
    94  1   0   0   1   0           0;          %Abbenfleth
    95  1   0   0   1   112.3e6     36.92e6;    %Stade
    96  1   0   0   1   216.6e6     71.21e6;    %Braunschweig
    97  1   0   0   1   93.8e6      93.8e6;     %Aurich
    98  1   0   0   1   78.6e6      25.84e6;    %Leer
    99  1   0   0   1   124.2e6     40.83e6;    %Wilhelmshaven
    100 1   0   0   1   50.3e6      16.54e6;    %Brake
    101 1   0   0   1   219.8e6     72.27e6;    %Oldenburg
    102 1   0   0   1   324.7e6     106.76e6;   %Lingen
    103 1   0   0   1   147.7e6     48.56e6;    %Vechta
    104 1   0   0   1   55.2e6      18.15e6;    %Wildeshausen
    105 1   0   0   1   49.4e6      16.24e6;    %Delmenhorst
    106 1   0   0   1   101.3e6     33.3e6;     %Diepholz
    107 1   0   0   1   418.4e6     137.56e6;   %Osnabrück
    108 1   0   0   1   625.3e6     205.59e6;   %Bremen
    109 1   0   0   1   112.6e6     37.02e6;    %Bremerhaven
    110 1   0   0   1   50.2e6      16.5e6;     %Cuxhaven
    111 1   0   0   1   57.9e6      19.04e6;    %Bremervörde
    112 1   0   0   1   107.2e6     35.25e6;    %Seevetal
    113 1   0   0   1   81.5e6      26.8e6;     %Ottersberg/Verden
    114 1   0   0   1   -10.3e6     -3.39e6; 	%Dannenberg
    115 1   0   0   1   42.9e6      14.1e6;     %Soltau
    116 1   0   0   1   12.5e6      4.11e6;     %Uelzen
    117 1   0   0   1   82.4e6      27.09e6;    %Celle
    118 1   0   0   1   50.1e6      16.47e6;    %Nienburg
    119 1   0   0   1   179.9e6     59.15e6;    %Hamlen
    120 1   0   0   1   173.9e6     57.18e6;    %Hildesheim
    121 1   0   0   1   15.4e6      5.06e6;     %Northeim
    122 1   0   0   1   190.9e6     62.76e6;    %Wolfsburg
    123 1   0   0   1   166.2e6     54.64e6;    %Wolfenbüttel
    124 1   0   0   1   122.5e6     40.28e6;    %Salzgitter
    125 1   0   0   1   159.2e6     52.34e6;    %Goslar
    ];

Knotentransit=[
    1   1   0   0   1   0           0;          %Hamburg
    2   1   0   0   1   0           0;          %Brunsbüttel
    3   1   0   0   1   0           0;          %Hamburg-Ost
    4   2   0   0   1   -800e6      0;          %Hamburg-Süd
    5   1   0   0   1   0           0;          %Krümmel
    6   1   0   0   1   0           0;          %Audorf
    7   1   0   0   1   0           0;          %Jardelund
    8   2   0   0   1   -1339.5e6   0;          %Brokdorf
    9   1   0   0   1   0           0;          %Wilster
    10  2   0   0   1   -533.5e6    0;          %Büttel
    11  2   0   0   0   -1300e6      0;         %Dänemark
    12  1   0   0   1   63.1e6      20.75e6;    %Flensburg
    13  1   0   0   1   182e6       59.84e6;    %Kiel-West
    14  1   0   0   1   -3.3e6      -1.08e6;    %Itzehoe
    15  2   0   0   1   -261.2e6    0;          %Lübeck
    16  1   0   0   1   0           0;          %Kummerfeld
    17  2   0   0   1   -161.5e6    0;          %Kiel Kraftwerk
    18  1   0   0   1   -15.2e6     -5e6;       %Eckernförde
    19  1   0   0   1   -12.9e6     -4.24e6;    %Plön
    20  1   0   0   1   55.3e6      18.18e6;    %Neumünster
    21  1   0   0   1   -49.4e6     -16.24e6;   %Schleswig
    22  1   0   0   1   -52.8e6     -17.36e6;   %Husum
    23  1   0   0   1   -30.2e6     -9.93e6;    %Heide
    24  1   0   0   1   137.1e6     45.08e6;    %Pinneberg
    25  1   0   0   1   64.3e6      21.14e6;    %Norderstedt
    26  1   0   0   1   96.6e6      31.8e6;     %Bad Oldesloe
    27  1   0   0   1   3.1e6       1.02e6;     %Mölln
    28  1   0   0   1   297.5e6     97.81e6;    %Harburg
    29  1   0   0   1   606.3e6     199.34e6;   %Hamburg-Mitte
    30  1   0   0   1   111.2e6     36.56e6;    %Eimsbüttel
    31  2   0   0   1   -43.7e6      0;         %Bergedorf
    32  1   0   0   1   220.5e6     72.5e6;     %Wandsbek
    33  1   0   0   1   57.2e6      18.8e6;     %Altona
    34  1   0   0   1   199.6e6     65.63e6;    %Hamburg-Nord
    35  1   0   0   1	0           0;          %Görries
    36  1   0   0   1   0           0;          %Wessin
    37  1   0   0   1   23.5e6      7.73e6;     %Güstrow
    38  2   0   0   1   -105e6      0;          %Lubmin
    39  1   0   0   1   0           0;          %Altentreptow
    40  1   0   0   0   200e6       65.76e6;    %Gransee
    41  1   0   0   1   0           0;          %Siedenbrünzow
    42  1   0   0   0   200e6       65.76e6;    %Putliz
    43  1   0   0   0   200e6       65.76e6;    %Malchow
    44  2   0   0   1   -402.2e6    0;          %Rostock
    45  1   0   0   0   200e6       65.76e6;    %Bertikow
    46  1   0   0   1   0           0;          %Pasewalk
    47  1   0   0   1   0           0;          %Vierraden
    48  1   0   0   1   0           0;          %Parchim
    49  1   0   0   0   200e6       65.76e6;    %Wolmirstedt
    50  1   0   0   1   23.4e6      7.70e6;     %Wismar
    51  1   0   0   1   120e6       39.45e6;    %Schwerin
    52  1   0   0   1   -11.5e6     -3.78e6;    %Hagenow
    53  1   0   0   1   29.6e6      9.73e6;     %Stralsund
    54  1   0   0   1   29.6e6      9.73e6;     %Neubrandenburg
    55  1   0   0   1   16.4e6      5.39e6;     %Greifswald
    56  1   0   0   1   0           0;          %Hanekenfähr
    57  1   0   0   1   0           0;          %Meppen
    58  1   0   0   0   -200e6      -65.76e6;   %Roxel
    59  1   0   0   0   500e6       164.39e6;   %Gronau
    60  1   0   0   1   0           0;          %Wehrendorf
    61  1   0   0   1   0           0;          %Landesbergen
    62  1   0   0   1   118.5e6     38.96e6;    %Helmstedt
    63  1   0   0   1   0           0;          %Dollern
    64  1   0   0   1   0           0;          %Algermissen
    65  2   0   0   1   -1297.7e6   0;          %Grohnde
    66  1   0   0   1   0           0;          %Conneforde
    67  2   0   0   1   -360.6e6    0;          %Diele
    68  2   0   0   1   -479.7e6    0;          %Dörpen
    69  1   0   0   0   1500e6      493.17e6;   %Meeden
    70  2   0   0   1   -175e6      0;          %Farge
    71  1   0   0   1   0           0;          %Alfstedt
    72  1   0   0   1   0           0;          %Ganderkesee
    73  2   0   0   1   -449.8e6     0;         %Niedervieland
    74  1   0   0   0   200e6       65.76e6;    %Bergeshausen
    75  1   0   0   0   200e6       65.76e6;    %Würgassen
    76  1   0   0   1   0           0;          %Hattorf
    77  1   0   0   1   0           0;          %Klein Ilsede
    78  1   0   0   0   -400e6      -131.51;    %Ovenstedt
    79  1   0   0   1   0           0;          %Sottrum
    80  1   0   0   1   79.7e6      26.20e6;    %Lüneburg
    81  1   0   0   1   0           0;          %Stadorf
    82  2   0   0   1   -128.4e6    0;          %Unterweser
    83  1   0   0   1   0           0;          %Wahle
    84  1   0   0   1   119.8e6     39.39e6;    %Cloppenburg
    85  2   0   0   1   -744e6      0;          %Maade
    86  1   0   0   1   72.9e6      23.97e6;    %Emden
    87  1   0   0   1   0           0;          %Godenau
    88  1   0   0   1   77.5e6      25.48e6;    %Göttingen
    89  1   0   0   1   805.7e6     264.9e6;    %Hannover(-West)
    90  1   0   0   1   0           0;          %Lehrte
    91  2   0   0   1   -345e6      0;          %Mehrum
    92  1   0   0   1   0           0;          %Hallendorf
    93  1   0   0   0   200e6       65.76e6;    %Sandershausen
    94  1   0   0   1   0           0;          %Abbenfleth
    95  1   0   0   1   112.3e6     36.92e6;    %Stade
    96  1   0   0   1   216.6e6     71.21e6;    %Braunschweig
    97  1   0   0   1   93.8e6      93.8e6;     %Aurich
    98  1   0   0   1   78.6e6      25.84e6;    %Leer
    99  1   0   0   1   124.2e6     40.83e6;    %Wilhelmshaven
    100 1   0   0   1   50.3e6      16.54e6;    %Brake
    101 1   0   0   1   219.8e6     72.27e6;    %Oldenburg
    102 1   0   0   1   324.7e6     106.76e6;   %Lingen
    103 1   0   0   1   147.7e6     48.56e6;    %Vechta
    104 1   0   0   1   55.2e6      18.15e6;    %Wildeshausen
    105 1   0   0   1   49.4e6      16.24e6;    %Delmenhorst
    106 1   0   0   1   101.3e6     33.3e6;     %Diepholz
    107 1   0   0   1   418.4e6     137.56e6;   %Osnabrück
    108 1   0   0   1   625.3e6     205.59e6;   %Bremen
    109 1   0   0   1   112.6e6     37.02e6;    %Bremerhaven
    110 1   0   0   1   50.2e6      16.5e6;     %Cuxhaven
    111 1   0   0   1   57.9e6      19.04e6;    %Bremervörde
    112 1   0   0   1   107.2e6     35.25e6;    %Seevetal
    113 1   0   0   1   81.5e6      26.8e6;     %Ottersberg/Verden
    114 1   0   0   1   -10.3e6     -3.39e6; 	%Dannenberg
    115 1   0   0   1   42.9e6      14.1e6;     %Soltau
    116 1   0   0   1   12.5e6      4.11e6;     %Uelzen
    117 1   0   0   1   82.4e6      27.09e6;    %Celle
    118 1   0   0   1   50.1e6      16.47e6;    %Nienburg
    119 1   0   0   1   179.9e6     59.15e6;    %Hamlen
    120 1   0   0   1   173.9e6     57.18e6;    %Hildesheim
    121 1   0   0   1   15.4e6      5.06e6;     %Northeim
    122 1   0   0   1   190.9e6     62.76e6;    %Wolfsburg
    123 1   0   0   1   166.2e6     54.64e6;    %Wolfenbüttel
    124 1   0   0   1   122.5e6     40.28e6;    %Salzgitter
    125 1   0   0   1   159.2e6     52.34e6;    %Goslar
    ];

Knotendunkelflaute=[
    1   1   0   0   1   0           0;          %Hamburg
    2   1   0   0   1   0           0;          %Brunsbüttel
    3   1   0   0   1   0           0;          %Hamburg-Ost
    4   2   0   0   1   -1200e6     0;          %Hamburg-Süd
    5   1   0   0   1   0           0;          %Krümmel
    6   1   0   0   1   0           0;          %Audorf
    7   1   0   0   1   0           0;          %Jardelund
    8   2   0   0   1   -1339.5e6   0;          %Brokdorf
    9   1   0   0   1   0           0;          %Wilster
    10  2   0   0   1   -177.8e6    0;          %Büttel
    11  2   0   0   0   -350e6      0;          %Dänemark
    12  1   0   0   1   67.6e6      22.23e6;    %Flensburg
    13  1   0   0   1   191.4e6     62.93e6;    %Kiel-West
    14  1   0   0   1   80.7e6      26.53e6;    %Itzehoe
    15  2   0   0   1   -244.2e6     0;         %Lübeck
    16  1   0   0   1   0           0;          %Kummerfeld
    17  2   0   0   1   -242.3e6    0;          %Kiel Kraftwerk
    18  1   0   0   1   158.8e6     52.21e6;    %Eckernförde
    19  1   0   0   1   184e6       60.5e6;     %Plön
    20  1   0   0   1   61e6        20.06e6;    %Neumünster
    21  1   0   0   1   115.2e6     37.88e6;    %Schleswig
    22  1   0   0   1   112.8e6     37.09e6;    %Husum
    23  1   0   0   1   83.4e6      27.42e6;    %Heide
    24  1   0   0   1   190e6       62.47e6;    %Pinneberg
    25  1   0   0   1   171.2e6     56.29e6;    %Norderstedt
    26  1   0   0   1   157.5e6     51.78e6;    %Bad Oldesloe
    27  1   0   0   1   103.5e6     34.03e6;    %Mölln
    28  1   0   0   1   297.5e6     97.81e6;    %Harburg
    29  1   0   0   1   606.3e6     199.34e6;   %Hamburg-Mitte
    30  1   0   0   1   111.2e6     36.56e6;    %Eimsbüttel
    31  2   0   0   1   -92.3e6     0;          %Bergedorf
    32  1   0   0   1   220.5e6     72.5e6;     %Wandsbek
    33  2   0   0   1   -7.8e6      0e6;        %Altona
    34  1   0   0   1   199.6e6     65.63e6;    %Hamburg-Nord
    35  1   0   0   1	0           0;          %Görries
    36  1   0   0   1   0           0;          %Wessin
    37  1   0   0   1   116.9e6     38.43e6;    %Güstrow
    38  2   0   0   1   -35e6      0;           %Lubmin
    39  1   0   0   1   0           0;          %Altentreptow
    40  1   0   0   0   200e6       65.76e6;    %Gransee
    41  1   0   0   1   0           0;          %Siedenbrünzow
    42  1   0   0   0   200e6       65.76e6;    %Putliz
    43  1   0   0   0   200e6       65.76e6;    %Malchow
    44  2   0   0   1   -546.1e6    0;          %Rostock
    45  1   0   0   0   200e6       65.76e6;    %Bertikow
    46  1   0   0   1   0           0;          %Pasewalk
    47  1   0   0   1   0           0;          %Vierraden
    48  1   0   0   1   0           0;          %Parchim
    49  1   0   0   0   200e6       65.76e6;    %Wolmirstedt
    50  1   0   0   1   81.3e6      26.73e6;    %Wismar
    51  1   0   0   1   123.6e6     40.64e6;    %Schwerin
    52  1   0   0   1   118.2e6     38.86e6;    %Hagenow
    53  1   0   0   1   122.2e6     40.18e6;    %Stralsund
    54  1   0   0   1   156.6e6     51.49e6;    %Neubrandenburg
    55  1   0   0   1   123.8e6     40.7e6;     %Greifswald
    56  1   0   0   1   0           0;          %Hanekenfähr
    57  1   0   0   1   0           0;          %Meppen
    58  1   0   0   0   -200e6      -65.76e6;   %Roxel
    59  1   0   0   0   -200e6      -65.76e6;   %Gronau
    60  1   0   0   1   0           0;          %Wehrendorf
    61  1   0   0   1   0           0;          %Landesbergen
    62  1   0   0   1   143.8e6     47.28e6;    %Helmstedt
    63  1   0   0   1   0           0;          %Dollern
    64  1   0   0   1   0           0;          %Algermissen
    65  2   0   0   1   -1297.7e6   0;          %Grohnde
    66  1   0   0   1   0           0;          %Conneforde
    67  2   0   0   1   -360.6e6    0;          %Diele
    68  2   0   0   1   -479.7e6    0;          %Dörpen
    69  1   0   0   0   200e6       65.76e6;    %Meeden
    70  2   0   0   1   -175e6      0;          %Farge
    71  1   0   0   1   0           0;          %Alfstedt
    72  1   0   0   1   0           0;          %Ganderkesee
    73  2   0   0   1   -449.8e6    0;          %Niedervieland
    74  1   0   0   0   200e6       65.76e6;    %Bergeshausen
    75  1   0   0   0   200e6       65.76e6;    %Würgassen
    76  1   0   0   1   0           0;          %Hattorf
    77  1   0   0   1   0           0;          %Klein Ilsede
    78  1   0   0   0   -400e6      -131.51;    %Ovenstedt
    79  1   0   0   1   0           0;          %Sottrum
    80  1   0   0   1   129.3e6     42.51e6;    %Lüneburg
    81  1   0   0   1   0           0;          %Stadorf
    82  2   0   0   1   -128.4e6    0;          %Unterweser
    83  1   0   0   1   0           0;          %Wahle
    84  1   0   0   1   172.8e6     56.81e6;    %Cloppenburg
    85  2   0   0   1   -744e6      0;          %Maade
    86  1   0   0   1   77.1e6      25.35e6;    %Emden
    87  1   0   0   1   0           0;          %Godenau
    88  1   0   0   1   143e6       47.02e6;    %Göttingen
    89  1   0   0   1   891.3e6     293.04e6;   %Hannover(-West)
    90  1   0   0   1   0           0;          %Lehrte
    91  2   0   0   1   -345e6      0;          %Mehrum
    92  1   0   0   1   0           0;          %Hallendorf
    93  1   0   0   0   200e6       65.76e6;    %Sandershausen
    94  1   0   0   1   0           0;          %Abbenfleth
    95  1   0   0   1   159.6e6     52.47e6;    %Stade
    96  1   0   0   1   243.8e6     80.16e6;    %Braunschweig
    97  1   0   0   1   141.8e6     46.62e6;    %Aurich
    98  1   0   0   1   119e6       39.13e6;    %Leer
    99  1   0   0   1   175.4e6     57.67e6;    %Wilhelmshaven
    100 1   0   0   1   81.1e6      26.66e6;    %Brake
    101 1   0   0   1   250.9e6     82.49e6;    %Oldenburg
    102 1   0   0   1   324.7e6     106.76e6;   %Lingen
    103 1   0   0   1   178.1e6     58.56e6;    %Vechta
    104 1   0   0   1   94.9e6      31.2e6;     %Wildeshausen
    105 1   0   0   1   51.8e6      17.03e6;    %Delmenhorst
    106 1   0   0   1   175.5e6     57.7e6;     %Diepholz
    107 1   0   0   1   502.1e6     165.08e6;   %Osnabrück
    108 1   0   0   1   661.8e6     217.59e6;   %Bremen
    109 1   0   0   1   116.1e6     38.17e6;    %Bremerhaven
    110 1   0   0   1   127e6       41.76e6;    %Cuxhaven
    111 1   0   0   1   135.3e6     44.48e6;    %Bremervörde
    112 1   0   0   1   153.8e6     50.57e6;    %Seevetal
    113 1   0   0   1   111e6       36.49e6;    %Ottersberg/Verden
    114 1   0   0   1   35.5e6      11.67e6; 	%Dannenberg
    115 1   0   0   1   113.1e6     37.19e6;    %Soltau
    116 1   0   0   1   67.1e6      22.06e6;    %Uelzen
    117 1   0   0   1   140.2e6     46.1e6;     %Celle
    118 1   0   0   1   102.4e6     33.67e6;    %Nienburg
    119 1   0   0   1   234.8e6     77.2e6;     %Hamlen
    120 1   0   0   1   219e6       72e6;       %Hildesheim
    121 1   0   0   1   88.6e6      29.13e6;    %Northeim
    122 1   0   0   1   257e6       84.5e6;     %Wolfsburg
    123 1   0   0   1   193.2e6     63.52e6;    %Wolfenbüttel
    124 1   0   0   1   130.8e6     43e6;       %Salzgitter
    125 1   0   0   1   195.2e6     64.18e6;    %Goslar
    ];

%Hier muss das Szenario aus der Bachelorarbeit Dressel ausgewählt werden

Knoten=Knotenisoliert;

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

%% LFR für Validierung

[Pa,Qa,Ua] = ConverttoPSTLFNR(Leitungen,Knoten,AnzL,AnzK);


%% Weitere Reduktion mit der elektrischen Distanz
%Das Verfahren wird dahingehend verbessert, dass möglichst keine
%Erzeugungsknoten gelöscht werden
%Zielanzahl an Knoten:
zielAnzvec=30:5:125;
erelp=zeros(length(zielAnzvec),1);
erelq=erelp;
zaehlplot=1;
clusterKnotencellarray=cell(length(zielAnzvec),1);
for zielAnz=30:5:125
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
            while (clusterKnoten(c2,2)==2 || clusterKnoten(c1,2)==2) && zaehladvanced<AnzK
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
            clusterKnoten(c1,6)=clusterKnoten(c1,6)+clusterKnoten(c2,6);
            clusterKnoten(c1,7)=clusterKnoten(c1,7)+clusterKnoten(c2,7);
            clusterKnoten(c2,:)=zeros(1,7);
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
    
    [Par,Qar,Uar] = ConverttoPSTLFNR_Y(Leitungen,Knoten,AnzL,AnzK,clusterKnoten,cluster);
    
    %Nun muss der Fehler berechnet werden. Dafür wird jeweils eine Matrix
    %mit den Wirk- und Blindleistungen zwischen den Knoten aufgestellt
    
    PMatrixr=zeros(AnzCluster,AnzCluster);
    QMatrixr=zeros(AnzCluster,AnzCluster);
   
    for i=1:AnzCluster
       for j=1:AnzCluster
           PMatrixr(i,j)=Par(i)-Par(j);
           QMatrixr(i,j)=Qar(i)-Qar(j);
       end        
    end
    
    %Erzeugen der oberen Dreiecksmatrix, damit Fehler nicht doppelt
    %betrachtet werden
    
    PMatrixr=triu(PMatrixr);
    QMatrixr=triu(QMatrixr);

    %Das Ganze muss jetzt verglichen werden mit den Ergebnissen aus der
    %ursprünglichen LFR. Dafür müssen die Knoten der Cluster addiert werden
    
    Paurspcluster=zeros(AnzCluster,1);
    Qaurspcluster=zeros(AnzCluster,1);
    
    for i=1:AnzCluster
        for j=1:AnzK
            if cluster(i,j)~=0
                Paurspcluster(i)=Paurspcluster(i)+Pa(cluster(i,j));
                Qaurspcluster(i)=Qaurspcluster(i)+Qa(cluster(i,j));
            end            
        end        
    end
    
    %Jetzt muss die entsprechende Matrix berechnet werden
    
    PMatrix=zeros(AnzCluster,AnzCluster);
    QMatrix=zeros(AnzCluster,AnzCluster);
   
    for i=1:AnzCluster
       for j=1:AnzCluster
           PMatrix(i,j)=Paurspcluster(i)-Paurspcluster(j);
           QMatrix(i,j)=Qaurspcluster(i)-Qaurspcluster(j);
       end        
    end
    
    PMatrix=triu(PMatrix);
    QMatrix=triu(QMatrix);
    
    Pf=abs(PMatrix-PMatrixr);
    
    Qf=abs(QMatrix-QMatrixr);
    
    ep = norm(Pf,'fro');
    eq = norm(Qf,'fro');
    
    erelp(zaehlplot)=ep/(norm(PMatrix,'fro'));
    erelq(zaehlplot)=eq/(norm(QMatrix,'fro'));
    
    clusterKnotencellarray{zaehlplot}=clusterKnoten;
    
    zaehlplot=zaehlplot+1;
    
    
end

%close all
% figure;
hold on;
plot(zielAnzvec,erelp,'k');
plot(zielAnzvec,erelq,'g');
hold off;
ylabel('Relative Error','FontSize',20);
xlabel('Number of Busses','FontSize',20);
set(gca,'Fontsize',14);
grid on;
ylim([0,2]);
legend('Error for Active Power','Error for Reactive Power','Error for Active Power','Error for Reactive Power','FontSize',12,'Location','northeast');

