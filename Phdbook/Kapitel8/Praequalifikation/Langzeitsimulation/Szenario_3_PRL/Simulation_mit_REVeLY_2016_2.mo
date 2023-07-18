within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Szenario_3_PRL;
model Simulation_mit_REVeLY_2016_2

  import MABook;
  Modelica.Blocks.Interfaces.RealOutput Einspeisung annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-294,-12})));
  Modelica.Blocks.Interfaces.RealOutput Spotmarktangebot annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-322,-132})));
  Modelica.Blocks.Interfaces.RealOutput Energie_Brennstoff annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-322,-166})));
  Modelica.Blocks.Interfaces.RealOutput Zyklenzahl annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-320,-200})));
  Modelica.Blocks.Interfaces.RealOutput Sicherheit annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-280,28})));
protected
  parameter Modelica.Units.SI.Power P_el_N=0.7513e6 "Nennleistung Elektrolyseur";
  parameter Real varG=0.1 "G";
  parameter Modelica.Units.SI.Mass m_H2=35.2948 "Speichermasse Wasserstoff";
  parameter Real SOC_min=0.3373 "Sicherheitspuffer";
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_9(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(extent={{46,34},{66,54}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid(useInputConnector=true)
                                                                                annotation (Placement(transformation(extent={{178,196},{198,216}})));
  TransiEnt.Basics.Tables.GenericDataTable Frequenzdaten(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Frequenz2016.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={182,242})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={118,-104})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_11(P_inst(displayUnit="MW") = 1933920, use_input_data=true) annotation (Placement(transformation(extent={{50,326},{70,346}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_11(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_12.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,334},{26,354}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_2.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_4.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_6.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_8.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_10.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,44})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_7(N=1, windTurbineModel(P_el_n=3050000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE101_3050kW())) annotation (Placement(transformation(extent={{46,68},{66,88}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_5(N=1, windTurbineModel(P_el_n=2000000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV90_2000kW())) annotation (Placement(transformation(extent={{48,104},{68,124}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_3(N=1, windTurbineModel(P_el_n=2300000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE82_2300kW())) annotation (Placement(transformation(extent={{48,138},{68,158}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_1(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(extent={{48,168},{68,188}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_13(P_inst(displayUnit="MW") = 749650, use_input_data=true) annotation (Placement(transformation(extent={{50,294},{70,314}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_13(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_14.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,302},{26,322}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_15(P_inst(displayUnit="MW") = 900660, use_input_data=true) annotation (Placement(transformation(extent={{50,260},{70,280}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_15(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_16.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,268},{26,288}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_18(P_inst(displayUnit="MW") = 2315040, use_input_data=true) annotation (Placement(transformation(extent={{50,228},{70,248}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_18(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_17.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,236},{26,256}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_4(P_inst(displayUnit="MW") = 6320800, use_input_data=true) annotation (Placement(transformation(extent={{50,198},{70,218}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_20(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Daten16_19.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,206},{26,226}})));

  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitSpeicher_rev_FC_NAP regler_Virtuelles_Kraftwerk_mitLiIon(SOC_min=SOC_min) annotation (Placement(transformation(
        extent={{-39,-88},{39,88}},
        rotation=180,
        origin={39,-64})));

      Modelica.Blocks.Math.MultiSum Summe_Leistung_gesetzt(nu=10) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-122,-32})));
     Modelica.Blocks.Math.Gain G(k=varG)
                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={118,-184})));

  Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen.Rev_PEM_FC_statisch rev_PEM_FC_statisch(P_el_n(displayUnit="W") = P_el_N, m_H2=m_H2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,-168})));
  TransiEnt.Basics.Tables.GenericDataTable Prognose_Optimierung_S1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/Prognose_2016_S2.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={122,-226})));

  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit Zuverlaessigkeit annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-204,38})));

  Modelica.Blocks.Continuous.Integrator Energie_gesetzt annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-176,-44})));

  Phdbook.Kapitel8.Praequalifikation.Anlagen.Lithium_Ion_Batterie.Zyklanzahl_von_SOC zyklanzahl_von_SOC(start=0.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-170,-208})));

  Modelica.Blocks.Continuous.Integrator P_AP annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-164,-102})));
  Modelica.Blocks.Continuous.Integrator Energie_Brennstoffzelle annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-168,-154})));
equation
 // prognosegenauigkeit.PowerIn=-ElectricGrid.epp.P;
  connect(Frequenzdaten.y1,ElectricGrid. f_set) annotation (Line(points={{182,231},{182,218},{182.6,218}},   color={0,0,127}));
  connect(Frequenzdaten.y1,primaryBalancingController. Frequenzy) annotation (Line(points={{182,231},{210,231},{210,-96.7},{129.2,-96.7}},
                                                                                                                                     color={0,0,127}));
  connect(Data_11.y[1],PV_11. T_in) annotation (Line(points={{27,344},{48,344}}, color={0,0,127}));
  connect(Data_11.y[2],PV_11. DNI_in) annotation (Line(points={{27,344},{38,344},{38,338.4},{48,338.4}}, color={0,0,127}));
  connect(Data_11.y[3],PV_11. DHI_in) annotation (Line(points={{27,344},{38,344},{38,333.4},{48,333.4}}, color={0,0,127}));
  connect(Data_11.y[4],PV_11. WindSpeed_in) annotation (Line(points={{27,344},{38,344},{38,328},{48,328}}, color={0,0,127}));
  connect(G.y,primaryBalancingController. PRL_Angebot) annotation (Line(points={{118,-173},{118,-110.3},{129.3,-110.3}},
                                                                                                                      color={0,0,127}));
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
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.PRL_set, primaryBalancingController.P_set) annotation (Line(points={{78.78,-97.5238},{91.39,-97.5238},{91.39,-102.2},{106.2,-102.2}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.PRL_Angebot, G.y) annotation (Line(points={{78.78,-105.067},{118.39,-105.067},{118.39,-173},{118,-173}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.PRL_erfuellt, Zuverlaessigkeit.Erfuellt) annotation (Line(points={{-4.68,13.1048},{-16.78,13.1048},{-16.78,36.8},{-193.2,36.8}}, color={255,0,255}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_1, Wind_1.MaxP_Out) annotation (Line(points={{80.34,-25.4476},{104,-25.4476},{104,184.6},{68.6,184.6}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_2, Wind_3.MaxP_Out) annotation (Line(points={{80.34,-16.2286},{100,-16.2286},{100,154.6},{68.6,154.6}},
                                                                                                                                                          color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_3, Wind_5.MaxP_Out) annotation (Line(points={{80.34,-9.52381},{96,-9.52381},{96,120.6},{68.6,120.6}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_4, Wind_7.MaxP_Out) annotation (Line(points={{80.34,3.04762},{92,3.04762},{92,84.6},{66.6,84.6}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_Wind_5, Wind_9.MaxP_Out) annotation (Line(points={{80.34,13.1048},{88,13.1048},{88,50.6},{66.6,50.6}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_1, Wind_1.P_set) annotation (Line(
      points={{-3.12,-34.6667},{-40,-34.6667},{-40,170.3},{47.2,170.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_2, Wind_3.P_set) annotation (Line(
      points={{-3.12,-24.6095},{-30,-24.6095},{-30,140.3},{47.2,140.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_3, Wind_5.P_set) annotation (Line(
      points={{-3.9,-14.5524},{-18,-14.5524},{-18,106.3},{47.2,106.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_4, Wind_7.P_set) annotation (Line(
      points={{-3.9,-4.49524},{-8,-4.49524},{-8,70.3},{45.2,70.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_5, Wind_9.P_set) annotation (Line(
      points={{-3.9,2.20952},{-3.9,36.3},{45.2,36.3}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_5, PV_4.P_set) annotation (Line(
      points={{-2.34,-52.2667},{-48,-52.2667},{-48,194},{57.4,194},{57.4,197.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_4, PV_18.P_set) annotation (Line(
      points={{-2.34,-60.6476},{-56,-60.6476},{-56,227.5},{57.4,227.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_3, PV_15.P_set) annotation (Line(
      points={{-2.34,-71.5429},{-66,-71.5429},{-66,259.5},{57.4,259.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_2, PV_13.P_set) annotation (Line(
      points={{-2.34,-79.0857},{-76,-79.0857},{-76,293.5},{57.4,293.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_1, PV_11.P_set) annotation (Line(
      points={{-2.34,-87.4667},{-86,-87.4667},{-86,325.5},{57.4,325.5}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_5, PV_4.MaxP_out) annotation (Line(points={{80.34,-39.6952},{110,-39.6952},{110,216.4},{71.2,216.4}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_4, PV_18.MaxP_out) annotation (Line(points={{80.34,-48.9143},{116,-48.9143},{116,246.4},{71.2,246.4}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_3, PV_15.MaxP_out) annotation (Line(points={{80.34,-58.1333},{122,-58.1333},{122,278.4},{71.2,278.4}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_2, PV_13.MaxP_out) annotation (Line(points={{80.34,-65.6762},{128,-65.6762},{128,312.4},{71.2,312.4}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.Max_PV_1, PV_11.MaxP_out) annotation (Line(points={{80.34,-74.8952},{134,-74.8952},{134,344.4},{71.2,344.4}}, color={0,127,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_5, Summe_Leistung_gesetzt.u[1]) annotation (Line(
      points={{-3.9,2.20952},{-59.56,2.20952},{-59.56,-35.78},{-116,-35.78}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_4, Summe_Leistung_gesetzt.u[2]) annotation (Line(
      points={{-3.9,-4.49524},{-58.56,-4.49524},{-58.56,-34.94},{-116,-34.94}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_3, Summe_Leistung_gesetzt.u[3]) annotation (Line(
      points={{-3.9,-14.5524},{-58.56,-14.5524},{-58.56,-34.1},{-116,-34.1}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_2, Summe_Leistung_gesetzt.u[4]) annotation (Line(
      points={{-3.12,-24.6095},{-59.17,-24.6095},{-59.17,-33.26},{-116,-33.26}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_Wind_1, Summe_Leistung_gesetzt.u[5]) annotation (Line(
      points={{-3.12,-34.6667},{-59.17,-34.6667},{-59.17,-32.42},{-116,-32.42}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_5, Summe_Leistung_gesetzt.u[6]) annotation (Line(
      points={{-2.34,-52.2667},{-58.17,-52.2667},{-58.17,-31.58},{-116,-31.58}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_4, Summe_Leistung_gesetzt.u[7]) annotation (Line(
      points={{-2.34,-60.6476},{-60,-60.6476},{-60,-30.74},{-116,-30.74}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_3, Summe_Leistung_gesetzt.u[8]) annotation (Line(
      points={{-2.34,-71.5429},{-59.17,-71.5429},{-59.17,-29.9},{-116,-29.9}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_2, Summe_Leistung_gesetzt.u[9]) annotation (Line(
      points={{-2.34,-79.0857},{-59.17,-79.0857},{-59.17,-29.06},{-116,-29.06}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_PV_1, Summe_Leistung_gesetzt.u[10]) annotation (Line(
      points={{-2.34,-87.4667},{-59.17,-87.4667},{-59.17,-28.22},{-116,-28.22}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Energie_gesetzt.u, Summe_Leistung_gesetzt.y) annotation (Line(points={{-164,-44},{-146,-44},{-146,-32},{-129.02,-32}},
                                                                                                           color={0,0,127}));
  connect(rev_PEM_FC_statisch.epp, ElectricGrid.epp) annotation (Line(
      points={{42.3,-167.9},{110,-167.9},{110,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(rev_PEM_FC_statisch.SOC, regler_Virtuelles_Kraftwerk_mitLiIon.SOC_LiIon) annotation (Line(points={{42.4,-175.4},{94,-175.4},{94,-144.457},{79.56,-144.457}}, color={0,0,127}));
  connect(zyklanzahl_von_SOC.SOC, regler_Virtuelles_Kraftwerk_mitLiIon.SOC_LiIon) annotation (Line(points={{-159.1,-207.9},{94,-207.9},{94,-144.457},{79.56,-144.457}},                        color={0,0,127}));
  connect(P_AP.u, regler_Virtuelles_Kraftwerk_mitLiIon.P_sum_AP) annotation (Line(points={{-152,-102},{-64,-102},{-64,-149.486},{-1.56,-149.486}},color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk_mitLiIon.P_set_LiIon, rev_PEM_FC_statisch.electricPowerIn) annotation (Line(
      points={{-1.56,-138.59},{-18,-138.59},{-18,-163.6},{21.2,-163.6}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(rev_PEM_FC_statisch.P_max_Ely, regler_Virtuelles_Kraftwerk_mitLiIon.Max_P_load_LiIon) annotation (Line(
      points={{42.6,-163.2},{104,-163.2},{104,-125.181},{80.34,-125.181}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(rev_PEM_FC_statisch.P_max_FC, regler_Virtuelles_Kraftwerk_mitLiIon.Max_P_unload_LiIon) annotation (Line(
      points={{42.4,-160.4},{100,-160.4},{100,-117.638},{80.34,-117.638}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Energie_Brennstoffzelle.u, rev_PEM_FC_statisch.electricPowerIn) annotation (Line(points={{-156,-154},{-56,-154},{-56,-140},{-18,-140},{-18,-163.6},{21.2,-163.6}},color={0,0,127}));
  connect(Prognose_Optimierung_S1.y[1], G.u) annotation (Line(points={{122,-215},{122,-196},{118,-196}},
                                                                                              color={0,0,127}));
  connect(Zuverlaessigkeit.Percentage,Sicherheit)  annotation (Line(
      points={{-215.2,31},{-265.6,31},{-265.6,28},{-280,28}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Energie_gesetzt.y,Einspeisung)  annotation (Line(points={{-187,-44},{-252,-44},{-252,-12},{-294,-12}},
                                                                                           color={0,0,127}));
  connect(P_AP.y,Spotmarktangebot)  annotation (Line(points={{-175,-102},{-262,-102},{-262,-132},{-322,-132}},
                                                                                      color={0,0,127}));
  connect(Energie_Brennstoffzelle.y,Energie_Brennstoff)  annotation (Line(points={{-179,-154},{-262,-154},{-262,-166},{-322,-166}},
                                                                                                           color={0,0,127}));
  connect(zyklanzahl_von_SOC.Zyklen,Zyklenzahl)  annotation (Line(points={{-182.2,-208},{-264,-208},{-264,-200},{-320,-200}},
                                                                                                                           color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-320},{260,360}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-320},{260,360}})),
    experiment(
      StopTime=31536000,
      Interval=10.000008,
      Tolerance=0.05,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Jahressimulation zur erbringung von Regelleistung, bei der im Packagenamen das Szenario und die Regelleistungsart definiert und der Name durch Name_Name_Jahr_Standortauswahl aufgebaut ist.</p>
<p>Um die Daten einzubinden ist es notwendig diese entweder als Administrator in die Transient-Library zu integriegen und die Pfade relativ auf die TransiEnt.Basics.Tables umzuleiten und dann die Daten aus dem Ordner in der H&ouml;chsten Ordnerstruktur ./Daten zu integriegen, oder den absoluten Pfad so anzupassen, dass er in jedem Datensatz auf die pers&ouml;nliche Datenstruktur passt.</p>
<p><br><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Simulation_mit_REVeLY_2016_2;
