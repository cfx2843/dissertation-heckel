within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block Rev_PEM_FC_statisch
  import TransiEnt;

  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{-126,-24},{-80,22}}), iconTransformation(extent={{-126,-24},{-80,22}})));
  Fuelcell_statisch
           fuelcell_statisch(
                    eta_FC=0.4, P_max=P_el_n)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,62})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn electricPowerIn annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=180,
        origin={108,-44}),
                         iconTransformation(
        extent={{-24,-24},{24,24}},
        rotation=180,
        origin={108,-44})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,28})));
  parameter Modelica.Units.SI.Power P_el_n=1e6 "Nominal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Mass m_H2=44.74 "Speichermasse Druckspeicher";

  Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,20})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_max_Ely annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,-48})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_max_FC annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-104,-76})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=P_el_n)                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-8})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=-P_el_n)                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-22,-96})));
  Elektrolyseur_statisch elektrolyseur_statisch(eta_ely=0.75, P_max=P_el_n)
                                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={68,-6})));
  Druckspeicher druckspeicher(Kapazitaet=m_H2, SOC_start=0.5) annotation (Placement(transformation(extent={{-4,18},{16,38}})));
  Modelica.Blocks.Interfaces.RealOutput SOC annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-104,74}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-104,74})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,-28})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,-76})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-58,-28})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-9,9},{9,-9}},
        rotation=180,
        origin={-61,-77})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-21,-53})));
equation
  connect(fuelcell_statisch.epp, epp) annotation (Line(
      points={{50.2,55.8},{-23.9,55.8},{-23.9,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(add1.y, fuelcell_statisch.P_el_set) annotation (Line(points={{57,20},{52,20},{52,57.6},{75.7,57.6}}, color={0,0,127}));
  connect(electricPowerIn, add1.u1) annotation (Line(points={{108,-44},{90,-44},{90,14},{80,14}},   color={0,127,127}));
  connect(elektrolyseur_statisch.P_el_set, add1.y) annotation (Line(points={{77.3,-10.4},{52.85,-10.4},{52.85,20},{57,20}},   color={0,127,127}));
  connect(elektrolyseur_statisch.epp, epp) annotation (Line(
      points={{58.2,-12.2},{40,-12.2},{40,14},{40.1,14},{40.1,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(fuelcell_statisch.m_dot_H2, add.u2) annotation (Line(points={{49.6,62},{48,62},{48,34},{44,34}}, color={0,0,127}));
  connect(elektrolyseur_statisch.m_dot_H2, add.u1) annotation (Line(points={{57.6,-6},{52,-6},{52,22},{44,22}},  color={0,0,127}));
  connect(druckspeicher.massFlowRateIn, add.y) annotation (Line(points={{15.8,27.2},{18.9,27.2},{18.9,28},{21,28}},     color={0,0,127}));
  connect(druckspeicher.P_V, add1.u2) annotation (Line(
      points={{17.4,22.6},{17.4,90},{134,90},{134,26},{80,26}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(druckspeicher.epp, epp) annotation (Line(
      points={{-3.1,21.1},{-66,21.1},{-66,0},{-65.9,0},{-65.9,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(druckspeicher.SOC, SOC) annotation (Line(points={{-5.1,35.1},{-60,35.1},{-60,74},{-104,74}},color={0,0,127}));
  connect(druckspeicher.SOC, greaterEqualThreshold.u) annotation (Line(points={{-5.1,35.1},{-8,35.1},{-8,-28}}, color={0,0,127}));
  connect(druckspeicher.SOC, lessEqualThreshold.u) annotation (Line(points={{-5.1,35.1},{-6,35.1},{-6,-76}}, color={0,0,127}));
  connect(greaterEqualThreshold.y, switch1.u2) annotation (Line(points={{-31,-28},{-46,-28}}, color={255,0,255}));
  connect(realExpression1.y, switch1.u3) annotation (Line(points={{-31,-8},{-46,-8},{-46,-20}}, color={0,0,127}));
  connect(switch1.y, P_max_Ely) annotation (Line(points={{-69,-28},{-84,-28},{-84,-48},{-106,-48}}, color={0,0,127}));
  connect(switch2.y, P_max_FC) annotation (Line(points={{-70.9,-77},{-88,-77},{-88,-76},{-104,-76}}, color={0,0,127}));
  connect(lessEqualThreshold.y, switch2.u2) annotation (Line(points={{-29,-76},{-40,-76},{-40,-77},{-50.2,-77}}, color={255,0,255}));
  connect(const.y, switch1.u1) annotation (Line(points={{-26.5,-53},{-35.25,-53},{-35.25,-36},{-46,-36}}, color={0,0,127}));
  connect(switch2.u1, const.y) annotation (Line(points={{-50.2,-69.8},{-38.1,-69.8},{-38.1,-53},{-26.5,-53}}, color={0,0,127}));
  connect(switch2.u3, realExpression2.y) annotation (Line(points={{-50.2,-84.2},{-41.1,-84.2},{-41.1,-96},{-33,-96}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Generische statische reversible Brennstoffzelle</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Rev_PEM_FC_statisch;
