%% Erstellen eines Netzes mit n Knoten

clear all;

n=7;

[clusterKnoten,clusterLeitungen]=Verfahren_SimBench_function(n);

%% Stationäre Voruntersuchung

[AnzK,~]=size(clusterKnoten);

[AnzL,~]=size(clusterLeitungen);

%Knoten neu sortieren, um die SimBench-Nummerierung zu entfernen

Knotenneuenum=clusterKnoten;
Leitungenneuenum=clusterLeitungen;

Knotenneuenum(:,1)=1:AnzK;

for i=1:AnzL
    index1=find(clusterKnoten(:,1)==Leitungenneuenum(i,1));
    index2=find(clusterKnoten(:,1)==Leitungenneuenum(i,2));
    Leitungenneuenum(i,1)=Knotenneuenum(index1,1);
    Leitungenneuenum(i,2)=Knotenneuenum(index2,1);
    
end

%Admittanzmatrix bestimmen

Y=Admittanzmatrix_SimBench(Leitungenneuenum,AnzK);

% Output of the admittance matrix in magnitude and phase

Y_out=abs(Y);
theta_out=angle(Y);

%Leistung erhöhen

% Knotenneuenum(:,7:8)=Knotenneuenum(:,7:8)*1.3;

%LFR für Spannungsprofil

[~,~,Ua,Dta] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenneuenum,AnzL,AnzK);

sortUa=sort(Ua);

indexUa=find(Ua==sortUa(1));

% indexUa=3;

%Blindlesitung am Konten indexUa erhöhen

erhoehungszaehl=0;

Knotenerhoeht=Knotenneuenum;

konvfehler=0;

while ~konvfehler
    
    Knotenerhoeht(indexUa,8)=Knotenerhoeht(indexUa,8)+0.5*10^8;;
    
    [~,~,~,~,konvfehler] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenerhoeht,AnzL,AnzK);
    
    erhoehungszaehl=erhoehungszaehl+1;
end

Knotenerhoeht=Knotenneuenum;
Knotenerhoeht(indexUa,8)=Knotenneuenum(indexUa,8)*2^(erhoehungszaehl-1);

[Pa,Qa,Ua] = ConverttoPSTLFNR_SimBench(Leitungenneuenum,Knotenerhoeht,AnzL,AnzK);


V_bus=Ua*380e3;


Sb=1700e6;


Q_bus=Qa*Sb;

MVSI=zeros(AnzK,1);

for iteration1=1:AnzK
    denominator=0;
    for iteration2=1:AnzK
        if iteration1 == iteration2
        else
            sum=V_bus(iteration2)*Y_out(iteration1,iteration2)*sin(theta_out(iteration1,iteration2));
            denominator=sum+denominator;
        end
    end
    
    MVSI(iteration1)= (4*(Q_bus(iteration1)*Y_out(iteration1,iteration1)*sin(theta_out(iteration1,iteration1)))/(denominator^2));
    
end

sortMVSI=sort(MVSI);

indexMVSI=find(MVSI==sortMVSI(end));

% indexMVSI=6;

critMVSI=sortMVSI(end);

%Erhöhung Leistung am kritischen Knoten

% Knotenneuenum(indexMVSI,7:8)=Knotenneuenum(indexMVSI,7:8)*2;

%% Erstellung des Simulationsmodells

%Leitungs Ausfall
clusterLeitungenBackup=Leitungenneuenum;
%anzahl der leitungen mit Fehler

setlinesa=find(Leitungenneuenum(:,1)==indexMVSI);
setlinesb=find(Leitungenneuenum(:,2)==indexMVSI);

setlines=[setlinesa;setlinesb];

brokenlines=length(setlines);

k = zeros(brokenlines,1); p = k; t = p;


clusterLeitungBrook=zeros(brokenlines,7); % intialierung
clusterITBrook =zeros(2*brokenlines,4);


for i=1:brokenlines
    
    k(i)=setlines(i);% Leitungsnummer
    p(i)=0.5*Leitungenneuenum(k(i),5);% anzahl der Leitungen die wegfallen
    t(i)=40;% Zeitpunkt
end
for i=1:brokenlines
    Leitungenneuenum(k(i),5)= Leitungenneuenum(k(i),5)-p(i);
    clusterLeitungBrook(i,1:6)= Leitungenneuenum(k(i),1:6);
    clusterLeitungBrook(i,5)=p(i);
    clusterLeitungBrook(i,7)=t(i);
end
% checken auf p>=0 und ggf anpasssen
for i=1:AnzL
    if Leitungenneuenum(i,5)<0
        for j=1:brokenlines
            if Leitungenneuenum(i,1)==clusterLeitungBrook(j,1)
                clusterLeitungBrook(j,5)=clusterLeitungBrook(j,5)+Leitungenneuenum(i,5);
            end
        end
        Leitungenneuenum(i,:)=0;
    elseif Leitungenneuenum(i,5)==0
        Leitungenneuenum(i,:)=0;
    end
end
Leitungenneuenum(all(Leitungenneuenum==0,2),:)=[]; %loeschen nicht von null zeilen

% muss in der modelica datei anders benannt werden
% zusätzlichen ports müssen mit erstellt werden
% im anschluss erst knotenabbildung laufen lassen

clusterKnoten=Knotenneuenum;

clusterLeitungen=Leitungenneuenum;

% Nummerierung ändern damit keine überschneidung bei den nummern passiert
alt=unique(clusterKnoten(:,1));
[ab,~]=size(clusterKnoten);
for i=1:ab
clusterKnoten(clusterKnoten(:,1)==alt(i))=i;
clusterLeitungen(clusterLeitungen(:,1:2)==alt(i))=i;
if(exist ('clusterLeitungBrook') == true)
    clusterLeitungBrook(clusterLeitungBrook(:,1:2)==alt(i))=i;
end
end


%%
knoten= clusterKnoten;
[nk,~]=size(knoten);
[nw,~]=size(clusterLeitungen);

sum=0; a=1; sum2=0;

for i=1:nk
    if knoten(i,2)==2 && knoten(i,7)>0
        knoten(i,2)=1;
    end
    if knoten(i,2)==1
        sum=sum+knoten(i,7);
        if abs(knoten(i,7))> a
            a=abs(knoten(i,7));
            b=knoten(i,1);
        end
    elseif knoten(i,2)==2
        sum2=sum2+knoten(i,7);
    end
end

if sum <0 % erstellen des neuen last knoten der an den betragsmäßig größsten knoten verbunden wird
    knoten(nk+1,:)=knoten(1,:);
    knoten(nk+1,1)=nk+1;
    knoten(nk+1,2)=1;
    knoten(nk+1,6)=knoten(b,6);
    knoten(nk+1,7)=-sum-sum2/2;
    knoten(nk+1,8)=0;
    nk=nk+1;
    clusterLeitungen(nw+1,:)=[b, nk, 1, knoten(b,6), 100, 11]; %erstellen einer neuen Leitung zum Lastknoten
end

wire= clusterLeitungen;
[nw,~]=size(wire);
%%
% ändern der Leistungen auf pos. Werte wenn es  sich um eine Kraftwerk
% handelt
a=1; prev=0;
if knoten(:,2)~=3
    for i=1:nk
        if knoten(i,2)==2
            knoten(i,7)=abs(knoten(i,7));
            knoten(i,8)=0;
            if knoten(i,7)> a         %sucht slack knoten
                a=knoten(i,7);
                b=i;
            end
        end
    end
    knoten(b,2)=3; % trägt Slack knoten fest
else
    sk=sum(knoten(:,2)==3);
    if sk>1
        for i=1:nk
            if knoten(i,2)==3 && knoten(i,7)>=prev
                prev=knoten(i,7); %sucht maximum
            end
        end
        for i=1:nk
            if knoten(i,2)==3 && knoten(i,7)< prev
                knoten(i,2)=2;
            end
        end
    end
end

clusterKnoten = knoten;

%% eintragen der werte aus Leitungstabelle
% es werden die Werte aus Knoten genommen

clusterBus=zeros(nk,2); 
clusterBus(1:end,1)=knoten(:,1);
clusterBus(1:end,2)=knoten(:,6);

%%  Trafos einfügen
% x*100+1 Formel für neue verbindung
clusterIdleTrafo=zeros(2*nw,4); % erstellen der Matrix
m=1;
for k=1:2
    for i=1:nk
        for j=1:nw
            if clusterBus(i,1)==wire(j,k) && clusterBus(i,2)~=wire(j,4)
                clusterIdleTrafo(m,1)=clusterBus(i,1);
                clusterIdleTrafo(m,2)=clusterBus(i,1)*100+m;
                clusterIdleTrafo(m,3)=clusterBus(i,2);
                clusterIdleTrafo(m,4)=wire(j,4);
                wire(j,k)=clusterBus(i,1)*100+m;
                m=m+1;
            end
        end
    end
end
clusterIdleTrafo(all(clusterIdleTrafo==0,2),:)=[]; %loeschen nicht von null zeilen
m=1;

if(exist ('clusterLeitungBrook') == true)
    [q,~]=size(clusterLeitungBrook);
    clusterITBrook=zeros(2*q,4);
    for k=1:2
        for i=1:nk
            for j=1:q
                if clusterBus(i,1)==clusterLeitungBrook(j,k) && clusterBus(i,2)~=clusterLeitungBrook(j,4)
                    clusterITBrook(m,1)=clusterBus(i,1);
                    clusterITBrook(m,2)=clusterBus(i,1)*1000+m;
                    clusterITBrook(m,3)=clusterBus(i,2);
                    clusterITBrook(m,4)=clusterLeitungBrook(j,4);
                    clusterLeitungBrook(j,k)=clusterBus(i,1)*1000+m;
                    m=m+1;
                end
            end
        end
    end
    clusterITBrook(all(clusterITBrook==0,2),:)=[]; %loeschen nicht von null zeilen
    [a,~]=size(clusterITBrook);
    if(a==1)
        clusterITBrook(2,:)=0;
    end
end
clusterLeitungen=wire;
%% backup
clusterIdleTrafoBackup=clusterIdleTrafo;

%% Trafos löschen aus der Idle und durch 'echte' erstezen (ist noch nicht getestet!!) 
clusterIdleTrafo=clusterIdleTrafoBackup;
%clusterTrafos=clusterTrafosBackup;
zahl=0;
if(exist ('clusterTrafos') == true) %Fall das Sim_bench_trafo verwendet wird
    [ni,~]=size(clusterIdleTrafo);
    [nt,~]=size(clusterTrafos);
    for k1=1:2
        if k1==1 k2=2; else k2=1; end
        for k3=1:2
            if k3==1 k4=2; else k4=1; end
            for k5=1:2
                if k5==1 k6=2; else k6=1; end
                for i=1:ni
                    for j=1:nt
                        for k=1:nw
                            if clusterTrafos(j,k1)==clusterIdleTrafo(i,k3)&&...
                                    clusterIdleTrafo(i,k4)==wire(k,k5)&&...
                                    wire(k,k6)==clusterTrafos(j,k2)&&...
                                    clusterTrafos(j,k1+2)==clusterIdleTrafo(i,k3+2)&&...
                                    clusterTrafos(j,k2+2)==clusterIdleTrafo(i,k4+2)
                                clusterTrafos(j,k2)=clusterIdleTrafo(i,k4);
                                clusterIdleTrafo(i,:)=zeros;
                                fprintf('ziel 1\n');
                             
                            else
                                for k7=1:2
                                    if k7==1 k8=2; else k8=1; end
                                    for m=1:ni
                                        if clusterTrafos(j,k1)==clusterIdleTrafo(i,k3)&&...
                                                clusterIdleTrafo(i,k4)==wire(k,k5)&&...
                                                wire(k,k6)==clusterIdleTrafo(m,k7)&&...
                                                clusterIdleTrafo(m,k8)==clusterTrafos(j,k2)
                                         %   &&...  
                                         % clusterTrafos(j,k1+2)==clusterIdleTrafo(i,k3+2)&&...
                                           %     clusterTrafos(j,k2+2)==clusterIdleTrafo(m,k8+2)
                                           clusterTrafos(j,k2)=clusterIdleTrafo(i,k4);
                                            clusterIdleTrafo(i,:)=zeros;
                                            fprintf('ziel 2\n');
                                           
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

%% Dateinenzum drin schreiben erstellen/oeffnen
%TransiEntDevZone.Sketchbook.jh.VoltageStabilityDynamicInteraction
%ModelFile=['C:/resilientee-sources/transient_library/TransiEntDevZone/Sketchbook/jh/VoltageStabilityDynamicInteraction/Nachbau.mo'];
%Modelname= 'Nachbau'; %Modell name
%fileID=fopen('C:/resilientee-sources/transient_library/TransiEntDevZone/Sketchbook/jh/VoltageStabilityDynamicInteraction/Nachbau.mo','w');
%% dummy für zuhause
 ModelFile=['C:/resilientee-sources/transient_library/TransiEntDevZone/Sketchbook/jh/VoltageStabilityDynamicInteraction/Nachbau.mo'];
 Modelname= 'Nachbau'; %Modell name
 fileID=fopen('C:/resilientee-sources/transient_library/TransiEntDevZone/Sketchbook/jh/VoltageStabilityDynamicInteraction/Nachbau.mo','w');
%%
% laden der Netz daten
wire= clusterLeitungen; % Leitungens parameter
load= clusterKnoten; % Netzknoten
trafo=clusterIdleTrafo; % Trafos
linetypes=readtable('Netzknotenreduktion_ResiliEntEE\Rohdaten\Rohdaten_SimBench_LineType.csv');
types=table2array(linetypes(1:21,2:5));

% Groessen von Load und Netz bestimmen
[nw,~]=size(wire);
[nl,~]=size(load);
[nt,~]=size(trafo);
ref=0; omega=2*pi*50; km=1e3;

set_heat=0; % legt fest ob el. Heizungen verwebdet werden oder nicht
load_dyn=1; % legt die last fest (=1: dynamische Lasten aktiv)
lpheat = 20; % gibt an wie viel Prozent Leistung an heizen gehen soll (1 bis 100, für Null einfach set_heat auf 0 setzen) 

numbervec=unique(wire(:,1:2)); %gibt unterschiedlichen enden von Leitungen an
numbervec2=unique(load(:,1:1)); % gleich fuer loads
[nb,~]=size(numbervec2); % anzahl der benoetigten busse

%% Prüfung der Fehler Fälle und entsprechendes setzen der Variablen
if(exist ('clusterLeitungBrook') == true)
    for i=1:nb
        port_b(i)=nnz(clusterLeitungBrook(:,1:2)==numbervec2(i))+nnz(clusterITBrook(:,1:2)==numbervec2(i)); 
        [wireBrook,~] = size(clusterLeitungBrook);
        numvec_brook=unique(clusterITBrook(:,1:2));
        [m,~]=size(numvec_brook);
        for l=1:m
            for j=1:nb
                if numvec_brook(l)==numbervec2(j)
                    numvec_brook(l)=0;
                end
            end
        end
    end
    clusterITBrook(all(clusterITBrook==0,2),:)=[]; %loeschen nicht von null zeilen
    [trafoBrook,~]= size(clusterITBrook);
    numvec_brook(all(numvec_brook==0,2),:)=[]; %loeschen nicht von null zeilen
    [trb,~]=size(numvec_brook);
else
    port_b=zeros(1,nb);
    trafoBrook=0; wireBrook=0; numvecvec_brook=0;
end

if(exist ('clusterKJump') == true)
	[loadjump,~]=size(clusterKJump);
else 
	loadjump=0;
end

for i=1:nb
    if set_heat==1
        if load(i,2)==1 && load(i,7)>0 && load(i,1)~=nl
            pl(1,i)=2;
        else
            pl(1,i)=1;
        end  
    end
end
%% Dymola file schreiben:
%% setzen von standard Parametern
fprintf(fileID,['model ',Modelname,'\n ']);
fprintf(fileID,['// Number of busses in the model: ',num2str(nb),' \n // Load: dynmaic Load = ',num2str(load_dyn),'\n\n']);
fprintf(fileID,['inner TransiEnt.SimCenter simCenter (v_n(displayUnit="kV") = 380000\n']);
if set_heat==1
 fprintf(fileID,[',redeclare TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid1,\n',...
    'tableInterpolationSmoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2, \n',... 
	' ambientConditions( \n ',...
    ' redeclare TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind, \n',...
    ' redeclare TransiEnt.Basics.Tables.Ambient.GHI_Hamburg_3600s_2012_TMY globalSolarRadiation, \n',...
    ' redeclare TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY directSolarRadiation, \n',...
    ' redeclare TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY diffuseSolarRadiation,\n',...
    ' redeclare TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_900s_2012 temperature),\n',...
    ' integrateHeatFlow=true);\n']);
else
	fprintf(fileID,[');\n']);
end
fprintf(fileID,['inner TransiEnt.ModelStatistics modelStatistics;\n\n']);

%% Leitungen
fprintf(fileID,['//wire\n']); 
for i=1:nw  
    fprintf(fileID,[' TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced Path_',num2str(wire(i,1)),'_',num2str(wire(i,2)),'_',num2str(wire(i,4)),'(\n',...
        'r_custom= ',num2str(types(wire(i,6),1)/km),' ,\n    x_custom=',num2str(types(wire(i,6),2)/km),',\n    c_custom=',num2str(types(wire(i,6),3)/(omega*km*1e6)),',\n     i_r_custom=',num2str(types(wire(i,6),4)),',',...
        '\n ChooseVoltageLevel=4, \n    p=',num2str(wire(i,5)),',\n    l(displayUnit="km") = ',num2str(wire(i,3)),'e3) ',...
        'annotation (Placement(transformation(extent={{ ',num2str(20*i),' ,  10 },{ ',num2str(20+20*i),' ,  30  }})));\n']);
    
%     if wire(i,4)==110
%         fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced Path_',num2str(wire(i,1)),'_',num2str(wire(i,2)),'_',num2str(wire(i,4)),'(',... 
%         'HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,ChooseVoltageLevel=3,p=',num2str(wire(i,5)),',l(displayUnit="km") =',num2str(wire(i,3)),'e3)',... 
%         ' annotation (Placement(transformation(extent={{ ',num2str(20*i),' ,  10 },{ ',num2str(20+20*i),' ,  30  }})));\n']);
%     elseif wire(i,4)==220
%         fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced Path_',num2str(wire(i,1)),'_',num2str(wire(i,2)),'_',num2str(wire(i,4)),'(',...
%         ' HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L5,ChooseVoltageLevel=3,p=',num2str(wire(i,5)),',l(displayUnit="km") =',num2str(wire(i,3)),'e3)',... 
%         ' annotation (Placement(transformation(extent={{ ',num2str(20*i),' ,  30 },{ ',num2str(20+20*i),' ,  50  }})));\n']);
%     elseif wire(i,4)==380
%         fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced Path_',num2str(wire(i,1)),'_',num2str(wire(i,2)),'_',num2str(wire(i,4)),'(',...
%         ' HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,ChooseVoltageLevel=3,p=',num2str(wire(i,5)),',l(displayUnit="km") =',num2str(wire(i,3)),'e3)',...
%         ' annotation (Placement(transformation(extent={{ 0 ,  ',num2str(20*i),' },{ 20 ,  ',num2str(20+20*i),'  }})));\n']);
%     else
%         fprintf('Spannungsebene nicht vorhanden!\n');
%     end
end

    for i=1:wireBrook  % setzen der leitungen die ausfallen
       fprintf(fileID,[' TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced FPath_',num2str(clusterLeitungBrook(i,1)),'_',num2str(clusterLeitungBrook(i,2)),'_',num2str(clusterLeitungBrook(i,4)),'(\n',...
        'r_custom= ',num2str(types(wire(i,6),1)/km),' ,\n    x_custom=',num2str(types(wire(i,6),2)/km),',\n    c_custom=',num2str(types(wire(i,6),3)/(omega*km*1e6)),',\n     i_r_custom=',num2str(types(clusterLeitungBrook(i,6),4)),',',...
        '\n ChooseVoltageLevel=4, \n    p=',num2str(clusterLeitungBrook(i,5)),',\n    l(displayUnit="km") = ',num2str(clusterLeitungBrook(i,3)),'e3 ,activateSwitch=true) ',...
        'annotation (Placement(transformation(extent={{ ',num2str(20*i),' ,  30 },{ ',num2str(20+20*i),' ,  50  }})));\n']); 
        
        
%         if clusterLeitungBrook(i,4)==110
%             fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced FPath_',num2str(clusterLeitungBrook(i,1)),'_',num2str(clusterLeitungBrook(i,2)),'_',num2str(clusterLeitungBrook(i,4)),'(\n',...
% 			'activateSwitch=true, HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,ChooseVoltageLevel=3,p=',num2str(clusterLeitungBrook(i,5)),',l(displayUnit="km") =',num2str(clusterLeitungBrook(i,3)),'e3) annotation (Placement(transformation(extent={{',num2str(20*i-20),' ,  0 },{ ',num2str(20*i),' ,  20  }})));\n']);
%         elseif clusterLeitungBrook(i,4)==220
%             fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced FPath_',num2str(clusterLeitungBrook(i,1)),'_',num2str(clusterLeitungBrook(i,2)),'_',num2str(clusterLeitungBrook(i,4)),'(\n',...
% 			'activateSwitch=true, HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L5,ChooseVoltageLevel=3,p=',num2str(clusterLeitungBrook(i,5)),',l(displayUnit="km") =',num2str(clusterLeitungBrook(i,3)),'e3) annotation (Placement(transformation(extent={{ ',num2str(20*i-20),' ,  0 },{ ',num2str(20*i),' ,  20  }})));\n']);
%         elseif clusterLeitungBrook(i,4)==380
%             fprintf(fileID,['TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced FPath_',num2str(clusterLeitungBrook(i,1)),'_',num2str(clusterLeitungBrook(i,2)),'_',num2str(clusterLeitungBrook(i,4)),'(\n',...
% 			'activateSwitch=true, HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,ChooseVoltageLevel=3,p=',num2str(clusterLeitungBrook(i,5)),',l(displayUnit="km") =',num2str(clusterLeitungBrook(i,3)),'e3) annotation (Placement(transformation(extent={{ ',num2str(20*i-20),' ,  0 },{ ',num2str(20*i),' ,  20  }})));\n']);
%         else
%             fprintf('Spannungsebene nicht vorhanden!\n');
%         end
        
		fprintf(fileID,['Modelica.Blocks.Sources.BooleanStep Step_',num2str(i),...
        '(startTime(displayUnit="s") = ',num2str(clusterLeitungBrook(i,7)),', startValue=true)    annotation (Placement(transformation(extent={{',num2str(280+20*i),',190},{',num2str(300+20*i),',210}})));\n']);
    end


%% Lasten
m=1;
fprintf(fileID,['\n//load\n']);
for i=1:nl
    if load(i,2)==1 %Last
        if set_heat==1 && load(i,7)>0 && load(i,1)~=nl % Heizung an 
            [heat,power]=powersplit(lpheat,load(i,7)); % jeder Haushalt ca 5000W leistung (aktuell nur schätzung Probleme zum zeitpunkt T=0) 
            fprintf(fileID,['TransiEntDevZone.Sketchbook.jh.VoltageStabilityDynamicInteraction.ElectricHeatSystems.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp Lb_',num2str(load(i,1)),'(scalingFactor=',num2str(heat),','...
                'electricBoilerImpedance(v_n=',num2str(load(i,6)),'e3)) annotation (Placement(transformation(extent={{190,',num2str(400-20*i),'},{210,',num2str(420-20*i),'}})));\n']);
            if load_dyn==1
                fprintf(fileID,['TransiEnt.Consumer.Electrical.DynamicExponentialElectricConsumerComplex Load_',num2str(load(i,1)),'(',...
                    ' v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3,    P_n(displayUnit="MW") = ',num2str(power),',    Q_n=',num2str(load(i,8)),') annotation (Placement(transformation(extent={{',num2str(70+20*i),',100},{',num2str(90+20*i),',120}})));\n']);
            else
                fprintf(fileID,['TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Load_',num2str(load(i,1)),'(    P_el_set_const(displayUnit="MW") = ',num2str(load(i,7)),',    v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3,'...
                    'P_n(displayUnit="MW") = ',num2str(power),',Q_n=',num2str(load(i,8)),') annotation (Placement(transformation(extent={{',num2str(70+20*i),',100},{',num2str(90+20*i),',120}})));\n']);
            end
        else    %heizung aus
            if  load_dyn==1 && load(i,7)>0
                fprintf(fileID,['TransiEnt.Consumer.Electrical.DynamicExponentialElectricConsumerComplex Load_',num2str(load(i,1)),'(',...
                    ' v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3,    P_n(displayUnit="MW") = ',num2str(load(i,7)),',    Q_n=',num2str(load(i,8)),') annotation (Placement(transformation(extent={{',num2str(70+20*i),',100},{',num2str(90+20*i),',120}})));\n']);
            else
                fprintf(fileID,['TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Load_',num2str(load(i,1)),'(    P_el_set_const(displayUnit="MW") = ',num2str(load(i,7)),',    v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3,'...
                    'P_n(displayUnit="MW") = ',num2str(load(i,7)),',Q_n=',num2str(load(i,8)),') annotation (Placement(transformation(extent={{',num2str(70+20*i),',100},{',num2str(90+20*i),',120}})));\n']);
            end
        end
        
    elseif load(i,2)==4 % Lastsprung
		fprintf(fileID,['TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Load_',num2str(clusterKJump(m,1)),'(',...   
        ' useInputConnectorP=true, P_el_set_const(displayUnit="MW") = ',num2str(clusterKJump(m,7)),',    v_n(displayUnit="kV") = ',num2str(clusterKJump(m,6)),'e3,',... 
        '   P_n(displayUnit="MW") = ',num2str(clusterKJump(m,7)),') annotation (Placement(transformation(extent={{',num2str(70+20*i),',120},{',num2str(90+20*i),',140}})));\n']);
        fprintf(fileID,['Modelica.Blocks.Sources.Step step_',num2str(clusterKJump(m,1)),'( \n   height=',num2str(clusterKJump(m,9)),',    offset=',num2str(clusterKJump(m,7)),',    startTime=',num2str(clusterKJump(m,10)),')'... 
            'annotation (Placement(transformation(extent={{',num2str(20*i+260),',100},{',num2str(20*i+280),',120}})));\n']);
		if set_heat==1
			fprintf(fileID,['TransiEntDevZone.Sketchbook.jh.VoltageStabilityDynamicInteraction.ElectricHeatSystems.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp Lb_',num2str(load(i,1)),'(scalingFactor=1, '...
			'electricBoilerImpedance(v_n=',num2str(load(i,6)),'e3, cosphi=0.866)) annotation (Placement(transformation(extent={{106,62},{126,42}})));\n']);
		end
        m=m+1;
    elseif load(i,2)==2 %Kraftwerke

		fprintf(fileID,['TransiEnt.Producer.Electrical.Others.Biomass G_',num2str(load(i,1)),'(    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),    P_init_set=',num2str(load(i,7)),'/2,    H=11,',...
		'redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,    set_P_init=true,    isPrimaryControlActive=true,    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciterWithOEL Exciter(v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3, oEL_summation(',...
        'VfLimit=simCenter.v_n,        L1=-20e3,        L2=30e3,        L3=380e3,        K1=1,        K3=0.01)),    isSecondaryControlActive=false,    isExternalSecondaryController=true,    P_el_n(displayUnit="MW") = ',num2str(load(i,7)),', redeclare',...
		' TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(      v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3,          R_a=0))',...
        'annotation (Placement(transformation(extent={{',num2str(20+20*i),',62},{',num2str(40+20*i),',82}})));\n']);
		fprintf(fileID,['Modelica.Blocks.Sources.Constant const_',num2str(load(i,1)),'(k=-G_',num2str(load(i,1)),'.P_init) annotation (Placement(transformation(extent={{80,',num2str(20*i+80),'},{100,',num2str(20*i+100),'}})));\n']);
    elseif  load(i,2)==3% Referenzknoten
       
        fprintf(fileID,['TransiEnt.Producer.Electrical.Others.Biomass G_',num2str(load(i,1)),'_Slack( \n   primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),\n    H=11,\n    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,\n    set_P_init=false,\n    isPrimaryControlActive=true,\n    P_min_star=0.1,\n',...
		'redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciterWithOEL Exciter(v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3, oEL_summation(\n',...
        'VfLimit=simCenter.v_n,  \n      L1=-20e3,     \n   L2=30e3,    \n    L3=380e3,    \n    K1=1,  \n      K3=0.01)), \n  ',...                                            
		'isSecondaryControlActive=true,  \n  isExternalSecondaryController=true, \n   P_el_n(displayUnit="MW") = ',num2str(load(i,7)),',\n',...
		'redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(\n',...
		'v_n(displayUnit="kV") = ',num2str(load(i,6)),'e3, \n     IsSlack=true, \n     R_a=0))       annotation (Placement(transformation(extent={{20,400},{40,380}})));\n']);
        % parameter zur bestimmung für den Integrator
        fprintf(fileID,['Modelica.Blocks.Sources.Constant const_',num2str(load(i,1)),'(k=-G_',num2str(load(i,1)),'_Slack.P_init) annotation (Placement(transformation(extent={{0,380},{20,360}})));\n']);
        fprintf(fileID,['Modelica.Blocks.Continuous.Integrator integrator(k=-1.36e5)annotation (Placement(transformation(        extent={{0,400},{20,380}}             )));\n']);
        fprintf(fileID,['Modelica.Blocks.Sources.RealExpression globalFrequency_reference(y=simCenter.f_n) annotation (Placement(transformation(extent={{0,360},{20,340}})));\n']);
        fprintf(fileID,['Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{0,340},{20,320}})));\n']);
        fprintf(fileID,['TransiEnt.Components.Sensors.ElectricFrequencyComplex globalFrequency annotation (Placement(transformation(extent={{0,320},{20,300}})));\n']);
        ref=ref+1; %Kontrollfunktion
    end
end

%% Busse
fprintf(fileID,['\n//Bus\n']);
for i=1:nb
	if set_heat==1 
        port(i)=nnz(wire(:,1:2)==numbervec2(i))+pl(i)+nnz(trafo(:,1:2)==numbervec2(i))+ port_b(i); %berechnet die Nummer der Ports an jedem Bus
    else
        pl=nnz(load(:,1:1)==numbervec2(i));
        port(i)=nnz(wire(:,1:2)==numbervec2(i))+pl+nnz(trafo(:,1:2)==numbervec2(i))+ port_b(i); %berechnet die Nummer der Ports an jedem Bus
    end	
	
    fprintf(fileID,['Studentbook.ElectricPowerBusDynamic Bus_',num2str(numbervec2(i)),' (port=',num2str(port(i)),')',... 
    ' annotation (Placement(transformation(extent={{',num2str(420-20*i),',400},{',num2str(400-20*i),',380}})));\n']);
end

%% Trafos
fprintf(fileID,['\n//trafo\n']);
for i=1:nt
    fprintf(fileID,['TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'(\n  UseInput=true, \n U_P(displayUnit="kV") = ',num2str(trafo(i,3)),'e3,',... 
	' U_S(displayUnit="kV") =',num2str(trafo(i,4)),'e3) annotation (Placement(transformation(extent={{',num2str(100+20*i),',58},{',num2str(80+20*i),',38}})));\n']);
	fprintf(fileID,['TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'( \n   numberTaps=11,    v_prim_n(displayUnit="kV") = ',num2str(trafo(i,3)),'e3,',... 
	'v_sec_n(displayUnit="kV") = ',num2str(trafo(i,4)),'e3) annotation (Placement(transformation(extent={{80,40},{100,60}})));\n']);
end

for i=1:trafoBrook
 fprintf(fileID,['TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'( \n  UseInput=true, \n ',...
 'U_P(displayUnit="kV") = ',num2str(clusterITBrook(i,3)),'e3, U_S(displayUnit="kV") =',num2str(clusterITBrook(i,4)),'e3)',...
 ' annotation (Placement(transformation(extent={{',num2str(100+20*i),',58},{',num2str(80+20*i),',38}})));\n']);
 fprintf(fileID,['TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTCb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'(  \n  numberTaps=11,    v_prim_n(displayUnit="kV") = ',num2str(clusterITBrook(i,3)),'e3,',...    
 'v_sec_n(displayUnit="kV") = ',num2str(clusterITBrook(i,4)),'e3) annotation (Placement(transformation(extent={{70,60},{90,40}})));\n']);
end

%% Connections
fprintf(fileID,'\nequation \n');
% bilden der epp verbindenungen
for i=1:nb     % ports
    j=1;		%reset
    while j<=port(i)   	% anschluesse an ports
        for k=1:nl		% loads
            if numbervec2(i)==load(k,1) 	%loads checken
                if load(k,2)==1 %Last
                    dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],Load_',num2str(load(k,1)),'.epp);'],'-append','delimiter','');
                    j=j+1;
					if set_heat==1 && load(i,7)>0 && load(i,1)~=nl 
						dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],Lb_',num2str(load(k,1)),'.epp);'],'-append','delimiter','');
						j=j+1;
					end
                elseif load(k,2)==2 %Kraftwerk
                    dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],G_',num2str(load(k,1)),'.epp);'],'-append','delimiter','');
                    j=j+1;
                elseif load(k,2)==3 %Slack
                    dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],G_',num2str(load(k,1)),'_Slack.epp);'],'-append','delimiter','');
                    j=j+1;
                elseif load(k,2)==4 %Lastsprung
                    dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],Load_',num2str(load(k,1)),'.epp);'],'-append','delimiter','');
					j=j+1;
                end
            end
        end
		
        for k=1:nt 	%trafos
            if numbervec2(i)==trafo(k,1)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],sT_',num2str(trafo(k,1)),'_',num2str(trafo(k,2)),'.epp_p);'],'-append','delimiter','');
                j=j+1;
            elseif numbervec2(i)==trafo(k,2)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],sT_',num2str(trafo(k,1)),'_',num2str(trafo(k,2)),'.epp_n);'],'-append','delimiter','');
                j=j+1;
            end
        end
        
		for k=1:trafoBrook	%brook trafos
            if numbervec2(i)==clusterITBrook(k,1)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],sTb_',num2str(clusterITBrook(k,1)),'_',num2str(clusterITBrook(k,2)),'.epp_p);'],'-append','delimiter','');
                j=j+1;
            elseif numbervec2(i)==clusterITBrook(k,2)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],sTb_',num2str(clusterITBrook(k,1)),'_',num2str(clusterITBrook(k,2)),'.epp_n);'],'-append','delimiter','');
                j=j+1;
            end
        end
		
        for k=1:nw 		%check wire
            if numbervec2(i)==wire(k,1)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],Path_',num2str(wire(k,1)),'_',num2str(wire(k,2)),'_',num2str(wire(k,4)),'.epp_n);'],'-append','delimiter','');
                j=j+1;
            elseif numbervec2(i)==wire(k,2)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],Path_',num2str(wire(k,1)),'_',num2str(wire(k,2)),'_',num2str(wire(k,4)),'.epp_p);'],'-append','delimiter','');
                j=j+1;
            end
        end
        
		for k=1:wireBrook 		%check brook wire
            if numbervec2(i)==clusterLeitungBrook(k,1)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],FPath_',num2str(clusterLeitungBrook(k,1)),'_',num2str(clusterLeitungBrook(k,2)),'_',num2str(clusterLeitungBrook(k,4)),'.epp_n);'],'-append','delimiter','');
                j=j+1;
            elseif numbervec2(i)==clusterLeitungBrook(k,2)
                dlmwrite(ModelFile,['connect(Bus_',num2str(numbervec2(i)),'.epp_[',num2str(j),'],FPath_',num2str(clusterLeitungBrook(k,1)),'_',num2str(clusterLeitungBrook(k,2)),'_',num2str(clusterLeitungBrook(k,4)),'.epp_p);'],'-append','delimiter','');
                j=j+1;
            end
        end
    end
end

% Verbindungen von Trafos und Leitungen
% doppelte elemente eleminerien
[n,~]=size(numbervec);
for i=1:n
    for j=1:nb
        if numbervec(i)==numbervec2(j)
            numbervec(i)=0;
            numbervec2(j)=0;
        end
    end
end
numbervec(all(numbervec==0,2),:)=[];
[n,~]=size(numbervec);

%leitungs trafo verbindungen (nicht ideal im moment)
for i=1:nt
    for j=1:nw
        for k=1:n
        if    trafo(i,1)==wire(j,1)&&trafo(i,1)==numbervec(k)
            dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.epp_p,  Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_n);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.ratio_set, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.RatioOut);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_n, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.epp);'],'-append','delimiter','');
        elseif trafo(i,1)==wire(j,2) &&trafo(i,1)==numbervec(k)
            dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.epp_p, Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_p);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.ratio_set, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.RatioOut);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_p, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.epp);'],'-append','delimiter','');
        elseif trafo(i,2)==wire(j,1) &&trafo(i,2)==numbervec(k)
            dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.epp_n, Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_n);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.ratio_set, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.RatioOut);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_n, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.epp);'],'-append','delimiter','');
        elseif trafo(i,2)==wire(j,2) &&trafo(i,2)==numbervec(k)
            dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.epp_n, Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_p);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(sT_',num2str(trafo(i,1)),'_',num2str(trafo(i,2)),'.ratio_set, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.RatioOut);'],'-append','delimiter','');
			dlmwrite(ModelFile,['connect(Path_',num2str(wire(j,1)),'_',num2str(wire(j,2)),'_',num2str(wire(j,4)),'.epp_p, OLTC_',num2str(trafo(i)),'_',num2str(trafo(i,2)),'.epp);'],'-append','delimiter','');
        end
        end
    end
end

%trafo verbindungen mit den brook leitungen (nicht ideal im moment)
for i=1:trafoBrook
    for j=1:wireBrook
        for k=1:trb
            if    clusterITBrook(i,1)==clusterLeitungBrook(j,1)&&clusterITBrook(i,1)==numvec_brook(k)
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.epp_p,  FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_n);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.ratio_set, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.RatioOut);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_n, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.epp);'],'-append','delimiter','');
            elseif clusterITBrook(i,1)==clusterLeitungBrook(j,2) &&clusterITBrook(i,1)==numvec_brook(k)
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.epp_p, FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_p);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.ratio_set, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.RatioOut);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_p, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.epp);'],'-append','delimiter','');
            elseif clusterITBrook(i,2)==clusterLeitungBrook(j,1) &&clusterITBrook(i,2)==numvec_brook(k)
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.epp_n, FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_n);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.ratio_set, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.RatioOut);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_n, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.epp);'],'-append','delimiter','');
            elseif clusterITBrook(i,2)==clusterLeitungBrook(j,2) && clusterITBrook(i,2)==numvec_brook(k)
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.epp_n, FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_p);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(sTb_',num2str(clusterITBrook(i,1)),'_',num2str(clusterITBrook(i,2)),'.ratio_set, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.RatioOut);'],'-append','delimiter','');
                dlmwrite(ModelFile,['connect(FPath_',num2str(clusterLeitungBrook(j,1)),'_',num2str(clusterLeitungBrook(j,2)),'_',num2str(clusterLeitungBrook(j,4)),'.epp_p, OLTCb_',num2str(clusterITBrook(i)),'_',num2str(clusterITBrook(i,2)),'.epp);'],'-append','delimiter','');
            end
        end
    end
end

for i=1:wireBrook 
	dlmwrite(ModelFile,['connect(Step_',num2str(i),'.y,FPath_',num2str(clusterLeitungBrook(i,1)),'_',num2str(clusterLeitungBrook(i,2)),'_',num2str(clusterLeitungBrook(i,4)),'.switched_input);'],'-append','delimiter',''); 
end
for i=1:loadjump
	dlmwrite(ModelFile,['connect(step_',num2str(clusterKJump(i,1)),'.y,Load_',num2str(clusterKJump(i,1)),'.P_el_set);'],'-append','delimiter',''); 
end

%bilden der boolean verbindungen
for i=1:nl
    if load(i,2)==2
        dlmwrite(ModelFile,['connect(const_',num2str(load(i,1)),'.y,G_',num2str(load(i,1)),'.P_el_set);'],'-append','delimiter','');     
    elseif load(i,2)==3
        dlmwrite(ModelFile,['connect(const_',num2str(load(i,1)),'.y,G_',num2str(load(i,1)),'_Slack.P_el_set);'],'-append','delimiter','');  %const an kraftwerk
        dlmwrite(ModelFile,['connect(integrator.y,G_',num2str(load(i,1)),'_Slack.P_SB_set);'],'-append','delimiter','');			 	%integrator an Kraftwerk
        dlmwrite(ModelFile,['connect(integrator.u, feedback.y);'],'-append','delimiter','');											% feedback an integrator
        dlmwrite(ModelFile,['connect(globalFrequency.f, feedback.u2);'],'-append','delimiter','');  									%feedback an globalFrequency
        dlmwrite(ModelFile,['connect(globalFrequency_reference.y, feedback.u1);'],'-append','delimiter','');  							% feedback an globalFrequency_reference
        dlmwrite(ModelFile,['connect(globalFrequency.epp,G_',num2str(load(i,1)),'_Slack.epp);'],'-append','delimiter','');  	% global an Kraftwerk
    else
        %printf('')
    end
end

% dlmwrite(ModelFile,[' connect(Path1.epp_p, Load1.epp);'],'-append','delimiter','');
% Festlegung von Größe und simulationsdauer
dlmwrite(ModelFile,['annotation (    experiment(StartTime=0, StopTime=400),    Diagram(coordinateSystem(extent={{0,0},{400,400}})),    Icon(coordinateSystem(extent={{0,0},{400,400}})));'],'-append','delimiter','');
dlmwrite(ModelFile,['end ' Modelname ';'],'-append','delimiter','');

fprintf('Es gibt %d Referenzknoten!\n',ref ); %protokollierung der Anzahl an Referenzknoten!

