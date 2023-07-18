within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model Check_PrimaryBalancingController
  import MABook;
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(extent={{-16,0},{4,20}})));
  Modelica.Blocks.Sources.Constant const(k=-10000) annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
  Modelica.Blocks.Sources.Constant const1(k=49.81) annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
equation
  connect(const.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-57,30},{-36.5,30},{-36.5,16.3},{-17.3,16.3}}, color={0,0,127}));
  connect(const1.y, primaryBalancingController.Frequenzy) annotation (Line(points={{-55,-12},{-36,-12},{-36,2.7},{-17.2,2.7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Check_PrimaryBalancingController;
