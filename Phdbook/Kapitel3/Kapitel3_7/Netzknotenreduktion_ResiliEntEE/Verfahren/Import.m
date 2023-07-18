%% Voreinstellungen
%Namen der zu importieerenden Exeltabellen eingeben
Leitungenfilename='ELMODLeitungen';
Knotenfilename='ELMODKnoten';

%% Leitungsmatrix erstellen
%Exceltabe in den Unterordner Opensourcedaten legen der Name kann oben,
%oder in der App eingegeben werden.
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in V
%Spalte 5:  Anzahl der Leitungen

filename=['Opensourcedaten\',Leitungenfilename,'.xlsx'];
[app.Leitungen]=xlsread(filename);
app.Leitungen=app.Leitungen(:,1:5);

%% "leere Leitungen" füllen
%sollte eine Leitung keine Leiter enthalten wird der parallelitätsfaktor
%von 1 angenommen
[AnzL,~]=size(app.Leitungen);
for i=1:AnzL
    if app.Leitungen(i,5)<1
        app.Leitungen(i,5)=1;
    end
end

% %% Leitungen, die nicht Teil des Übertragernetzes sind entfernen
% i=1;
% while i<AnzL
%     if ~(app.Leitungen(i,4)==380000||app.Leitungen(i,4)==220000)
%         app.Leitungen(i,:)=[];
%         AnzL=AnzL-1;
%     else
%         i=i+1;
%     end
% end

%% Knoten importieren
%Exceltabe in den Unterordner Opensourcedaten legen der Name kann oben,
%oder in der App eingegeben werden.
%Spalte 1:  Knotennummer
%Spalte 2:  Art des Knotens
%Spalte 3:  Längengrad
%Spalte 4:  Breitengrad
%Spalte 5: Landkreis)
%Spalte 6: Norddeutsch

%Art des Knotens: 1 Lastknoten 2 Generatorknoten 3 lastloser Knoten

filename=['Opensourcedaten\',Knotenfilename,'.xlsx'];
[num,~,raw] = xlsread(filename);
app.Landkreis=raw(1:end,5);
app.Landkreis=string(app.Landkreis);
app.Knoten = [num(:,1),num(1:end,2),num(:,3),num(:,4),num(:,6)];

[AnzK,~]=size(app.Knoten);
app.Y=Admittanzmatrix_erstellen(app.Leitungen,AnzK);

%% Erstellt eine Cluster Matrix, indem alle Knotennummern Clustern zugeordnet werden.
% Am Anfang ist in jedem Cluster nur ein Knoten
[AnzK,~]=size(app.Knoten);
app.cluster=zeros(AnzK,AnzK);
for i=1:AnzK
    app.cluster(i,1)=app.Knoten(i,1); 
end


%% Nicht Verbundene Knoten entfernen
i=1;
while i<AnzK
    if app.Y(i,i)==0
        app.cluster(i,:)=[];
        AnzK=AnzK-1;
        i=i+1;
    else
        i=i+1;
    end
end

%% Distanzmatrix erstellen
 app.D=zeros(AnzK,AnzK);
for i = 1:AnzL   %Leitungslängen eintragen in app.D
    c1=app.Leitungen(i,1);
    c2=app.Leitungen(i,2);
    app.D(c1,c2)=app.Leitungen(i,3)/app.Leitungen(i,5);  %el. Länge bestimmen über phy. Länge /p
    app.D(c2,c1)=app.Leitungen(i,3)/app.Leitungen(i,5);
end
%0 durch Nan ersetzen
app.D(app.D==0)=NaN;
%% Workspace aufräumen
clear ak ue
clear AnzK
clear AnzL
clear B
clear Bb220
clear Bb380
clear Rb220
clear Rb380
clear X
clear Xb220
clear Xb380
clear Rb220
clear Rb380
clear R
clear Rb220
clear Rb380
clear distij
clear ek
clear f
clear i
clear j
clear klat
clear klong
clear latij
clear longij
clear yii
clear yij
clear Zb
clear lauf
clear c1 c2
clear Zb
clear numK
clear f
clear ak
clear AnzL
clear ek
clear i
clear AnzK
clear lauf
clear yii
clear yij
clear Yl
clear filename
clear num
clear raw
clear Knotenfilename
clear Leitungenfilename
clear Leitungsbelege