%% Entfernt die Knoten kdel aus den Daten
function [app] = Knotenentfernen (kdel,app)
%% Leitung finden und Überprüfen, ob der Knoten vorhanden ist.
    %% In allen Objekten den Knoten und die Leitung entfernen
    Knotenindize=find(app.Knoten(:,1)==kdel);
    [Clusterindize,~]=find(app.cluster==kdel);
    app.cluster(Clusterindize,:)=[];
    app.Knoten(Knotenindize,:)=[];
    [AnzL,~] = size(app.Leitungen);
    app.Landkreis(Knotenindize)=[];
%%Leitungsmatrix anpassen
    i=1;
    while i<=AnzL  
        if kdel==app.Leitungen(i,1)||kdel==app.Leitungen(i,2)
            app.Leitungen(i,:)=[];
            [AnzL,~] = size(app.Leitungen);
        else
            i=i+1;
        end
    end