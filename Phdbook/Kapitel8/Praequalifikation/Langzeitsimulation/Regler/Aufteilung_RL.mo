within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Aufteilung_RL
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_Angebot annotation (Placement(transformation(extent={{-114,58},{-74,100}}), iconTransformation(extent={{-114,58},{-74,100}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_set annotation (Placement(transformation(extent={{-114,12},{-74,54}}), iconTransformation(extent={{-114,12},{-74,54}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_max annotation (Placement(transformation(extent={{-126,-78},{-86,-36}}), iconTransformation(extent={{-116,-74},{-76,-32}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Restangebot annotation (Placement(transformation(extent={{94,-50},{134,-10}}),iconTransformation(extent={{94,-50},{134,-10}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Rest annotation (Placement(transformation(extent={{92,-98},{132,-58}}),
                                                                                                                                     iconTransformation(extent={{94,-100},{134,-60}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set annotation (Placement(transformation(extent={{92,28},{132,68}}),   iconTransformation(extent={{92,28},{132,68}})));
   Real Abruf;
  output TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_AP annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,120})));
equation
  if P_RL_Angebot<0 then
    Abruf=P_RL_set/P_RL_Angebot;
  else
    Abruf=0;
  end if;
  if 2*P_RL_Angebot>=P_max then
    P_set=P_max-P_RL_Angebot+Abruf*P_RL_Angebot;
    P_RL_Restangebot=0;
    P_RL_Rest=0;
    P_AP=P_max-P_RL_Angebot;
  else
    P_set=0.5*P_max*(1+Abruf);
    P_RL_Restangebot=P_RL_Angebot-(0.5*P_max);
    P_RL_Rest=P_RL_Restangebot*Abruf;
    P_AP=0.5*P_max;
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-120,-10},{120,110}}, color={28,108,200}),
        Line(points={{-120,-110},{140,20}}, color={28,108,200}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{-128,-28},{74,106}},
                                                                                                                                                                color={28,108,200}),
                                                                                                                                Line(points={{-72,-114},{130,20}},
                                                                                                                                                                color={28,108,200})}),
    Documentation(info="<html>
<p>Aufteilung von Regelleisunng f&uuml;r Erneuerbare Erzeuger</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Aufteilung_RL;
