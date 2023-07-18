within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_statisch;
model Lastprofil_Waerme
  parameter Integer n_Gebaude=40 "Anzahl der zu versorgenden Gebäude";
  parameter Real n_Personen=3 "Durchschnittliche Anzahl Personen pro Haushalt";
  parameter Real A_Gebaeude=140 "Durchschnittliche Wohnfläche der Gebäude";
  parameter Modelica.Units.SI.Energy Q_H=50*3600000 "spezifischer Heizwärmebedarf";
  parameter Modelica.Units.SI.Energy Q_W=500*3600000 "spezifischer Brauchwasserwärmebedarf pro Person";
  Modelica.Blocks.Sources.RealExpression Heizwaerme_pro_Jahr(y=n_Gebaude*A_Gebaeude*Q_H) annotation (Placement(transformation(extent={{-96,-80},{-8,-32}})));
  Modelica.Blocks.Sources.RealExpression Brauchwasserwaerme_pro_Jahr(y=Q_W*n_Gebaude*n_Personen)
                                                                                             annotation (Placement(transformation(extent={{-92,40},{-4,88}})));
  TransiEnt.Basics.Tables.GenericDataTable Last_in_Joule_pro_Minute_1000(
    multiple_outputs(
      quantity=2,
      start=false,
      fixed=true) = true,
    columns={2,3},
    use_absolute_path=true,
    absolute_path="C:/ducci/Daten/Lastprofil.txt",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    shiftTime=0,
    timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateOut Trinkwasserwaerme annotation (Placement(transformation(extent={{88,30},{144,86}}), iconTransformation(extent={{88,30},{144,86}})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateOut Heizwaerme annotation (Placement(transformation(extent={{86,-76},{142,-20}}), iconTransformation(extent={{88,-78},{144,-22}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(extent={{52,48},{72,68}})));
  Modelica.Blocks.Math.Product product2 annotation (Placement(transformation(extent={{48,-56},{68,-36}})));
  Modelica.Blocks.Math.Gain gain(k=1/60000) annotation (Placement(transformation(extent={{-2,-38},{18,-18}})));
  Modelica.Blocks.Math.Gain gain1(k=1/60000) annotation (Placement(transformation(extent={{-8,24},{12,44}})));
equation
  connect(Brauchwasserwaerme_pro_Jahr.y, product1.u1) annotation (Line(points={{0.4,64},{50,64}}, color={0,0,127}));
  connect(product1.y, Trinkwasserwaerme) annotation (Line(points={{73,58},{116,58}}, color={0,0,127}));
  connect(product2.y, Heizwaerme) annotation (Line(points={{69,-46},{90,-46},{90,-48},{114,-48}}, color={0,0,127}));
  connect(Heizwaerme_pro_Jahr.y, product2.u2) annotation (Line(points={{-3.6,-56},{22,-56},{22,-52},{46,-52}}, color={0,0,127}));
  connect(product2.u1, gain.y) annotation (Line(points={{46,-40},{36,-40},{36,-28},{19,-28}}, color={0,0,127}));
  connect(gain.u, Last_in_Joule_pro_Minute_1000.y[1]) annotation (Line(points={{-4,-28},{-22,-28},{-22,0},{-49,0}}, color={0,0,127}));
  connect(product1.u2, gain1.y) annotation (Line(points={{50,52},{44,52},{44,34},{13,34}}, color={0,0,127}));
  connect(Last_in_Joule_pro_Minute_1000.y[2], gain1.u) annotation (Line(points={{-49,0},{-28,0},{-28,34},{-10,34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Lastprofil_Waerme;
