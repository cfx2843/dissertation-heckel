%Sollten in einem Landkreis mehrere Knoten liegen, werden diese zu einem
%Superknoten zusammengefasst.
[AnzK,~]=size(app.Knoten);
[Lsort,sortind]=sort(app.Landkreis);         %nach namen sortierter Landkreisvektor
sortnr=app.Knoten(sortind,1);                %dazugehörige Knotennummern
for lauf=1:AnzK-1                           %geht den sortierten Landkreisvektor durch und bildet bei doppelten Einträgen Superknoten
    if all(Lsort(lauf)==Lsort(lauf+1))&&Lsort(lauf)~='0'
        [c1ind,~]=find(sortnr(lauf)==app.cluster);
        [c2ind,~]=find(sortnr(lauf+1)==app.cluster);
        clusternr1=app.cluster(c1ind,1);
        clusternr2=app.cluster(c2ind,1);
        if c1ind~=c2ind
            app=Superknoten(clusternr1,clusternr2,app);
        end
    end
end
clear AnzK c1ind c2ind ind c1ind c2ind
clear Lsort
clear lauf
clear sortind
clear sortnr
clear clusternr1
clear clusternr2