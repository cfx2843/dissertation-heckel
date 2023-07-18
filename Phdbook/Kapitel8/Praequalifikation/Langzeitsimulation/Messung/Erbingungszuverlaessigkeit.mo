within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Messung;
block Erbingungszuverlaessigkeit
  import Modelica.Units.Conversions.*;

  Modelica.Blocks.Continuous.Integrator integrator(y_start=1)
                                                   annotation (Placement(transformation(extent={{36,2},{56,22}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{8,2},{28,22}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-48,54},{-28,74}})));
  Modelica.Blocks.Sources.Constant const1(k=0) annotation (Placement(transformation(extent={{-54,-42},{-34,-22}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{84,-10},{104,10}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Percentage annotation (Placement(transformation(extent={{116,-32},{190,42}}),iconTransformation(extent={{96,54},{128,86}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=1, startTime=0) annotation (Placement(transformation(extent={{18,-34},{38,-14}})));
  Modelica.Blocks.Interfaces.BooleanInput Erfuellt annotation (Placement(transformation(extent={{-128,-8},{-88,32}})));
equation
  connect(integrator.y, division.u1) annotation (Line(points={{57,12},{70,12},{70,6},{82,6}}, color={0,0,127}));
  connect(switch1.y, integrator.u) annotation (Line(points={{29,12},{34,12}}, color={0,0,127}));
  connect(division.y, Percentage) annotation (Line(points={{105,0},{112,0},{112,5},{153,5}}, color={0,0,127}));
  connect(switch1.u2, Erfuellt) annotation (Line(points={{6,12},{-108,12}}, color={255,0,255}));
  connect(const.y, switch1.u1) annotation (Line(points={{-27,64},{-10,64},{-10,20},{6,20}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{-33,-32},{-14,-32},{-14,4},{6,4}}, color={0,0,127}));
  connect(clock.y, division.u2) annotation (Line(points={{39,-24},{60,-24},{60,-6},{82,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=36000,
      StopTime=31536000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Berechnung der Erbringungszuverl&auml;ssigkeit</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Erbingungszuverlaessigkeit;
