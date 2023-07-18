within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Aufteilung_RL_recFC_SRL
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_Angebot annotation (Placement(transformation(extent={{-122,58},{-82,100}}), iconTransformation(extent={{-122,58},{-82,100}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_RL_set annotation (Placement(transformation(extent={{-124,4},{-84,46}}),  iconTransformation(extent={{-124,4},{-84,46}})));
  input
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_max annotation (Placement(transformation(extent={{-126,-78},{-86,-36}}), iconTransformation(extent={{-116,-74},{-76,-32}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Restangebot annotation (Placement(transformation(extent={{94,-50},{134,-10}}),iconTransformation(extent={{94,-50},{134,-10}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_Rest annotation (Placement(transformation(extent={{92,-98},{132,-58}}),
                                                                                                                                     iconTransformation(extent={{94,-96},{134,-56}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set annotation (Placement(transformation(extent={{92,28},{132,68}}),   iconTransformation(extent={{92,28},{132,68}})));
  parameter Real SOC_soll=0.5;
   Real Abruf;
  Modelica.Blocks.Math.Abs P_max_abs annotation (Placement(transformation(extent={{-52,-62},{-32,-42}})));
  Modelica.Blocks.Interfaces.RealInput SOC annotation (Placement(transformation(
        extent={{-22,-22},{22,22}},
        rotation=270,
        origin={4,110}), iconTransformation(extent={{-25,-25},{25,25}},
        rotation=270,
        origin={1,113})));
equation
  if P_RL_Angebot<0 then
    Abruf=P_RL_set/P_RL_Angebot;
  else
    Abruf=0;
  end if;
  if Abruf>0 then
  if P_RL_Angebot>=-P_max_abs.y then
    P_set=Abruf*P_RL_Angebot;
    P_RL_Restangebot=0;
    P_RL_Rest=0;
  else
    P_RL_Restangebot=P_RL_Angebot+(P_max_abs.y);
    P_set=Abruf*P_max;
    P_RL_Rest=P_RL_Restangebot*Abruf;
  end if;
  else
    if P_RL_Angebot>=-P_max_abs.y then
    P_set=Abruf*P_RL_Angebot;
    P_RL_Restangebot=0;
    P_RL_Rest=0;
    else
      P_RL_Restangebot=P_RL_Angebot+(P_max_abs.y);
      if SOC>SOC_soll then
        P_set=-Abruf*P_max;
        P_RL_Rest=P_RL_Restangebot*Abruf;
      else
         if P_max>P_RL_set then
      P_set=P_RL_set;
      P_RL_Rest=0;
        else
      P_set=P_max;
      P_RL_Rest=P_RL_set-P_max;
        end if;
      end if;
    end if;
  end if;

  connect(P_max, P_max_abs.u) annotation (Line(points={{-106,-57},{-80,-57},{-80,-52},{-54,-52}}, color={0,127,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-120,-10},{120,110}}, color={28,108,200}),
        Line(points={{-120,-110},{140,20}}, color={28,108,200}),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{-128,-28},{74,106}},
                                                                                                                                                                color={28,108,200}),
                                                                                                                                Line(points={{-72,-114},{130,20}},
                                                                                                                                                                color={28,108,200})}),
    experiment(
      StopTime=7200000,
      Interval=10.000008,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Aufteilung von Regelleistung einer Reversiblen Brennstoffzelle zur Erbringung von Sekund&auml;rregelleistung</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Aufteilung_RL_recFC_SRL;
