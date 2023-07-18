within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_statisch;
model Check_Lastprofil_Waerme
  Lastprofil_Waerme lastprofil_Waerme annotation (Placement(transformation(extent={{-66,-40},{12,48}})));
  Modelica.Blocks.Continuous.Integrator integrator(use_reset=false) annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
  Modelica.Blocks.Continuous.Integrator integrator1(use_reset=false) annotation (Placement(transformation(extent={{70,26},{90,46}})));
  Modelica.Blocks.Continuous.Derivative derivative annotation (Placement(transformation(extent={{110,24},{130,44}})));
equation
  connect(lastprofil_Waerme.Heizwaerme, integrator.u) annotation (Line(
      points={{18.24,-18},{44,-18},{44,-24},{68,-24}},
      color={175,0,0},
      pattern=LinePattern.Dash));
  connect(lastprofil_Waerme.Trinkwasserwaerme, integrator1.u) annotation (Line(
      points={{18.24,29.52},{42.12,29.52},{42.12,36},{68,36}},
      color={175,0,0},
      pattern=LinePattern.Dash));
  connect(integrator1.y, derivative.u) annotation (Line(points={{91,36},{100,36},{100,34},{108,34}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31449600,
      Interval=29.9999808,
      __Dymola_Algorithm="Dassl"));
end Check_Lastprofil_Waerme;
