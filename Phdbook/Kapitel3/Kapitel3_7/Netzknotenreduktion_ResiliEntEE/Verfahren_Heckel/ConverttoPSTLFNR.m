function [Pa,Qa,Ua,DTAa,konvfehler] = ConverttoPSTLFNR(Leitungen,Knoten,AnzL,AnzK)

knotend=zeros(AnzK,10);

knotend(:,1)=1:AnzK;

Sb=1700e6;

Knotensort=sortrows(Knoten,2,'descend');

Leitungenneuenum=Leitungen;

for i=1:AnzL
    index1=Knotensort(:,1)==Leitungen(i,1);
    index2=Knotensort(:,1)==Leitungen(i,2);
    Leitungenneuenum(i,1)=knotend(index1,1);
    Leitungenneuenum(i,2)=knotend(index2,1);
end

pu=0;

for i=1:AnzK
    if Knotensort(i,2)==2
        knotend(i,2)=1;
        knotend(i,3)=-Knotensort(i,6)/Sb;
        knotend(i,4)=-Knotensort(i,7)/Sb;
        knotend(i,7)=-inf;
        knotend(i,8)=inf;
        knotend(i,9)=0.001;
        knotend(i,10)=70;   
        pu=pu+1;
    else
        knotend(i,5)=Knotensort(i,6)/Sb;
        knotend(i,6)=Knotensort(i,7)/Sb;
    end
end

ltd=zeros(AnzL,5);

ltd(:,1:2)=Leitungenneuenum(:,1:2);

Rb380=0.0275; Xb380=0.264; Bb380=(13.8e-09)*2*pi*50;       %Norddeutsche Durchnittswerte für 380kV-Leitungen
Rb220=0.0744; Xb220=0.319; Bb220=(11.3e-09)*2*pi*50;       %Norddeutsche Durchnittswerte für 220kV-Leitungen
Rb110=0.012;  Xb110=0.39;  Bb110=(9e-09)*2*pi*50;          %Norddeutsche Durchnittswerte für 110kV-Leitungen

Zb=(380000^2)/Sb; %Bezugsimpedanz;

ue=380/220; %Übertragerverhältnis
ue2=380/110;

Rb380norm=Rb380/Zb;            Xb380norm=Xb380/Zb;             Bb380norm=Bb380*Zb;
Rb220norm=(Rb220/Zb)*ue^2;     Xb220norm=(Xb220/Zb)*ue^2;      Bb220norm=(Bb220*Zb)/ue^2;
Rb110norm=(Rb110/Zb)*ue2^2;    Xb110norm=(Xb110/Zb)*ue2^2;     Bb110norm=(Bb110*Zb)/ue2^2;

for i=1:AnzL
   if Leitungenneuenum(i,4)==380
       ltd(i,3)=Leitungenneuenum(i,3)*Rb380norm/Leitungenneuenum(i,5);
       ltd(i,4)=Leitungenneuenum(i,3)*Xb380norm/Leitungenneuenum(i,5);
       ltd(i,5)=Leitungenneuenum(i,3)*Bb380norm*Leitungenneuenum(i,5);
   elseif Leitungenneuenum(i,4)==220
       ltd(i,3)=Leitungenneuenum(i,3)*Rb220norm/Leitungenneuenum(i,5);
       ltd(i,4)=Leitungenneuenum(i,3)*Xb220norm/Leitungenneuenum(i,5);
       ltd(i,5)=Leitungenneuenum(i,3)*Bb220norm*Leitungenneuenum(i,5);
   elseif Leitungenneuenum(i,4)==110
       ltd(i,3)=Leitungenneuenum(i,3)*Rb110norm/Leitungenneuenum(i,5);
       ltd(i,4)=Leitungenneuenum(i,3)*Xb110norm/Leitungenneuenum(i,5);
       ltd(i,5)=Leitungenneuenum(i,3)*Bb110norm*Leitungenneuenum(i,5);
   end
end

U=knotend(:,2);

Pg=knotend(:,3);
Qg=knotend(:,4);

Pl=knotend(:,5);
Ql=knotend(:,6);

Pg=Pg*sum(Pl)/sum(Pg);

Emin=knotend(:,7);
Emax=knotend(:,8);

xd=knotend(:,9);
dmax=knotend(:,10);

  

ttd=[];

ltdrossel=[];

k=AnzK;


Err  = [1E-4 50 2 2 inf]';

% Testlastflussrechnung

[Pa,Qa,Ua,DTAa,~,~,~,konvfehler] =...
pst_lfnr(Pg,Qg,Pl,Ql,Emin,Emax,dmax,xd,U,ltd,ttd,ltdrossel,k,pu,Err,0);

%Ausgabe-Größen zurück sortieren

Pa=[Pa,Knotensort(:,1)];

Pa=sortrows(Pa,2,'ascend');

Pa(:,2)=[];

Qa=[Qa,Knotensort(:,1)];

Qa=sortrows(Qa,2,'ascend');

Qa(:,2)=[];


Ua=[Ua,Knotensort(:,1)];

Ua=sortrows(Ua,2,'ascend');

Ua(:,2)=[];


DTAa=[DTAa,Knotensort(:,1)];

DTAa=sortrows(DTAa,2,'ascend');

DTAa(:,2)=[];



end

