within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
model Check_FC
    import TransiEnt;
  import      Modelica.Units.SI;
  Modelica.Blocks.Sources.Step step(
    offset=0,
    height=1e7,
    startTime=10)                   annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
  Modelica.Blocks.Sources.Step step1(height=-(2e7),                 startTime=30)
                                     annotation (Placement(transformation(extent={{-100,4},{-80,24}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=2) annotation (Placement(transformation(extent={{-60,36},{-48,48}})));

public
  Rev_PEM_FC rev_PEM_FC(
    P_el_n(displayUnit="MW") = 11000000,
    P_el_min=0,
    T_out=343.15,
    p_out=3500000)      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,-12})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{54,-20},{74,0}})));
  Druckspeicher druckspeicher(
    Kapazitaet=1,
    p_Max=80000000,
    T_b(displayUnit="K"),
    SOC_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={48,-46})));
equation
  connect(step.y,multiSum. u[1]) annotation (Line(points={{-79,44},{-70,44},{-70,44.1},{-60,44.1}}, color={0,0,127}));
  connect(step1.y,multiSum. u[2]) annotation (Line(points={{-79,14},{-70,14},{-70,40},{-60,40},{-60,39.9}},
                                                                                                 color={0,0,127}));
  connect(multiSum.y, rev_PEM_FC.electricPowerIn) annotation (Line(points={{-46.98,42},{-18,42},{-18,-7.6},{7.2,-7.6}},
                                                                                                                      color={0,0,127}));
  connect(ElectricGrid.epp, rev_PEM_FC.epp) annotation (Line(
      points={{54,-10},{42,-10},{42,-11.9},{28.3,-11.9}},
      color={0,135,135},
      thickness=0.5));
  connect(rev_PEM_FC.epp, druckspeicher.epp) annotation (Line(
      points={{28.3,-11.9},{57.1,-11.9},{57.1,-39.1}},
      color={0,135,135},
      thickness=0.5));
  connect(rev_PEM_FC.m_flow, druckspeicher.massFlowRateIn) annotation (Line(points={{28.9,-18.9},{28.9,-46},{38.2,-46},{38.2,-45.2}}, color={0,0,127}));
  connect(druckspeicher.P_V, rev_PEM_FC.Zusatzleistung_verdichter) annotation (Line(
      points={{36.6,-40.6},{2,-40.6},{2,-18.7},{8.7,-18.7}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=9,
      StopTime=50,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">&Uuml;berpr&uuml;fung: Generische Brennstoffzelle</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Check_FC;
