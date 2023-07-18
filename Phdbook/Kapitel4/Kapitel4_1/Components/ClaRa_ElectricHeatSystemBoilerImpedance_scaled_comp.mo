within Phdbook.Kapitel4.Kapitel4_1.Components;
model ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp
  extends TransiEnt.Basics.Icons.Boiler;

parameter Real scalingFactor=30000;

  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpVLE_L1_simple(
    presetVariableType="dp",
    Delta_p_fixed=30000,
    m_flow_fixed=0.2)    annotation (Placement(transformation(extent={{-70,-8},{-50,12}})));
  replaceable TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler.ElectricBoilerImpedance electricBoilerImpedance(
    cosphi=0.866,
    Q_flow_n=scalingFactor*7.5e3,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    heatFlowBoundary(p_drop=10000)) annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  ClaRa.Components.VolumesValvesFittings.Valves.GenericValveVLE_L1 valveVLE_L1_1(openingInputIsActive=true, redeclare model PressureLoss = ClaRa.Components.VolumesValvesFittings.Valves.Fundamentals.LinearNominalPoint (m_flow_nom=scalingFactor*0.2, Delta_p_nom=2e4))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{0,6},{20,-6}})));
  ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 volumeVLE_2_1(
    redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry (volume=scalingFactor),
    m_flow_nom=scalingFactor*0.2,
    h_nom=4200*90,
    initOption=0,
    h_start=167.62313882385e3,
    redeclare model HeatTransfer = ClaRa.Basics.ControlVolumes.Fundamentals.HeatTransport.Generic_HT.CharLine_L2 (alpha_nom=scalingFactor*250, PL_alpha=[0,0.2; 0.5,0.6; 0.7,0.72; 1,1]))
                               annotation (Placement(transformation(extent={{42,10},{62,-10}})));
  ClaRa.Components.Utilities.Blocks.LimPID PIDValve(
    Tau_d=0,
    y_min=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    y_max=electricBoilerImpedance.Q_flow_n,
    y_ref=electricBoilerImpedance.Q_flow_n,
    u_ref=273.15 + 90,
    k=5,
    Tau_i=5,
    initOption=503,
    y_start=2300,
    y_inactive=0)
                 annotation (Placement(transformation(extent={{2,36},{14,48}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(extent={{-10,52},{-16,58}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempBeforeConsumer(unitOption=1)
                                                                   annotation (Placement(transformation(extent={{40,18},{20,38}})));
  TransiEntDevZone.Sketchbook.as.New_Models_for_TL.ThermalHeatConsumer_L3 thermalHeatConsumer_L3_1(
    redeclare TransiEntDevZone.Sketchbook.as.New_Models_for_TL.Base.Construction_Base.ConstructionData.Vivaldi_Flo matLayFlo,
    redeclare TransiEntDevZone.Sketchbook.as.New_Models_for_TL.Base.Construction_Base.ConstructionData.Vivaldi_Oth matLayRoof,
    redeclare TransiEntDevZone.Sketchbook.as.New_Models_for_TL.Base.Construction_Base.ConstructionData.Vivaldi_Ext matLayExt,
    k_Win=3)                                                                                       annotation (Placement(transformation(extent={{54,-66},{76,-50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=0) annotation (Placement(transformation(extent={{14,-78},{34,-58}})));
  ClaRa.Components.Utilities.Blocks.LimPID PIDValve1(
    u_ref=273.15 + 22,
    Tau_d=0,
    initOption=503,
    y_max=1,
    y_min=1e-5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=50,
    Tau_i=5,
    y_start=0.1) annotation (Placement(transformation(extent={{-12,-52},{0,-40}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 22) annotation (Placement(transformation(extent={{-46,-54},{-26,-34}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempAfterConsumer1(unitOption=1) annotation (Placement(transformation(extent={{68,0},{88,20}})));
 outer TransiEnt.SimCenter simCenter;
  TransiEntDevZone.Sketchbook.as.MA_Senkel.System.ff.Components.Components.Basics.IdealizedExpansionVessel idealizedExpansionVessel(p=100000)
                                                                                                                                    annotation (Placement(transformation(extent={{-90,48},{-70,68}})));
TransiEntDevZone.Sketchbook.as.HeatCircuits.HeatingCurves.HeatingCurve_60_40_angepasst heatingCurve_60_40 annotation (Placement(transformation(extent={{-22,30},{-8,44}})));
  ResiliEntEE.Experiments.Coupled.HeatFlowMultiplier heatFlowMultiplier(factor=scalingFactor) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={54,-32})));
//   Modelica.Blocks.Sources.Constant scalingfactor(k=30000)
//                                                        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
equation
  connect(volumeVLE_2_1.outlet, pumpVLE_L1_simple.fluidPortIn) annotation (Line(
      points={{62,0},{78,0},{78,-84},{-80,-84},{-80,2},{-70,2}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(gain.u,PIDValve. y) annotation (Line(points={{-9.4,55},{14.6,55},{14.6,42}}, color={0,0,127}));
  connect(fixedHeatFlow.port,thermalHeatConsumer_L3_1. port_internalGains) annotation (Line(points={{34,-68},{54,-68},{54,-61}},    color={191,0,0}));
  connect(realExpression.y,PIDValve1. u_s) annotation (Line(points={{-25,-44},{-20,-44},{-20,-46},{-13.2,-46}},color={0,0,127}));
  connect(PIDValve1.u_m,thermalHeatConsumer_L3_1. y) annotation (Line(points={{-5.94,-53.2},{-5.94,-56.8},{53.4,-56.8}}, color={0,0,127}));
  connect(tempBeforeConsumer.T, PIDValve.u_m) annotation (Line(points={{19,28},{8.06,28},{8.06,34.8}}, color={0,0,127}));
  connect(volumeVLE_2_1.outlet, tempAfterConsumer1.port) annotation (Line(
      points={{62,0},{78,0}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(idealizedExpansionVessel.waterPort, pumpVLE_L1_simple.fluidPortIn) annotation (Line(
      points={{-80,48},{-80,2},{-70,2}},
      color={175,0,0},
      thickness=0.5));
  connect(valveVLE_L1_1.outlet, volumeVLE_2_1.inlet) annotation (Line(
      points={{20,0},{42,0}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(heatingCurve_60_40.T_Supply,PIDValve. u_s) annotation (Line(points={{-7.44,39.52},{0.8,39.52},{0.8,42}},     color={0,0,127}));
  connect(gain.y, electricBoilerImpedance.Q_flow_set) annotation (Line(points={{-16.3,55},{-30,55},{-30,10}}, color={0,0,127}));
  connect(pumpVLE_L1_simple.fluidPortOut, electricBoilerImpedance.fluidPortIn) annotation (Line(
      points={{-50,2},{-44,2},{-44,0},{-39.8,0}},
      color={175,0,0},
      thickness=0.5));
  connect(electricBoilerImpedance.fluidPortOut, valveVLE_L1_1.inlet) annotation (Line(
      points={{-20,0},{0,0}},
      color={175,0,0},
      thickness=0.5));
  connect(electricBoilerImpedance.fluidPortOut, tempBeforeConsumer.port) annotation (Line(
      points={{-20,0},{-6,0},{-6,18},{30,18}},
      color={175,0,0},
      thickness=0.5));
  connect(heatFlowMultiplier.port_b, volumeVLE_2_1.heat) annotation (Line(points={{54,-22},{54,-10},{52,-10}}, color={191,0,0}));
  connect(heatFlowMultiplier.port_a, thermalHeatConsumer_L3_1.port_HeatDemand) annotation (Line(points={{54,-42},{54,-46},{54,-50.4},{54.4,-50.4}}, color={191,0,0}));
  connect(valveVLE_L1_1.opening_in, PIDValve1.y) annotation (Line(points={{10,-9},{8,-9},{8,-46},{0.6,-46}}, color={0,0,127}));
  connect(electricBoilerImpedance.epp,epp)  annotation (Line(
      points={{-30,-10},{-30,-20},{-100,-20},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(
      StartTime=2419200,
      StopTime=3024000,
      Interval=900.00288));
end ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp;
