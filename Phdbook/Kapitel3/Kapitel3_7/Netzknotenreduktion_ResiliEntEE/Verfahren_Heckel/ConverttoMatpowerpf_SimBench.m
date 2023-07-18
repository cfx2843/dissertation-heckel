function [Pa,Qa,Ua,DTAa,konvfehler] = ConverttoMatpowerpf_SimBench(Leitungen,Knoten,AnzL,AnzK)

mpc.version = '2';

mpc.baseMVA = 100;

%Zur Erinnerung: die Leitungsdaten
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in kV
%Spalte 5:  Anzahl der Leitungen
%Spalte 6:  Leitungstyp oder Trafotyp

mpc.bus=zeros(AnzK,13);

mpc.bus(:,1)=1:AnzK;
mpc.bus(:,2)=Knoten(:,2);


pu=0;
hasslack=0;

for i=1:AnzK
    if Knoten(i,2)==2
        if hasslack==0 %Slack-Knoten noch nicht vorhanden
            mpc.bus(i,2)=3; %Slack-Knoten wird gesetzt
            hasslack=1;
        end
        mpc.bus(i,7)=1;
        mpc.bus(i,8)=1;
        
        mpc.bus(i,10)=380;
        mpc.bus(i,11)=1;
        mpc.bus(i,11)=1.1;
        mpc.bus(i,11)=0.9;
           
        pu=pu+1;
    else
        
        mpc.bus(i,3)=Knoten(i,7)/1e6;
        mpc.bus(i,4)=Knoten(i,8)/1e6;
        mpc.bus(i,7)=1;
        mpc.bus(i,8)=1;
        
        mpc.bus(i,10)=380;
        mpc.bus(i,11)=1;
        mpc.bus(i,11)=1.1;
        mpc.bus(i,11)=0.9;
        
        
    end
end

mpc.gen=zeros(pu,21);

pu2=1;

for i=1:AnzK
    if Knoten(i,2)==2
        mpc.gen(pu2,1)=Knoten(i,1);
        mpc.gen(pu2,2)=-Knoten(i,7)/1e6;
        mpc.gen(pu2,3)=-Knoten(i,8)/1e6;
        mpc.gen(pu2,4)=inf;
        mpc.gen(pu2,5)=-inf;
        mpc.gen(pu2,6)=1;
        mpc.gen(pu2,7)=100;
        mpc.gen(pu2,8)=1;
        mpc.gen(pu2,9)=inf;
        mpc.gen(pu2,10)=-inf;
        
        pu2=pu2+1;
        
    end   
end

    
    
mpc.branch=zeros(AnzL,13);

%Aufbau ltd
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Widerstand
%Spalte 4:  Reaktanz
%Spalte 5:  Suszeptanz


mpc.branch(:,1:2)=Leitungen(:,1:2);


linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');
trafotypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_TransformerType.csv');

[AnzLtypes,~]=size(linetypes);


ue=380/220; %Übertragerverhältnis
ue2=380/110;


for i=1:AnzL
    
    linetypenum=Leitungen(i,6);
    
    if linetypenum<AnzLtypes
        
        Rbnorm=linetypes(linetypenum,2);
        Rbnorm=Rbnorm.r;
        
        Xbnorm=linetypes(linetypenum,3);
        Xbnorm=Xbnorm.x;
        
        Bbnorm=linetypes(linetypenum,4);
        Bbnorm=Bbnorm.b*10^-6;
        
        if Leitungen(i,4)==220
            Rbnorm=Rbnorm*ue^2;
            Xbnorm=Xbnorm*ue^2;
            Bbnorm=Bbnorm/ue^2;
        elseif Leitungen(i,4)==110
            Rbnorm=Rbnorm*ue2^2;
            Xbnorm=Xbnorm*ue2^2;
            Bbnorm=Bbnorm/ue2^2;
            
        end
    else
        
        
        
        Sb=trafotypes(linetypenum-AnzLtypes,2);
        Sb=Sb.sR;
        uk=trafotypes(linetypenum-AnzLtypes,6);
        uk=uk.vmImp;
        
        Xbnorm=uk*0.01*((Leitungen(i,4)^2)/(Sb*10^6));
        
        if Leitungen(i,4)==220
            Xbnorm=Xbnorm*ue^2;
        elseif Leitungen(i,4)==110
            Xbnorm=Xbnorm*ue2^2;
        end
        
        
        %     pCu=trafotypes(linetypenum-AnzLtypes,7);
        %     pCu=pCu.pCu;
        %
        %     Rb=(Leitungen(i,4)^2)/(pCu*10^3);
        
        Rbnorm=0;
        Bbnorm=0;
    end
    
    
    mpc.branch(i,3)=Leitungen(i,3)*Rbnorm/Leitungen(i,5);
    mpc.branch(i,4)=Leitungen(i,3)*Xbnorm/Leitungen(i,5);
    mpc.branch(i,5)=Leitungen(i,3)*Bbnorm*Leitungen(i,5);
    mpc.branch(i,6)=1e6;
    mpc.branch(i,7)=1e6;
    mpc.branch(i,8)=1e6;
    
    mpc.branch(i,11)=1;
    mpc.branch(i,12)=-360;
    mpc.branch(i,13)=360;
    
end

mpc.gencost=zeros(pu,7);

for i=1:pu

mpc.gencost(i,:)=[2	1500	0	3	0.11	5	150];

end


startup;



% Testlastflussrechnung

[~, bus, gen, ~, success, ~]=runpf(mpc);

%Ausgabe-Größen erzeugen

Pa=zeros(AnzK,1);
Qa=zeros(AnzK,1);

for i=1:AnzK
    if Knoten(i)==2
        Pa(i)=gen(i,2);
        Qa(i)=gen(i,3);
    else
        Pa(i)=bus(i,3);
        Qa(i)=bus(i,4);
    end
    
end


Ua=bus(:,8);
DTAa=bus(:,9)*(pi/180);

if success==1
    konvfehler=0;
    
else
    konvfehler=1;
    
    
end


end

