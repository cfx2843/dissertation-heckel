%% Entfernt alle Knoten auserhalb Norddeutschlands (Als erstes ausführen!)
[AnzK,~]=size(app.Knoten(:,1));  
lauf=1;
while lauf<=AnzK                    %geht alle Knotennummern durch 
    Knotennr=app.Knoten(lauf,1);
    if app.Knoten(lauf,5)==0     %ist der Knoten zu lauf auserhalb Norddeutschlands wird er entfernt.
        app=Knotenentfernen(Knotennr,app);
        AnzK=AnzK-1;
    else
        lauf=lauf+1;
    end
end
% %%passt die Knoten Nummern in app.Leitungen und app.Knoten an
  [AnzL,~]=size(app.Leitungen);
for i=1:AnzL
    app.Leitungen(i,1)=find(app.Leitungen(i,1)==app.Knoten(:,1));
    app.Leitungen(i,2)=find(app.Leitungen(i,2)==app.Knoten(:,1));
end
app.Knoten(:,1)=1:AnzK;
app.cluster(:,1)=app.Knoten(:,1);

%% Distanzmatrix erneuern erstellen
app.D=zeros(AnzK,AnzK);
for i = 1:AnzL   %Leitungslängen eintragen in app.D
    app.D(app.Leitungen(i,1),app.Leitungen(i,2))=app.Leitungen(i,3)/app.Leitungen(i,5);  %el. Länge bestimmen über phy. Länge /p
    app.D(app.Leitungen(i,2),app.Leitungen(i,1))=app.Leitungen(i,3)/app.Leitungen(i,5);
end
%0 durch Nan ersetzen
app.D(app.D==0)=NaN;

%% Admittanzmatrix erneuern
AnzK=max(app.Knoten(:,1));
app.Y=Admittanzmatrix_erstellen(app.Leitungen,AnzK);

clear AnzK
clear Indize
clear lauf