within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model Check_Aufteilung_RL
  import MABook;
  import MABook;
  Langzeitsimulation.Regler.Aufteilung_RL aufteilung_RL annotation (Placement(transformation(extent={{16,-46},{122,78}})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(extent={{-34,56},{-14,76}})));
  Modelica.Blocks.Sources.Constant const(k=-100)
                                         annotation (Placement(transformation(extent={{-176,62},{-156,82}})));
  Modelica.Blocks.Math.Gain gain(k=0.1)
                                 annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
  Modelica.Blocks.Sources.Constant const1(k=50.1)
                                         annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
                                         annotation (Placement(transformation(extent={{-78,-26},{-58,-6}})));
equation
  connect(const.y, gain.u) annotation (Line(points={{-155,72},{-92,72}}, color={0,0,127}));
  connect(gain.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-69,72},{-60,72},{-60,72.3},{-35.3,72.3}}, color={0,0,127}));
  connect(const1.y, primaryBalancingController.Frequenzy) annotation (Line(points={{-69,38},{-68,38},{-68,58.7},{-35.2,58.7}}, color={0,0,127}));
  connect(const2.y, aufteilung_RL.P_max) annotation (Line(points={{-57,-16},{-20,-16},{-20,-16.86},{18.12,-16.86}}, color={0,0,127}));
  connect(primaryBalancingController.P_set, aufteilung_RL.P_RL_set) annotation (Line(
      points={{-12.2,64.2},{-12.2,31.1},{19.18,31.1},{19.18,31.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(aufteilung_RL.P_RL_Angebot, primaryBalancingController.PRL_Angebot) annotation (Line(points={{19.18,64.98},{-4,64.98},{-4,84},{-48,84},{-48,72.3},{-35.3,72.3}}, color={0,127,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Check_Aufteilung_RL;
