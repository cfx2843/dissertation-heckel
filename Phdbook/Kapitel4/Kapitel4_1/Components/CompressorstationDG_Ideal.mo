within Phdbook.Kapitel4.Kapitel4_1.Components;
model CompressorstationDG_Ideal
  TransiEnt.Components.Boundaries.Gas.BoundaryRealGas_pTxi source(p_const=6000000) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryRealGas_Txim_flow sink(variable_m_flow=true) annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  TransiEntDevZone.Sketchbook.cb.Grid.Gas.Components.CompressorStation.CompressorStation_pOutControl compressorStation(
    N_comp=2,
    P_el_n_comp=10e6,
    Delta_p_start(displayUnit="Pa") = {1e5 - 100,100},
    p_out_set_const=6000000,
    k=1e4,
    useMechPowerPort=false) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  TransiEnt.Components.Gas.VolumesValvesFittings.Pipes.PipeFlow_L4_Simple_isoth pipe1(
    frictionAtInlet=false,
    frictionAtOutlet=true,
    diameter_i=1.2,
    N_cv=1,
    m_flow_start=ones(pipe1.N_cv + 1)*50,
    length=100e3,
    p_start=ones(pipe1.N_cv)*99e5) annotation (Placement(transformation(extent={{-44,-6},{-16,6}})));
  TransiEnt.Components.Gas.VolumesValvesFittings.Pipes.PipeFlow_L4_Simple_isoth pipe2(
    frictionAtInlet=true,
    frictionAtOutlet=false,
    diameter_i=1.2,
    N_cv=1,
    m_flow_start=ones(pipe2.N_cv + 1)*50,
    length=100e3,
    p_start=ones(pipe2.N_cv)*100e5) annotation (Placement(transformation(extent={{16,-6},{44,6}})));
  TransiEnt.Basics.Tables.GenericDataTable genericDataTable(use_absolute_path=true,
    absolute_path="C:/RepositoryTUHH/gomez/Masterbook/GasDemandForHeatingWithGasBoiler4535_900s.txt",
    constantfactor=ScaleFactor.k)                                                                                                                                                                                  annotation (Placement(transformation(extent={{100,-4},{80,16}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary(useInputConnectorQ=false) annotation (Placement(transformation(extent={{-10,-54},{10,-34}})));
  Modelica.Blocks.Sources.RealExpression globalFrequency_reference(y=(compressorStation.compressorStation[1].compressor.P_shaft + compressorStation.compressorStation[2].compressor.P_shaft))
                                                                                    annotation (Placement(transformation(extent={{-10,-30},{-32,-18}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-94,-54},{-74,-34}}), iconTransformation(extent={{-94,-54},{-74,-34}})));
  Modelica.Blocks.Sources.Constant ScaleFactor(k=4.85/(7.64*4e8))               annotation (Placement(transformation(extent={{-40,44},{-20,64}})));
equation
  connect(compressorStation.gasPortOut, pipe2.gasPortIn) annotation (Line(
      points={{10,0},{16,0}},
      color={255,255,0},
      thickness=1.5));
  connect(source.gasPort, pipe1.gasPortIn) annotation (Line(
      points={{-50,0},{-44,0}},
      color={255,255,0},
      thickness=1.5));
  connect(pipe1.gasPortOut, compressorStation.gasPortIn) annotation (Line(
      points={{-16,0},{-10,0}},
      color={255,255,0},
      thickness=1.5));
  connect(pipe2.gasPortOut, sink.gasPort) annotation (Line(
      points={{44,0},{50,0}},
      color={255,255,0},
      thickness=1.5));
  connect(sink.m_flow, genericDataTable.y1) annotation (Line(points={{72,6},{79,6}}, color={0,0,127}));
  connect(globalFrequency_reference.y, pQBoundary.P_el_set) annotation (Line(points={{-33.1,-24},{-44,-24},{-44,-32},{-6,-32}}, color={0,0,127}));
  connect(pQBoundary.epp, epp) annotation (Line(
      points={{-10,-44},{-22,-44},{-22,-44},{-84,-44}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{120,100}}), graphics={Rectangle(
          extent={{-84,82},{114,-62}},
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{120,100}})),
    experiment(
      StartTime=2000000,
      StopTime=2300000,
      Interval=900,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"));
end CompressorstationDG_Ideal;
