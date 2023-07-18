within Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie;
block Zyklanzahl_von_SOC
  parameter Real start;
  Modelica.Blocks.Interfaces.RealOutput Zyklen annotation (Placement(transformation(extent={{92,-30},{152,30}}), iconTransformation(extent={{92,-30},{152,30}})));
  Modelica.Blocks.Interfaces.RealInput SOC annotation (Placement(transformation(extent={{-142,-34},{-76,32}}), iconTransformation(extent={{-142,-34},{-76,32}})));
  Modelica.Blocks.Math.Abs abs1 annotation (Placement(transformation(extent={{-14,-12},{6,8}})));
  Modelica.Blocks.Continuous.Integrator integrator annotation (Placement(transformation(extent={{46,-12},{66,8}})));
  Modelica.Blocks.Math.Gain gain(k=0.5) annotation (Placement(transformation(extent={{16,-12},{36,8}})));
  Modelica.Blocks.Continuous.Derivative derivative(x_start=start) annotation (Placement(transformation(extent={{-52,-18},{-32,2}})));
equation
  connect(integrator.y, Zyklen) annotation (Line(points={{67,-2},{80,-2},{80,0},{122,0}}, color={0,0,127}));
  connect(abs1.y, gain.u) annotation (Line(points={{7,-2},{14,-2}}, color={0,0,127}));
  connect(gain.y, integrator.u) annotation (Line(points={{37,-2},{44,-2}}, color={0,0,127}));
  connect(SOC, derivative.u) annotation (Line(points={{-109,-1},{-81.5,-1},{-81.5,-8},{-54,-8}}, color={0,0,127}));
  connect(derivative.y, abs1.u) annotation (Line(points={{-31,-8},{-22,-8},{-22,-2},{-16,-2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Berechnung der Zyklenzahl aus dem Ladezustand</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Zyklanzahl_von_SOC;
