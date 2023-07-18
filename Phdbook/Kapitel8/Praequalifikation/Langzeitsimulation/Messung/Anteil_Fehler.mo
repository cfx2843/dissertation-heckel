within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Messung;
block Anteil_Fehler
  import Modelica.Units.Conversions.*;

  Modelica.Blocks.Continuous.Integrator integrator(y_start=0)
                                                   annotation (Placement(transformation(extent={{30,72},{50,92}})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{2,72},{22,92}})));
  Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(transformation(extent={{-48,100},{-28,120}})));
  Modelica.Blocks.Sources.Constant const1(k=0) annotation (Placement(transformation(extent={{-44,48},{-24,68}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{78,60},{98,80}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Percentage_hoch annotation (Placement(transformation(extent={{110,38},{184,112}}), iconTransformation(extent={{96,54},{128,86}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=1, startTime=0) annotation (Placement(transformation(extent={{12,36},{32,56}})));
  Modelica.Blocks.Interfaces.BooleanInput Erfuellt annotation (Placement(transformation(extent={{-128,-8},{-88,32}})));
  Modelica.Blocks.Interfaces.BooleanInput Soc_Niedriger annotation (Placement(transformation(extent={{-128,-92},{-88,-52}})));
  Modelica.Blocks.Interfaces.BooleanInput Soc_Hoeher annotation (Placement(transformation(extent={{-128,60},{-88,100}})));
  Modelica.Blocks.MathBoolean.Not not1 annotation (Placement(transformation(extent={{-80,8},{-72,16}})));
  Modelica.Blocks.Continuous.Integrator integrator1(y_start=0)
                                                   annotation (Placement(transformation(extent={{34,-84},{54,-64}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(extent={{6,-84},{26,-64}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
                                              annotation (Placement(transformation(extent={{-44,-56},{-24,-36}})));
  Modelica.Blocks.Sources.Constant const3(k=0) annotation (Placement(transformation(extent={{-40,-108},{-20,-88}})));
  Modelica.Blocks.Math.Division division1
                                         annotation (Placement(transformation(extent={{82,-96},{102,-76}})));
  Modelica.Blocks.Sources.ContinuousClock clock1(offset=1, startTime=0) annotation (Placement(transformation(extent={{16,-120},{36,-100}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Percentage_niedrig annotation (Placement(transformation(extent={{114,-118},{188,-44}}), iconTransformation(extent={{96,-90},{128,-58}})));
  Modelica.Blocks.MathBoolean.And and1(nu=2) annotation (Placement(transformation(extent={{-52,-76},{-40,-64}})));
  Modelica.Blocks.MathBoolean.And and2(nu=2) annotation (Placement(transformation(extent={{-62,78},{-50,90}})));
  Modelica.Blocks.Continuous.Integrator integrator2(y_start=0)
                                                   annotation (Placement(transformation(extent={{44,-8},{64,12}})));
  Modelica.Blocks.Logical.Switch switch3 annotation (Placement(transformation(extent={{16,-8},{36,12}})));
  Modelica.Blocks.Sources.Constant const4(k=1)
                                              annotation (Placement(transformation(extent={{-26,8},{-6,28}})));
  Modelica.Blocks.Sources.Constant const5(k=0) annotation (Placement(transformation(extent={{-28,-22},{-8,-2}})));
  Modelica.Blocks.Math.Division division2
                                         annotation (Placement(transformation(extent={{92,-20},{112,0}})));
  Modelica.Blocks.Sources.ContinuousClock clock2(offset=1, startTime=0) annotation (Placement(transformation(extent={{26,-44},{46,-24}})));
  Modelica.Blocks.MathBoolean.And and3(nu=3) annotation (Placement(transformation(extent={{-44,-2},{-32,10}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Percentage_Andere annotation (Placement(transformation(extent={{124,-42},{198,32}}), iconTransformation(extent={{96,-16},{128,16}})));
  Modelica.Blocks.MathBoolean.Not not2 annotation (Placement(transformation(extent={{-80,36},{-72,44}})));
  Modelica.Blocks.MathBoolean.Not not3 annotation (Placement(transformation(extent={{-80,-36},{-72,-28}})));
equation
  connect(integrator.y, division.u1) annotation (Line(points={{51,82},{64,82},{64,76},{76,76}},
                                                                                              color={0,0,127}));
  connect(switch1.y, integrator.u) annotation (Line(points={{23,82},{28,82}}, color={0,0,127}));
  connect(division.y, Percentage_hoch) annotation (Line(points={{99,70},{106,70},{106,75},{147,75}}, color={0,0,127}));
  connect(clock.y, division.u2) annotation (Line(points={{33,46},{54,46},{54,64},{76,64}},   color={0,0,127}));
  connect(const.y, switch1.u1) annotation (Line(points={{-27,110},{-14,110},{-14,90},{0,90}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{-23,58},{-18,58},{-18,74},{0,74}}, color={0,0,127}));
  connect(not1.u, Erfuellt) annotation (Line(points={{-81.6,12},{-108,12}}, color={255,0,255}));
  connect(integrator1.y, division1.u1) annotation (Line(points={{55,-74},{68,-74},{68,-80},{80,-80}}, color={0,0,127}));
  connect(switch2.y, integrator1.u) annotation (Line(points={{27,-74},{32,-74}}, color={0,0,127}));
  connect(division1.y, Percentage_niedrig) annotation (Line(points={{103,-86},{110,-86},{110,-81},{151,-81}}, color={0,0,127}));
  connect(clock1.y, division1.u2) annotation (Line(points={{37,-110},{58,-110},{58,-92},{80,-92}}, color={0,0,127}));
  connect(const2.y, switch2.u1) annotation (Line(points={{-23,-46},{-10,-46},{-10,-66},{4,-66}}, color={0,0,127}));
  connect(const3.y, switch2.u3) annotation (Line(points={{-19,-98},{-14,-98},{-14,-82},{4,-82}}, color={0,0,127}));
  connect(not1.y, and1.u[1]) annotation (Line(points={{-71.2,12},{-62,12},{-62,-67.9},{-52,-67.9}}, color={255,0,255}));
  connect(and1.u[2], Soc_Niedriger) annotation (Line(points={{-52,-72.1},{-72,-72.1},{-72,-72},{-108,-72}}, color={255,0,255}));
  connect(and1.y, switch2.u2) annotation (Line(points={{-39.1,-70},{-18,-70},{-18,-74},{4,-74}}, color={255,0,255}));
  connect(and2.u[1], not1.y) annotation (Line(points={{-62,86.1},{-68,86.1},{-68,12},{-71.2,12}}, color={255,0,255}));
  connect(and2.u[2], Soc_Hoeher) annotation (Line(points={{-62,81.9},{-82,81.9},{-82,80},{-108,80}}, color={255,0,255}));
  connect(and2.y, switch1.u2) annotation (Line(points={{-49.1,84},{-24,84},{-24,82},{0,82}}, color={255,0,255}));
  connect(integrator2.y, division2.u1) annotation (Line(points={{65,2},{78,2},{78,-4},{90,-4}}, color={0,0,127}));
  connect(switch3.y, integrator2.u) annotation (Line(points={{37,2},{42,2}}, color={0,0,127}));
  connect(division2.y, Percentage_Andere) annotation (Line(points={{113,-10},{120,-10},{120,-5},{161,-5}}, color={0,0,127}));
  connect(clock2.y, division2.u2) annotation (Line(points={{47,-34},{68,-34},{68,-16},{90,-16}}, color={0,0,127}));
  connect(const4.y, switch3.u1) annotation (Line(points={{-5,18},{0,18},{0,10},{14,10}}, color={0,0,127}));
  connect(const5.y, switch3.u3) annotation (Line(points={{-7,-12},{-4,-12},{-4,-6},{14,-6}}, color={0,0,127}));
  connect(not3.u, Soc_Niedriger) annotation (Line(points={{-81.6,-32},{-88,-32},{-88,-72},{-108,-72}}, color={255,0,255}));
  connect(and3.u[1], not1.y) annotation (Line(points={{-44,6.8},{-54,6.8},{-54,12},{-71.2,12}}, color={255,0,255}));
  connect(not2.y, and3.u[2]) annotation (Line(points={{-71.2,40},{-56,40},{-56,4},{-44,4}}, color={255,0,255}));
  connect(not3.y, and3.u[3]) annotation (Line(points={{-71.2,-32},{-58,-32},{-58,1.2},{-44,1.2}}, color={255,0,255}));
  connect(and3.y, switch3.u2) annotation (Line(points={{-31.1,4},{-8,4},{-8,2},{14,2}}, color={255,0,255}));
  connect(not2.u, Soc_Hoeher) annotation (Line(points={{-81.6,40},{-90,40},{-90,80},{-108,80}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=36000,
      StopTime=31536000,
      Interval=10,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Berechnung der Fehlerartanteile zur &uuml;berpr&uuml;fung der Fehle</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Anteil_Fehler;
