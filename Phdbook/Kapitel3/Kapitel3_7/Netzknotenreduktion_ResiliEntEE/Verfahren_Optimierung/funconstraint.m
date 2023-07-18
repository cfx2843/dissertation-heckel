function [funun,funeq] = funconstraint(SGleichungenstring)
%FUNCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here

[AnzSGleichung,~]=size(SGleichungenstring);

for lauf=1:AnzSGleichung
    funeq{lauf}=SGleichungenstring{lauf};
    
end

funun = [];

end

