within Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen;
model Check_WindparkPrognosis
  TransiEnt.Basics.Tables.GenericDataTable windPrognose16(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/windPrognose16.txt",
    shiftTime=0)                                                                  annotation (Placement(transformation(extent={{-78,6},{-58,26}})));
  inner TransiEnt.SimCenter simCenter annotation (Placement(transformation(extent={{-58,64},{-38,84}})));
  Windkraftanlagen.PrognosisWindpark prognosisWindpark annotation (Placement(transformation(extent={{16,2},{36,22}})));
equation
  connect(windPrognose16.y1, prognosisWindpark.v_wind) annotation (Line(points={{-57,16},{-20,16},{-20,11.8},{15.6,11.8}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end Check_WindparkPrognosis;
