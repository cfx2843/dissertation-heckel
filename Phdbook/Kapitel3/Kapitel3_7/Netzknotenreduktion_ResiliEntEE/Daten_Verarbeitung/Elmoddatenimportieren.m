%% Wandelt Die Elmod-Leitungsdaten in Start- und Endknoten für die Leitungsmatrix
% Die Werte müssen aus dem Workspace kopiert werden und in eine Exeltabelle
% eingefügt werden.
[num,~,~] = xlsread('AlteDaten\Data_Input','Grid_topology');
[AnzL,AnzK]=size(num);
Leitungen = zeros(AnzL,2);
for i=1:AnzL   %geht die Matrix durch und bestimmt Startknoten (1) und Endknoten (-1).
    for j=1:AnzK
        if num(i,j)==-1
            Leitungen(i,2)=j;
        elseif num(i,j)==1
            Leitungen(i,1)=j;
        end
    end
end

%% Zugehörigkeit zu Nordeutschland finden
[~,txt,~] = xlsread('AlteDaten\Data_Input','Node_Data');
[AnzK,~] = size(txt);
ND = zeros(AnzK-2,1);
txt = string(txt);

for i=3:AnzK              %Sollte ein Knoten un den Ländern: Schleswig-Holstein, Bremen, Hamburg, Mecklenburg-Vorpommern oder Niedersachen liegen, wird er zu Nordeutschland gezählt
    if txt(i,3)=="DE_HB"||txt(i,3)=="DE_HH"||txt(i,3)=="DE_MV"||txt(i,3)=="DE_NI"...
            ||txt(i,3)=="DE_SH"
        ND(i-2) = 1;
    end
end  

%% Knotenart bestimmen

[~,txt] = xlsread('AlteDaten\Data_Input','Plant_con');
kr=ones(AnzK-2,1);    %markiert erst alle Knoten als Lastknoten.
for i=3:AnzK          %alle Generatorknoten werden im zweiten Schritt umbenannt
    kch=char(txt(i,3));
    k=str2double(kch(2:end));
    kr(k)=2;
end
clear AnzK AnzL i j k kch num txt


