within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Simulationsoptimierung;
model Optimierung_Prognose
  TransiEnt.Basics.Tables.GenericDataTable Prognose_Optimierung_S1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/Prognose_2017_S2.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-104,74},{-84,94}})));
  Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{30,124},{50,144}})));
public
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.PrognosisWindpark Wind_1_p(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={82,38})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.PrognosisPVModule PV_12_p(P_inst(displayUnit="MW") = 1933920, use_input_data=true) annotation (Placement(transformation(extent={{-42,26},{-22,46}})));
            TransiEnt.Basics.Tables.GenericDataTable Prog_12(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_12.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-84,28},{-64,48}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.PrognosisPVModule PV_14_p(P_inst(displayUnit="MW") = 749650, use_input_data=true) annotation (Placement(transformation(extent={{-42,-4},{-22,16}})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_14(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_14.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-84,-2},{-64,18}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.PrognosisPVModule PV_16_p(P_inst(displayUnit="MW") = 900660, use_input_data=true) annotation (Placement(transformation(extent={{-42,-36},{-22,-16}})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_16(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_16.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-84,-34},{-64,-14}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.PrognosisPVModule PV_17_p(P_inst(displayUnit="MW") = 2315040, use_input_data=true) annotation (Placement(transformation(extent={{-42,-66},{-22,-46}})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_17(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_17.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-84,-64},{-64,-44}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.PrognosisPVModule PV_19_p(P_inst(displayUnit="MW") = 6320800, use_input_data=true) annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_19(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_19.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-82,-94},{-62,-74}})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_2.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,38})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_4(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_4.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,8})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_6(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_6.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,-22})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_8(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_8.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,-52})));
  TransiEnt.Basics.Tables.GenericDataTable Prog_10(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Prognose17_10.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={118,-84})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.PrognosisWindpark Wind_2_p(N=1, windTurbineModel(P_el_n=2300000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE82_2300kW())) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,8})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.PrognosisWindpark Wind_3_p(N=1, windTurbineModel(P_el_n=2000000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV90_2000kW())) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,-20})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.PrognosisWindpark Wind_4_p(N=1, windTurbineModel(P_el_n=3050000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE101_3050kW())) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,-52})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.PrognosisWindpark Wind_5_p(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,-84})));
         Modelica.Blocks.Math.MultiSum Prognose_Summe(nu=10) annotation (Placement(transformation(
        extent={{-17,-17},{17,17}},
        rotation=90,
        origin={21,55})));
equation
  connect(Prog_12.y[1],PV_12_p. T_in) annotation (Line(points={{-63,38},{-54,38},{-54,44},{-44,44}},     color={0,0,127}));
  connect(Prog_12.y[2],PV_12_p. DNI_in) annotation (Line(points={{-63,38},{-54,38},{-54,38.4},{-44,38.4}},     color={0,0,127}));
  connect(Prog_12.y[3],PV_12_p. DHI_in) annotation (Line(points={{-63,38},{-54,38},{-54,33.4},{-44,33.4}},     color={0,0,127}));
  connect(Prog_12.y[4],PV_12_p. WindSpeed_in) annotation (Line(points={{-63,38},{-54,38},{-54,28},{-44,28}},     color={0,0,127}));
  connect(Prog_14.y[1],PV_14_p. T_in) annotation (Line(points={{-63,8},{-54,8},{-54,14},{-44,14}},       color={0,0,127}));
  connect(Prog_14.y[2],PV_14_p. DNI_in) annotation (Line(points={{-63,8},{-54,8},{-54,8.4},{-44,8.4}},         color={0,0,127}));
  connect(Prog_14.y[3],PV_14_p. DHI_in) annotation (Line(points={{-63,8},{-54,8},{-54,3.4},{-44,3.4}},         color={0,0,127}));
  connect(Prog_14.y[4],PV_14_p. WindSpeed_in) annotation (Line(points={{-63,8},{-54,8},{-54,-2},{-44,-2}},       color={0,0,127}));
  connect(Prog_16.y[1],PV_16_p. T_in) annotation (Line(points={{-63,-24},{-54,-24},{-54,-18},{-44,-18}}, color={0,0,127}));
  connect(Prog_16.y[2],PV_16_p. DNI_in) annotation (Line(points={{-63,-24},{-54,-24},{-54,-23.6},{-44,-23.6}}, color={0,0,127}));
  connect(Prog_16.y[3],PV_16_p. DHI_in) annotation (Line(points={{-63,-24},{-54,-24},{-54,-28.6},{-44,-28.6}}, color={0,0,127}));
  connect(Prog_16.y[4],PV_16_p. WindSpeed_in) annotation (Line(points={{-63,-24},{-54,-24},{-54,-34},{-44,-34}}, color={0,0,127}));
  connect(Prog_17.y[1],PV_17_p. T_in) annotation (Line(points={{-63,-54},{-54,-54},{-54,-48},{-44,-48}}, color={0,0,127}));
  connect(Prog_17.y[2],PV_17_p. DNI_in) annotation (Line(points={{-63,-54},{-54,-54},{-54,-53.6},{-44,-53.6}}, color={0,0,127}));
  connect(Prog_17.y[3],PV_17_p. DHI_in) annotation (Line(points={{-63,-54},{-54,-54},{-54,-58.6},{-44,-58.6}}, color={0,0,127}));
  connect(Prog_17.y[4],PV_17_p. WindSpeed_in) annotation (Line(points={{-63,-54},{-54,-54},{-54,-64},{-44,-64}}, color={0,0,127}));
  connect(Prog_19.y[1],PV_19_p. T_in) annotation (Line(points={{-61,-84},{-52,-84},{-52,-78},{-42,-78}}, color={0,0,127}));
  connect(Prog_19.y[2],PV_19_p. DNI_in) annotation (Line(points={{-61,-84},{-52,-84},{-52,-83.6},{-42,-83.6}}, color={0,0,127}));
  connect(Prog_19.y[3],PV_19_p. DHI_in) annotation (Line(points={{-61,-84},{-52,-84},{-52,-88.6},{-42,-88.6}}, color={0,0,127}));
  connect(Prog_19.y[4],PV_19_p. WindSpeed_in) annotation (Line(points={{-61,-84},{-52,-84},{-52,-94},{-42,-94}}, color={0,0,127}));
  connect(Prog_1.y[4],Wind_1_p. v_wind) annotation (Line(points={{105,38},{98,38},{98,38.2},{92.4,38.2}},            color={0,0,127}));
  connect(Prog_4.y[4],Wind_2_p. v_wind) annotation (Line(points={{105,8},{98,8},{98,8.2},{90.4,8.2}},                color={0,0,127}));
  connect(Prog_6.y[4],Wind_3_p. v_wind) annotation (Line(points={{105,-22},{100,-22},{100,-19.8},{94.4,-19.8}},      color={0,0,127}));
  connect(Prog_8.y[4],Wind_4_p. v_wind) annotation (Line(points={{105,-52},{102,-52},{102,-51.8},{98.4,-51.8}},      color={0,0,127}));
  connect(Prog_10.y[4],Wind_5_p. v_wind) annotation (Line(points={{107,-84},{102,-84},{102,-83.8},{96.4,-83.8}},      color={0,0,127}));
  connect(PV_12_p.MaxP_out,Prognose_Summe. u[1]) annotation (Line(
      points={{-20.6,36},{2,36},{2,38},{10.29,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_14_p.MaxP_out,Prognose_Summe. u[2]) annotation (Line(
      points={{-20.6,6},{0,6},{0,38},{12.67,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_16_p.MaxP_out,Prognose_Summe. u[3]) annotation (Line(
      points={{-20.6,-26},{2,-26},{2,38},{15.05,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_17_p.MaxP_out,Prognose_Summe. u[4]) annotation (Line(
      points={{-20.6,-56},{2,-56},{2,38},{17.43,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_19_p.MaxP_out,Prognose_Summe. u[5]) annotation (Line(
      points={{-18.6,-86},{4,-86},{4,38},{19.81,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_1_p.MaxP_Out,Prognose_Summe. u[6]) annotation (Line(
      points={{71.4,38},{22.19,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_2_p.MaxP_Out,Prognose_Summe. u[7]) annotation (Line(
      points={{69.4,8},{46,8},{46,38},{24.57,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_3_p.MaxP_Out,Prognose_Summe. u[8]) annotation (Line(
      points={{73.4,-20},{50,-20},{50,38},{26.95,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_4_p.MaxP_Out,Prognose_Summe. u[9]) annotation (Line(
      points={{77.4,-52},{50,-52},{50,38},{29.33,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_5_p.MaxP_Out,Prognose_Summe. u[10]) annotation (Line(
      points={{75.4,-84},{50,-84},{50,38},{31.71,38}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Prognose_Summe.y, add.u2) annotation (Line(points={{21,74.89},{21,101.445},{28,101.445},{28,128}}, color={0,0,127}));
  connect(Prognose_Optimierung_S1.y[1], add.u1) annotation (Line(points={{-83,84},{-27.5,84},{-27.5,140},{28,140}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=10,
      __Dymola_fixedstepsize=10,
      __Dymola_Algorithm="Rkfix4"),
    Documentation(info="<html>
<p>Zur reduzierung der Rechenzeit wurde hier bereits die Prognosleistung  zu einer Datentabelle Zusammengefasst</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Optimierung_Prognose;
