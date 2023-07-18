within Phdbook.Kapitel4.Kapitel4_1.Components;
model Electrolyzer_Ideal
  extends TransiEnt.Basics.Icons.Electrolyser2;

parameter Real scalingFactor=30000;

// outer TransiEnt.SimCenter simCenter;
//   Modelica.Blocks.Sources.Constant scalingfactor(k=30000)
//                                                        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-44,82},{-24,102}})));
  inner TransiEnt.SimCenter simCenter(
    redeclare TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid1,
    v_n(displayUnit="kV") = 110000,
    p_eff_2=6898000,
    initOptionGasPipes=0,
    tableInterpolationSmoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    ambientConditions(
      redeclare TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind,
      redeclare TransiEnt.Basics.Tables.Ambient.GHI_Hamburg_3600s_2012_TMY globalSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY directSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY diffuseSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_900s_2012 temperature),
    integrateHeatFlow=true)                                                                         annotation (Placement(transformation(extent={{-78,82},{-58,102}})));
  Modelica.Blocks.Sources.RealExpression set_pressure(y=70e5) annotation (Placement(transformation(extent={{-14,52},{6,76}})));
  TransiEnt.Components.Gas.VolumesValvesFittings.Pipes.PipeFlow_L4_Simple_isoth pipe(
    medium=simCenter.gasModel3,
    frictionAtInlet=true,
    length=10e3,
    diameter_i=0.25,
    N_cv=1,
    p_start(displayUnit="bar") = {6950000}) annotation (Placement(transformation(extent={{64,-64},{92,-52}})));
  TransiEnt.Consumer.Gas.GasConsumer_HFlow gasConsumer_HFlow(medium=simCenter.gasModel3, usePIDcontroller=false) annotation (Placement(transformation(extent={{134,-68},{154,-48}})));
  TransiEnt.Producer.Gas.Electrolyzer.PEMElectrolyzer_L1 electrolyzer(
    P_el_n=1e9,
    redeclare TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary powerBoundary(useInputConnectorQ=false, cosphi_boundary=0.9),
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp) annotation (Placement(transformation(extent={{82,22},{62,42}})));
  TransiEnt.Components.Sensors.RealGas.PressureSensor pressureSensor(medium=simCenter.gasModel3) annotation (Placement(transformation(extent={{36,-26},{56,-6}})));
  Modelica.Blocks.Sources.Constant ScaleFactor(k=scalingFactor*280)             annotation (Placement(transformation(extent={{-70,-84},{-50,-64}})));
  Phdbook.Kapitel4.Kapitel4_1.Components.LimPIDDG PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    u_ref=70e5,
    y_ref=700*ScaleFactor.k,
    y_max=700*ScaleFactor.k,
    y_min=0,
    ramp(
      height=0,
      offset=5,
      startTime=2000000)) annotation (Placement(transformation(extent={{22,54},{42,74}})));
  GasDemand_DG gasDemand_DG(
    relativepath="GasDemandForHeatingWithGasBoiler4535_900s.txt",
    use_absolute_path=true,
    absolute_path="C:/Users/cfx2843/Nextcloud2/08 Daten/transientee-data/modelica/gas/GasDemandForHeatingWithGasBoiler4535_900s.txt",
    constantfactor=ScaleFactor.k/10e9) annotation (Placement(transformation(extent={{54,-92},{74,-72}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-88,-56},{-68,-36}})));
  TransiEnt.Components.Sensors.RealGas.GCVSensor gCVSensor_electrolyzer(medium=simCenter.gasModel3)
                                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-6})));
  TransiEnt.Components.Sensors.RealGas.GCVSensor gCVSensor_electrolyzer1(medium=simCenter.gasModel3)
                                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={114,-48})));
equation
  connect(pressureSensor.gasPortOut, pipe.gasPortIn) annotation (Line(
      points={{56,-26},{62,-26},{62,-58},{64,-58}},
      color={255,255,0},
      thickness=1.5));
  connect(set_pressure.y, PID.u_s) annotation (Line(points={{7,64},{20,64}}, color={0,0,127}));
  connect(PID.y, electrolyzer.P_el_set) annotation (Line(points={{43,64},{76,64},{76,44}}, color={0,0,127}));
  connect(pressureSensor.p, PID.u_m) annotation (Line(points={{57,-16},{90,-16},{90,8},{32.1,8},{32.1,52}}, color={0,0,127}));
  connect(gasDemand_DG.y1, gasConsumer_HFlow.H_flow) annotation (Line(points={{75,-82},{168,-82},{168,-58},{155,-58}},                     color={0,0,127}));
  connect(electrolyzer.epp, epp) annotation (Line(
      points={{82,32},{100,32},{100,-46},{-78,-46}},
      color={28,108,200},
      thickness=0.5));
  connect(electrolyzer.gasPortOut, gCVSensor_electrolyzer.gasPortIn) annotation (Line(
      points={{62,32},{38,32},{38,34},{30,34},{30,4}},
      color={255,255,0},
      thickness=1.5));
  connect(gCVSensor_electrolyzer.gasPortOut, pressureSensor.gasPortIn) annotation (Line(
      points={{30,-16},{30,-26},{36,-26}},
      color={255,255,0},
      thickness=1.5));
  connect(gasConsumer_HFlow.fluidPortIn, gCVSensor_electrolyzer1.gasPortOut) annotation (Line(
      points={{134,-58},{124,-58}},
      color={255,255,0},
      thickness=1.5));
  connect(gCVSensor_electrolyzer1.gasPortIn, pipe.gasPortOut) annotation (Line(
      points={{104,-58},{92,-58}},
      color={255,255,0},
      thickness=1.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
    experiment(
      StartTime=2000000,
      StopTime=2300000,
      Interval=100,
      __Dymola_Algorithm="Dassl"));
end Electrolyzer_Ideal;
