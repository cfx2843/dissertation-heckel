within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block Druckspeicher
  parameter Modelica.Units.SI.Mass Kapazitaet=500 "Maximales Wasserstoffgewicht im Speicher";
  parameter Modelica.Units.SI.Pressure p_Eingang(displayUnit="bar") = 3500000 "Eingangsdruch in den Verdichter";
  parameter Modelica.Units.SI.Pressure p_Max=8000000 "Maximaler Druck im Speicher";
  parameter Modelica.Units.SI.Temperature T_b(displayUnit="degC") = 343.15 "Eingangstemperatur des Wasserstoffs";
  parameter Real SOC_start=1 "Startfüllstand des Speichers";
  parameter Modelica.Units.SI.Efficiency eta_V=0.95 "Wirkungsgrad des Verdichters";
  Modelica.Blocks.Interfaces.RealOutput SOC annotation (Placement(transformation(
        extent={{-21,-21},{21,21}},
        rotation=0,
        origin={111,1}), iconTransformation(
        extent={{-21,-21},{21,21}},
        rotation=180,
        origin={-111,71})));
  TransiEnt.Basics.Interfaces.General.PressureOut P_Speicher annotation (Placement(transformation(
        extent={{-22,-22},{22,22}},
        rotation=0,
        origin={112,76}), iconTransformation(
        extent={{-22,-22},{22,22}},
        rotation=180,
        origin={-110,4})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateIn massFlowRateIn annotation (Placement(transformation(
        extent={{-28,-28},{28,28}},
        rotation=0,
        origin={-110,0}), iconTransformation(
        extent={{-28,-28},{28,28}},
        rotation=180,
        origin={98,-8})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(
    outMax=Kapazitaet,
    outMin=0,
    y_start=SOC_start*Kapazitaet) annotation (Placement(transformation(extent={{-56,-16},{-24,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Kapazitaet) annotation (Placement(transformation(extent={{-44,-46},{-24,-26}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{-6,-16},{14,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=p_Eingang) annotation (Placement(transformation(extent={{-40,52},{-20,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=p_Max) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Math.Add add(k1=-1)
                               annotation (Placement(transformation(extent={{-2,36},{18,56}})));
  Modelica.Blocks.Math.Add Absolutdruck annotation (Placement(transformation(extent={{62,36},{82,56}})));
  Modelica.Blocks.Math.Product Differenzdruck annotation (Placement(transformation(extent={{32,30},{52,50}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power Verdichter annotation (Placement(transformation(extent={{26,-64},{46,-44}})));
  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{-112,-90},{-70,-48}}),
  iconTransformation(extent={{-112,-90},{-70,-48}})));
  Real W_12;
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_V annotation (Placement(transformation(extent={{88,-80},{140,-28}}), iconTransformation(extent={{88,-80},{140,-28}})));
equation
  // Berechnung der Benötigten spezifischen Leistung für den Verdichter
  W_12=T_b*(4124.2/0.41)*(1-(p_Eingang/P_Speicher)^(-41/141));
  if massFlowRateIn>0 then
    Verdichter.P_el_set= -W_12*massFlowRateIn/eta_V;
    else
    Verdichter.P_el_set=0;
  end if;
  connect(massFlowRateIn, limIntegrator.u) annotation (Line(points={{-110,0},{-59.2,0}}, color={0,0,127}));
  connect(limIntegrator.y, division.u1) annotation (Line(points={{-22.4,0},{-8,0}}, color={0,0,127}));
  connect(realExpression.y, division.u2) annotation (Line(points={{-23,-36},{-18,-36},{-18,-12},{-8,-12}}, color={0,0,127}));
  connect(add.y, Differenzdruck.u1) annotation (Line(points={{19,46},{30,46}}, color={0,0,127}));
  connect(division.y, Differenzdruck.u2) annotation (Line(points={{15,-6},{22,-6},{22,34},{30,34}}, color={0,0,127}));
  connect(Differenzdruck.y, Absolutdruck.u2) annotation (Line(points={{53,40},{60,40}}, color={0,0,127}));
  connect(realExpression1.y, add.u1) annotation (Line(points={{-19,62},{-12,62},{-12,52},{-4,52}}, color={0,0,127}));
  connect(realExpression2.y, add.u2) annotation (Line(points={{-19,40},{-4,40}}, color={0,0,127}));
  connect(realExpression1.y, Absolutdruck.u1) annotation (Line(points={{-19,62},{56,62},{56,52},{60,52}}, color={0,0,127}));
  connect(Absolutdruck.y, P_Speicher) annotation (Line(points={{83,46},{90,46},{90,76},{112,76}}, color={0,0,127}));
  connect(Verdichter.epp, epp) annotation (Line(
      points={{26,-54},{26,-69},{-91,-69}},
      color={0,135,135},
      thickness=0.5));
  connect(SOC, division.y) annotation (Line(points={{111,1},{63.5,1},{63.5,-6},{15,-6}}, color={0,0,127}));
  connect(P_V, P_V) annotation (Line(
      points={{114,-54},{108,-54},{108,-54},{114,-54}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Verdichter.P_el_set, P_V) annotation (Line(points={{30,-42},{66,-42},{66,-54},{114,-54}}, color={0,127,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Generischer Druckspeicher</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Druckspeicher;
