within Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie;
block LiIon_Battery
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power Power annotation (Placement(transformation(extent={{46,-32},{66,-12}})));
  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{88,-16},{108,4}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn electricPowerIn annotation (Placement(transformation(extent={{-148,-26},{-78,42}}), iconTransformation(extent={{-148,-26},{-78,42}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Max_P_unload annotation (Placement(transformation(extent={{90,62},{126,98}}), iconTransformation(extent={{90,62},{126,98}})));
  output
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Max_P_load annotation (Placement(transformation(extent={{92,24},{132,64}}), iconTransformation(extent={{92,24},{132,64}})));
  output
  Modelica.Blocks.Interfaces.RealOutput SOC annotation (Placement(transformation(extent={{94,-100},{146,-48}}), iconTransformation(extent={{94,-100},{146,-48}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=genericStorage.P_max_load_real.y)
                                                                                          annotation (Placement(transformation(extent={{36,34},{56,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=genericStorage.P_max_unload_real.y)
                                                                                              annotation (Placement(transformation(extent={{36,72},{56,92}})));
  Modelica.Blocks.Sources.RealExpression SOC2(y=genericStorage.SOC) annotation (Placement(transformation(extent={{-92,-94},{-38,-52}})));
  replaceable Lithium_Ion_Batterie.GenericStorage_base genericStorage(params=Lithium_Ion_Batterie.LithiumIon()) annotation (Placement(transformation(extent={{-54,-18},{16,36}})));
equation
  connect(Power.epp, epp) annotation (Line(
      points={{46,-22},{46,-6},{98,-6}},
      color={0,135,135},
      thickness=0.5));
  connect(realExpression.y, Max_P_load) annotation (Line(points={{57,44},{112,44}}, color={0,0,127}));
  connect(realExpression1.y, Max_P_unload) annotation (Line(points={{57,82},{80,82},{80,80},{108,80}}, color={0,0,127}));
  connect(electricPowerIn, genericStorage.P_set) annotation (Line(points={{-113,8},{-76,8},{-76,8.46},{-57.2308,8.46}}, color={0,127,127}));
  connect(genericStorage.P_is, Power.P_el_set) annotation (Line(
      points={{16.8077,8.73},{36.48,8.73},{36.48,-10},{50,-10}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(SOC2.y, SOC) annotation (Line(points={{-35.3,-73},{87.35,-73},{87.35,-74},{120,-74}},color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Lithium-Ionen-Speichermodell Layer erstellt durch Daniel Ducci Dokumentation in unteren Layer</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end LiIon_Battery;
