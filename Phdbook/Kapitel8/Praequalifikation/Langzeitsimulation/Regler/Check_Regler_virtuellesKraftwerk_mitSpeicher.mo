within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model Check_Regler_virtuellesKraftwerk_mitSpeicher
  import MABook;
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitSpeicher_neu regler_Virtuelles_Kraftwerk_mitLiIon(SOC_LiIon_soll=0.5) annotation (Placement(transformation(extent={{-40,-82},{46,52}})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
  Modelica.Blocks.Sources.Constant const(k=-5000)
                                                 annotation (Placement(transformation(extent={{-136,32},{-116,52}})));
  Modelica.Blocks.Sources.Constant const1(k=49.9) annotation (Placement(transformation(extent={{-136,2},{-116,22}})));
  Modelica.Blocks.Sources.Constant const2(k=-100)
                                                annotation (Placement(transformation(extent={{-118,-64},{-98,-44}})));
  Modelica.Blocks.Sources.Constant const3(k=-50)  annotation (Placement(transformation(extent={{-136,-32},{-116,-12}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie.LiIon_Battery liIon_Battery(genericStorage(params=Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie.LithiumIon(E_start=5000*24*3600, P_max_unload=5000))) annotation (Placement(transformation(extent={{-50,56},{-30,76}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{94,52},{114,72}})));
equation
  connect(const.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-115,42},{-100,42},{-100,42.3},{-83.3,42.3}}, color={0,0,127}));
  connect(const1.y, primaryBalancingController.Frequenzy) annotation (Line(points={{-115,12},{-100,12},{-100,28.7},{-83.2,28.7}}, color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.PRL_set, primaryBalancingController.P_set) annotation (Line(points={{-40.86,10.5238},{-51.86,10.5238},{-51.86,34.2},{-60.2,34.2}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.PRL_Angebot, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-40.86,16.2667},{-96,16.2667},{-96,42.3},{-83.3,42.3}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_LiIon, liIon_Battery.electricPowerIn) annotation (Line(
      points={{47.72,41.7905},{72,41.7905},{72,88},{-58,88},{-58,66.8},{-51.3,66.8}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(liIon_Battery.Max_P_load, regler_Virtuelles_Kraftwerk_mitLiIon.Max_P_load_LiIon) annotation (Line(
      points={{-28.8,70.4},{4,70.4},{4,31.581},{-42.58,31.581}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(liIon_Battery.Max_P_unload, regler_Virtuelles_Kraftwerk_mitLiIon.Max_P_unload_LiIon) annotation (Line(
      points={{-29.2,74},{22,74},{22,25.8381},{-42.58,25.8381}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(liIon_Battery.SOC, regler_Virtuelles_Kraftwerk_mitLiIon.SOC_LiIon) annotation (Line(points={{-28,58.6},{-14,58.6},{-14,58},{-2,58},{-2,42.4286},{-41.72,42.4286}}, color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_1) annotation (Line(points={{-97,-54},{-70,-54},{-70,-44.3524},{-42.58,-44.3524}}, color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_2) annotation (Line(points={{-97,-54},{-70,-54},{-70,-51.3714},{-42.58,-51.3714}},
                                                                                                                                               color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_3) annotation (Line(points={{-97,-54},{-70,-54},{-70,-56.4762},{-42.58,-56.4762}}, color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_4) annotation (Line(points={{-97,-54},{-70,-54},{-70,-66.0476},{-42.58,-66.0476}}, color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_5) annotation (Line(points={{-97,-54},{-72,-54},{-72,-73.7048},{-42.58,-73.7048}}, color={0,0,127}));
  connect(ElectricGrid.epp, liIon_Battery.epp) annotation (Line(
      points={{94,62},{32,62},{32,65.4},{-30.2,65.4}},
      color={0,135,135},
      thickness=0.5));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_1) annotation (Line(points={{-115,-22},{-80,-22},{-80,-6.70476},{-42.58,-6.70476}}, color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_2) annotation (Line(points={{-115,-22},{-80,-22},{-80,-13.7238},{-42.58,-13.7238}}, color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_3) annotation (Line(points={{-115,-22},{-80,-22},{-80,-19.4667},{-42.58,-19.4667}}, color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_4) annotation (Line(points={{-115,-22},{-80,-22},{-80,-26.4857},{-42.58,-26.4857}}, color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_5) annotation (Line(points={{-115,-22},{-80,-22},{-80,-33.5048},{-42.58,-33.5048}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1800000,
      Interval=10,
      __Dymola_Algorithm="Dassl"));
end Check_Regler_virtuellesKraftwerk_mitSpeicher;
