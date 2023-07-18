% ------------------------------------------------------------------------
%  Newton Raphson Lastflulssrechnung
%
%  Prinzip:
%  - Die Parametervektoren sind sortiert zu uebergeben. d.h.: 
%    Slackknoten, PU-Knoten, PQ-Knoten
%  - Parameter:      Pg, Qg     = Einspeisungen in allen Knoten
%                    Pl, Ql     = Lasten in allen Knoten
%                    Qmin, Qmax = Blindleistungsschranken der Einspeisungen 
%                    U          = Betraege der Knotenspannungssollwerte
%                    Y          = Sortierte Knotenadmittanzmatrix
%                    Err        = Konvergenzschranke fuer Iteration
%
%  Transformatoren werden von ue=1 um trafostuf ttd(11)
%     gestuft im Bereich trafostufmin ttd(9) bis -max ttd(10)
%  Stufung erfolgt, wenn Sekundaerspannung  
%     ausserhalb trafospannungmin ttd(12) und -max ttd(13)
%     Bei trafospannungmin = 0 und -max = 2  
%     keine Stufung
%  (ttd ist eine Matrix, die Daten aller Transformatoren enthält und in 
%  Netzdatendatei definiert werden muss) 
%
%  Autor:    D. Westermann, C. Rehtanz
%  Datum:    6.12.1996
%  aenderung:
%
% ------------------------------------------------------------------------
%	Aufruf in bd_sim1718ini mit pst_lfnr(Pg,Qg,Pl,Ql,Emin,Emax,dmax,xd,U,ltd,ttd,ltdrossel,k,pu,Err,lfanz);
function [Pa,Qa,Ua,DTAa,Y,Qmaxa,TTa,konvfehler] = PST_LF(Pg,Qg,Pl,Ql,Emin,Emax,dmax,xd,U,ltd,ttd,drossel,k,m,Err,lfanz,cluster,AnzCluster);

if size(Err)~=[5,1],
     Err(2) = 50;
     Err(3) = 2;
     Err(4) = 2;
     Err(5) = inf;
end; 

Error = Err(1);
itmax     = Err(2);         % Maximale Anzahl von Iterationen 
trafoschritt = Err(3);      % Transformatoren werden nur bei jeder 
                            %     trafoschritt. Iteration gestuft
refschritt = Err(4);        % Leistungsanpassung der Gen.-einspeisung
                            %     nur bei jeder refschritt. Iteration
refpmax = Err(5);           % Maximal erlaubte Leistungsabweichung des 
                            %     Referenzknotens vom Sollwert
                            %     bei refpmax = inf keine Anpassung
   
  Pa        = Pg-Pl;
  Qa        = Qg-Ql;
  Qmin1 = zeros (AnzCluster,1);
  Qmin2 = zeros (AnzCluster,1);
  Qmin  = zeros (AnzCluster,1);
  Qmax  = zeros (AnzCluster,1);
  PU        = 2:m;
  PQ        = m+1:AnzCluster;
  Ua(1:m,1) = U(1:m,1);
  Ua(PQ,1)  = ones(AnzCluster-m,1);
  U = Ua;
  DTAa      = zeros(k,1);
  [tra,bla] = size (ttd); 
  [lta,bla] = size (ltd); 
  e = U;
  f = zeros (AnzCluster,1);
  kue = 1;

  % Aufbau des konstanten Teils des Ergebnisvektors
  pg  = Pg;
  ppi  = Pg - Pl;
  qi  = Qg - Ql;
  ui2 = zeros(k,1);
  ui2(PU) = U(PU).^2;

  % Initializierung der Delta-Werte
  de  = zeros (k-1,1);
  df  = zeros (k-1,1);
  dp  = zeros (k,1);
  dq  = zeros (k,1);
  du2 = zeros (k,1);

  % Initializierung der Iterationswerte
  pik  = zeros (k,1);
  qik  = zeros (k,1);
  uik2 = zeros (k,1);

% Aufstellen der Knotenadmittanzmatrix in Abhängigkeit 
% der Trafostufungen ue = ttd(lauf,7)
  Yl   = zeros(k,k);
  Yt   = zeros(k,k);
  Y    = zeros(k,k);
  for lauf=1:lta,
     ak  = ltd(lauf,1); 
     ek  = ltd(lauf,2);
     yij = inv(ltd(lauf,3)+i*ltd(lauf,4));
     yii = i*0.5*ltd(lauf,5);    

     Yl(ak,ak) = Yl(ak,ak)+yii+yij;
     Yl(ek,ek) = Yl(ek,ek)+yii+yij;	
     Yl(ak,ek) = Yl(ak,ek)-yij;
     Yl(ek,ak) = Yl(ek,ak)-yij;	
  end

  if isempty(ttd)~=1
  for lauf=1:tra,
     ak  = ttd(lauf,1); 
     ek  = ttd(lauf,2);
     yij = inv(ttd(lauf,3)+i*ttd(lauf,4));
     ue  = ttd(lauf,7)+i*ttd(lauf,8);
    
     Yt(ak,ak) = Yt(ak,ak)+(yij)/(ue*ue);
     Yt(ek,ek) = Yt(ek,ek)+yij;	
     Yt(ak,ek) = Yt(ak,ek)-yij/conj(ue);
     Yt(ek,ak) = Yt(ek,ak)-yij/ue;	
  end
  end
	
  if isempty(drossel)~=1
    for lauf=1:size(drossel,1),
      ak  =  drossel(lauf,1);
      yii =  -i*inv(drossel(lauf,3));
 
      Yl(ak,ak)=Yl(ak,ak)+yii;
     end
  end   

  Y=Yl+Yt;

KUeb=cluster(:,1);
KRed=cluster(:,2:end);
KRed=KRed(:);

loesch=zeros(length(KRed),1);
for zaehlneu=1:length(KRed)
    if KRed(zaehlneu)==0
        loesch(zaehlneu)=1;
    end
end

KRed(loesch==1)=[];

KRed=sort(KRed);

Yr=Y;

% Matrix-Reduktion
Y11 = Yr(KUeb,KUeb);
Y12 = Yr(KUeb,KRed);
Y21 = Yr(KRed,KUeb);
Y22 = Yr(KRed,KRed);

Yred = Y11-Y12*(Y22\Y21);

Y=Yred;

  % Aufteilung  der Admittanzen
  g = real (Y);
  b = imag (Y);

  % Steuervariablen
  itanz = 0;
  iteration = 1;
  
  k=AnzCluster;
  
  while (iteration | (kue==1)) & (itanz<itmax)
    itanz = itanz + 1;
	
    % Bestimmung der Wirkleistungen und Spannungen aus e und f an Generatorknoten
    uik2(PU) = e(PU).^2 + f(PU).^2;
    
    pik(PU) = e(PU).* (g(PU,1:k)*e(1:k)-b(PU,1:k)*f(1:k)) + ...
              f(PU).* (g(PU,1:k)*f(1:k)+b(PU,1:k)*e(1:k));

    % Bestimmung der Wirkleistungen und Blindleistung aus e und f an Lastknoten
    pik(PQ) = e(PQ).* (g(PQ,1:k)*e(1:k)-b(PQ,1:k)*f(1:k)) + ...
              f(PQ).* (g(PQ,1:k)*f(1:k)+b(PQ,1:k)*e(1:k));

    qik(PQ) = f(PQ).* (g(PQ,1:k)*e(1:k)-b(PQ,1:k)*f(1:k)) - ...
              e(PQ).* (g(PQ,1:k)*f(1:k)+b(PQ,1:k)*e(1:k));
    % Aufbau der Jacobi-Matrix, basierend auf sortierten b und g Elementen
        % Filter Nebendiagonale
	FND =  ones(k)-diag(ones(k,1));

        % P relevante Matrizen:
	J1 = (-diag(e)*b + diag(f)*g).*FND;
	J1 = J1 + diag(2*f.*diag(g) + (g.*FND)*f + (b.*FND)*e);

	J2 = (diag(e)*g + diag(f)*b).*FND;
	J2 = J2 + diag(2*e.*diag(g) + (g.*FND)*e - (b.*FND)*f);

        % Q relevante Matrizen:
	J3 = (-diag(e)*g - diag(f)*b).*FND;
	J3 = J3 + diag(-2*f.*diag(b) + (g.*FND)*e - (b.*FND)*f);

	J4 = (-diag(e)*b + diag(f)*g).*FND;
	J4 = J4 - diag(2*e.*diag(b) + (g.*FND)*f + (b.*FND)*e);

        % U2 relevante Matrizen: Nur Elemente der Hauptdiagonalen
	J5 = diag(2*f);
	J6 = diag(2*e);
   
        % Gesamte Jacobi Matrix
        J = [ J1(2:k,2:k) , J2(2:k,2:k); ...
              J3(PQ,2:k)  , J4(PQ,2:k) ; ...
              J5(PU,2:k)  , J6(PU,2:k)];

        % Bestimmung der Delta-Werte
    
        dp  = ppi  - pik;
        dq  = qi   - qik;
        du2 = ui2  - uik2;

        epsilon = norm ([dp(2:k); dq(PQ); du2(PU)], inf);
        iteration = epsilon > Error;
	
     if iteration | kue==1,
	% Spannungen bestimmen:
        ef_h = inv(J) * [dp(2:k); dq(PQ); du2(PU)];
        de = ef_h (k:2*(k-1));
	df = ef_h (1:k-1);
          
	% Verbesserte Spannungswerte bestimmen:
	e(2:k) = e(2:k) + de;
	f(2:k) = f(2:k) + df;

	% Berechnung der aktuellen Blindleistungsgrenzen
%        Qmin1(2:m)  = -U(2:m).^2./xd(2:m)+pg(2:m)./tan(dmax(2:m)*pi/180);
%	Qmin2(2:m) = (Emin(2:m).*U(2:m)-U(2:m).^2)./xd(2:m);

%        for lauf = 2:m,
%	   if Qmin1(lauf) < Qmin2(lauf),
%	      Qmin(lauf) = Qmin2(lauf);
% 	   else 
%	      Qmin(lauf) = Qmin1(lauf);
%           end;
%        end;

%	Qmax(2:m) = sqrt ((Emax(2:m).*U(2:m)./xd(2:m)).^2 - pg(2:m).^2)...
%			 - (U(2:m).^2)./xd(2:m);
Qmax(2:m)=Emax(2:m);
Qmin(2:m)=Emin(2:m);

	% Zurückwandeln von PQ- in PU-Knoten bei Grenzeinhaltungen der
	% Blindleistungseinspeisungen [Qg]

	ul = e + i*f;
        PUneu = [];
        PQneu = [];
        for lauf=PQ,        
           if lauf<m+1,
              Ua1        = ul(lauf,1);            
              ul(lauf,1) = U(lauf,1)*exp(i*angle(ul(lauf,1)));
              PU1        = [PUneu,lauf];
	      Qg(PU1) = imag(ul(PU1).*conj(Y(PU1,:)*ul))+Ql(PU1);

              if Qg(PU1)>=Qmin(PU1) & Qg(PU1)<=Qmax(PU1),
                 PUneu = PU1;
              else 
	         if Qg(lauf)<Qmin(lauf),
                    qi(lauf) = Qmin(lauf)-Ql(lauf);
                 elseif Qg(lauf)>Qmax(lauf),         
                    qi(lauf) = Qmax(lauf)-Ql(lauf);
		 end;
                 ul(lauf,1) = Ua1;
                 PQneu      = [PQneu,lauf];
              end
           else
              break 
           end
        end

	% Umwandeln von PU- in PQ-Knoten bei Grenzverletzungen der
	% Blindleistungseinspeisungen [Qg]
	if max(size(PU))~=0,
	  Qg(2:m) = imag(ul(2:m).*conj(Y(2:m,:)*ul))+Ql(2:m);

          for lauf=PU,
            if Qg(lauf)<Qmin(lauf),
               PQneu = [PQneu,lauf]; 
               qi(lauf) = Qmin(lauf)-Ql(lauf);
            elseif Qg(lauf)>Qmax(lauf),         
               PQneu = [PQneu,lauf];
               qi(lauf) = Qmax(lauf)-Ql(lauf);
            else 
               PUneu = [PUneu,lauf]; 
            end;
          end;
	end;
        PU = sort(PUneu);
        PQ = sort([PQneu,m+1:k]);

	% Leistungsanpassung Referenzknoten
	  if (rem(itanz,refschritt)==0),
	
	    % Wirkleistung im Referenzknoten
	    pa(1) = real(ul(1)*conj(Y(1,:)*ul));	    
	  
	    % Leistungszuschlag bei prozentualer Beibehaltung des Kraftwerkseinspeisemusters
	    if abs(pa(1)-pg(1)) > refpmax,
	      pg(2:m)   = pg(2:m) + (pa(1)-pg(1))*pg(2:m)/sum(pg(2:m));
	      ppi = pg-Pl;	
	    end;
	  end;
	% Ende Leistungsanpassung


	% Trafostufung
	Ua=abs(ul);
	kue = 0;
	if ((itanz>2)&(rem(itanz,trafoschritt)==0)),
	    for lauf=1:tra,
	      if ((ttd(lauf,7)>ttd(lauf,9))&(ttd(lauf,7)<ttd(lauf,10))),
              	if Ua(ttd(lauf,2),1)<ttd(lauf,12),
	          ttd(lauf,7) = ttd(lauf,7)-ttd(lauf,11);
        	  kue = 1;
	        end
  	        if Ua(ttd(lauf,2),1)>ttd(lauf,13),
         	  ttd(lauf,7) = ttd(lauf,7)+ttd(lauf,11);
	          kue = 1;
                end
              end 
            end

% 	% Neuaufstellen des Trafoteils der Knotenadmittanzmatrix
% 	  Yt   = zeros(k,k);
% 	  for lauf=1:tra,
% 	     ak  = ttd(lauf,1); 
% 	     ek  = ttd(lauf,2);
% 	     yij = inv(ttd(lauf,3)+i*ttd(lauf,4));
% 	     ue  = ttd(lauf,7)+i*ttd(lauf,8);
%     
%       	     Yt(ak,ak) = Yt(ak,ak)+(yij)/(ue*ue);
% 	     Yt(ek,ek) = Yt(ek,ek)+yij;	
% 	     Yt(ak,ek) = Yt(ak,ek)-yij/conj(ue);
%      	     Yt(ek,ak) = Yt(ek,ak)-yij/ue;	
%  	  end
% 	
% 	  Y=Yl+Yt;
% 	  g = real (Y);
% 	  b = imag (Y);
 	else     % Trafostufung
	  kue=1;
	end;     % Trafostufung
%TTa = ttd(:,7)';
%TTa
%Ua(1:8)'
%[PU 0 PQ]
%Qg(1:4)'
%Qmax(1:4)'
%pause

     end;
  end; 		%Ende der Iterationsschleife 

  % Ausgangsvektoren berechnen    
  ul = e + i*f;
  Pa=ppi;
  Pa(1) = real(ul(1)*conj(Y(1,:)*ul));
  Qa(1:m) = imag(ul(1:m).*conj(Y(1:m,:)*ul));
  Ua    = abs(ul);
  DTAa  = angle(ul);
  Qmaxa = Qmax (1:m);
  if ~isempty(ttd)
	TTa = ttd(:,7);
  else
	TTa = [];
  end;
  
  if itanz == itmax
	konvfehler=1;
  else 
        konvfehler=0;
  end;
