within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Simulationsoptimierung;
model Optimierung_Anteil_SRL
  TransiEnt.Basics.Tables.GenericDataTable SRL_Erbringung(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/regelleistung.net/SRL_Sekundenwerte_Lang.txt",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    shiftTime=3.1536e7)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,4})));
  Modelica.Blocks.Math.Gain Erbrachte_SRL(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-20,4})));
  TransiEnt.Basics.Tables.GenericDataTable SRL_Bedarf(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/regelleistung.net/SRL_Bedarf_Lang.txt",
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    shiftTime=3.1536e7)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,44})));
  Modelica.Blocks.Math.Gain Max_neg_SRL(k=1)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={14,60})));
  Modelica.Blocks.Math.Gain Max_pos_SRL(k=-1)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={14,28})));
  Modelica.Blocks.Math.Division division annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-58,38})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,44})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,44})));
  TransiEnt.Basics.Tables.GenericDataTable Prognose_Optimierung_S1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/Abrufanteil_SRL_2017.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-146,76},{-126,96}})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{-76,70},{-56,90}})));
equation
  connect(Max_pos_SRL.u,SRL_Bedarf. y[2]) annotation (Line(points={{26,28},{88,28},{88,44},{89,44}},           color={0,0,127}));
  connect(Erbrachte_SRL.u,SRL_Erbringung. y1) annotation (Line(points={{-8,4},{89,4}},         color={0,0,127}));
  connect(division.u1,Erbrachte_SRL. y) annotation (Line(points={{-46,32},{-38,32},{-38,4},{-31,4}},         color={0,0,127}));
  connect(greaterThreshold.u,SRL_Erbringung. y1) annotation (Line(points={{56,44},{68,44},{68,4},{89,4}},             color={0,0,127}));
  connect(Max_pos_SRL.y,switch1. u1) annotation (Line(points={{3,28},{-6,28},{-6,36},{-12,36}},         color={0,0,127}));
  connect(Max_neg_SRL.y,switch1. u3) annotation (Line(points={{3,60},{-6,60},{-6,52},{-12,52}},         color={0,0,127}));
  connect(greaterThreshold.y,switch1. u2) annotation (Line(points={{33,44},{-12,44}},    color={255,0,255}));
  connect(switch1.y,division. u2) annotation (Line(points={{-35,44},{-46,44}},   color={0,0,127}));
  connect(SRL_Bedarf.y[1],Max_neg_SRL. u) annotation (Line(points={{89,44},{88,44},{88,60},{26,60}},         color={0,0,127}));
  connect(Prognose_Optimierung_S1.y[1],add. u1) annotation (Line(points={{-125,86},{-78,86}},                   color={0,0,127}));
  connect(division.y, add.u2) annotation (Line(points={{-69,38},{-78,38},{-78,74}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=10.000008,
      Tolerance=1e-05,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Rkfix4"),
    Documentation(info="<html>
<p>Zur reduzierung der Rechenzeit wurde hier bereits der anteil der zu erbringenden SRL zu einer Datentabelle Zusammengefasst</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Optimierung_Anteil_SRL;
