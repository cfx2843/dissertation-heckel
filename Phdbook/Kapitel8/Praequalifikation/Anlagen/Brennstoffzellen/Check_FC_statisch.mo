within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
model Check_FC_statisch
    import TransiEnt;
  import      Modelica.Units.SI;
  Modelica.Blocks.Sources.Step step(
    offset=-1e7,
    height=2e7,
    startTime=60)                   annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));

  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{54,-20},{74,0}})));
  Rev_PEM_FC_statisch rev_PEM_FC_statisch annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-6,-6})));
equation
  connect(rev_PEM_FC_statisch.electricPowerIn, step.y) annotation (Line(points={{-16.8,-1.6},{-44.4,-1.6},{-44.4,0},{-73,0}}, color={0,127,127}));
  connect(rev_PEM_FC_statisch.epp, ElectricGrid.epp) annotation (Line(
      points={{4.3,-5.9},{54,-5.9},{54,-10}},
      color={0,135,135},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=150,
      Interval=0.01,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">&Uuml;berpr&uuml;fung statisch-generische Brennstoffzelle</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Check_FC_statisch;
