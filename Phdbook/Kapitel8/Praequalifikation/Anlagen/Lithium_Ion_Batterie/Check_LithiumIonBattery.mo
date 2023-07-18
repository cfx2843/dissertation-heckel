within Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie;
model Check_LithiumIonBattery
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{38,12},{58,32}})));
  Modelica.Blocks.Sources.Constant const(k=-100000) annotation (Placement(transformation(extent={{-90,28},{-70,48}})));
  Anlagen.Lithium_Ion_Batterie.LiIon_Battery liIon_Battery(genericStorage(params=Anlagen.Lithium_Ion_Batterie.LithiumIon(E_start=5000*24*3600, P_max_unload=5000))) annotation (Placement(transformation(extent={{-32,20},{-12,40}})));
equation

  connect(const.y, liIon_Battery.electricPowerIn) annotation (Line(points={{-69,38},{-52,38},{-52,30.8},{-33.3,30.8}}, color={0,0,127}));
  connect(liIon_Battery.epp, ElectricGrid.epp) annotation (Line(
      points={{-12.2,29.4},{12.9,29.4},{12.9,22},{38,22}},
      color={0,135,135},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=36000,
      StopTime=360000,
      Interval=10.000008,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>&Uuml;berpr&uuml;fung Speichermodell Layer erstellt durch Daniel Ducci Dokumentation in unteren Layer</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Check_LithiumIonBattery;
