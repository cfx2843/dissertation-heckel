function [Y] = Admittanzmatrix_erstellen(Leitungen,AnzK)
%ADMITTANZMATRIX_ERSTELLEN Summary of this function goes here
%   Detailed explanation goes here
%% normierten Wiederstand, normierte Längreaktanz und normierte queradmittanz bestimmen
[AnzL,~]=size(Leitungen);   %Anzahl der Leitungen bestimmen
R=zeros(AnzL,1);
X=zeros(AnzL,1);
B=zeros(AnzL,1);
Rb380=2.148e-04; Xb380=2.1e-3; Bb380=5.549e-04;       %normierte Leitungsbelege für 380000V Leitungen
Rb220=5.813e-04; Xb220=2.5e-3; Bb220=4.549e-04;       %normierte Leitungsbelege für 220000V Leitungen
%Die Berechnungen sind in Leitungsbelege zu finden
ue=380/220; %Übertragerverhältnis

%% Absolute Werte bestimmen
for i=1:AnzL                      %Über die Leitungslänge den absoluten Werte bestimmen (Länge*Belag)
    if Leitungen(i,5)>=1      %Überprüft, ob Parallelitätsfaktor vorhanden ist
        if Leitungen(i,4)==380000
            R(i)=Leitungen(i,3)*Rb380/Leitungen(i,5);     %Wiederstand=Länge*Wiederstandsbelag/Anzahl paralleler Leitungen
            X(i)=Leitungen(i,3)*Xb380/Leitungen(i,5);     %Längsreaktanz=Länge*Wiederstandsbelag/Anzahl paralleler Leitungen
            B(i)=Leitungen(i,3)*Bb380*Leitungen(i,5);     %Quersuszeptanz=Länge*Wiederstandsbelag*Anzahl paralleler Leitungen
        elseif Leitungen(i,4)==220000
            R(i)=Leitungen(i,3)*Rb220/Leitungen(i,5);
            X(i)=Leitungen(i,3)*Xb220/Leitungen(i,5);
            B(i)=Leitungen(i,3)*Bb220*Leitungen(i,5);
        else
            % disp('Leitung ist nicht Teil des Übertragungernetzes') %Leitungen ohne Spannungsangaben werden nicht als Teil des Verteilernetzes angesehen.
             R(i)=0;                                                 %Dementsprechend werden die Leitungsbelege auf 0 gesetzt.
             X(i)=0;
             B(i)=0;
        end
    else
        %Paralleitätsfaktor falsch eine Leitung wird angenommen
        if Leitungen(i,4)==380000
            R(i)=Leitungen(i,3)*Rb380;     %Wiederstand=Länge*Wiederstandsbelag/Anzahl paralleler Leitungen
            X(i)=Leitungen(i,3)*Xb380;     %Längsreaktanz=Länge*Wiederstandsbelag/Anzahl paralleler Leitungen
            B(i)=Leitungen(i,3)*Bb380;     %Quersuszeptanz=Länge*Wiederstandsbelag*Anzahl paralleler Leitungen
        elseif Leitungen(i,4)==220000
            R(i)=Leitungen(i,3)*Rb220;
            X(i)=Leitungen(i,3)*Xb220;
            B(i)=Leitungen(i,3)*Bb220;
        else
            %disp('Leitung ist nicht Teil des Übertragungernetzes') %Leitungen ohne Spannungsangaben werden nicht als Teil des Verteilernetzes angesehen.
             R(i)=0;                                                 %Dementsprechend werden die Leitungsbelege auf 0 gesetzt.
             X(i)=0;
             B(i)=0;
        end
    end
end
%% Admittanzmatrix erstellen       %Anzahl der Knoten
Y = zeros(AnzK,AnzK);        %app.Y Admittanzmatrix
for lauf=1:AnzL
    if Leitungen(lauf,4)==380000  %Admittanzmatrix ist auf 380kV bezogen
        ak  = Leitungen(lauf,1);
        ek  = Leitungen(lauf,2);
        yij = inv(R(lauf)+1i*X(lauf));
        yii = 1i*0.5*B(lauf);
        Y(ak,ak) = Y(ak,ak)+yii+yij;
        Y(ek,ek) = Y(ek,ek)+yii+yij;
        Y(ak,ek) = Y(ak,ek)-yij;
        Y(ek,ak) = Y(ek,ak)-yij;
    elseif Leitungen(lauf,4)==220000  
        ak  = Leitungen(lauf,1);
        ek  = Leitungen(lauf,2);
        yij = inv(R(lauf)+1i*X(lauf))/ue^2;
        yii = 1i*0.5*B(lauf)/ue^2;
        Y(ak,ak) = Y(ak,ak)+yii+yij;
        Y(ek,ek) = Y(ek,ek)+yii+yij;
        Y(ak,ek) = Y(ak,ek)-yij;
        Y(ek,ak) = Y(ek,ak)-yij;
    end
end
end

