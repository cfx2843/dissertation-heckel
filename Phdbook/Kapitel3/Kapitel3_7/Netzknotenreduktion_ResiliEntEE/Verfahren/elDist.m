% Bildet solange aus den nächstgelegenen Knoten Cluster, bis ein gewisser
% Wert erreicht ist

%% Anzahl Cluster eingeben
ZielAnz=255;

%% Reduktion
[AnzK,~]=size(app.cluster);
while AnzK>ZielAnz
    %% Dichteste Knoten finden
    minD = min(app.D,[],'all');
    [K1,K2] = find(minD == app.D);   
    K1=K1(1); K2=K2(1);
    %% Cluster bilden
    [K1,~]=find(app.cluster==K1);
    [K2,~]=find(app.cluster==K2);
    K1=app.cluster(K1,1);  %clusternummer herraussuchen
    K2=app.cluster(K2,1);
    app=Superknoten(K1,K2,app);
   [AnzK,~]=size(app.cluster);   %neue Clusteranzahl bestimmen
end
%% Workspace aufräumen
clear K1;
clear K2;
clear minD;
clear minDz;
clear ZielAnz;
clear AnzK;