within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Messung;
model Check_Erbingungszuverlaessigkeit
  import MABook;
  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit prognosegenauigkeit annotation (Placement(transformation(extent={{8,-6},{50,38}})));
  Modelica.Blocks.Sources.Constant const(k=-1000) annotation (Placement(transformation(extent={{-94,32},{-74,52}})));
  Modelica.Blocks.Sources.Constant const1(k=-1200)
                                                  annotation (Placement(transformation(extent={{-92,-34},{-72,-14}})));
equation
  connect(const.y, prognosegenauigkeit.prognosisPower) annotation (Line(points={{-73,42},{-54,42},{-54,31.18},{6.11,31.18}},   color={0,0,127}));
  connect(const1.y, prognosegenauigkeit.PowerIn) annotation (Line(points={{-71,-24},{-54,-24},{-54,3.68},{6.11,3.68}},       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>&Uuml;berpr&uuml;fung: Berechnung der Erbringungszuverl&auml;ssigkeit</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Check_Erbingungszuverlaessigkeit;
