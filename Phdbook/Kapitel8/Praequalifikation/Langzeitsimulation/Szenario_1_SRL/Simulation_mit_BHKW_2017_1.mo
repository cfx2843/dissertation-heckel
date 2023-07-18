within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Szenario_1_SRL;
model Simulation_mit_BHKW_2017_1
  import MABook;

public
  Modelica.Blocks.Interfaces.RealOutput Einspeisung annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-206,-50})));
  Modelica.Blocks.Interfaces.RealOutput Spotmarktangebot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-84,-154})));
  Modelica.Blocks.Interfaces.RealOutput Energie_BHKW annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-136,-182})));
  Modelica.Blocks.Interfaces.RealOutput Sicherheit annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-158,14})));
  Modelica.Blocks.Interfaces.RealOutput Sicherheit_Waerme annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-74,-258})));
protected
  parameter Real varG=0.1;
  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit Zuverlaessigkeit annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,20})));
  Modelica.Blocks.Continuous.Integrator Energie_gesetzt annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-166,-52})));
  Modelica.Blocks.Continuous.Integrator Energie_gesetzt_BHKW annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-86,-182})));
  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit Zuverlaessigkeit_Waerme annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,-260})));
  Modelica.Blocks.Math.Gain G(k=varG)
                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={226,-134})));
  TransiEnt.Basics.Tables.GenericDataTable Abrufanteil_SRL(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/Abrufanteil_SRL_2017.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={256,-88})));
  Modelica.Blocks.Math.Product P_SRL annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={192,-92})));
  TransiEnt.Basics.Tables.GenericDataTable Prognose_Optimierung_S1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/Prognose_2017_S1.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={226,-176})));
  Modelica.Blocks.Continuous.Integrator Energie_Spotmarkt annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-42,-154})));

  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={4,-256})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_9(N=1, windTurbineModel(P_el_n=2500000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE115_2500kW())) annotation (Placement(transformation(extent={{46,34},{66,54}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid(useInputConnector=true)
                                                                                annotation (Placement(transformation(extent={{178,196},{198,216}})));
  TransiEnt.Basics.Tables.GenericDataTable Frequenzdaten(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Frequenz2017.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={182,242})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_11(P_inst(displayUnit="MW") = 299990, use_input_data=true) annotation (Placement(transformation(extent={{50,326},{70,346}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_11(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_11.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,334},{26,354}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_1.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,178})));
  TransiEnt.Basics.Tables.GenericDataTable Data_3(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_3.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,148})));
  TransiEnt.Basics.Tables.GenericDataTable Data_5(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_5.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,114})));
  TransiEnt.Basics.Tables.GenericDataTable Data_7(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_7.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,78})));
  TransiEnt.Basics.Tables.GenericDataTable Data_9(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_9.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,44})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_7(N=1, windTurbineModel(P_el_n=3400000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.SenvionM104_3400kW())) annotation (Placement(transformation(extent={{46,68},{66,88}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_5(N=1, windTurbineModel(P_el_n=2300000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE82_2300kW())) annotation (Placement(transformation(extent={{48,104},{68,124}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_3(N=3, windTurbineModel(P_el_n=2000000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV90_2000kW())) annotation (Placement(transformation(extent={{48,138},{68,158}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_1(N=1, windTurbineModel(PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.Nordex_N149())) annotation (Placement(transformation(extent={{48,168},{68,188}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_13(P_inst(displayUnit="MW") = 921670, use_input_data=true) annotation (Placement(transformation(extent={{50,294},{70,314}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_13(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_13.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,302},{26,322}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_15(P_inst(displayUnit="MW") = 4776360, use_input_data=true) annotation (Placement(transformation(extent={{50,260},{70,280}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_15(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_15.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,268},{26,288}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_18(P_inst(displayUnit="MW") = 717120, use_input_data=true) annotation (Placement(transformation(extent={{50,228},{70,248}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_18(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_18.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,236},{26,256}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_4(P_inst(displayUnit="MW") = 7876000, use_input_data=true) annotation (Placement(transformation(extent={{50,198},{70,218}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_20(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_20.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,206},{26,226}})));

  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitvarErzeuger regler_Virtuelles_Kraftwerk(SOC_Thermal_min=0.9) annotation (Placement(transformation(
        extent={{-39,-88},{39,88}},
        rotation=180,
        origin={39,-64})));

  Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_statisch.BHKW_statisch bHKW_statisch(
    P_el_n(displayUnit="MW") = 1600000,
    m_dot=0.191666,
    m_Speicher=1200) annotation (Placement(transformation(extent={{-6,-224},{82,-172}})));
      Modelica.Blocks.Math.MultiSum Summe_Leistung_gesetzt(nu=10) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-112,-52})));
equation
 // prognosegenauigkeit.PowerIn=-ElectricGrid.epp.P;
  connect(Frequenzdaten.y1,ElectricGrid. f_set) annotation (Line(points={{182,231},{182,218},{182.6,218}},   color={0,0,127}));
  connect(Data_11.y[1],PV_11. T_in) annotation (Line(points={{27,344},{48,344}}, color={0,0,127}));
  connect(Data_11.y[2],PV_11. DNI_in) annotation (Line(points={{27,344},{38,344},{38,338.4},{48,338.4}}, color={0,0,127}));
  connect(Data_11.y[3],PV_11. DHI_in) annotation (Line(points={{27,344},{38,344},{38,333.4},{48,333.4}}, color={0,0,127}));
  connect(Data_11.y[4],PV_11. WindSpeed_in) annotation (Line(points={{27,344},{38,344},{38,328},{48,328}}, color={0,0,127}));
  connect(Data_9.y[4],Wind_9. v_wind) annotation (Line(points={{37,44},{34,44},{34,43.8},{45.6,43.8}}, color={0,0,127}));
  connect(Data_7.y[4],Wind_7. v_wind) annotation (Line(points={{37,78},{40,78},{40,77.8},{45.6,77.8}}, color={0,0,127}));
  connect(Data_5.y[4],Wind_5. v_wind) annotation (Line(points={{37,114},{40,114},{40,113.8},{47.6,113.8}}, color={0,0,127}));
  connect(Wind_3.v_wind,Data_3. y[4]) annotation (Line(points={{47.6,147.8},{44,147.8},{44,148},{37,148}}, color={0,0,127}));
  connect(Wind_1.v_wind,Data_1. y[4]) annotation (Line(points={{47.6,177.8},{42,177.8},{42,178},{37,178}}, color={0,0,127}));
  connect(Data_13.y[1],PV_13. T_in) annotation (Line(points={{27,312},{48,312}}, color={0,0,127}));
  connect(Data_13.y[2],PV_13. DNI_in) annotation (Line(points={{27,312},{38,312},{38,306.4},{48,306.4}}, color={0,0,127}));
  connect(Data_13.y[3],PV_13. DHI_in) annotation (Line(points={{27,312},{38,312},{38,301.4},{48,301.4}}, color={0,0,127}));
  connect(Data_13.y[4],PV_13. WindSpeed_in) annotation (Line(points={{27,312},{38,312},{38,296},{48,296}}, color={0,0,127}));
  connect(Data_15.y[1],PV_15. T_in) annotation (Line(points={{27,278},{48,278}}, color={0,0,127}));
  connect(Data_15.y[2],PV_15. DNI_in) annotation (Line(points={{27,278},{38,278},{38,272.4},{48,272.4}}, color={0,0,127}));
  connect(Data_15.y[3],PV_15. DHI_in) annotation (Line(points={{27,278},{38,278},{38,267.4},{48,267.4}}, color={0,0,127}));
  connect(Data_15.y[4],PV_15. WindSpeed_in) annotation (Line(points={{27,278},{38,278},{38,262},{48,262}}, color={0,0,127}));
  connect(Data_18.y[1],PV_18. T_in) annotation (Line(points={{27,246},{48,246}}, color={0,0,127}));
  connect(Data_18.y[2],PV_18. DNI_in) annotation (Line(points={{27,246},{38,246},{38,240.4},{48,240.4}}, color={0,0,127}));
  connect(Data_18.y[3],PV_18. DHI_in) annotation (Line(points={{27,246},{38,246},{38,235.4},{48,235.4}}, color={0,0,127}));
  connect(Data_18.y[4],PV_18. WindSpeed_in) annotation (Line(points={{27,246},{38,246},{38,230},{48,230}}, color={0,0,127}));
  connect(Data_20.y[1],PV_4. T_in) annotation (Line(points={{27,216},{48,216}}, color={0,0,127}));
  connect(Data_20.y[2],PV_4. DNI_in) annotation (Line(points={{27,216},{38,216},{38,210.4},{48,210.4}}, color={0,0,127}));
  connect(Data_20.y[3],PV_4. DHI_in) annotation (Line(points={{27,216},{38,216},{38,205.4},{48,205.4}}, color={0,0,127}));
  connect(Data_20.y[4],PV_4. WindSpeed_in) annotation (Line(points={{27,216},{38,216},{38,200},{48,200}}, color={0,0,127}));
  connect(PV_4.epp,ElectricGrid. epp) annotation (Line(
      points={{69.3,207.4},{124.65,207.4},{124.65,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(PV_15.epp,ElectricGrid. epp) annotation (Line(
      points={{69.3,269.4},{154,269.4},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(PV_13.epp,ElectricGrid. epp) annotation (Line(
      points={{69.3,303.4},{154,303.4},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(PV_11.epp,ElectricGrid. epp) annotation (Line(
      points={{69.3,335.4},{154,335.4},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(PV_18.epp,ElectricGrid. epp) annotation (Line(
      points={{69.3,237.4},{154,238},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_9.epp,ElectricGrid. epp) annotation (Line(
      points={{66.4,44},{154,44},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_7.epp,ElectricGrid. epp) annotation (Line(
      points={{66.4,78},{154,78},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_5.epp,ElectricGrid. epp) annotation (Line(
      points={{68.4,114},{154,114},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_3.epp,ElectricGrid. epp) annotation (Line(
      points={{68.4,148},{154,148},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_1.epp,ElectricGrid. epp) annotation (Line(
      points={{68.4,178},{154,178},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(regler_Virtuelles_Kraftwerk.Max_Wind_1, Wind_1.MaxP_Out) annotation (Line(points={{79.56,-27.92},{104,-27.92},{104,184.6},{68.6,184.6}},     color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_Wind_2, Wind_3.MaxP_Out) annotation (Line(points={{79.56,-21.76},{100,-21.76},{100,154.6},{68.6,154.6}},     color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_Wind_3, Wind_5.MaxP_Out) annotation (Line(points={{79.56,-15.6},{96,-15.6},{96,120.6},{68.6,120.6}},
                                                                                                                                           color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_Wind_4, Wind_7.MaxP_Out) annotation (Line(points={{79.56,-9.44},{92,-9.44},{92,84.6},{66.6,84.6}},       color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_Wind_5, Wind_9.MaxP_Out) annotation (Line(points={{79.56,-3.28},{88,-3.28},{88,50.6},{66.6,50.6}},       color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_1, Wind_1.P_set) annotation (Line(
      points={{-3.9,-34.08},{-40,-34.08},{-40,170.3},{47.2,170.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_2, Wind_3.P_set) annotation (Line(
      points={{-3.9,-27.04},{-30,-27.04},{-30,140.3},{47.2,140.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_3, Wind_5.P_set) annotation (Line(
      points={{-3.9,-20.88},{-18,-20.88},{-18,106.3},{47.2,106.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_4, Wind_7.P_set) annotation (Line(
      points={{-3.9,-14.72},{-8,-14.72},{-8,70.3},{45.2,70.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_5, Wind_9.P_set) annotation (Line(
      points={{-3.9,-8.56},{-3.9,36.3},{45.2,36.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_PV_5, PV_4.P_set) annotation (Line(
      points={{-3.9,-53.44},{-48,-53.44},{-48,194},{57.4,194},{57.4,197.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_PV_4, PV_18.P_set) annotation (Line(
      points={{-3.9,-59.6},{-56,-59.6},{-56,227.5},{57.4,227.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_PV_3, PV_15.P_set) annotation (Line(
      points={{-3.9,-64.88},{-66,-64.88},{-66,259.5},{57.4,259.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_PV_2, PV_13.P_set) annotation (Line(
      points={{-3.9,-71.04},{-76,-71.04},{-76,293.5},{57.4,293.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_PV_1, PV_11.P_set) annotation (Line(
      points={{-3.9,-77.2},{-86,-77.2},{-86,325.5},{57.4,325.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.Max_PV_5, PV_4.MaxP_out) annotation (Line(points={{78.78,-47.28},{110,-47.28},{110,216.4},{71.2,216.4}},
                                                                                                                                             color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_PV_4, PV_18.MaxP_out) annotation (Line(points={{78.78,-53.44},{116,-53.44},{116,246.4},{71.2,246.4}},     color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_PV_3, PV_15.MaxP_out) annotation (Line(points={{78.78,-59.6},{122,-59.6},{122,278.4},{71.2,278.4}},       color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_PV_2, PV_13.MaxP_out) annotation (Line(points={{78.78,-65.76},{128,-65.76},{128,312.4},{71.2,312.4}},     color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk.Max_PV_1, PV_11.MaxP_out) annotation (Line(points={{78.78,-71.92},{134,-71.92},{134,344.4},{71.2,344.4}},     color={0,127,127}));
  connect(G.y, regler_Virtuelles_Kraftwerk.PRL_Angebot) annotation (Line(points={{226,-123},{194,-123},{194,-115.92},{79.56,-115.92}},   color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk.P_set_Erzeuger, bHKW_statisch.electricPowerIn) annotation (Line(
      points={{-3.12,-100.96},{-36,-100.96},{-36,-134},{-60,-134},{-60,-211},{-9.22667,-211}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(bHKW_statisch.P_el_max, regler_Virtuelles_Kraftwerk.Max_P_Erzeuger) annotation (Line(
      points={{86.4,-217.5},{110,-217.5},{110,-90.4},{80.34,-90.4}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(bHKW_statisch.epp, ElectricGrid.epp) annotation (Line(
      points={{82,-175.12},{82,8.66},{178,8.66},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(bHKW_statisch.SOF_Gas, regler_Virtuelles_Kraftwerk.SOF_Gas) annotation (Line(points={{21.28,-228.42},{21.28,-252},{130,-252},{130,-130},{79.56,-130}}, color={0,0,127}));
  connect(bHKW_statisch.SOC_Thermal, regler_Virtuelles_Kraftwerk.SOC_Thermal) annotation (Line(points={{51.2,-227.9},{51.2,-240},{120,-240},{120,-146.72},{79.56,-146.72}}, color={0,0,127}));
  connect(Zuverlaessigkeit.Erfuellt, regler_Virtuelles_Kraftwerk.PRL_erfuellt) annotation (Line(points={{-99.2,18.8},{-52.6,18.8},{-52.6,17.84},{-5.46,17.84}}, color={255,0,255}));
  connect(Summe_Leistung_gesetzt.y, Energie_gesetzt.u) annotation (Line(points={{-119.02,-52},{-136,-52},{-136,-52},{-154,-52}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[1], Wind_9.P_set) annotation (Line(points={{-106,-55.78},{-56,-55.78},{-56,4},{-3.9,4},{-3.9,36.3},{45.2,36.3}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[2], Wind_7.P_set) annotation (Line(points={{-106,-54.94},{-58,-54.94},{-58,0},{-8,0},{-8,70.3},{45.2,70.3}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[3], Wind_5.P_set) annotation (Line(points={{-106,-54.1},{-62,-54.1},{-62,-10},{-18,-10},{-18,106.3},{47.2,106.3}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[4], Wind_3.P_set) annotation (Line(points={{-106,-53.26},{-68,-53.26},{-68,-22},{-30,-22},{-30,140.3},{47.2,140.3}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[5], Wind_1.P_set) annotation (Line(points={{-106,-52.42},{-74,-52.42},{-74,-30},{-40,-30},{-40,170.3},{47.2,170.3}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[6], PV_4.P_set) annotation (Line(points={{-106,-51.58},{-78,-51.58},{-78,-46},{-48,-46},{-48,194},{57.4,194},{57.4,197.5}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[7], PV_18.P_set) annotation (Line(points={{-106,-50.74},{-82,-50.74},{-82,-58},{-56,-58},{-56,227.5},{57.4,227.5}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[8], PV_15.P_set) annotation (Line(points={{-106,-49.9},{-86,-49.9},{-86,-60},{-66,-60},{-66,259.5},{57.4,259.5}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[9], PV_13.P_set) annotation (Line(points={{-106,-49.06},{-92,-49.06},{-92,-64},{-76,-64},{-76,293.5},{57.4,293.5}}, color={0,0,127}));
  connect(Summe_Leistung_gesetzt.u[10], PV_11.P_set) annotation (Line(points={{-106,-48.22},{-96,-48.22},{-96,-72},{-86,-72},{-86,325.5},{57.4,325.5}}, color={0,0,127}));
  connect(Energie_gesetzt_BHKW.u, bHKW_statisch.electricPowerIn) annotation (Line(points={{-74,-182},{-68,-182},{-68,-180},{-60,-180},{-60,-211},{-9.22667,-211}}, color={0,0,127}));
  connect(greaterThreshold.y, Zuverlaessigkeit_Waerme.Erfuellt) annotation (Line(points={{-7,-256},{-12,-256},{-12,-261.2},{-17.2,-261.2}}, color={255,0,255}));
  connect(greaterThreshold.u, regler_Virtuelles_Kraftwerk.SOF_Gas) annotation (Line(points={{16,-256},{20,-256},{20,-250},{21.28,-250},{21.28,-252},{130,-252},{130,-130},{79.56,-130}}, color={0,0,127}));
  connect(Abrufanteil_SRL.y[1],P_SRL. u2) annotation (Line(points={{245,-88},{226,-88},{226,-86},{204,-86}}, color={0,0,127}));
  connect(G.y, P_SRL.u1) annotation (Line(points={{226,-123},{224,-123},{224,-98},{204,-98}}, color={0,0,127}));
  connect(P_SRL.y, regler_Virtuelles_Kraftwerk.PRL_set) annotation (Line(points={{181,-92},{132,-92},{132,-106.24},{79.56,-106.24}}, color={0,0,127}));
  connect(Prognose_Optimierung_S1.y[1], G.u) annotation (Line(points={{226,-165},{226,-146}}, color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk.P_sum_AP, Energie_Spotmarkt.u) annotation (Line(
      points={{-2.34,-145.84},{-15.17,-145.84},{-15.17,-154},{-30,-154}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Zuverlaessigkeit_Waerme.Percentage,Sicherheit_Waerme)  annotation (Line(
      points={{-39.2,-267},{-48.6,-267},{-48.6,-258},{-74,-258}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Energie_gesetzt_BHKW.y,Energie_BHKW)  annotation (Line(points={{-97,-182},{-136,-182}}, color={0,0,127}));
  connect(Energie_Spotmarkt.y,Spotmarktangebot)  annotation (Line(points={{-53,-154},{-84,-154}},  color={0,0,127}));
  connect(Energie_gesetzt.y,Einspeisung)  annotation (Line(points={{-177,-52},{-182,-52},{-182,-50},{-206,-50}}, color={0,0,127}));
  connect(Zuverlaessigkeit.Percentage,Sicherheit)  annotation (Line(
      points={{-121.2,13},{-139.6,13},{-139.6,14},{-158,14}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-320},{260,360}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-320},{260,360}})),
    experiment(
      StopTime=31536000,
      Interval=10.000008,
      Tolerance=0.05,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(executeCall=simulateModel(
          "MABook.Simulation_Statisch.Usecase_2_PRL.Simulation_mit_BHKW",
          stopTime=31536000,
          numberOfIntervals=0,
          outputInterval=10.000008,
          tolerance=0.05,
          resultFile="Simulation_mit_BHKW"),
      executeCall=translateModel("MABook.Simulation_Statisch.Usecase_2_PRL.Simulation_mit_BHKW"),
      file="\"*.mos\""),
    Documentation(info="<html>
<p>Jahressimulation zur erbringung von Regelleistung, bei der im Packagenamen das Szenario und die Regelleistungsart definiert und der Name durch Name_Name_Jahr_Standortauswahl aufgebaut ist.</p>
<p>Um die Daten einzubinden ist es notwendig diese entweder als Administrator in die Transient-Library zu integriegen und die Pfade relativ auf die TransiEnt.Basics.Tables umzuleiten und dann die Daten aus dem Ordner in der H&ouml;chsten Ordnerstruktur ./Daten zu integriegen, oder den absoluten Pfad so anzupassen, dass er in jedem Datensatz auf die pers&ouml;nliche Datenstruktur passt.</p>
<p><br><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Simulation_mit_BHKW_2017_1;
