within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model Check_Regler_Virtuelles_Kraftwerk
  import MABook;
  import MABook;
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk regler_Virtuelles_Kraftwerk annotation (Placement(transformation(extent={{0,2},{20,32}})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(extent={{-34,56},{-14,76}})));
  Modelica.Blocks.Sources.Constant const(k=-100)
                                         annotation (Placement(transformation(extent={{-176,62},{-156,82}})));
  Modelica.Blocks.Math.Gain gain(k=0.1)
                                 annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
  Modelica.Blocks.Sources.Constant const1(k=50.1)
                                         annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Modelica.Blocks.Sources.Constant const2(k=-4)
                                         annotation (Placement(transformation(extent={{-130,-14},{-110,6}})));
  Modelica.Blocks.Sources.Constant const3(k=-4)
                                         annotation (Placement(transformation(extent={{-132,18},{-112,38}})));
equation
  connect(primaryBalancingController.P_set, regler_Virtuelles_Kraftwerk.PRL_set) annotation (Line(
      points={{-12.2,64.2},{-7.1,64.2},{-7.1,28.5},{-0.4,28.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(const.y, gain.u) annotation (Line(points={{-155,72},{-92,72}}, color={0,0,127}));
  connect(gain.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-69,72},{-60,72},{-60,72.3},{-35.3,72.3}}, color={0,0,127}));
  connect(const1.y, primaryBalancingController.Frequenzy) annotation (Line(points={{-69,38},{-68,38},{-68,58.7},{-35.2,58.7}}, color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk.PRL_Angebot, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-0.4,31},{-54,31},{-54,72.3},{-35.3,72.3}},     color={0,127,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk.Max_Wind_1) annotation (Line(points={{-109,-4},{-54,-4},{-54,10.8333},{-0.4,10.8333}},
                                                                                                                                 color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk.Max_PV_1) annotation (Line(points={{-111,28},{-96,28},{-96,14},{-82,14},{-82,22.1667},{-0.4,22.1667}},
                                                                                                                                                 color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Check_Regler_Virtuelles_Kraftwerk;
