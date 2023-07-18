function [Pa,Qa,Ua,DTAa,konvfehler,Paslack,Qaslack,slacknumber] = ConverttoPSTLFNR_SimBench(Leitungen,Knoten,AnzL,AnzK)

%Zur Erinnerung: die Leitungsdaten
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen
%Spalte 6:  Leitungstyp oder Trafotyp

knotend=zeros(AnzK,10);

%Aufbau knotend
%Spalte 1:  Knotennummer
%Spalte 2:  Spannungsbetrag in p.u. Wenn hier der Wert 1 steht, handelt es
%           sich um einen Erzeugungsknoten
%Spalte 3:  Erzeugte Wirkleistung
%Spalte 4:  Erzeugte Blindleistung
%Spalte 5:  Verbrauchte Wirkleistung
%Spalte 6:  Verbrauchte Blindleistung
%Spalte 7:  Minimale Polradspannung (nur für Generator, bei LFR nicht
%           relevant
%Spalte 8:  Maximale Polradspannung (nur für Generator, bei LFR nicht
%           relevant
%Spalte 9:  Synchrone Reaktanz (nur für Generator, bei LFR nicht
%           relevant
%Spalte 10: Maximaler Polradwinkel (nur für Generator, bei LFR nicht
%           relevant

knotend(:,1)=1:AnzK;

Sb=1700e6; %Bezugsleistung

Knotensort=sortrows(Knoten,2,'descend');

slacknumber=Knotensort(1,1);

Leitungenneuenum=Leitungen;

for i=1:AnzL
    index1=Knotensort(:,1)==Leitungen(i,1);
    index2=Knotensort(:,1)==Leitungen(i,2);
    Leitungenneuenum(i,1)=knotend(index1,1);
    Leitungenneuenum(i,2)=knotend(index2,1);
end

pu=0; %Zählt die Anzahl der Erzeugungsknoten

for i=1:AnzK
    if Knotensort(i,2)==2
        knotend(i,2)=1;
        knotend(i,3)=-Knotensort(i,7)/Sb;
        knotend(i,4)=-Knotensort(i,8)/Sb;
        knotend(i,7)=-inf;
        knotend(i,8)=inf;
        knotend(i,9)=0.001;
        knotend(i,10)=70;   
        pu=pu+1;
    else
        knotend(i,5)=Knotensort(i,7)/Sb;
        knotend(i,6)=Knotensort(i,8)/Sb;
    end
end

ltd=zeros(AnzL,5);

%Aufbau ltd
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Widerstand
%Spalte 4:  Reaktanz
%Spalte 5:  Suszeptanz


ltd(:,1:2)=Leitungenneuenum(:,1:2);

Zb=(380000^2)/Sb; %Bezugsimpedanz

linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');
trafotypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_TransformerType.csv');

ue=380/220; %Übertragerverhältnis
ue2=380/110;

[AnzLtypes,~]=size(linetypes);


for i=1:AnzL
    
    linetypenum=Leitungenneuenum(i,6);
    
    if linetypenum<AnzLtypes
        
        Rbnorm=linetypes(linetypenum,2);
        Rbnorm=Rbnorm.r;
        Rbnorm=Rbnorm/Zb;
        
        Xbnorm=linetypes(linetypenum,3);
        Xbnorm=Xbnorm.x;
        Xbnorm=Xbnorm/Zb;
        
        Bbnorm=linetypes(linetypenum,4);
        Bbnorm=Bbnorm.b*10^-6;
        Bbnorm=Bbnorm*Zb;
        
        if Leitungenneuenum(i,4)==220
            Rbnorm=Rbnorm*ue^2;
            Xbnorm=Xbnorm*ue^2;
            Bbnorm=Bbnorm/ue^2;
        elseif Leitungenneuenum(i,4)==110
            Rbnorm=Rbnorm*ue2^2;
            Xbnorm=Xbnorm*ue2^2;
            Bbnorm=Bbnorm/ue2^2;
            
        end
    else
        
        
        
        Sb=trafotypes(linetypenum-AnzLtypes,2);
        Sb=Sb.sR;
        uk=trafotypes(linetypenum-AnzLtypes,6);
        uk=uk.vmImp;
        
        Xbnorm=uk*0.01*((Leitungenneuenum(i,4)^2)/(Sb*10^6));
        Xbnorm=Xbnorm/Zb;
        
        if Leitungenneuenum(i,4)==220
            Xbnorm=Xbnorm*ue^2;
        elseif Leitungenneuenum(i,4)==110
            Xbnorm=Xbnorm*ue2^2;
        end
        
        
        %     pCu=trafotypes(linetypenum-AnzLtypes,7);
        %     pCu=pCu.pCu;
        %
        %     Rb=(Leitungen(i,4)^2)/(pCu*10^3);
        
        Rbnorm=0;
        Bbnorm=0;
    end
    
    
    ltd(i,3)=Leitungenneuenum(i,3)*Rbnorm/Leitungenneuenum(i,5);
    ltd(i,4)=Leitungenneuenum(i,3)*Xbnorm/Leitungenneuenum(i,5);
    ltd(i,5)=Leitungenneuenum(i,3)*Bbnorm*Leitungenneuenum(i,5);
    
end


U=knotend(:,2);

Pg=knotend(:,3);
Qg=knotend(:,4);

Pl=knotend(:,5);
Ql=knotend(:,6);

% Pg=Pg*sum(Pl)/sum(Pg);

Emin=knotend(:,7);
Emax=knotend(:,8);

xd=knotend(:,9);
dmax=knotend(:,10);

  

ttd=[];

ltdrossel=[];

k=AnzK;


Err  = [1E-2 50 2 2 inf]';

% Testlastflussrechnung

[Pa,Qa,Ua,DTAa,~,~,~,konvfehler] =...
pst_lfnr(Pg,Qg,Pl,Ql,Emin,Emax,dmax,xd,U,ltd,ttd,ltdrossel,k,pu,Err,0);

Paslack=Pa(1);
Qaslack=Qa(1);

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

