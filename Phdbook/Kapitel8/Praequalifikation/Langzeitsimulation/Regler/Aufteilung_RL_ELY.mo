within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Aufteilung_RL_ELY
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_Angebot annotation (Placement(transformation(extent={{-122,58},{-82,100}}), iconTransformation(extent={{-122,58},{-82,100}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_set annotation (Placement(transformation(extent={{-124,4},{-84,46}}),  iconTransformation(extent={{-124,4},{-84,46}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_ELY annotation (Placement(transformation(extent={{-126,-78},{-86,-36}}), iconTransformation(extent={{-116,-74},{-76,-32}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Restangebot annotation (Placement(transformation(extent={{94,-50},{134,-10}}),iconTransformation(extent={{94,-50},{134,-10}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Rest annotation (Placement(transformation(extent={{92,-98},{132,-58}}),
                                                                                                                                     iconTransformation(extent={{94,-96},{134,-56}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set annotation (Placement(transformation(extent={{92,28},{132,68}}),   iconTransformation(extent={{92,28},{132,68}})));
   Real Abruf;
equation
  P_RL_Restangebot=P_RL_Angebot;
  if P_RL_Angebot<0 then
    Abruf=P_RL_set/P_RL_Angebot;
  else
    Abruf=0;
  end if;
  if P_RL_set<0 then
    P_RL_Rest=P_RL_set;
    P_set=0;
  else
    if P_RL_set>=P_ELY then
      P_set=P_ELY;
    P_RL_Rest=P_RL_set-P_ELY;
    else
    P_set=P_RL_set;
    P_RL_Rest=0;
    end if;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-120,-10},{120,110}}, color={28,108,200}),
        Line(points={{-120,-110},{140,20}}, color={28,108,200}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{-128,-28},{74,106}},
                                                                                                                                                                color={28,108,200}),
                                                                                                                                Line(points={{-72,-114},{130,20}},
                                                                                                                                                                color={28,108,200})}),
    experiment(
      StopTime=360000,
      Interval=10.000008,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Aufteilung von Regelleistung eineeines Elektrolyseurs zur Erbringung von Regelleistung</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Aufteilung_RL_ELY;
