function [Y] = Admittanzmatrix_SimBench(Leitungen,AnzK)
%Zur Erinnerung der Aufbau der Leitungsmatrix
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in V
%Spalte 5:  Anzahl der Leitungen
%Spalte 6:  Leitungstyp

[AnzL,~]=size(Leitungen);   %Anzahl der Leitungen bestimmen

linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');
% trafotypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_TransformerType.csv');

ue=380/220; %Übertragerverhältnis
ue2=380/110;

[AnzLtypes,~]=size(linetypes);

%% Leitungsparameter bestimmen

R=zeros(AnzL,1);
X=zeros(AnzL,1);
B=zeros(AnzL,1);

for i=1:AnzL %Über die Leitungslänge den absoluten Werte bestimmen (Länge*Belag)
    
    linetypenum=Leitungen(i,6);
    
    if linetypenum<AnzLtypes
    
    Rb=linetypes(linetypenum,2);
    Rb=Rb.r;
    
    Xb=linetypes(linetypenum,3);
    Xb=Xb.x;
    
    Bb=linetypes(linetypenum,4);
    Bb=Bb.b*10^-6;
    
    else
        
    Bb=0;
    
%     Sb=trafotypes(linetypenum-AnzLtypes,2);
%     Sb=Sb.sR;
%     uk=trafotypes(linetypenum-AnzLtypes,6);
%     uk=uk.vmImp;
%     
%     Xb=uk*0.01*((Leitungen(i,4)^2)/(Sb*10^6));
    
%     pCu=trafotypes(linetypenum-AnzLtypes,7);
%     pCu=pCu.pCu;
%     
%     Rb=(Leitungen(i,4)^2)/(pCu*10^3);
    
    Rb=0;
    
    Xb=0;
        
    end
    
    
    R(i)=Leitungen(i,3)*Rb;
    X(i)=Leitungen(i,3)*Xb;
    B(i)=Leitungen(i,3)*Bb;
    
    
end



%% Admittanzmatrix erstellen
Y = zeros(AnzK,AnzK);
for lauf=1:AnzL
    if Leitungen(lauf,4)==380  %Admittanzmatrix ist auf 380kV bezogen
        ak  = Leitungen(lauf,1);
        ek  = Leitungen(lauf,2);
        yij = (inv(R(lauf)+1i*X(lauf)))*Leitungen(lauf,5);
        yii = 1i*0.5*B(lauf)*Leitungen(lauf,5);
        Y(ak,ak) = Y(ak,ak)+yii+yij;
        Y(ek,ek) = Y(ek,ek)+yii+yij;
        Y(ak,ek) = Y(ak,ek)-yij;
        Y(ek,ak) = Y(ek,ak)-yij;
    elseif Leitungen(lauf,4)==220
        ak  = Leitungen(lauf,1);
        ek  = Leitungen(lauf,2);
        yij = ((inv(R(lauf)+1i*X(lauf)))*Leitungen(lauf,5))/ue^2;
        yii = (1i*0.5*B(lauf)*Leitungen(lauf,5))/ue^2;
        Y(ak,ak) = Y(ak,ak)+yii+yij;
        Y(ek,ek) = Y(ek,ek)+yii+yij;
        Y(ak,ek) = Y(ak,ek)-yij;
        Y(ek,ak) = Y(ek,ak)-yij;
     elseif Leitungen(lauf,4)==110
        ak  = Leitungen(lauf,1);
        ek  = Leitungen(lauf,2);
        yij = ((inv(R(lauf)+1i*X(lauf)))*Leitungen(lauf,5))/ue2^2;
        yii = (1i*0.5*B(lauf)*Leitungen(lauf,5))/ue2^2;
        Y(ak,ak) = Y(ak,ak)+yii+yij;
        Y(ek,ek) = Y(ek,ek)+yii+yij;
        Y(ak,ek) = Y(ak,ek)-yij;
        Y(ek,ak) = Y(ek,ak)-yij;
    end
end
end