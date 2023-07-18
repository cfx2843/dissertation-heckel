%Extra script für SciGRID daten:
%Die Spalte Knotentyp wird ihren Zahlen zugeordnet
%Daten müssen kopiert werden und in die entsprechende Zeile eingefügt!
[num,~,raw] = xlsread('AlteDaten\SciGRIDKnoten.xlsx');
[n,~] = size(raw);
Knotentyp = zeros(n,1);
raw = string(raw);

for i=2:n
    if raw(i,4)=='substation'
        Knotentyp(i-1)=1;
    elseif raw(i,4)=='plant'
        Knotentyp(i-1)=2;
    elseif raw(i,4)=='generator'
        Knotentyp(i-1)=2;
    elseif raw(i,4)=='auxillary_T_node'
        Knotentyp(i-1)=3;
    else
        disp('kein Knotentyp');
    end
end

KnotenNr=num(:,1);

%% Start- und EndKnoten anpassen
[num,~,~] = xlsread('AlteDaten\SciGRIDLeitungen.xlsx');
[AnzL,~]=size(num);
Start=zeros(AnzL,1);
End=zeros(AnzL,1);

for i=1:AnzL
    Start(i)=find(KnotenNr==num(i,2));
    End(i)=find(KnotenNr==num(i,3));
end

clear raw n i