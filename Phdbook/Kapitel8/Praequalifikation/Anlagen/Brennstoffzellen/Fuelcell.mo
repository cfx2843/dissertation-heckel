within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block Fuelcell
  parameter Real eta_FC=0.75 "Wirkungsgrad der Elektrolyse";
  parameter Modelica.Units.SI.Power P_max=1e6 "Anschlussleistung Brennstoffzelle";
  parameter Modelica.Units.SI.SpecificEnergy H_H2=120e6 "Heizwert Wasserstoff";

  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_el_set annotation (Placement(transformation(extent={{-176,26},{-138,62}}),iconTransformation(extent={{-176,26},{-138,62}})));
  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{88,52},{108,72}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Power Power(change_sign=true)
                                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,62})));
  Modelica.Blocks.Math.Gain gain(k=1/eta_FC)        annotation (Placement(transformation(extent={{12,-10},{32,10}})));
  Modelica.Blocks.Math.Gain gain1(k=1/H_H2)         annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateOut m_dot_H2 annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Continuous.SecondOrder secondOrder(
    k=-1,
    w=15,
    D=0.65)                                          annotation (Placement(transformation(extent={{-50,34},{-30,54}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0, uMin=-P_max)
                                            annotation (Placement(transformation(extent={{-118,32},{-98,52}})));
equation
  connect(Power.epp, epp) annotation (Line(
      points={{68,62},{98,62}},
      color={0,135,135},
      thickness=0.5));
  connect(gain.y, gain1.u) annotation (Line(points={{33,0},{46,0}}, color={0,0,127}));
  connect(gain1.y, m_dot_H2) annotation (Line(points={{69,0},{86,0},{86,0},{104,0}}, color={0,0,127}));
  connect(secondOrder.y, Power.P_el_set) annotation (Line(points={{-29,44},{18,44},{18,50},{64,50}}, color={0,0,127}));
  connect(P_el_set, limiter.u) annotation (Line(points={{-157,44},{-138,44},{-138,42},{-120,42}}, color={0,127,127}));
  connect(limiter.y, secondOrder.u) annotation (Line(points={{-97,42},{-73.5,42},{-73.5,44},{-52,44}}, color={0,0,127}));
  connect(limiter.y, gain.u) annotation (Line(points={{-97,42},{-74,42},{-74,0},{10,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Generische Brennstoffzelle</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Fuelcell;
