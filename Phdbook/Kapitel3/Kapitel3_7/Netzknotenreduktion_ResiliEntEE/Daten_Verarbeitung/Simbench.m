%%Simbench Leitungsmatrix erstellen
Leitungenfilename='SimbenchLeitungen';
filename=['AlteDaten\',Leitungenfilename,'.csv'];
[num,~,raw]=xlsread(filename);

Start=raw(2:end,2);
Start=char(Start);
Start=Start(:,9:end);
End=raw(2:end,3);
End=char(End);
End=End(:,9:end);
[AnzL,~]=size(Start);
length=zeros(AnzL,1);
Leitungstyp=raw(2:end,4);
Leitungstyp=char(Leitungstyp);
Leitungstyp=Leitungstyp(:,10:end);

x=zeros(AnzL,1);
y=zeros(AnzL,1);
z=zeros(AnzL,1);

for i=1:AnzL
    x(i,1)=str2double(Start(i,:));
    y(i,1)=str2double(End(i,:));
    z(i,1)=str2double(Leitungstyp(i,:));
    if any(num(i,1))
        length(i)=num(i,1)/1000;
    else
        a=string(raw(i+1,5));
        length(i)=str2double(a);
    end
end
Spannungsebene(1:AnzL,1)=380000;
p=ones(AnzL,1);
Leitungen=[x,y,length,Spannungsebene,p];

Leitungenfilename='SimbenchKnoten';
filename=['AlteDaten\',Leitungenfilename,'.csv'];
[num,~,raw]=xlsread(filename);

KnotenNr=raw(2:end,1);
KnotenNr=char(KnotenNr);
KnotenNr=KnotenNr(:,9:end);

% [AnzK,~] = size(num);
% 
% Knoten=[KnotenNr];

clear a AnzK End filename i KnotenNr Leitungenfilename Leitungstyp length Spannungsebene Start x y z 