%%
%Ergänzung NEP in bereits erzeugten Datensatz

[NEP25,~,~] = xlsread('Netzknotenreduktion_ResiliEntEE\Rohdaten\NEP2025_Daten.xls','Tabelle1');
% Die NEP datei muss vollständig sein hinsichtlich start und Endpunkt,
% sonst kommt es zu einem error
% Wenn weder Neubau noch Ausbau eingesetzt werden, dann wird die Zeile
% nicht berücksichtigt

[AnzNEP,~]=size(NEP25);


Leitungenerweitert=Leitungen;

%Entscheidung ob Leitung geupgradet oder neueingebau wird
%Im ersten Teil werden Neubauten hinzugefügt

for i=1:1:AnzNEP
    if NEP25(i,5)==1
        Leitungentemp=[Leitungenerweitert;0 0 0 0 0 0];
        [AnzTemp,~]=size(Leitungentemp);
        Leitungentemp(AnzTemp,1)= NEP25(i,7);
        Leitungentemp(AnzTemp,2)= NEP25(i,8);
        Leitungentemp(AnzTemp,3)= NEP25(i,4);
        Leitungentemp(AnzTemp,4)= 380;
        Leitungentemp(AnzTemp,5)= 1 ;
        Leitungentemp(AnzTemp,6)= 9 ;
        Leitungenerweitert=Leitungentemp;
        
        %Wahl der Leitungsart fraglich? erst mal 9 genommen
        %5. zeile ist der parallelitätsfaktor
        %es wird im fall neubau eine variable eingeführt um eine
        %zusätzliche Zeile einzufügen und dann die entsprechden Werte in
        %die neue Zeile zu schreiben
        
    elseif NEP25(i,5)==2
       %im Ausbaufall muss geprüft werden ob in den Simbenchdaten die
       %Leitung bereits vorhanden ist, der counter dient dazu 
        aktLeitungsverlauf1=[NEP25(i,7),NEP25(i,8)];
        aktLeitungsverlauf2=[NEP25(i,8),NEP25(i,7)];
        counter=0;
        for j=1:AnzL
            if isequal(Leitungen(j,1:2),aktLeitungsverlauf1)||isequal(Leitungen(j,1:2),aktLeitungsverlauf2)
                
                Leitungenerweitert(j,5)=  Leitungenerweitert(j,5)+1;
                Leitungenerweitert(j,4)=380;
                % Annahme: beim Ausbau werden niedrigere Spannungsebenen
                % automatisch auf 380kV ausgebaut
                counter=counter+1;
                
            end
        end
        if counter==0 
            Leitungentemp=[Leitungenerweitert;0 0 0 0 0 0];
            [AnzTemp,~]=size(Leitungentemp);
            Leitungentemp(AnzTemp,1)= NEP25(i,7);
            Leitungentemp(AnzTemp,2)= NEP25(i,8);
            Leitungentemp(AnzTemp,3)= NEP25(i,4);
            Leitungentemp(AnzTemp,4)= 380;
            Leitungentemp(AnzTemp,5)= 1 ;
            Leitungentemp(AnzTemp,6)= 9 ;
            Leitungenerweitert=Leitungentemp;
        end
      % für den Fall,dass die Leitung in den Simbench daten nicht vorhanden
      % ist wird diese neu hinzugefügt mit dem gleichen code wie im ersten
      % teil
        
        
        
    end
end



Leitungen=Leitungenerweitert;

%%Es muss ausgeschlossen werden, dass eine Leitung zum Ausgangspunkt
%%zurückführt, was der golgende Abschnitt verhindern soll aber nicht
%%hinbekommt aus derzeit unbekannten grund
%Jetzt müssen die Leitungen die im Kreis führen gelöscht werden
[AnzL,~]=size(Leitungen);

for i=1:AnzL
    if Leitungen(i,1)==Leitungen(i,2)
        Leitungen(i,:)=zeros(1,6);
            end
end

%Jetzt folgt das Löschen der leeren Zeilen
%leere Einträge von Leitungen löschen
loesch=zeros(AnzL,1);
for i=1:AnzL
    if Leitungen(i,1)==0
        loesch(i)=1;
    end
end

Leitungen(loesch==1,:)=[];


[AnzL,~]=size(Leitungen);