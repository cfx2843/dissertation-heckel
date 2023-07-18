within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block Elektrolyseur_statisch
  parameter Real eta_ely=0.4 "Wirkungsgrad der Elektrolyse";
  parameter Modelica.Units.SI.Power P_max=1e6 "Anschlussleistung Elektrolyseur";
  parameter Modelica.Units.SI.SpecificEnergy H_H2=120e6 "Heizwert Wasserstoff";

  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_el_set annotation (Placement(transformation(extent={{-112,26},{-74,62}}), iconTransformation(extent={{-112,26},{-74,62}})));
  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{88,52},{108,72}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power Power(change_sign=false)
                                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,62})));
  Modelica.Blocks.Math.Gain gain(k=eta_ely)         annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  Modelica.Blocks.Math.Gain gain1(k=1/H_H2)         annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateOut m_dot_H2 annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=P_max, uMin=0)
                                            annotation (Placement(transformation(extent={{-72,32},{-52,52}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut electricPowerOut annotation (Placement(transformation(extent={{94,-66},{130,-30}}), iconTransformation(extent={{94,-66},{130,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=P_max) annotation (Placement(transformation(extent={{34,-58},{54,-38}})));
equation
  connect(Power.epp, epp) annotation (Line(
      points={{68,62},{98,62}},
      color={0,135,135},
      thickness=0.5));
  connect(gain.y, gain1.u) annotation (Line(points={{33,0},{46,0}}, color={0,0,127}));
  connect(gain1.y, m_dot_H2) annotation (Line(points={{69,0},{86,0},{86,0},{104,0}}, color={0,0,127}));
  connect(P_el_set, limiter.u) annotation (Line(points={{-93,44},{-92,44},{-92,42},{-74,42}},     color={0,127,127}));
  connect(limiter.y, gain.u) annotation (Line(points={{-51,42},{-20,42},{-20,0},{10,0}}, color={0,0,127}));
  connect(Power.P_el_set, gain.u) annotation (Line(points={{64,50},{64,42},{-20,42},{-20,0},{10,0}}, color={0,127,127}));
  connect(realExpression.y, electricPowerOut) annotation (Line(points={{55,-48},{78,-48},{78,-48},{112,-48}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Generischer Elektrolyseur</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Elektrolyseur_statisch;
