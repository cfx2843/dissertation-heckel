within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
model Check_CHP_ice
  CHP_ice CHP(redeclare TCG_2016_V16_C Specification(P_el_max(displayUnit="MW") = 2000000, T_return_max=373.15))
                                                      annotation (Placement(transformation(extent={{-48,-44},{38,46}})));
  ControllerExtP_el controllerExtP_el(redeclare TCG_2016_V16_C Specification(T_return_max=373.15),
                                                                              t_OnOff=0) annotation (Placement(transformation(extent={{-98,-58},{-78,-38}})));
  Modelica.Blocks.Sources.Step step(
    height=400e3,
    offset=0,
    startTime=0)   annotation (Placement(transformation(extent={{-232,-56},{-212,-36}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi sink(gasModel=simCenter.exhaustGasModel) annotation (Placement(transformation(extent={{-102,28},{-82,48}})));
  inner TransiEnt.SimCenter simCenter(redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_NG7_H2_var gasModel1) annotation (Placement(transformation(extent={{-126,78},{-106,98}})));
  TransiEnt.Components.Sensors.IdealGas.GasMassflowSensor fuelGasMassflowSensor(xiNumber=7) annotation (Placement(transformation(extent={{-152,20},{-132,40}})));
  TransiEnt.Components.Sensors.IdealGas.GasMassflowSensor exhaustGasMassflowSensor(xiNumber=2, medium=simCenter.exhaustGasModel) annotation (Placement(transformation(extent={{-56,38},{-76,58}})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_pTxi waterSink(p_const=simCenter.p_nom[2], T_const(displayUnit="degC") = 318.15)
                                                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={234,65})));
  TransiEnt.Components.Sensors.TemperatureSensor temperatureWaterIn(unitOption=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,26})));
  TransiEnt.Components.Sensors.TemperatureSensor temperatureWaterOut(unitOption=2) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={206,44})));
  ClaRa.Components.BoundaryConditions.BoundaryVLE_Txim_flow boundaryVLE_Txim_flow(variable_m_flow=true, T_const(displayUnit="degC") = 318.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={84,-20})));
  Modelica.Blocks.Sources.Constant Solltemperatur(k=70) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={234,18})));
  TransiEnt.Components.Boundaries.Gas.BoundaryIdealGas_pTxi gasSource1(gasModel=simCenter.gasModel2, variable_xi=true)
                                                                                                                      annotation (Placement(transformation(extent={{-228,10},{-208,30}})));
  TransiEnt.Components.Boundaries.Gas.RealGasCompositionByWtFractions_stepVariation gasCompositionByWtFractions_stepVariation1(
    xi(start=simCenter.gasModel2.xi_default),
    xiNumber=7,
    stepsize=0.011687,
    period=1800) annotation (Placement(transformation(extent={{-260,-17},{-242,1}})));
  Modelica.Blocks.Continuous.PI PI(
    k=-8,
    T=10,
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={162,-32})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={192,16})));
  Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,-26})));
  Modelica.Blocks.Sources.Constant Solltemperatur1(k=0.01)
                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={168,4})));
  Modelica.Blocks.Sources.Constant Gasproduzent(k=0.03) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-176,-4})));
  Gasspeicher gasspeicher(m_max=1) annotation (Placement(transformation(extent={{-126,-14},{-106,6}})));
  Modelica.Blocks.Sources.Constant Spotmarkt(k=400e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-144,-56})));
  Modelica.Blocks.Math.Sum sum1(nin=2) annotation (Placement(transformation(extent={{-124,-66},{-104,-46}})));
public
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid1(useInputConnector=true)
                                                                                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={64,-74})));
  TransiEnt.Basics.Tables.GenericDataTable Frequenzdaten(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Frequenz2016.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-210,-92})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-144,-84})));
  Thermisches_Management thermisches_Management(
    E_thermal(displayUnit="kWh"),
    E_start(displayUnit="kWh"),
    Q_fermenter(displayUnit="kW") = 400000) annotation (Placement(transformation(
        extent={{-10,-19},{10,19}},
        rotation=180,
        origin={106,31})));
equation
  if controllerExtP_el.controlBus.switch==true then
    PI.u=feedback.y;
  else
    0=PI.u;
  end if;

  connect(controllerExtP_el.controlBus, CHP.controlBus) annotation (Line(points={{-78,-44},{-58,-44},{-58,10},{-48,10}},
                                                                                                                     color={255,0,0}));
  connect(sink.gasPort,exhaustGasMassflowSensor. outlet) annotation (Line(
      points={{-82,38},{-76,38}},
      color={255,213,170},
      thickness=1.25));
  connect(exhaustGasMassflowSensor.inlet, CHP.gasPortOut) annotation (Line(
      points={{-56,38},{-48,38},{-48,37}},
      color={255,213,170},
      thickness=1.25));
  connect(waterSink.steam_a, CHP.waterPortOut) annotation (Line(
      points={{224,65},{148,65},{148,43.75},{38,43.75}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(temperatureWaterOut.port, CHP.waterPortOut) annotation (Line(
      points={{206,54},{206,65},{148,65},{148,43.75},{38,43.75}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(temperatureWaterIn.port, CHP.waterPortIn) annotation (Line(
      points={{70,16},{56,16},{56,32.05},{38,32.05}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(boundaryVLE_Txim_flow.steam_a, temperatureWaterIn.port) annotation (Line(
      points={{74,-20},{70,-20},{70,16}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(gasCompositionByWtFractions_stepVariation1.xi, gasSource1.xi) annotation (Line(points={{-242,-8},{-242,14},{-230,14}},
                                                                                                                       color={0,0,127}));

  connect(temperatureWaterOut.T, feedback.u2) annotation (Line(points={{195,44},{190,44},{190,24},{192,24}},
                                                                                                           color={0,0,127}));
  connect(Solltemperatur.y, feedback.u1) annotation (Line(points={{223,18},{206,18},{206,16},{200,16}},                   color={0,0,127}));
  connect(boundaryVLE_Txim_flow.m_flow, max1.y) annotation (Line(points={{96,-26},{119,-26}},                                 color={0,0,127}));
  connect(max1.u1, PI.y) annotation (Line(points={{142,-32},{151,-32}},               color={0,0,127}));
  connect(Solltemperatur1.y, max1.u2) annotation (Line(points={{157,4},{150,4},{150,-20},{142,-20}},
                                                                                                   color={0,0,127}));
  connect(CHP.gasPortIn, fuelGasMassflowSensor.outlet) annotation (Line(
      points={{-48.43,20.35},{-94,20.35},{-94,20},{-132,20}},
      color={255,213,170},
      thickness=1.25));
  connect(gasSource1.gasPort, fuelGasMassflowSensor.inlet) annotation (Line(
      points={{-208,20},{-152,20}},
      color={255,213,170},
      thickness=1.25));
  connect(Gasproduzent.y, gasspeicher.Produzent) annotation (Line(points={{-165,-4},{-154.5,-4},{-154.5,4.2},{-126.8,4.2}},   color={0,0,127}));
  connect(fuelGasMassflowSensor.m_flow, gasspeicher.Verbraucher) annotation (Line(points={{-131,30},{-130,30},{-130,-9.8},{-126.8,-9.8}}, color={0,0,127}));
  connect(gasspeicher.SOF, controllerExtP_el.SOF_Speicher) annotation (Line(points={{-104.3,-10.3},{-104.3,-25.15},{-99,-25.15},{-99,-40.2}}, color={0,0,127}));
  connect(Frequenzdaten.y1, ElectricGrid1.f_set) annotation (Line(points={{-199,-92},{-199,-104},{92,-104},{92,-68.6},{76,-68.6}},
                                                                                                               color={0,0,127}));
  connect(Frequenzdaten.y1,primaryBalancingController. Frequenzy) annotation (Line(points={{-199,-92},{-182,-92},{-182,-91.3},{-155.2,-91.3}},
                                                                                                                                     color={0,0,127}));
  connect(CHP.epp, ElectricGrid1.epp) annotation (Line(
      points={{38,-17},{64,-17},{64,-64}},
      color={0,135,135},
      thickness=0.5));
  connect(step.y, primaryBalancingController.PRL_Angebot) annotation (Line(points={{-211,-46},{-194,-46},{-194,-77.7},{-155.3,-77.7}}, color={0,0,127}));
  connect(controllerExtP_el.P_el_set_external, sum1.y) annotation (Line(points={{-97.9,-47},{-100,-47},{-100,-56},{-103,-56}}, color={0,127,127}));
  connect(Spotmarkt.y, sum1.u[1]) annotation (Line(points={{-133,-56},{-132,-56},{-132,-57},{-126,-57}}, color={0,0,127}));
  connect(primaryBalancingController.P_set, sum1.u[2]) annotation (Line(
      points={{-132.2,-85.8},{-132.2,-75.9},{-126,-75.9},{-126,-55}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(thermisches_Management.Eingangstemperatur, temperatureWaterIn.T) annotation (Line(points={{116.4,14.28},{90.2,14.28},{90.2,26},{81,26}},  color={0,0,127}));
  connect(thermisches_Management.Ausgangstemperatur, feedback.u2) annotation (Line(points={{116.4,20.36},{192,20.36},{192,24}},
                                                                                                                             color={0,0,127}));
  connect(thermisches_Management.Durchfluss, boundaryVLE_Txim_flow.m_flow) annotation (Line(points={{116.4,27.58},{142,27.58},{142,-8},{96,-8},{96,-26}},   color={0,0,127}));
  connect(thermisches_Management.Thermischer_Verbraucher, Solltemperatur1.y) annotation (Line(
      points={{116.6,36.32},{157,36.32},{157,4}},
      color={175,0,0},
      pattern=LinePattern.Dash));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=10000,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"));
end Check_CHP_ice;
