within Phdbook.Kapitel4.Kapitel4_1.Components;
model ClaRa_HeatpumpCharline_Speicher_Ideal
  extends TransiEnt.Basics.Icons.Boiler;

parameter Real scalingFactor=30000;

// outer TransiEnt.SimCenter simCenter;
//   Modelica.Blocks.Sources.Constant scalingfactor(k=30000)
//                                                        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpVLE_L1_simple1(
    presetVariableType="m_flow",
    Delta_p_fixed=30000,
    m_flowInput=true,
    m_flow_fixed=0.5*ScaleFactor.k/30)
                         annotation (Placement(transformation(extent={{144,-42},{164,-22}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempAfterCons annotation (Placement(transformation(extent={{-28,-22},{-8,-6}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempBeforeCons annotation (Placement(transformation(extent={{58,8},{42,24}})));
  ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 hEXHeatCons(
    redeclare model HeatTransfer = TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.HeatTransfer_EN442 (
        T_mean_supply=333.15,
        DT_nom=20,
        Q_flow_nom=ScaleFactor.k,
        T_air_nom=295.15),
    redeclare model PressureLoss = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2,
    redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry (volume=1*ScaleFactor.k/1.81e6),
    m_flow_nom=ScaleFactor.k/4200/20,
    h_start=60*4200,
    p_start=6.0276e5,
    initOption=0) annotation (Placement(transformation(extent={{-30,-2},{-50,18}})));
  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpGrid(presetVariableType="m_flow",
                                                                                m_flowInput=true)     "Steuerung des Masseflusses zum Wärmeverbraucher."
                                                                                                      annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={10,6})));
  TransiEnt.Storage.Heat.HotWaterStorage_constProp_L4.HotWaterStorage_constProp_L4 hotWaterStorage(
    V=ScaleFactor.k*2*3600/(hotWaterStorage.c_v*hotWaterStorage.rho*(60 - 40)),
    h=(hotWaterStorage.V*4*5^2/Modelica.Constants.pi)^(1/3),
    n_prodIn=2,
    T_start(displayUnit="degC") = {338.15,333.15,333.15,333.15,333.15}) "Wärmespeicher mit der Kapazität den Nennwärmestrom der KWK über 2 Stunden zu versorgen."
                                                                        annotation (Placement(transformation(
        extent={{13,-12},{-13,12}},
        rotation=0,
        origin={115,-18})));
  TransiEnt.Components.Heat.Grid.IdealizedExpansionVessel idealizedExpansionVessel1(p(displayUnit="bar") = 600000) annotation (Placement(transformation(extent={{90,16},{104,32}})));
  ClaRa.Components.VolumesValvesFittings.Valves.ThreeWayValveVLE_L1_simple tWV(splitRatio_input=true) annotation (Placement(transformation(extent={{68,-12},{84,-28}})));
  ClaRa.Components.VolumesValvesFittings.Fittings.JoinVLE_L2_Y joinGrid(
    volume=0.1*ScaleFactor.k/1.81e6,
    m_flow_in_nom={ScaleFactor.k/30,ScaleFactor.k/30},
    h_start=60*4200,
    redeclare model PressureLossIn1 = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    redeclare model PressureLossIn2 = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    redeclare model PressureLossOut = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    p_start=6e5) annotation (Placement(transformation(extent={{84,16},{66,0}})));
  TransiEnt.Components.Heat.HeatFlowMultiplier heatFlowMultiplier1(factor=ScaleFactor.k/4793.46) "Skalierung des Wärmestroms auf den Verbrauch eines Gebäudes."
                                                                                                 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-40,32})));
 TransiEnt.Basics.Blocks.LimPID PID_TWV(
    Tau_d=0,
    initOption=503,
    y_max=1,
    y_min=0,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=10,
    Tau_i=0.01,
    y_start=1,
    y_inactive=0) "Regelung der Mischverhältnisse von Vor- und Rücklauftemperaturen."
                  annotation (Placement(transformation(extent={{50,-57},{68,-39}})));
  TransiEnt.Basics.Blocks.LimPID PID_PumpGrid(
    u_ref=22 + 273.15,
    y_ref=PID_PumpGrid.y_max,
    Tau_d=0,
    initOption=503,
    y_max=ScaleFactor.k/4200/30,
    y_min=1e-6,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=1000,
    Tau_i=1000,
    y_start=PID_PumpGrid.y_min,
    y_inactive=0) annotation (Placement(transformation(extent={{-2,32},{10,44}})));
  Modelica.Blocks.Sources.RealExpression setValueTemperature(y=273.15 + 22) annotation (Placement(transformation(extent={{-30,28},{-10,48}})));
  TransiEnt.Basics.Tables.HeatGrid.HeatingCurves.HeatingCurve_FromDataPath heatingCurve(datapath="heat/HeatingCurve_60_40.txt") annotation (Placement(transformation(extent={{-8,-62},{12,-42}})));
  TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.ThermalHeatConsumer_L3 thermalHeatConsumer_CHP(
    T_start(displayUnit="degC") = 295.13,
    k_Win=1.3,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Ext matLayExt,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Flo matLayFlo,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Roof matLayRoof) annotation (Placement(transformation(
        extent={{-11,-8},{11,8}},
        rotation=180,
        origin={-51,52})));
  Modelica.Blocks.Sources.Constant ScaleFactor(k=scalingFactor*34526)           annotation (Placement(transformation(extent={{-54,-62},{-34,-42}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempBeforeCons1
                                                                annotation (Placement(transformation(extent={{154,28},{138,44}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempBeforeCons2
                                                                annotation (Placement(transformation(extent={{190,-60},{174,-44}})));
  Modelica.Blocks.Sources.RealExpression targetsupplyTemperature_boiler3(y=heatPumpElectricCharlineDG.Q_flow_set_.y)
                                                                                       annotation (Placement(transformation(extent={{56,-84},{86,-68}})));
PumpControl pumpControl(
    c_p=4200,
    m_flow_max=ScaleFactor.k/4200/30,
    T_firstOrder=60,
    T_set=338.15) annotation (Placement(transformation(extent={{120,-92},{140,-72}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true) annotation (Placement(transformation(extent={{88,-70},{108,-50}})));
  HeatPumpElectricCharlineDG_Ideal heatPumpElectricCharlineDG(
    Q_flow_n=1.8*ScaleFactor.k,
    heatFlowBoundary(change_sign=true),
    usePowerPort=true,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    redeclare TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary powerBoundary(useInputConnectorQ=false, change_sign=true) "PowerBoundary for ActivePowerPort") annotation (Placement(transformation(extent={{180,-6},{200,14}})));
  Modelica.Blocks.Sources.RealExpression meas_temperature_storage1(y=hotWaterStorage.controlVolume[1].T)
                                                                                                        annotation (Placement(transformation(extent={{34,43},{54,64}})));
  Modelica.Blocks.Sources.RealExpression set_temperature_storage1(y=273.15 + 65)
                                                                                annotation (Placement(transformation(extent={{32,60},{52,84}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-86,-86},{-66,-66}})));
  LimPIDDG PID_CHP1(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    u_ref=273.15 + 65,
    y_ref=ScaleFactor.k,
    y_max=ScaleFactor.k,
    y_min=0,
    k=1,
    y_inactive=0,
    initOption=501,
    y_start=1) "It is necessary to change the ramp parameters, if a different start time is chosen." annotation (Placement(transformation(extent={{74,62},{94,82}})));
equation
  connect(setValueTemperature.y,PID_PumpGrid. u_s) annotation (Line(points={{-9,38},{-3.2,38}},         color={0,0,127}));
  connect(thermalHeatConsumer_CHP.T_room,PID_PumpGrid. u_m) annotation (Line(points={{-39.4,50.8},{-34,50.8},{-34,28},{4.06,28},{4.06,30.8}},                    color={0,0,127}));
  connect(PID_PumpGrid.y,pumpGrid. m_flow_in) annotation (Line(points={{10.6,38},{18,38},{18,17}},             color={0,0,127}));
  connect(tWV.outlet2,joinGrid. inlet2) annotation (Line(
      points={{76,-12},{76,0},{75,0}},
      color={175,0,0},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hotWaterStorage.waterPortOut_grid[1],joinGrid. inlet1) annotation (Line(
      points={{102,-13.2},{102,8},{84,8}},
      color={175,0,0},
      thickness=0.5));
  connect(thermalHeatConsumer_CHP.port_HeatDemand,heatFlowMultiplier1. port_a) annotation (Line(points={{-40.4,44.4},{-40.4,41.2},{-40,41.2},{-40,38}},     color={191,0,0}));
  connect(pumpGrid.fluidPortIn,joinGrid. outlet) annotation (Line(
      points={{20,6},{62,6},{62,8},{66,8}},
      color={175,0,0},
      thickness=0.5));
  connect(pumpGrid.fluidPortIn,tempBeforeCons. port) annotation (Line(
      points={{20,6},{36,6},{36,8},{50,8}},
      color={175,0,0},
      thickness=0.5));
  connect(tempAfterCons.port,tWV. inlet) annotation (Line(
      points={{-18,-22},{24,-22},{24,-20.8889},{68,-20.8889}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hEXHeatCons.inlet,pumpGrid. fluidPortOut) annotation (Line(
      points={{-30,8},{-16,8},{-16,6},{0,6}},
      color={162,29,33},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hEXHeatCons.outlet,tWV. inlet) annotation (Line(
      points={{-50,8},{-50,-20.8889},{68,-20.8889}},
      color={162,29,33},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(heatFlowMultiplier1.port_b,hEXHeatCons. heat) annotation (Line(points={{-40,26},{-40,18}},    color={191,0,0}));
  connect(idealizedExpansionVessel1.waterPort,hotWaterStorage. waterPortOut_grid[1]) annotation (Line(
      points={{97,16},{102,16},{102,-13.2}},
      color={175,0,0},
      thickness=0.5));
  connect(tempBeforeCons.T,PID_TWV. u_m) annotation (Line(points={{41.2,16},{32,16},{32,-58.8},{59.09,-58.8}},               color={0,0,127}));
  connect(heatingCurve.T_Supply,PID_TWV. u_s) annotation (Line(points={{12.8,-48.4},{44,-48.4},{44,-48},{48.2,-48}},             color={0,0,127}));
  connect(PID_TWV.y,tWV. splitRatio_external) annotation (Line(points={{68.9,-48},{76,-48},{76,-28.8889}},       color={0,0,127}));
  connect(hotWaterStorage.waterPortOut_prod[1], pumpVLE_L1_simple1.fluidPortIn) annotation (Line(
      points={{128,-22.8},{138,-22.8},{138,-32},{144,-32}},
      color={175,0,0},
      thickness=0.5));
  connect(hotWaterStorage.waterPortIn_grid[1], tWV.outlet1) annotation (Line(
      points={{102,-22.8},{94,-22.8},{94,-20.8889},{84,-20.8889}},
      color={175,0,0},
      thickness=0.5));
  connect(hotWaterStorage.waterPortIn_prod[1], tempBeforeCons1.port) annotation (Line(
      points={{128,-13.8},{138,-13.8},{138,28},{146,28}},
      color={175,0,0},
      thickness=0.5));
  connect(pumpVLE_L1_simple1.fluidPortOut, tempBeforeCons2.port) annotation (Line(
      points={{164,-32},{174,-32},{174,-60},{182,-60}},
      color={175,0,0},
      thickness=0.5));
  connect(targetsupplyTemperature_boiler3.y,pumpControl. Q_set) annotation (Line(points={{87.5,-76},{119.4,-76},{119.4,-76.4}},  color={0,0,127}));
  connect(booleanExpression.y, pumpControl.u) annotation (Line(points={{109,-60},{119.6,-60},{119.6,-73}}, color={255,0,255}));
  connect(tempBeforeCons2.T, pumpControl.T_beforeBoiler) annotation (Line(points={{173.2,-52},{166,-52},{166,-102},{119.4,-102},{119.4,-82}}, color={0,0,127}));
  connect(pumpVLE_L1_simple1.m_flow_in, pumpControl.m_flow) annotation (Line(points={{146,-21},{144,-21},{144,-20},{140.8,-20},{140.8,-82}}, color={0,0,127}));
  connect(heatPumpElectricCharlineDG.waterPortOut, tempBeforeCons1.port) annotation (Line(
      points={{194,-6},{194,-14},{138,-14},{138,28},{146,28}},
      color={175,0,0},
      thickness=0.5));
  connect(heatPumpElectricCharlineDG.waterPortIn, tempBeforeCons2.port) annotation (Line(
      points={{186,-6},{186,-32},{174,-32},{174,-60},{182,-60}},
      color={175,0,0},
      thickness=0.5));
  connect(heatPumpElectricCharlineDG.epp, epp) annotation (Line(
      points={{200,4},{202,4},{202,-94},{-76,-94},{-76,-76}},
      color={28,108,200},
      thickness=0.5));
  connect(set_temperature_storage1.y, PID_CHP1.u_s) annotation (Line(points={{53,72},{72,72}}, color={0,0,127}));
  connect(meas_temperature_storage1.y, PID_CHP1.u_m) annotation (Line(points={{55,53.5},{84.1,53.5},{84.1,60}}, color={0,0,127}));
  connect(PID_CHP1.y, heatPumpElectricCharlineDG.Q_flow_set) annotation (Line(points={{95,72},{160,72},{160,4},{180,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
    experiment(
      StartTime=2419200,
      StopTime=3456000,
      Interval=100,
      __Dymola_Algorithm="Dassl"));
end ClaRa_HeatpumpCharline_Speicher_Ideal;
