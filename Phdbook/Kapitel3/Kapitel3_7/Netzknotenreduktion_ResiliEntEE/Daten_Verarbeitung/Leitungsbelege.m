%%Leitungsbelege berechnen

Cr380=0.0275;  Cr220=0.0744;    %Wiederstandbelag [Ohm/km]
Cx380=0.264;   Cx220=0.319;     %Reaktanzbelag [Ohm/km]
Cc380=13.8;    Cc220=11.3;      %Kapazitätsbelag [nF/km]
Zb=128; f=50;                   %Bezugsimpedanz [Ohm] und Frequenz [Hz]

Rb380=Cr380/Zb;                 %Berechnet die Bezogenengrößen
Xb380=Cx380/Zb;
Bb380=Cc380*f*Zb*2*pi*1e-9;
Rb220=Cr220/Zb;
Xb220=Cx220/Zb;
Bb220=Cc220*2*pi*f*Zb*1e-9;