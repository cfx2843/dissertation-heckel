function [Y] = Admittanzmatrix_Heckel(Leitungen,AnzK)
%Zur Erinnerung der Aufbau der Leitungsmatrix
%Spalte 1:  Startknoten
%Spalte 2:  Endknoten
%Spalte 3:  Leitungslänge [km]
%Spalte 4:  Spannungsebene in V
%Spalte 5:  Anzahl der Leitungen

[AnzL,~]=size(Leitungen);   %Anzahl der Leitungen bestimmen
Rb380=0.0275; Xb380=0.264; Bb380=(13.8e-09)*2*pi*50;       %Norddeutsche Durchnittswerte für 380kV-Leitungen
Rb220=0.0744; Xb220=0.319; Bb220=(11.3e-09)*2*pi*50;       %Norddeutsche Durchnittswerte für 220kV-Leitungen
Rb110=0.012;  Xb110=0.39;  Bb110=(9e-09)*2*pi*50;          %Norddeutsche Durchnittswerte für 110kV-Leitungen
%Es handelt sich um physikalische Werte aus der Bachelorarbeit von Markus Dressel

ue=380/220; %Übertragerverhältnis
ue2=380/110;

%% Leitungsparameter bestimmen

R=zeros(AnzL,1);
X=zeros(AnzL,1);
B=zeros(AnzL,1);

for i=1:AnzL                      %Über die Leitungslänge den absoluten Werte bestimmen (Länge*Belag)
    if Leitungen(i,4)==380
        R(i)=Leitungen(i,3)*Rb380;     %Wiederstand=Länge*Wiederstandsbelag
        X(i)=Leitungen(i,3)*Xb380;     %Längsreaktanz=Länge*Wiederstandsbelag
        B(i)=Leitungen(i,3)*Bb380;     %Quersuszeptanz=Länge*Wiederstandsbelag
    elseif Leitungen(i,4)==220
        R(i)=Leitungen(i,3)*Rb220;
        X(i)=Leitungen(i,3)*Xb220;
        B(i)=Leitungen(i,3)*Bb220;
     elseif Leitungen(i,4)==110
        R(i)=Leitungen(i,3)*Rb110;
        X(i)=Leitungen(i,3)*Xb110;
        B(i)=Leitungen(i,3)*Bb110;
    else
        disp('Leitung ist nicht Teil des Übertragungernetzes') %Leitungen ohne Spannungsangaben werden nicht als Teil des Verteilernetzes angesehen.
        R(i)=0;                                                 %Dementsprechend werden die Leitungsbelege auf 0 gesetzt.
        X(i)=0;
        B(i)=0;
    end
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