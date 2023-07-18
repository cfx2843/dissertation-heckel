within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Simulationsoptimierung;
model Max_E_2016_2

  import MABook;
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-134,18},{-114,38}})));
public
  Modelica.Blocks.Continuous.Integrator Energie_max annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={342,-64})));
protected
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_9(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(extent={{46,34},{66,54}})));
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
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_11(P_inst(displayUnit="MW") = 1933920, use_input_data=true) annotation (Placement(transformation(extent={{50,326},{70,346}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_11(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_12.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,334},{26,354}})));

  TransiEnt.Basics.Tables.GenericDataTable Data_1(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_2.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_4.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_6.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_8.txt",
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
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_10.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,44})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_7(N=1, windTurbineModel(P_el_n=3050000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE101_3050kW())) annotation (Placement(transformation(extent={{46,68},{66,88}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_5(N=1, windTurbineModel(P_el_n=2000000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV90_2000kW())) annotation (Placement(transformation(extent={{48,104},{68,124}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_3(N=1, windTurbineModel(P_el_n=2300000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.EnerconE82_2300kW())) annotation (Placement(transformation(extent={{46,138},{66,158}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.ControlableWindpark Wind_1(N=1, windTurbineModel(P_el_n=3450000, PowerCurveChar=Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models.VestasV112_3450kW())) annotation (Placement(transformation(extent={{48,168},{68,188}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_13(P_inst(displayUnit="MW") = 749650, use_input_data=true) annotation (Placement(transformation(extent={{50,294},{70,314}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_13(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_14.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,302},{26,322}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_15(P_inst(displayUnit="MW") = 900660, use_input_data=true) annotation (Placement(transformation(extent={{50,260},{70,280}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_15(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_16.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,268},{26,288}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_18(P_inst(displayUnit="MW") = 2315040, use_input_data=true) annotation (Placement(transformation(extent={{50,228},{70,248}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_18(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_17.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,236},{26,256}})));
  Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen.ControlablePVModule PV_4(P_inst(displayUnit="MW") = 6320800, use_input_data=true) annotation (Placement(transformation(extent={{50,198},{70,218}})));
  TransiEnt.Basics.Tables.GenericDataTable Data_20(
    multiple_outputs(
      quantity=4,
      start=false,
      fixed=true) = true,
    columns={2,3,4,5},
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2017/Daten17_19.txt",
    shiftTime=0) annotation (Placement(transformation(extent={{6,206},{26,226}})));

     Modelica.Blocks.Math.MultiSum Summe_Leistung_max(nu=10) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={258,-64})));
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
  connect(Wind_3.v_wind,Data_3. y[4]) annotation (Line(points={{45.6,147.8},{44,147.8},{44,148},{37,148}}, color={0,0,127}));
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
      points={{66.4,148},{154,148},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(Wind_1.epp,ElectricGrid. epp) annotation (Line(
      points={{68.4,178},{154,178},{154,206},{178,206}},
      color={0,135,135},
      thickness=0.5));
  connect(const.y, PV_4.P_set) annotation (Line(points={{-113,28},{-18,28},{-18,197.5},{57.4,197.5}},   color={0,0,127}));
  connect(const.y, PV_18.P_set) annotation (Line(points={{-113,28},{-18,28},{-18,227.5},{57.4,227.5}},   color={0,0,127}));
  connect(const.y, PV_15.P_set) annotation (Line(points={{-113,28},{-18,28},{-18,259.5},{57.4,259.5}},   color={0,0,127}));
  connect(const.y, PV_13.P_set) annotation (Line(points={{-113,28},{-18,28},{-18,293.5},{57.4,293.5}},   color={0,0,127}));
  connect(const.y, PV_11.P_set) annotation (Line(points={{-113,28},{-18,28},{-18,325.5},{57.4,325.5}},   color={0,0,127}));
  connect(const.y, Wind_1.P_set) annotation (Line(points={{-113,28},{-24,28},{-24,170.3},{47.2,170.3}},   color={0,0,127}));
  connect(const.y, Wind_3.P_set) annotation (Line(points={{-113,28},{-24,28},{-24,140.3},{45.2,140.3}},   color={0,0,127}));
  connect(const.y, Wind_5.P_set) annotation (Line(points={{-113,28},{-24,28},{-24,106.3},{47.2,106.3}},   color={0,0,127}));
  connect(const.y, Wind_7.P_set) annotation (Line(points={{-113,28},{-26,28},{-26,70.3},{45.2,70.3}},   color={0,0,127}));
  connect(const.y, Wind_9.P_set) annotation (Line(points={{-113,28},{-24,28},{-24,36.3},{45.2,36.3}},   color={0,0,127}));
  connect(Energie_max.u,Summe_Leistung_max. y) annotation (Line(points={{330,-64},{265.02,-64}},
                                                                                               color={0,0,127}));
  connect(Wind_9.MaxP_Out,Summe_Leistung_max. u[1]) annotation (Line(
      points={{66.6,50.6},{168.3,50.6},{168.3,-60.22},{252,-60.22}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_7.MaxP_Out,Summe_Leistung_max. u[2]) annotation (Line(
      points={{66.6,84.6},{167.3,84.6},{167.3,-61.06},{252,-61.06}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_5.MaxP_Out,Summe_Leistung_max. u[3]) annotation (Line(
      points={{68.6,120.6},{168.3,120.6},{168.3,-61.9},{252,-61.9}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_3.MaxP_Out,Summe_Leistung_max. u[4]) annotation (Line(
      points={{66.6,154.6},{169.3,154.6},{169.3,-62.74},{252,-62.74}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Wind_1.MaxP_Out,Summe_Leistung_max. u[5]) annotation (Line(
      points={{68.6,184.6},{169.3,184.6},{169.3,-63.58},{252,-63.58}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_4.MaxP_out,Summe_Leistung_max. u[6]) annotation (Line(
      points={{71.2,216.4},{170.6,216.4},{170.6,-64.42},{252,-64.42}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_18.MaxP_out,Summe_Leistung_max. u[7]) annotation (Line(
      points={{71.2,246.4},{170.6,246.4},{170.6,-65.26},{252,-65.26}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_15.MaxP_out,Summe_Leistung_max. u[8]) annotation (Line(
      points={{71.2,278.4},{169.6,278.4},{169.6,-66.1},{252,-66.1}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_13.MaxP_out,Summe_Leistung_max. u[9]) annotation (Line(
      points={{71.2,312.4},{170.6,312.4},{170.6,-66.94},{252,-66.94}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(PV_11.MaxP_out, Summe_Leistung_max.u[10]) annotation (Line(
      points={{71.2,344.4},{172,344.4},{172,284},{170.6,284},{170.6,-67.7333},{252,-67.7333},{252,-67.78}},
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
    Documentation(info="<html>
<p>Bestimmung der maximalen Energie f&uuml;r eine Standortzusammenstellung</p>
<p>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Max_E_2016_2;
