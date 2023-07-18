within Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie;
model Check_Zyklenzahl_von_SOC
  Zyklanzahl_von_SOC zyklanzahl_von_SOC(start=1) annotation (Placement(transformation(extent={{72,-6},{92,14}})));
  LiIon_Battery liIon_Battery(genericStorage(params=LithiumIon(E_start=420*24*3600))) annotation (Placement(transformation(extent={{-22,0},{-2,20}})));
  Modelica.Blocks.Sources.Constant const1(k=-120)   annotation (Placement(transformation(extent={{-108,-28},{-88,-8}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid1(useInputConnector=false)
                                                                                annotation (Placement(transformation(extent={{32,38},{52,58}})));
equation
  connect(liIon_Battery.SOC, zyklanzahl_von_SOC.SOC) annotation (Line(points={{0,2.6},{36,2.6},{36,3.9},{71.1,3.9}}, color={0,0,127}));
  connect(const1.y, liIon_Battery.electricPowerIn) annotation (Line(points={{-87,-18},{-54,-18},{-54,10.8},{-23.3,10.8}}, color={0,0,127}));
  connect(liIon_Battery.epp, ElectricGrid1.epp) annotation (Line(
      points={{-2.2,9.4},{-2.2,29.7},{32,29.7},{32,48}},
      color={0,135,135},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=360000,
      Interval=36000,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>&Uuml;berpr&uuml;fung: Berechnung der Zyklenzahl aus dem Ladezustand</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Check_Zyklenzahl_von_SOC;
