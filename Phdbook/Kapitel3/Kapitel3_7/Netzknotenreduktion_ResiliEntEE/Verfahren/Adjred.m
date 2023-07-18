%erstellt eine neue Admittanzmatrix für das reduzierte Netz
[AnzL,~]=size(app.Leitungen);    
app.CLeitungen=app.Leitungen;   %erstellt eine Leitungsmatrix für die Cluster
%% Wechselt die Knoten in der Leitungsmatrix durch zugehörige Cluster
%fügt das Indize des Clusters von dem jeweiligen Knoten in als "Start- und Endknoten" ein
for i=1:AnzL
    [c1ind,~]=find(app.Leitungen(i,1)==app.cluster);  
    [c2ind,~]=find(app.Leitungen(i,2)==app.cluster);
    c1=app.cluster(c1ind,1);
    c2=app.cluster(c2ind,1);
    app.CLeitungen(i,1)=c1;
    app.CLeitungen(i,2)=c2;
end
%% Entfernt Leitungen mit selbem Start und Ende
% Wie groß wird der Fehler? -> Vergleich mit Dortmund alg
[AnzL,~]=size(app.CLeitungen);
i=1;
% beim reduzieren über Superknoten entstehen so Leitunge, die zu sich
% selbst führen, diese werden hier entfernt.
while i<=AnzL
    if app.CLeitungen(i,1)==app.CLeitungen(i,2)
        app.CLeitungen(i,:)=[];  
        AnzL=AnzL-1;
    else
        i=i+1;
    end
end
%% reduziert parallele Leitungen
i=1;
while i<=AnzL
    j=i+1;
    while j<=AnzL   %findet Parallele Leitungen
        if app.CLeitungen(i,4)==app.CLeitungen(j,4)
            if app.CLeitungen(i,1)==app.CLeitungen(j,1)&&app.CLeitungen(i,2)==app.CLeitungen(j,2)
                app.CLeitungen(i,5)=app.CLeitungen(i,5)+app.CLeitungen(j,5); %passt den Parallelitätsfaktor an
                app.CLeitungen(j,:)=[];       %entfernt die nicht angepasste Leitung
            elseif app.CLeitungen(i,2)==app.CLeitungen(j,1)&&app.CLeitungen(i,1)==app.CLeitungen(j,2)
                app.CLeitungen(i,5)=app.CLeitungen(i,5)+app.CLeitungen(j,5);
                app.CLeitungen(j,:)=[];
            end
        end
        j=j+1;
        [AnzL,~]=size(app.CLeitungen);
    end
    i=i+1;
end
[AnzK,~]=size(app.Knoten);
app.Yc=Admittanzmatrix_erstellen(app.CLeitungen,AnzK);


%% Algorithmus zum Reduzieren der Admittanzmatrix
Yr = app.Y;
KUeb = app.cluster(:,1); %Knoten, die Übrig bleiben sollen
i = 2;
KRed = [];
[AnzC,~] = size(app.cluster);
while any(app.cluster(:,i))  %Knoten, die Reduziert werden sollen
    for j=1:AnzC       %Die zu reduzierenden Knoten sind aus app.cluster alle, die nicht 
        if app.cluster(j,i)~=0
            KRed =  [KRed;app.cluster(j,i)];
        end
    end
    i = i+1;
end

%% Reduktion
Y11 = Yr(KUeb,KUeb);
Y12 = Yr(KUeb,KRed);
Y21 = Yr(KRed,KUeb);
Y22 = Yr(KRed,KRed);

app.Yred = Y11-Y12*inv(Y22)*Y21;

%% Fehler berechnen über die Frobeniusnorm
aij = 0;
[AnzC,~] = size(app.Yc); 
for i=1:AnzC      %Frobeniusnorm: Wurzel aus der Addition aller quadrierten Elemente 
    for j=1:AnzC  %Norm für Yc (aus ) aus dem Cluster Algorithmus
        aij = aij+abs(app.Yc(i,j))^2 ;
    end
end
NormFYc = sqrt(aij);

aij = 0;
[AnzC,~] = size(app.Yred);
for i=1:AnzC   %Norm für Yred von dem EES 3 Algorithmus
    for j=1:AnzC
        aij = aij+abs(app.Yred(i,j))^2 ;
    end
end
NormFYred = sqrt(aij);
app.AbsError = abs(NormFYc-NormFYred);
app.RelError = app.AbsError/NormFYred;

%% Workspace bereinigen
clear aij AnzC i j KRed KUeb NormFYc NormFYred Y11 Y12 Y21 Y22 Yr ue c1ind c2ind
clear ak
clear AnzK
clear AnzL
clear B
clear Bb220
clear Bb380
clear c1
clear c2
clear ek
clear i
clear j
clear lauf
clear R
clear Rb220
clear Rb380
clear X
clear Xb220
clear Xb380
clear yii
clear yij