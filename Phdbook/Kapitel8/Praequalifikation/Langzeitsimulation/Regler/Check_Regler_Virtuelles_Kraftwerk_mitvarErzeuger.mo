within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model Check_Regler_Virtuelles_Kraftwerk_mitvarErzeuger
  import MABook;
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(extent={{-34,56},{-14,76}})));
  Modelica.Blocks.Sources.Constant const(k=-100)
                                         annotation (Placement(transformation(extent={{-176,62},{-156,82}})));
  Modelica.Blocks.Math.Gain gain(k=0.1)
                                 annotation (Placement(transformation(extent={{-90,62},{-70,82}})));
  Modelica.Blocks.Sources.Constant const1(k=50.1)
                                         annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Modelica.Blocks.Sources.Constant const2(k=-3)
                                         annotation (Placement(transformation(extent={{-64,-38},{-44,-18}})));
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitvarErzeuger regler_Virtuelles_Kraftwerk_mitvarErzeuger annotation (Placement(transformation(extent={{24,-90},{82,88}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
                                         annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
  Modelica.Blocks.Sources.Constant const4(k=0.9)
                                         annotation (Placement(transformation(extent={{-60,92},{-40,112}})));
equation
  connect(const.y, gain.u) annotation (Line(points={{-155,72},{-92,72}}, color={0,0,127}));
  connect(gain.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-69,72},{-60,72},{-60,72.3},{-35.3,72.3}}, color={0,0,127}));
  connect(const1.y, primaryBalancingController.Frequenzy) annotation (Line(points={{-69,38},{-68,38},{-68,58.7},{-35.2,58.7}}, color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_PV_2) annotation (Line(points={{-43,-28},{-10,-28},{-10,0.78},{23.42,0.78}},       color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_PV_3) annotation (Line(points={{-43,-28},{-10,-28},{-10,-5.45},{23.42,-5.45}},     color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_PV_4) annotation (Line(points={{-43,-28},{-10,-28},{-10,-11.68},{23.42,-11.68}},     color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_PV_5) annotation (Line(points={{-43,-28},{-10,-28},{-10,-17.91},{23.42,-17.91}},
                                                                                                                                                color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_Wind_1) annotation (Line(points={{-43,-28},{-10,-28},{-10,-37.49},{22.84,-37.49}},     color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_Wind_2) annotation (Line(points={{-43,-28},{-10,-28},{-10,-43.72},{22.84,-43.72}},     color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_Wind_3) annotation (Line(points={{-43,-28},{-10,-28},{-10,-49.95},{22.84,-49.95}},
                                                                                                                                                    color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_Wind_4) annotation (Line(points={{-43,-28},{-10,-28},{-10,-56.18},{22.84,-56.18}},     color={0,0,127}));
  connect(const2.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_Wind_5) annotation (Line(points={{-43,-28},{-10,-28},{-10,-62.41},{22.84,-62.41}},     color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk_mitvarErzeuger.PRL_Angebot, primaryBalancingController.PRL_Angebot) annotation (Line(points={{22.84,51.51},{-4,51.51},{-4,84},{-42,84},{-42,72.3},{-35.3,72.3}},     color={0,127,127}));
  connect(primaryBalancingController.P_set, regler_Virtuelles_Kraftwerk_mitvarErzeuger.PRL_set) annotation (Line(
      points={{-12.2,64.2},{5.9,64.2},{5.9,41.72},{22.84,41.72}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_P_Erzeuger) annotation (Line(points={{-39,14},{-24,14},{-24,25.7},{22.26,25.7}},       color={0,0,127}));
  connect(const4.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.SOF_Gas) annotation (Line(points={{-39,102},{-10,102},{-10,65.75},{22.84,65.75}},     color={0,0,127}));
  connect(const3.y, regler_Virtuelles_Kraftwerk_mitvarErzeuger.Max_PV_1) annotation (Line(points={{-39,14},{-10,14},{-10,7.01},{23.42,7.01}},       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>&Uuml;berpr&uuml;fung Betriebsf&uuml;hrung und &quot;Fallregler&quot; f&uuml;r ein virtuelles Kraftwerk mit einem nicht-volatilen Erzeuger.</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Check_Regler_Virtuelles_Kraftwerk_mitvarErzeuger;
