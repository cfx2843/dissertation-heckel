within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
block BHKW
  parameter Modelica.Units.SI.Power P_el_n=800e3 "Nennleistung Vebrennungsmotor";
  parameter Modelica.Units.SI.MassFlowRate m_dot=0.03 "Gaserzeugung";
  parameter Modelica.Units.SI.Mass m_Speicher=500 "Kapazität Gasspeicher";
  CHP_ice CHP(redeclare TCG_2016_V16_C Specification(
      EfficiencyCharLine=TransiEnt.Producer.Combined.SmallScaleCHP.Base.PartloadEfficiency.PartloadEfficiencyCharacteristic(CL_eta_el=[CHP.Specification.P_el_min/CHP.Specification.P_el_max,CHP.Specification.eta_el_min/CHP.Specification.eta_el_max; 1.00,CHP.Specification.eta_el_max/CHP.Specification.eta_el_max], CL_eta_th=[CHP.Specification.P_el_min/CHP.Specification.P_el_max,CHP.Specification.eta_h_max/CHP.Specification.eta_h_max; 1.00,CHP.Specification.eta_h_min/CHP.Specification.eta_h_max]),
      P_el_max=P_el_n,
      P_el_min=0,
      T_return_max=373.15,
      reactionTime=0,
      damping=0,
      syncTime=0), NCV_const=15218300)                annotation (Placement(transformation(extent={{-46,-46},{40,44}})));
  ControllerExtP_el controllerExtP_el(redeclare TCG_2016_V16_C Specification(
      P_el_max=P_el_n,
      P_el_min=0,
      T_return_max=373.15,
      reactionTime=0,
      damping=0,
      syncTime=0),                                                            t_OnOff=0) annotation (Placement(transformation(extent={{-98,-60},{-78,-40}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi sink(gasModel=simCenter.exhaustGasModel) annotation (Placement(transformation(extent={{-102,28},{-82,48}})));
  inner TransiEnt.SimCenter simCenter(redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_NG7_H2_var gasModel1) annotation (Placement(transformation(extent={{-168,74},{-148,94}})));
  TransiEnt.Components.Sensors.IdealGas.GasMassflowSensor fuelGasMassflowSensor(xiNumber=7) annotation (Placement(transformation(extent={{-158,20},{-138,40}})));
  TransiEnt.Components.Sensors.IdealGas.GasMassflowSensor exhaustGasMassflowSensor(xiNumber=2, medium=simCenter.exhaustGasModel) annotation (Placement(transformation(extent={{-56,38},{-76,58}})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_pTxi waterSink(p_const=simCenter.p_nom[2], T_const(displayUnit="degC") = 318.15)
                                                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={172,41})));
  TransiEnt.Components.Sensors.TemperatureSensor temperatureWaterIn(unitOption=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={68,26})));
  TransiEnt.Components.Sensors.TemperatureSensor temperatureWaterOut(unitOption=2) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={150,26})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_Txim_flow boundaryVLE_Txim_flow(variable_m_flow=true, T_const(displayUnit="degC") = 318.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,-20})));
  Modelica.Blocks.Sources.Constant Solltemperatur(k=70) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={152,2})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi gasSource1(gasModel=simCenter.gasModel2,
    variable_xi=false,
    xi_const={0.6,0,0,0,0,0.4})                                                                                       annotation (Placement(transformation(extent={{-192,10},{-172,30}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-8,
    T=10,
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={212,-50})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,2})));
  Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={158,-26})));
  Modelica.Blocks.Sources.Constant Mindestwert(k=0.01) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={212,-20})));
  Modelica.Blocks.Sources.Constant Gasproduzent(k=m_dot)
                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-158,-10})));
  Gasspeicher gasspeicher(m_max=m_Speicher)
                                   annotation (Placement(transformation(extent={{-128,-28},{-108,-8}})));
  Thermisches_Management thermisches_Management(
    E_thermal(displayUnit="kWh") = 712800000,
    E_start(displayUnit="kWh"),
    Q_fermenter(displayUnit="kW") = m_dot*15218300*0.21)
                                            annotation (Placement(transformation(
        extent={{-10,-19},{10,19}},
        rotation=180,
        origin={96,71})));
  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{90,78},{110,98}}), iconTransformation(extent={{90,78},{110,98}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_el_max annotation (Placement(transformation(extent={{-21,-21},{21,21}},
        rotation=270,
        origin={-61,-115}),                                                                                                           iconTransformation(extent={{94,-96},{136,-54}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn electricPowerIn annotation (Placement(transformation(extent={{-238,-78},{-184,-22}}), iconTransformation(extent={{-238,-78},{-184,-22}})));
  Modelica.Blocks.Interfaces.RealOutput SOF_Gas annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=270,
        origin={-107,-117}), iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=270,
        origin={-107,-117})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-156,-60},{-136,-40}})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-62,-76})));
  Anlagen.BHKW_statisch.Lastprofil_Waerme lastprofil_Waerme annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={206,88})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={176,88})));
  Modelica.Blocks.Interfaces.RealOutput SOC_Thermal annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=0,
        origin={111,103}), iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=270,
        origin={-5,-115})));
equation
  if controllerExtP_el.controlBus.switch==true then
    PI.u=feedback.y;
  else
    0=PI.u;
  end if;

  connect(controllerExtP_el.controlBus, CHP.controlBus) annotation (Line(points={{-78,-46},{-58,-46},{-58,8},{-46,8}},
                                                                                                                     color={255,0,0}));
  connect(sink.gasPort,exhaustGasMassflowSensor. outlet) annotation (Line(
      points={{-82,38},{-76,38}},
      color={255,213,170},
      thickness=1.25));
  connect(exhaustGasMassflowSensor.inlet, CHP.gasPortOut) annotation (Line(
      points={{-56,38},{-46,38},{-46,35}},
      color={255,213,170},
      thickness=1.25));
  connect(waterSink.steam_a, CHP.waterPortOut) annotation (Line(
      points={{162,41},{86,41},{86,41.75},{40,41.75}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(temperatureWaterOut.port, CHP.waterPortOut) annotation (Line(
      points={{150,36},{150,41},{86,41},{86,41.75},{40,41.75}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(temperatureWaterIn.port, CHP.waterPortIn) annotation (Line(
      points={{68,16},{56,16},{56,30.05},{40,30.05}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(boundaryVLE_Txim_flow.steam_a, temperatureWaterIn.port) annotation (Line(
      points={{74,-20},{68,-20},{68,16}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));

  connect(temperatureWaterOut.T, feedback.u2) annotation (Line(points={{139,26},{116,26},{116,10}},        color={0,0,127}));
  connect(Solltemperatur.y, feedback.u1) annotation (Line(points={{141,2},{124,2}},                                       color={0,0,127}));
  connect(boundaryVLE_Txim_flow.m_flow, max1.y) annotation (Line(points={{96,-26},{147,-26}},                                 color={0,0,127}));
  connect(max1.u1, PI.y) annotation (Line(points={{170,-32},{174,-32},{174,-50},{201,-50}},
                                                                                      color={0,0,127}));
  connect(CHP.gasPortIn, fuelGasMassflowSensor.outlet) annotation (Line(
      points={{-46.43,18.35},{-94,18.35},{-94,20},{-138,20}},
      color={255,213,170},
      thickness=1.25));
  connect(gasSource1.gasPort, fuelGasMassflowSensor.inlet) annotation (Line(
      points={{-172,20},{-158,20}},
      color={255,213,170},
      thickness=1.25));
  connect(Gasproduzent.y, gasspeicher.Produzent) annotation (Line(points={{-147,-10},{-154.5,-10},{-154.5,-9.8},{-128.8,-9.8}},
                                                                                                                              color={0,0,127}));
  connect(fuelGasMassflowSensor.m_flow, gasspeicher.Verbraucher) annotation (Line(points={{-137,30},{-134,30},{-134,-23.8},{-128.8,-23.8}},
                                                                                                                                          color={0,0,127}));
  connect(gasspeicher.SOF, controllerExtP_el.SOF_Speicher) annotation (Line(points={{-106.3,-24.3},{-106.3,-25.15},{-99,-25.15},{-99,-42.2}}, color={0,0,127}));
  connect(thermisches_Management.Eingangstemperatur, temperatureWaterIn.T) annotation (Line(points={{106.4,54.28},{110.2,54.28},{110.2,26},{79,26}},color={0,0,127}));
  connect(thermisches_Management.Ausgangstemperatur, feedback.u2) annotation (Line(points={{106.4,60.36},{116,60.36},{116,10}},
                                                                                                                             color={0,0,127}));
  connect(thermisches_Management.Durchfluss, boundaryVLE_Txim_flow.m_flow) annotation (Line(points={{106.4,67.58},{134,67.58},{134,-26},{96,-26}},          color={0,0,127}));
  connect(CHP.epp, epp) annotation (Line(
      points={{40,-19},{40,88},{100,88}},
      color={0,135,135},
      thickness=0.5));
  connect(gasspeicher.SOF, SOF_Gas) annotation (Line(points={{-106.3,-24.3},{-106.3,-57.15},{-107,-57.15},{-107,-117}}, color={0,0,127}));
  connect(electricPowerIn, gain.u) annotation (Line(points={{-211,-50},{-158,-50}},                       color={0,127,127}));
  connect(gain.y, controllerExtP_el.P_el_set_external) annotation (Line(points={{-135,-50},{-134,-50},{-134,-49},{-97.9,-49}}, color={0,0,127}));
  connect(gain1.u, controllerExtP_el.P_el_max) annotation (Line(points={{-62,-64},{-62,-59},{-78.3,-59}},          color={0,0,127}));
  connect(add.u2, lastprofil_Waerme.Heizwaerme) annotation (Line(points={{188,94},{192,94},{192,93},{194.4,93}}, color={0,0,127}));
  connect(add.u1, lastprofil_Waerme.Trinkwasserwaerme) annotation (Line(points={{188,82},{190,82},{190,82.2},{194.4,82.2}}, color={0,0,127}));
  connect(SOC_Thermal, thermisches_Management.SOC) annotation (Line(points={{111,103},{94,103},{94,102},{76,102},{76,71},{84.4,71}}, color={0,0,127}));
  connect(gain1.y, P_el_max) annotation (Line(points={{-62,-87},{-62,-115},{-61,-115}}, color={0,0,127}));
  connect(add.y, thermisches_Management.Thermischer_Verbraucher) annotation (Line(points={{165,88},{136,88},{136,76.32},{106.6,76.32}}, color={0,0,127}));
  connect(Mindestwert.y, max1.u2) annotation (Line(points={{201,-20},{170,-20}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{100,100}})),
    experiment(
      StopTime=604800,
      Interval=0.100000224,
      __Dymola_Algorithm="Dassl"));
end BHKW;
