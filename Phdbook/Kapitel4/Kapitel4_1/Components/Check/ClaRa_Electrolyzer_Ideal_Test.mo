within Phdbook.Kapitel4.Kapitel4_1.Components.Check;
model ClaRa_Electrolyzer_Ideal_Test
  extends TransiEnt.Basics.Icons.Boiler;

parameter Real scalingFactor=30000;

// outer TransiEnt.SimCenter simCenter;
//   Modelica.Blocks.Sources.Constant scalingfactor(k=30000)
//                                                        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.SlackBoundary
                                                                   electricGrid(f_n=50)                  annotation (Placement(transformation(extent={{138,52},{158,72}})));
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
  TransiEnt.Basics.Tables.GasGrid.NaturalGasVolumeFlowSTP gasDemandHFlow(change_of_sign=false, constantfactor=ScaleFactor.k)                annotation (Placement(transformation(extent={{-10,-28},{-30,-8}})));
  Modelica.Blocks.Sources.RealExpression set_pressure(y=70e5) annotation (Placement(transformation(extent={{-14,52},{6,76}})));
  TransiEnt.Components.Gas.VolumesValvesFittings.Pipes.PipeFlow_L4_Simple_isoth pipe(
    medium=simCenter.gasModel3,
    frictionAtInlet=true,
    length=10000,
    diameter_i=0.25,
    N_cv=1,
    p_start(displayUnit="bar") = {6700000}) annotation (Placement(transformation(extent={{98,-64},{126,-52}})));
  TransiEnt.Consumer.Gas.GasConsumer_HFlow gasConsumer_HFlow(medium=simCenter.gasModel3, usePIDcontroller=false) annotation (Placement(transformation(extent={{134,-68},{154,-48}})));
  TransiEnt.Producer.Gas.Electrolyzer.PEMElectrolyzer_L1 electrolyzer(
    P_el_n=2e8,
    redeclare TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary powerBoundary(useInputConnectorQ=false),
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp) annotation (Placement(transformation(extent={{82,22},{62,42}})));
  TransiEnt.Components.Sensors.RealGas.PressureSensor pressureSensor(medium=simCenter.gasModel3) annotation (Placement(transformation(extent={{64,-26},{84,-6}})));
  Modelica.Blocks.Sources.Constant ScaleFactor(k=scalingFactor*200)             annotation (Placement(transformation(extent={{-70,-84},{-50,-64}})));
  Phdbook.Kapitel4.Kapitel4_1.Components.LimPIDDG PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    u_ref=70e5,
    y_ref=700*ScaleFactor.k,
    y_max=700*ScaleFactor.k,
    y_min=0,
    k=5,
    ramp(height=0, offset=10)) annotation (Placement(transformation(extent={{22,54},{42,74}})));
  Phdbook.Kapitel4.Kapitel4_1.Components.GasDemand_DG gasDemand_DG(
    relativepath="GasDemandForHeatingWithGasBoiler4535_900s.txt",
    use_absolute_path=true,
    absolute_path="C:/RepositoryTUHH/gomez/Masterbook/GasDemandForHeatingWithGasBoiler4535_900s.txt",
    constantfactor=ScaleFactor.k/10e9) annotation (Placement(transformation(extent={{54,-94},{74,-74}})));
equation
  connect(gasConsumer_HFlow.fluidPortIn, pipe.gasPortOut) annotation (Line(
      points={{134,-58},{126,-58}},
      color={255,255,0},
      thickness=1.5));
  connect(electricGrid.epp, electrolyzer.epp) annotation (Line(
      points={{138,62},{110,62},{110,32},{82,32}},
      color={28,108,200},
      thickness=0.5));
  connect(pressureSensor.gasPortOut, pipe.gasPortIn) annotation (Line(
      points={{84,-26},{86,-26},{86,-58},{98,-58}},
      color={255,255,0},
      thickness=1.5));
  connect(electrolyzer.gasPortOut, pressureSensor.gasPortIn) annotation (Line(
      points={{62,32},{56,32},{56,34},{48,34},{48,-26},{64,-26}},
      color={255,255,0},
      thickness=1.5));
  connect(set_pressure.y, PID.u_s) annotation (Line(points={{7,64},{20,64}}, color={0,0,127}));
  connect(PID.y, electrolyzer.P_el_set) annotation (Line(points={{43,64},{76,64},{76,44}}, color={0,0,127}));
  connect(pressureSensor.p, PID.u_m) annotation (Line(points={{85,-16},{90,-16},{90,8},{32.1,8},{32.1,52}}, color={0,0,127}));
  connect(gasDemand_DG.y1, gasConsumer_HFlow.H_flow) annotation (Line(points={{75,-84},{118,-84},{118,-86},{168,-86},{168,-58},{155,-58}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-80,-100},{200,100}})),
    experiment(
      StartTime=2000000,
      StopTime=3300000,
      Interval=100,
      __Dymola_Algorithm="Dassl"));
end ClaRa_Electrolyzer_Ideal_Test;
