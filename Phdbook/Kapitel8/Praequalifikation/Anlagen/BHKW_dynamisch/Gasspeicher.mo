within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
model Gasspeicher
  TransiEnt.Basics.Interfaces.General.MassFlowRateIn Produzent annotation (Placement(transformation(extent={{-128,62},{-88,102}})));
  Modelica.Blocks.Interfaces.RealOutput SOF annotation (Placement(transformation(extent={{96,-84},{138,-42}}), iconTransformation(extent={{96,-84},{138,-42}})));
  parameter Modelica.Units.SI.Mass m_max=100 "Speichergröße";
  parameter Real SOF_start=0.5 "Startfüllstand";
  TransiEnt.Basics.Interfaces.General.MassFlowRateIn Verbraucher annotation (Placement(transformation(extent={{-128,-78},{-88,-38}})));
  Modelica.Blocks.Sources.RealExpression Groesse(y=m_max) annotation (Placement(transformation(extent={{-24,-62},{-4,-42}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-68,72},{-48,92}})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(extent={{36,-30},{56,-10}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(
    outMax=m_max,
    outMin=0,
    y_start=SOF_start*m_max) annotation (Placement(transformation(extent={{-42,72},{-22,92}})));
equation
  connect(Produzent, feedback.u1) annotation (Line(points={{-108,82},{-66,82}}, color={0,0,127}));
  connect(Verbraucher, feedback.u2) annotation (Line(points={{-108,-58},{-58,-58},{-58,74}}, color={0,0,127}));
  connect(SOF, division.y) annotation (Line(points={{117,-63},{88,-63},{88,-20},{57,-20}}, color={0,0,127}));
  connect(Groesse.y, division.u2) annotation (Line(points={{-3,-52},{16,-52},{16,-26},{34,-26}}, color={0,0,127}));
  connect(feedback.y, limIntegrator.u) annotation (Line(points={{-49,82},{-44,82}}, color={0,0,127}));
  connect(limIntegrator.y, division.u1) annotation (Line(points={{-21,82},{6,82},{6,-14},{34,-14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Gasspeicher;
