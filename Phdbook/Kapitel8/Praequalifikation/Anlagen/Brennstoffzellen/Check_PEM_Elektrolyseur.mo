within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
model Check_PEM_Elektrolyseur
  import MABook;
  Anlagen.Brennstoffzellen.PEM_Elektrolyseur pEM_Elektrolyseur(P_el_n=0.5e6, P_el_min=0) annotation (Placement(transformation(extent={{-26,2},{-6,22}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-66,14})));
  Modelica.Blocks.Sources.Step step(
    height=1e6,
    offset=0,
    startTime=50) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,8})));
equation
  connect(ElectricGrid.epp, pEM_Elektrolyseur.epp) annotation (Line(
      points={{-56,14},{-44,14},{-44,11.9},{-26.3,11.9}},
      color={0,135,135},
      thickness=0.5));
  connect(step.y, pEM_Elektrolyseur.electricPowerIn) annotation (Line(points={{21,8},{6,8},{6,7.6},{-5.2,7.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Check generischer Elektrolyseur</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Check_PEM_Elektrolyseur;
