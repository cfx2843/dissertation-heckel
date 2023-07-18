function [app] = Superknoten(k1,k2,app)

%Passt zunächst D an und legt die Knoten aus kdel in k
%wird das Cluster kdel entfernt
%% Größere Knotennummer wird gelöscht
% Dadurch bleibt die Reienfolge in Y und D erhalten
if k1>k2
    k=k2;
    kdel=k1;
else
    k=k1;
    kdel=k2;
end

[kind,~]=find(app.cluster==k);         %indizes in der Clustermatrix finden
[kdelind,~]=find(app.cluster==kdel); 
% k=app.cluster(kind,1);
% kdel=app.cluster(kdelind,1);

if kind==kdelind
    
    return
end

%%app.D anpassen
%if k<=AnzK&&kdel<=AnzK
AnzC=size(app.D);
for i=1:AnzC
    if i~=k
        if any(app.D(i,kdel))
            if any(app.D(i,k))
                  app.D(i,k)=(app.D(i,k)+app.D(i,kdel))/2;
                  app.D(k,i)=app.D(i,k);
            else
                  app.D(i,k)=app.D(i,kdel);
                  app.D(k,i)=app.D(i,k);
            end
        end
    end
end
app.D(kdel,:)=NaN;
app.D(:,kdel)=NaN;
%% app.cluster anpassen
% [kind,~]=find(app.cluster==k); %indizes in der Clustermatrix finden
% [kdelind,~]=find(app.cluster==kdel); 
i=1;
    while app.cluster(kind,i)  %geht in die Cluster Matrix an die erste frei Stelle beim Knoten k
        i=i+1;
    end
    j=1;
    while app.cluster(kdelind,j)~=0  %fügt alle Knoten aus kdel an der oben genannten Stelle ein
        app.cluster(kind,i+j-1)=app.cluster(kdelind,j);
        j=j+1;
    end
    app.cluster(kdelind,:)=[];
end

