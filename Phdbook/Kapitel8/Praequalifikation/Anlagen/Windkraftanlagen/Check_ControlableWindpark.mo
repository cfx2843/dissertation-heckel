within Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen;
model Check_ControlableWindpark
  import MABook;
  import MABook;
  import MABook;
  Anlagen.Windkraftanlagen.ControlableWindpark controlableWindpark(N=10) annotation (Placement(transformation(extent={{-16,22},{4,42}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{32,20},{52,40}})));
  TransiEnt.Basics.Tables.GenericDataTable windDaten16(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/windDaten16.txt",
    shiftTime=3600)                                                            annotation (Placement(transformation(extent={{-82,60},{-62,80}})));
  Modelica.Blocks.Sources.Constant const(k=-19999999) annotation (Placement(transformation(extent={{-64,-24},{-44,-4}})));
  inner TransiEnt.SimCenter simCenter annotation (Placement(transformation(extent={{-10,64},{10,84}})));
  Anlagen.Windkraftanlagen.ControlableWindpark PrognosecontrolableWindpark(N=10) annotation (Placement(transformation(extent={{-10,-38},{10,-18}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid1
                                                                                annotation (Placement(transformation(extent={{38,-40},{58,-20}})));
  Modelica.Blocks.Sources.Constant const1(k=-19999999)
                                                      annotation (Placement(transformation(extent={{-58,-84},{-38,-64}})));
  TransiEnt.Basics.Tables.GenericDataTable windPrognose16(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/windPrognose16.txt",
    shiftTime=0)                                                                  annotation (Placement(transformation(extent={{-90,-44},{-70,-24}})));
  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit prognosegenauigkeit annotation (Placement(transformation(extent={{84,2},{104,22}})));
  parameter Real endTime=31536000;
equation
  connect(controlableWindpark.epp, ElectricGrid.epp) annotation (Line(
      points={{4.4,32},{20,32},{20,30},{32,30}},
      color={0,135,135},
      thickness=0.5));
  connect(windDaten16.y1, controlableWindpark.v_wind) annotation (Line(points={{-61,70},{-38,70},{-38,31.8},{-16.4,31.8}}, color={0,0,127}));
  connect(const.y, controlableWindpark.P_set) annotation (Line(points={{-43,-14},{-30,-14},{-30,24.3},{-16.8,24.3}}, color={0,0,127}));
  connect(PrognosecontrolableWindpark.epp, ElectricGrid1.epp) annotation (Line(
      points={{10.4,-28},{26,-28},{26,-30},{38,-30}},
      color={0,135,135},
      thickness=0.5));
  connect(const1.y, PrognosecontrolableWindpark.P_set) annotation (Line(points={{-37,-74},{-24,-74},{-24,-35.7},{-10.8,-35.7}}, color={0,0,127}));
  connect(windPrognose16.y1, PrognosecontrolableWindpark.v_wind) annotation (Line(points={{-69,-34},{-40,-34},{-40,-28.2},{-10.4,-28.2}}, color={0,0,127}));
  connect(controlableWindpark.MaxP_Out, prognosegenauigkeit.prognosisPower) annotation (Line(
      points={{4.6,38.6},{43.3,38.6},{43.3,18.9},{83.1,18.9}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PrognosecontrolableWindpark.MaxP_Out, prognosegenauigkeit.PowerIn) annotation (Line(
      points={{10.6,-21.4},{47.3,-21.4},{47.3,6.4},{83.1,6.4}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end Check_ControlableWindpark;
