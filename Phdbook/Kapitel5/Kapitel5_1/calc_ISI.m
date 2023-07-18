%% calc_ISI
% This function calculates the Thevenin Equivalent Impedance as 
% described by Šmon et al. in their paper from 2006, as well as the 
% impedance stability index (ISI)

function [Z_k,Z_th,ISI,S,I] = calc_ISI(t,p,q,v,delta)
    [n,~]=size(t); % Anzahl Zeitpunkte
    S = p + q .* 1i; % Komplexe Leistung am Knoten
    u = v .* exp(delta .* 1i); % Komplexe Spannug am Knoten
    Z_k = u .^ 2 ./ S; % Impedanz am Knoten aus Spannung und Leistung
    Z_k_ISI = abs(Z_k);
    I = conj(S ./ u); % komplexe Stromstaerke
    delta_u = zeros(n-1,1); delta_i = delta_u; % initialisieren
    delta_u = u(2:end) - u(1:end-1); % Berechne Differenzen
    delta_I = I(2:end) - I(1:end-1); % Berechne Differenzen
    Z_th = conj(delta_u) ./ delta_I; % Berechne Thevenin Impedanz
%     for fori = 2:length(Z_th)
%         if (abs(delta_I(fori)) <=  0.015) || (delta_u(fori) ==  0)
%             Z_th(fori) = Z_th(fori-1);
%         end
%     end
%     Z_th(abs(delta_I) <=  0.015) = temp_Zth_versch(abs(delta_I) <=  0.015); % mit 0 ersetzen
%     Z_th(delta_u ==  0) = temp_Zth_versch(delta_u ==  0); % mit 0 ersetzen
%     Z_th(delta_u ==  0) = 0; % mit 0 ersetzen
    Z_th_ISI = abs(Z_th);
    ISI = (Z_k_ISI(2:end) - Z_th_ISI) ./ Z_k_ISI(2:end); % ISI
%     Z_k_basis = ones(size(Z_k,1)-1,1).*Z_k(1); % statischer Z_k
%     ISI_basis = (Z_k(1:end-1) - Z_th) ./ Z_k(1:end-1); % Basis ISI
end