%% Bildet aus allen Lastlosen Knoten Cluster mit dem nächst gelegenem Knoten (als erstes ausführen)
[AnzK,~]=size(app.Knoten);
K1=1;
while K1<=AnzK
    if app.Knoten(K1,2)==3
        K=app.Knoten(K1,1);
        [C1,~] = find(K==app.cluster);
        minD = min(app.D(C1,:));
        C2 = find(minD == app.D(C1,:));
        C2=C2(1);
        app=Superknoten(C1,C2,app);
    end
    K1=K1+1;
end
clear AnzK C1  C2 K1 K2 K1ind K2 minD