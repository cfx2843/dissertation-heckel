within Phdbook.Kapitel8.Praequalifikation;
block PQ_Tester
  parameter Modelica.Units.SI.Power Nennleistung=1e6 "Anlagenleistung";
  parameter Real g=0.1 "Anteil der als RL angeboten wird";
  parameter Boolean RL_Art=true "true=potitiv, false=negativ";
  parameter Modelica.Units.SI.Power Nennleistung_ohne=1e5 "Erzeuger außerhalb Präqualifikation";
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_el_soll annotation (Placement(transformation(extent={{88,34},{148,94}}), iconTransformation(extent={{88,34},{148,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=g)
                                                        annotation (Placement(transformation(extent={{-62,66},{-42,86}})));
  Modelica.Blocks.Math.MultiProduct Sollwert(nu=2) annotation (Placement(transformation(extent={{62,54},{74,66}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=RL_Art) annotation (Placement(transformation(extent={{-188,96},{-168,116}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-100,96},{-80,116}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-50,120},{-30,140}})));
  Modelica.Blocks.Math.Gain gain1(k=1) annotation (Placement(transformation(extent={{8,48},{28,68}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=g)
                                                        annotation (Placement(transformation(extent={{-42,-2},{-22,18}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=RL_Art)
                                                                        annotation (Placement(transformation(extent={{-78,-116},{-58,-96}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(extent={{10,-116},{30,-96}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_Angebot annotation (Placement(transformation(extent={{94,-30},{150,26}}), iconTransformation(extent={{94,-30},{150,26}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_RL_set annotation (Placement(transformation(extent={{126,-96},{176,-46}}),iconTransformation(extent={{126,-96},{176,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Nennleistung)
                                                        annotation (Placement(transformation(extent={{-98,-6},{-78,14}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
                                       annotation (Placement(transformation(extent={{58,-12},{78,8}})));
  Modelica.Blocks.Math.Gain gain3(k=-1)
                                       annotation (Placement(transformation(extent={{96,-80},{116,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=Nennleistung_ohne)
                                                        annotation (Placement(transformation(extent={{20,12},{40,32}})));
protected
  Modelica.Blocks.Sources.Step step(
    height=1,
    offset=0,
    startTime=5*60)                                 annotation (Placement(transformation(extent={{-108,58},{-88,78}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3) annotation (Placement(transformation(extent={{-2,84},{10,96}})));
  Modelica.Blocks.Math.Add add(k2=+1) annotation (Placement(transformation(extent={{36,92},{56,112}})));
  Modelica.Blocks.Math.Add add1(k1=+1, k2=+1)
                                      annotation (Placement(transformation(extent={{-62,88},{-42,108}})));
  Modelica.Blocks.Sources.Constant const1(k=-1)
                                               annotation (Placement(transformation(extent={{-146,120},{-126,140}})));
  Modelica.Blocks.Sources.Constant const3(k=1) annotation (Placement(transformation(extent={{-150,80},{-130,100}})));
  Modelica.Blocks.Sources.Constant const2(k=1) annotation (Placement(transformation(extent={{-6,110},{14,130}})));
  Modelica.Blocks.Math.MultiProduct multiProduct1(nu=2)
                                                       annotation (Placement(transformation(extent={{-2,-8},{10,4}})));
  Modelica.Blocks.Sources.Constant const4(k=1) annotation (Placement(transformation(extent={{-36,-92},{-16,-72}})));
  Modelica.Blocks.Sources.Constant const5(k=-1)
                                               annotation (Placement(transformation(extent={{-40,-132},{-20,-112}})));
  Modelica.Blocks.Math.MultiProduct multiProduct2(nu=3)
                                                       annotation (Placement(transformation(extent={{70,-76},{82,-64}})));
protected
  Modelica.Blocks.Sources.Step step1(
    height=1,
    offset=0,
    startTime=5*60)                                 annotation (Placement(transformation(extent={{6,-82},{26,-62}})));
  Modelica.Blocks.Math.Add add2(k2=+1)
                                      annotation (Placement(transformation(extent={{60,22},{80,42}})));
equation
  connect(multiProduct.y,add. u2) annotation (Line(points={{11.02,90},{12,90},{12,96},{34,96}},             color={0,0,127}));
  connect(add.y, Sollwert.u[1]) annotation (Line(points={{57,102},{62,102},{62,62.1}},         color={0,0,127}));
  connect(step.y, add1.u2) annotation (Line(points={{-87,68},{-80,68},{-80,92},{-64,92}},         color={0,0,127}));
  connect(switch1.y, add1.u1) annotation (Line(points={{-79,106},{-72,106},{-72,104},{-64,104}}, color={0,0,127}));
  connect(booleanExpression.y, switch1.u2) annotation (Line(points={{-167,106},{-102,106}},
                                                                                          color={255,0,255}));
  connect(const1.y, switch1.u1) annotation (Line(points={{-125,130},{-116,130},{-116,114},{-102,114}},
                                                                                                 color={0,0,127}));
  connect(const3.y, switch1.u3) annotation (Line(points={{-129,90},{-116,90},{-116,98},{-102,98}},     color={0,0,127}));
  connect(gain.u, add1.u1) annotation (Line(points={{-52,130},{-68,130},{-68,106},{-72,106},{-72,104},{-64,104}},color={0,0,127}));
  connect(gain.y, multiProduct.u[1]) annotation (Line(points={{-29,130},{-14,130},{-14,92.8},{-2,92.8}},  color={0,0,127}));
  connect(add1.y, multiProduct.u[2]) annotation (Line(points={{-41,98},{-20,98},{-20,90},{-2,90}},      color={0,0,127}));
  connect(realExpression.y, multiProduct.u[3]) annotation (Line(points={{-41,76},{-32,76},{-32,87.2},{-2,87.2}},      color={0,0,127}));
  connect(const2.y, add.u1) annotation (Line(points={{15,120},{24,120},{24,108},{34,108}}, color={0,0,127}));
  connect(realExpression1.y, multiProduct1.u[1]) annotation (Line(points={{-21,8},{-10,8},{-10,0.1},{-2,0.1}},
                                                                                                             color={0,0,127}));
  connect(booleanExpression1.y, switch2.u2) annotation (Line(points={{-57,-106},{8,-106}},
                                                                                         color={255,0,255}));
  connect(const4.y,switch2. u1) annotation (Line(points={{-15,-82},{-14,-82},{-14,-98},{8,-98}}, color={0,0,127}));
  connect(const5.y,switch2. u3) annotation (Line(points={{-19,-122},{-14,-122},{-14,-114},{8,-114}},   color={0,0,127}));
  connect(step1.y, multiProduct2.u[1]) annotation (Line(points={{27,-72},{46,-72},{46,-67.2},{70,-67.2}},
                                                                                                      color={0,0,127}));
  connect(switch2.y, multiProduct2.u[2]) annotation (Line(points={{31,-106},{46,-106},{46,-70},{70,-70}},   color={0,0,127}));
  connect(multiProduct1.y, multiProduct2.u[3]) annotation (Line(points={{11.02,-2},{40,-2},{40,-72.8},{70,-72.8}}, color={0,0,127}));
  connect(P_Angebot, P_Angebot) annotation (Line(
      points={{122,-2},{122,-2}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(gain1.y, Sollwert.u[2]) annotation (Line(points={{29,58},{46,58},{46,57.9},{62,57.9}}, color={0,0,127}));
  connect(realExpression2.y, multiProduct1.u[2]) annotation (Line(points={{-77,4},{-40,4},{-40,-4.1},{-2,-4.1}}, color={0,0,127}));
  connect(realExpression2.y, gain1.u) annotation (Line(points={{-77,4},{-36,4},{-36,58},{6,58}}, color={0,0,127}));
  connect(multiProduct1.y, gain2.u) annotation (Line(points={{11.02,-2},{56,-2}}, color={0,0,127}));
  connect(gain2.y, P_Angebot) annotation (Line(points={{79,-2},{122,-2}}, color={0,0,127}));
  connect(P_RL_set, P_RL_set) annotation (Line(
      points={{151,-71},{141.5,-71},{141.5,-71},{151,-71}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(gain3.y, P_RL_set) annotation (Line(points={{117,-70},{126,-70},{126,-71},{151,-71}}, color={0,0,127}));
  connect(multiProduct2.y, gain3.u) annotation (Line(points={{83.02,-70},{94,-70}}, color={0,0,127}));
  connect(add2.y, P_el_soll) annotation (Line(points={{81,32},{92,32},{92,64},{118,64}}, color={0,0,127}));
  connect(Sollwert.y, add2.u1) annotation (Line(points={{75.02,60},{66,60},{66,38},{58,38}}, color={0,0,127}));
  connect(realExpression3.y, add2.u2) annotation (Line(points={{41,22},{50,22},{50,26},{58,26}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{82,158},{206,96}},
          lineColor={28,108,200},
          textString="5min Einschwingen
15min Sollwertsprung max")}),
    experiment(
      StopTime=1200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Modell erstellt als Ausgangsleistung eine Betriebsfahrt f&uuml;r die Pr&auml;qualifikation zum Angebot von Regelleistung.</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021</p>
</html>"));
end PQ_Tester;
