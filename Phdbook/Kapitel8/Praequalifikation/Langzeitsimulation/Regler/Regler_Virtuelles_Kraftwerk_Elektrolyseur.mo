within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Regler_Virtuelles_Kraftwerk_Elektrolyseur
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  import MABook;
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_set annotation (Placement(transformation(extent={{-114,126},{-94,146}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_Angebot annotation (Placement(transformation(extent={{-114,148},{-94,168}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_P_Erzeuger annotation (Placement(transformation(extent={{-114,96},{-94,116}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Elektrolyseur annotation (Placement(transformation(extent={{98,114},{118,134}})));
  Modelica.Blocks.Interfaces.BooleanOutput PRL_erfuellt annotation (Placement(transformation(extent={{104,-156},{124,-136}})));

  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_1 annotation (Placement(transformation(extent={{-112,48},{-92,68}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_1 annotation (Placement(transformation(extent={{-114,-52},{-94,-32}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_2 annotation (Placement(transformation(extent={{-112,34},{-92,54}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_3 annotation (Placement(transformation(extent={{-112,20},{-92,40}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_4 annotation (Placement(transformation(extent={{-112,6},{-92,26}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_5 annotation (Placement(transformation(extent={{-112,-8},{-92,12}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_2 annotation (Placement(transformation(extent={{-114,-66},{-94,-46}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_3 annotation (Placement(transformation(extent={{-114,-80},{-94,-60}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_4 annotation (Placement(transformation(extent={{-114,-94},{-94,-74}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_5 annotation (Placement(transformation(extent={{-114,-108},{-94,-88}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_1 annotation (Placement(transformation(extent={{100,60},{120,80}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_1 annotation (Placement(transformation(extent={{100,-38},{120,-18}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_2 annotation (Placement(transformation(extent={{100,46},{120,66}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_3 annotation (Placement(transformation(extent={{100,32},{120,52}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_4 annotation (Placement(transformation(extent={{100,20},{120,40}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_5 annotation (Placement(transformation(extent={{100,6},{120,26}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_2 annotation (Placement(transformation(extent={{100,-54},{120,-34}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_3 annotation (Placement(transformation(extent={{100,-68},{120,-48}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_4 annotation (Placement(transformation(extent={{100,-82},{120,-62}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_5 annotation (Placement(transformation(extent={{100,-96},{120,-76}})));

  Regler.Aufteilung_RL_Verbraucher_sym aufteilung_Erzeuger annotation (Placement(transformation(extent={{18,100},{50,130}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_1 annotation (Placement(transformation(extent={{-90,52},{-64,78}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_2 annotation (Placement(transformation(extent={{-56,38},{-30,64}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_3 annotation (Placement(transformation(extent={{-22,24},{4,50}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_4 annotation (Placement(transformation(extent={{12,10},{38,36}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_5 annotation (Placement(transformation(extent={{46,-4},{72,22}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_2 annotation (Placement(transformation(extent={{-50,-62},{-24,-36}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_3 annotation (Placement(transformation(extent={{-16,-76},{10,-50}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_4 annotation (Placement(transformation(extent={{18,-90},{44,-64}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_5 annotation (Placement(transformation(extent={{52,-104},{78,-78}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_1 annotation (Placement(transformation(extent={{-84,-48},{-58,-22}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold annotation (Placement(transformation(extent={{78,-156},{98,-136}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_sum_AP annotation (Placement(transformation(extent={{98,172},{118,192}})));
equation

//Berechnet den Nutzungsgrad aller Anlagen
//if (Max_PV_1 + Max_PV_2 + Max_PV_3 + Max_PV_4 + Max_PV_5 + Max_Wind_1 + Max_Wind_2 + Max_Wind_3 + Max_Wind_4 + Max_Wind_5)<=-0.1 then
//  Usage_EE = (P_set_PV_1 + P_set_PV_2 + P_set_PV_3 + P_set_PV_4 + P_set_PV_5 + P_set_Wind_1 + P_set_Wind_2 + P_set_Wind_3 + P_set_Wind_4 + P_set_Wind_5)/(Max_PV_1 + Max_PV_2 + Max_PV_3 + Max_PV_4 + Max_PV_5 + Max_Wind_1 + Max_Wind_2 + Max_Wind_3 + Max_Wind_4 + Max_Wind_5);
//else
//  Usage_EE=1;
//end if;

//if Max_P_Erzeuger<=-0.1 then
//  Usage_Erzeuger =(P_set_Elektrolyseur/Max_P_Erzeuger);
//else
//  Usage_Erzeuger=1;
//end if;
P_sum_AP=aufteilung_PV_1.P_AP+aufteilung_PV_2.P_AP+aufteilung_PV_3.P_AP+aufteilung_PV_4.P_AP+aufteilung_PV_5.P_AP+aufteilung_Wind_1.P_AP+aufteilung_Wind_2.P_AP+aufteilung_Wind_3.P_AP+aufteilung_Wind_4.P_AP+aufteilung_Wind_5.P_AP;
  connect(Max_PV_1, aufteilung_PV_1.P_max) annotation (Line(points={{-102,58},{-86,58},{-86,58.11},{-89.48,58.11}}, color={0,127,127}));
  connect(aufteilung_PV_1.P_set, P_set_PV_1) annotation (Line(
      points={{-62.44,71.24},{98,71.24},{98,70},{110,70}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_1.P_RL_Restangebot, aufteilung_PV_2.P_RL_Angebot) annotation (Line(
      points={{-62.18,61.1},{-58.09,61.1},{-58.09,61.27},{-55.22,61.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_1.P_RL_Rest, aufteilung_PV_2.P_RL_set) annotation (Line(
      points={{-62.18,54.6},{-59.09,54.6},{-59.09,55.29},{-55.22,55.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_2.P_set, P_set_PV_2) annotation (Line(
      points={{-28.44,57.24},{50,57.24},{50,56},{110,56}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_2.P_RL_Restangebot, aufteilung_PV_3.P_RL_Angebot) annotation (Line(
      points={{-28.18,47.1},{-22.09,47.1},{-22.09,47.27},{-21.22,47.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_2.P_RL_Rest, aufteilung_PV_3.P_RL_set) annotation (Line(
      points={{-28.18,40.6},{-22.09,40.6},{-22.09,41.29},{-21.22,41.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_set, P_set_PV_3) annotation (Line(
      points={{5.56,43.24},{46,43.24},{46,42},{110,42}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_RL_Restangebot, aufteilung_PV_4.P_RL_Angebot) annotation (Line(
      points={{5.82,33.1},{8.91,33.1},{8.91,33.27},{12.78,33.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_RL_Rest, aufteilung_PV_4.P_RL_set) annotation (Line(
      points={{5.82,26.6},{8.91,26.6},{8.91,27.29},{12.78,27.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_4.P_max, Max_PV_4) annotation (Line(points={{12.52,16.11},{-66.74,16.11},{-66.74,16},{-102,16}}, color={0,127,127}));
  connect(aufteilung_PV_4.P_set, P_set_PV_4) annotation (Line(
      points={{39.56,29.24},{48.78,29.24},{48.78,30},{110,30}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_PV_3, aufteilung_PV_3.P_max) annotation (Line(points={{-102,30},{-62,30},{-62,30.11},{-21.48,30.11}}, color={0,127,127}));
  connect(Max_PV_2, aufteilung_PV_2.P_max) annotation (Line(points={{-102,44},{-78,44},{-78,44.11},{-55.48,44.11}}, color={0,127,127}));
  connect(aufteilung_PV_4.P_RL_Restangebot, aufteilung_PV_5.P_RL_Angebot) annotation (Line(
      points={{39.82,19.1},{42.91,19.1},{42.91,19.27},{46.78,19.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_4.P_RL_Rest, aufteilung_PV_5.P_RL_set) annotation (Line(
      points={{39.82,12.6},{43.91,12.6},{43.91,13.29},{46.78,13.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_5.P_set, P_set_PV_5) annotation (Line(
      points={{73.56,15.24},{88.78,15.24},{88.78,16},{110,16}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_PV_5, aufteilung_PV_5.P_max) annotation (Line(points={{-102,2},{-30,2},{-30,2.11},{46.52,2.11}}, color={0,127,127}));
  connect(aufteilung_Wind_2.P_RL_Restangebot, aufteilung_Wind_3.P_RL_Angebot) annotation (Line(
      points={{-22.18,-52.9},{-16.09,-52.9},{-16.09,-52.73},{-15.22,-52.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_2.P_RL_Rest, aufteilung_Wind_3.P_RL_set) annotation (Line(
      points={{-22.18,-59.4},{-16.09,-59.4},{-16.09,-58.71},{-15.22,-58.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_RL_Restangebot, aufteilung_Wind_4.P_RL_Angebot) annotation (Line(
      points={{11.82,-66.9},{14.91,-66.9},{14.91,-66.73},{18.78,-66.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_RL_Rest, aufteilung_Wind_4.P_RL_set) annotation (Line(
      points={{11.82,-73.4},{14.91,-73.4},{14.91,-72.71},{18.78,-72.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_RL_Restangebot, aufteilung_Wind_5.P_RL_Angebot) annotation (Line(
      points={{45.82,-80.9},{48.91,-80.9},{48.91,-80.73},{52.78,-80.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_RL_Rest, aufteilung_Wind_5.P_RL_set) annotation (Line(
      points={{45.82,-87.4},{49.91,-87.4},{49.91,-86.71},{52.78,-86.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_1.P_RL_Restangebot, aufteilung_Wind_2.P_RL_Angebot) annotation (Line(
      points={{-56.18,-38.9},{-54.09,-38.9},{-54.09,-38.73},{-49.22,-38.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_1.P_RL_Rest, aufteilung_Wind_2.P_RL_set) annotation (Line(
      points={{-56.18,-45.4},{-54.09,-45.4},{-54.09,-44.71},{-49.22,-44.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_1.P_max, Max_Wind_1) annotation (Line(points={{-83.48,-41.89},{-92.74,-41.89},{-92.74,-42},{-104,-42}}, color={0,127,127}));
  connect(Max_Wind_2, aufteilung_Wind_2.P_max) annotation (Line(points={{-104,-56},{-78,-56},{-78,-55.89},{-49.48,-55.89}}, color={0,127,127}));
  connect(Max_Wind_3, aufteilung_Wind_3.P_max) annotation (Line(points={{-104,-70},{-60,-70},{-60,-69.89},{-15.48,-69.89}}, color={0,127,127}));
  connect(Max_Wind_4, aufteilung_Wind_4.P_max) annotation (Line(points={{-104,-84},{-46,-84},{-46,-83.89},{18.52,-83.89}}, color={0,127,127}));
  connect(Max_Wind_5, aufteilung_Wind_5.P_max) annotation (Line(points={{-104,-98},{-28,-98},{-28,-97.89},{52.52,-97.89}}, color={0,127,127}));
  connect(aufteilung_Wind_1.P_set, P_set_Wind_1) annotation (Line(
      points={{-56.44,-28.76},{23.78,-28.76},{23.78,-28},{110,-28}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(P_set_Wind_1, P_set_Wind_1) annotation (Line(
      points={{110,-28},{110,-28}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_2.P_set, P_set_Wind_2) annotation (Line(
      points={{-22.44,-42.76},{38.78,-42.76},{38.78,-44},{110,-44}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_set, P_set_Wind_3) annotation (Line(
      points={{11.56,-56.76},{56.78,-56.76},{56.78,-58},{110,-58}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_set, P_set_Wind_4) annotation (Line(
      points={{45.56,-70.76},{45.56,-72},{110,-72}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_5.P_set, P_set_Wind_5) annotation (Line(
      points={{79.56,-84.76},{79.56,-84.38},{110,-84.38},{110,-86}},
      color={0,135,135},
      pattern=LinePattern.Dash));

  connect(greaterEqualThreshold.y, PRL_erfuellt) annotation (Line(points={{99,-146},{114,-146}},                     color={255,0,255}));
  connect(aufteilung_PV_5.P_RL_Restangebot, aufteilung_Wind_1.P_RL_Angebot) annotation (Line(
      points={{73.82,5.1},{88,5.1},{88,-18},{-92,-18},{-92,-24.73},{-83.22,-24.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_5.P_RL_Rest, aufteilung_Wind_1.P_RL_set) annotation (Line(
      points={{73.82,-1.4},{84,-1.4},{84,-14},{-96,-14},{-96,-30.71},{-83.22,-30.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Erzeuger.P_RL_Restangebot, aufteilung_PV_1.P_RL_Angebot) annotation (Line(
      points={{52.24,110.5},{92,110.5},{92,86},{-98,86},{-98,75.27},{-89.22,75.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Erzeuger.P_RL_Rest, aufteilung_PV_1.P_RL_set) annotation (Line(
      points={{52.24,103},{88,103},{88,90},{-104,90},{-104,69.29},{-89.22,69.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PRL_Angebot, aufteilung_Erzeuger.P_RL_Angebot) annotation (Line(points={{-104,158},{-26,158},{-26,126.85},{18.96,126.85}}, color={0,127,127}));
  connect(PRL_set, aufteilung_Erzeuger.P_RL_set) annotation (Line(points={{-104,136},{-28,136},{-28,119.95},{18.96,119.95}}, color={0,127,127}));
  connect(aufteilung_Wind_5.P_RL_Restangebot, greaterEqualThreshold.u) annotation (Line(
      points={{79.82,-94.9},{88,-94.9},{88,-128},{60,-128},{60,-146},{76,-146}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Erzeuger.P_set, P_set_Elektrolyseur) annotation (Line(
      points={{51.92,122.2},{77.96,122.2},{77.96,124},{108,124}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_P_Erzeuger, aufteilung_Erzeuger.P_max) annotation (Line(points={{-104,106},{-44,106},{-44,107.05},{18.64,107.05}}, color={0,127,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,200}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,200}})),
    Documentation(info="<html>
<p>Betriebsf&uuml;hrung und &quot;Fallregler&quot; f&uuml;r ein virtuelles Kraftwerk mit einem Elektrolyseur</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Regler_Virtuelles_Kraftwerk_Elektrolyseur;
