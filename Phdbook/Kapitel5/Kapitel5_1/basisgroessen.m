%% basisgrößen Kalkulation
% Beschreibung

function [Z_k,S,u,I] = basisgroessen(t,p,q,v,delta)
    S = p + q .* 1i; % Komplexe Leistung am Knoten
    u = v .* exp(delta .* 1i); % Komplexe Spannug am Knoten
    Z_k = u .^ 2 ./ S; % Impedanz am Knoten aus Spannung und Leistung
    I = conj(S ./ u); % komplexe StromstÃ¤rke
end