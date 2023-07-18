within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Regler_Virtuelles_Kraftwerk_ELY
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
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_set annotation (Placement(transformation(extent={{-112,80},{-92,100}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_Angebot annotation (Placement(transformation(extent={{-112,98},{-92,118}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_P_ELY annotation (Placement(transformation(extent={{-114,168},{-94,188}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_LiIon annotation (Placement(transformation(extent={{94,178},{114,198}})));
  Modelica.Blocks.Interfaces.BooleanOutput PRL_erfuellt annotation (Placement(transformation(extent={{102,-184},{122,-164}})));

  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_1 annotation (Placement(transformation(extent={{-116,26},{-96,46}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_1 annotation (Placement(transformation(extent={{-116,-92},{-96,-72}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_2 annotation (Placement(transformation(extent={{-116,4},{-96,24}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_3 annotation (Placement(transformation(extent={{-116,-14},{-96,6}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_4 annotation (Placement(transformation(extent={{-116,-36},{-96,-16}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_5 annotation (Placement(transformation(extent={{-116,-58},{-96,-38}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_2 annotation (Placement(transformation(extent={{-116,-114},{-96,-94}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_3 annotation (Placement(transformation(extent={{-116,-130},{-96,-110}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_4 annotation (Placement(transformation(extent={{-116,-160},{-96,-140}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_5 annotation (Placement(transformation(extent={{-116,-184},{-96,-164}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_1 annotation (Placement(transformation(extent={{96,56},{116,76}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_1 annotation (Placement(transformation(extent={{98,-70},{118,-50}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_2 annotation (Placement(transformation(extent={{96,36},{116,56}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_3 annotation (Placement(transformation(extent={{96,18},{116,38}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_4 annotation (Placement(transformation(extent={{96,-8},{116,12}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_5 annotation (Placement(transformation(extent={{96,-28},{116,-8}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_2 annotation (Placement(transformation(extent={{98,-94},{118,-74}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_3 annotation (Placement(transformation(extent={{100,-118},{120,-98}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_4 annotation (Placement(transformation(extent={{100,-142},{120,-122}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_5 annotation (Placement(transformation(extent={{100,-158},{120,-138}})));
  Aufteilung_RL_ELY
                aufteilung_Erzeuger annotation (Placement(transformation(extent={{8,76},{40,106}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_1 annotation (Placement(transformation(extent={{-86,32},{-60,58}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_2 annotation (Placement(transformation(extent={{-46,6},{-20,32}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_3 annotation (Placement(transformation(extent={{-12,-8},{14,18}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_4 annotation (Placement(transformation(extent={{22,-22},{48,4}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_PV_5 annotation (Placement(transformation(extent={{56,-36},{82,-10}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_2 annotation (Placement(transformation(extent={{-46,-94},{-20,-68}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_3 annotation (Placement(transformation(extent={{-12,-108},{14,-82}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_4 annotation (Placement(transformation(extent={{22,-122},{48,-96}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_5 annotation (Placement(transformation(extent={{56,-136},{82,-110}})));
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_Wind_1 annotation (Placement(transformation(extent={{-80,-80},{-54,-54}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold annotation (Placement(transformation(extent={{74,-184},{94,-164}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_sum_AP annotation (Placement(transformation(extent={{94,204},{114,224}})));
equation
  P_sum_AP=aufteilung_PV_1.P_AP+aufteilung_PV_2.P_AP+aufteilung_PV_3.P_AP+aufteilung_PV_4.P_AP+aufteilung_PV_5.P_AP+aufteilung_Wind_1.P_AP+aufteilung_Wind_2.P_AP+aufteilung_Wind_3.P_AP+aufteilung_Wind_4.P_AP+aufteilung_Wind_5.P_AP;
  connect(aufteilung_PV_2.P_RL_Restangebot,aufteilung_PV_3. P_RL_Angebot) annotation (Line(
      points={{-18.18,15.1},{-12.09,15.1},{-12.09,15.27},{-11.22,15.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_2.P_RL_Rest,aufteilung_PV_3. P_RL_set) annotation (Line(
      points={{-18.18,8.6},{-12.09,8.6},{-12.09,9.29},{-11.22,9.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_RL_Restangebot,aufteilung_PV_4. P_RL_Angebot) annotation (Line(
      points={{15.82,1.1},{18.91,1.1},{18.91,1.27},{22.78,1.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_RL_Rest,aufteilung_PV_4. P_RL_set) annotation (Line(
      points={{15.82,-5.4},{18.91,-5.4},{18.91,-4.71},{22.78,-4.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_4.P_RL_Restangebot,aufteilung_PV_5. P_RL_Angebot) annotation (Line(
      points={{49.82,-12.9},{52.91,-12.9},{52.91,-12.73},{56.78,-12.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_4.P_RL_Rest,aufteilung_PV_5. P_RL_set) annotation (Line(
      points={{49.82,-19.4},{53.91,-19.4},{53.91,-18.71},{56.78,-18.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_2.P_RL_Restangebot,aufteilung_Wind_3. P_RL_Angebot) annotation (Line(
      points={{-18.18,-84.9},{-12.09,-84.9},{-12.09,-84.73},{-11.22,-84.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_2.P_RL_Rest,aufteilung_Wind_3. P_RL_set) annotation (Line(
      points={{-18.18,-91.4},{-12.09,-91.4},{-12.09,-90.71},{-11.22,-90.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_RL_Restangebot,aufteilung_Wind_4. P_RL_Angebot) annotation (Line(
      points={{15.82,-98.9},{18.91,-98.9},{18.91,-98.73},{22.78,-98.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_RL_Rest,aufteilung_Wind_4. P_RL_set) annotation (Line(
      points={{15.82,-105.4},{18.91,-105.4},{18.91,-104.71},{22.78,-104.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_RL_Restangebot,aufteilung_Wind_5. P_RL_Angebot) annotation (Line(
      points={{49.82,-112.9},{52.91,-112.9},{52.91,-112.73},{56.78,-112.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_RL_Rest,aufteilung_Wind_5. P_RL_set) annotation (Line(
      points={{49.82,-119.4},{53.91,-119.4},{53.91,-118.71},{56.78,-118.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_1.P_RL_Restangebot,aufteilung_Wind_2. P_RL_Angebot) annotation (Line(
      points={{-52.18,-70.9},{-50.09,-70.9},{-50.09,-70.73},{-45.22,-70.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_1.P_RL_Rest,aufteilung_Wind_2. P_RL_set) annotation (Line(
      points={{-52.18,-77.4},{-50.09,-77.4},{-50.09,-76.71},{-45.22,-76.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_5.P_RL_Restangebot,aufteilung_Wind_1. P_RL_Angebot) annotation (Line(
      points={{83.82,-26.9},{92,-26.9},{92,-52},{-88,-52},{-88,-56.73},{-79.22,-56.73}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_5.P_RL_Rest,aufteilung_Wind_1. P_RL_set) annotation (Line(
      points={{83.82,-33.4},{88,-33.4},{88,-46},{-92,-46},{-92,-62.71},{-79.22,-62.71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_5.P_set, P_set_PV_5) annotation (Line(
      points={{83.56,-16.76},{91.78,-16.76},{91.78,-18},{106,-18}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(P_set_PV_5, P_set_PV_5) annotation (Line(
      points={{106,-18},{106,-18}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_4.P_set, P_set_PV_4) annotation (Line(
      points={{49.56,-2.76},{74.78,-2.76},{74.78,2},{106,2}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_3.P_set, P_set_PV_3) annotation (Line(
      points={{15.56,11.24},{58.78,11.24},{58.78,28},{106,28}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_2.P_set, P_set_PV_2) annotation (Line(
      points={{-18.44,25.24},{40.78,25.24},{40.78,46},{106,46}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PRL_Angebot, aufteilung_Erzeuger.P_RL_Angebot) annotation (Line(points={{-102,108},{-48,108},{-48,102.85},{7.68,102.85}}, color={0,127,127}));
  connect(PRL_set, aufteilung_Erzeuger.P_RL_set) annotation (Line(points={{-102,90},{-48,90},{-48,94.75},{7.36,94.75}}, color={0,127,127}));
  connect(aufteilung_Erzeuger.P_RL_Restangebot, aufteilung_PV_1.P_RL_Angebot) annotation (Line(
      points={{42.24,86.5},{56,86.5},{56,66},{-90,66},{-90,55.27},{-85.22,55.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(P_set_PV_1, P_set_PV_1) annotation (Line(
      points={{106,66},{104,66},{104,66},{106,66}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Erzeuger.P_RL_Rest, aufteilung_PV_1.P_RL_set) annotation (Line(
      points={{42.24,79.6},{50,79.6},{50,70},{-92,70},{-92,49.29},{-85.22,49.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_PV_1, aufteilung_PV_1.P_max) annotation (Line(points={{-106,36},{-96,36},{-96,38.11},{-85.48,38.11}}, color={0,127,127}));
  connect(Max_PV_2, aufteilung_PV_2.P_max) annotation (Line(points={{-106,14},{-76,14},{-76,12.11},{-45.48,12.11}}, color={0,127,127}));
  connect(aufteilung_PV_1.P_RL_Restangebot, aufteilung_PV_2.P_RL_Angebot) annotation (Line(
      points={{-58.18,41.1},{-58.18,34.55},{-45.22,34.55},{-45.22,29.27}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_1.P_RL_Rest, aufteilung_PV_2.P_RL_set) annotation (Line(
      points={{-58.18,34.6},{-58.18,28.56},{-45.22,28.56},{-45.22,23.29}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_PV_1.P_set, P_set_PV_1) annotation (Line(
      points={{-58.44,51.24},{21.78,51.24},{21.78,66},{106,66}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_PV_3, aufteilung_PV_3.P_max) annotation (Line(points={{-106,-4},{-60,-4},{-60,-1.89},{-11.48,-1.89}}, color={0,127,127}));
  connect(Max_PV_4, aufteilung_PV_4.P_max) annotation (Line(points={{-106,-26},{-42,-26},{-42,-15.89},{22.52,-15.89}}, color={0,127,127}));
  connect(Max_PV_5, aufteilung_PV_5.P_max) annotation (Line(points={{-106,-48},{-96,-48},{-96,-29.89},{56.52,-29.89}}, color={0,127,127}));
  connect(Max_Wind_1, aufteilung_Wind_1.P_max) annotation (Line(points={{-106,-82},{-93,-82},{-93,-73.89},{-79.48,-73.89}}, color={0,127,127}));
  connect(aufteilung_Wind_1.P_set, P_set_Wind_1) annotation (Line(
      points={{-52.44,-60.76},{24.78,-60.76},{24.78,-60},{108,-60}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_Wind_2, aufteilung_Wind_2.P_max) annotation (Line(points={{-106,-104},{-76,-104},{-76,-87.89},{-45.48,-87.89}}, color={0,127,127}));
  connect(aufteilung_Wind_2.P_set, P_set_Wind_2) annotation (Line(
      points={{-18.44,-74.76},{43.78,-74.76},{43.78,-84},{108,-84}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_3.P_set, P_set_Wind_3) annotation (Line(
      points={{15.56,-88.76},{93.78,-88.76},{93.78,-108},{110,-108}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_4.P_set, P_set_Wind_4) annotation (Line(
      points={{49.56,-102.76},{92,-102.76},{92,-132},{110,-132}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Wind_5.P_set, P_set_Wind_5) annotation (Line(
      points={{83.56,-116.76},{110,-116.76},{110,-148}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(greaterEqualThreshold.y, PRL_erfuellt) annotation (Line(points={{95,-174},{98,-174},{98,-174},{112,-174}}, color={255,0,255}));
  connect(aufteilung_Wind_3.P_max, Max_Wind_3) annotation (Line(points={{-11.48,-101.89},{-56.74,-101.89},{-56.74,-120},{-106,-120}}, color={0,127,127}));
  connect(aufteilung_Wind_4.P_max, Max_Wind_4) annotation (Line(points={{22.52,-115.89},{-88,-115.89},{-88,-150},{-106,-150}}, color={0,127,127}));
  connect(aufteilung_Wind_5.P_max, Max_Wind_5) annotation (Line(points={{56.52,-129.89},{-82,-129.89},{-82,-174},{-106,-174}}, color={0,127,127}));
  connect(aufteilung_Erzeuger.P_set, P_set_LiIon) annotation (Line(
      points={{41.92,98.2},{41.92,188.1},{104,188.1},{104,188}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_Erzeuger.P_ELY, Max_P_ELY) annotation (Line(points={{8.64,83.05},{-66,83.05},{-66,178},{-104,178}}, color={0,127,127}));
  connect(aufteilung_Wind_5.P_RL_Restangebot, greaterEqualThreshold.u) annotation (Line(
      points={{83.82,-126.9},{88,-126.9},{88,-154},{42,-154},{42,-174},{72,-174}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(extent={{-100,-200},{100,220}})), Icon(coordinateSystem(extent={{-100,-200},{100,220}})),
    Documentation(info="<html>
<p>Betriebsf&uuml;hrung und &quot;Fallregler&quot; f&uuml;r ein virtuelles Kraftwerk mit einem Elektrolyseur</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Regler_Virtuelles_Kraftwerk_ELY;
