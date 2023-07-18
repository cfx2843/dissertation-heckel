within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation;
model testcase_3
  //There are some differences in the models compared to the reference model due to several reasons.
  //One of the resons is the lack of the Power system stabilizer which resulted in stronger oscillations.
  //Another reason was the lack of the limits in the voltage regulator and governor which can be seen most prominently in a comparison of Exitation Voltage in test case 3.
  //Lastly the voltage regulator and Governor are using different values compared to the reference case either due to lack of said values in the reference paper and because the voltage regular didnt work in the form given in the paper.

  inner TransiEnt.SimCenter simCenter(v_n(displayUnit="kV") = 21000, P_n_low=475e6)
                                                                      annotation (Placement(transformation(extent={{-74,68},{-54,88}})));
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-44,72},{-24,92}})));
  TransiEnt.Components.Electrical.Machines.TwoAxisSynchronousMachineComplexSubtransient twoAxisSynchronousMachineComplexSubtransient(
    v_n=21000,
    v_grid(start=21000),
    P_el_n=475e6,
    S_n=500e6,
    IsSlack=false,
    OwnFrequency=true,
    X_d=1.764,
    X_q=1.5876,
    R_a=0,
    X_d_trans=0.3087,
    X_q_trans=0.441,
    T_d0_trans=0.9,
    T_q0_trans=0.6,
    X_d_subtrans=0.2205,
    X_q_subtrans=0.2646,
    T_d0_subtrans=0.03,
    T_q0_subtrans=0.05,
    v_d(start=0))       annotation (Placement(transformation(extent={{-92,-2},{-72,18}})));
  TransiEnt.Components.Boundaries.Mechanical.Power power(phi_is(fixed=false))
                                                         annotation (Placement(transformation(extent={{-142,-74},{-122,-54}})));
  TransiEnt.Components.Mechanical.ConstantInertia constantInertia(
    P_n=475e6,                                                    J=40528,
    phi(start=0),
    alpha(start=0))                                                        annotation (Placement(transformation(extent={{-116,-38},{-96,-18}})));

  TransiEnt.Components.Electrical.PowerTransformation.TransformerComplex transformerComplex(
    U_P=21e3,
    U_S=419e3,
    X_P=0,
    X_S=56.18,
    R_P=0,
    R_S=0.5367)
           annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load1(useCosPhi=false, v_n=21000) annotation (Placement(transformation(extent={{-4,-62},{16,-42}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=-419000,
    width=1,
    period=10,
    nperiod=1,
    offset=419000,
    startTime=0.1) annotation (Placement(transformation(extent={{10,62},{30,82}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PVBoundary pVBoundary(P_gen=0, useInputConnectorv=true) annotation (Placement(transformation(extent={{46,22},{66,42}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.SlackBoundary slackBoundary(
    v_gen=419000,
    f_n=50,
    P_gen(start=-783e3),
    Q_gen(start=-1.328e6))
                         annotation (Placement(transformation(extent={{118,-10},{138,10}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load(P_el_set_const=475e6,
    useCosPhi=false,
    Q_el_set=76e6,
    P_n=475e6,
    variability(kpu=2, kqu=2))                                                                                    annotation (Placement(transformation(extent={{104,-56},{124,-36}})));
  Components.GOVSTEAM0 gOVSTEAM0_1 annotation (Placement(transformation(extent={{-130,6},{-150,26}})));
  Modelica.Blocks.Sources.Constant const(k=-475e6) annotation (Placement(transformation(extent={{-176,-42},{-156,-22}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                              annotation (Placement(transformation(extent={{-150,46},{-130,66}})));
  Modelica.Blocks.Sources.RealExpression v_ref(y=21000)
                                                      annotation (Placement(transformation(extent={{-110,44},{-90,64}})));
  Components.ExcSEXS excSEXS(
    useIntegrator=true,
    K=30,
    KI=20,
    integrator(initType=Modelica.Blocks.Types.Init.SteadyState),
    transferFunction1(initType=Modelica.Blocks.Types.Init.SteadyState)) annotation (Placement(transformation(extent={{-42,32},{-62,52}})));
  Components.PSS2A pSS2A(KS1=2.5) annotation (Placement(transformation(extent={{-10,28},{-30,48}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-twoAxisSynchronousMachineComplexSubtransient.P_el_is) annotation (Placement(transformation(extent={{54,40},{-2,60}})));
public
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced
                                                   transmissionLine2(
    ChooseVoltageLevel=2,
    r_custom=1e-3,
    x_custom=0,
    c_custom=0,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L3,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,
    l(displayUnit="m") = 1000)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,0})));
public
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced
                                                   transmissionLine1(
    ChooseVoltageLevel=3,
    r_custom=0.001,
    x_custom=0,
    c_custom=0,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L3,
    l(displayUnit="m") = 5000)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={64,0})));
equation
  connect(twoAxisSynchronousMachineComplexSubtransient.mpp, constantInertia.mpp_b) annotation (Line(points={{-92,8},{-94,8},{-94,-28},{-96,-28}}, color={95,95,95}));
  connect(constantInertia.mpp_a, power.mpp) annotation (Line(points={{-116,-28},{-120,-28},{-120,-64},{-122,-64}}, color={95,95,95}));
  connect(transmissionLine2.epp_n, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-38,8.88178e-16},{-50,8.88178e-16},{-50,7.9},{-71.9,7.9}},
      color={28,108,200},
      thickness=0.5));
  connect(transformerComplex.epp_p, transmissionLine2.epp_p) annotation (Line(
      points={{-4,0},{-18,0}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine1.epp_n, transformerComplex.epp_n) annotation (Line(
      points={{54,8.88178e-16},{26,8.88178e-16},{26,0},{16,0}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine2.epp_p, load1.epp) annotation (Line(
      points={{-18,0},{-8,0},{-8,-52},{-3.8,-52}},
      color={28,108,200},
      thickness=0.5));
  connect(pulse.y, pVBoundary.v_gen_set) annotation (Line(points={{31,72},{94,72},{94,44},{62,44}}, color={0,0,127}));
  connect(pVBoundary.epp, transformerComplex.epp_n) annotation (Line(
      points={{46,32},{32,32},{32,0},{16,0}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, add.u2) annotation (Line(points={{-155,-32},{-152,-32},{-152,-30},{-148,-30}}, color={0,0,127}));
  connect(gOVSTEAM0_1.y, add.u1) annotation (Line(points={{-148.5,16.1},{-148.5,1.5},{-148,1.5},{-148,-18}}, color={0,0,127}));
  connect(add.y, power.P_mech_set) annotation (Line(points={{-125,-24},{-128,-24},{-128,-52.2},{-132,-52.2}}, color={0,0,127}));
  connect(gOVSTEAM0_1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-140,6},{-140,-10},{-64,-10},{-64,7.9},{-71.9,7.9}},
      color={28,108,200},
      thickness=0.5));
  connect(const1.y, gOVSTEAM0_1.RefL) annotation (Line(points={{-129,56},{-120,56},{-120,16},{-132.2,16},{-132.2,15.8}}, color={0,0,127}));
  connect(excSEXS.y, twoAxisSynchronousMachineComplexSubtransient.E_input) annotation (Line(points={{-62.6,42},{-60,42},{-60,17.9},{-82.3,17.9}}, color={0,0,127}));
  connect(excSEXS.voltageIn, v_ref.y) annotation (Line(points={{-42,49.6},{-32,49.6},{-32,48},{-30,48},{-30,54},{-89,54}}, color={0,127,127}));
  connect(excSEXS.u, pSS2A.y) annotation (Line(points={{-42,37},{-36,37},{-36,40},{-34,40},{-34,38},{-30.6,38}}, color={0,0,127}));
  connect(excSEXS.epp1, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-42,42},{-42,34},{-50,34},{-50,8},{-60,8},{-60,7.9},{-71.9,7.9}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, pSS2A.Pgen) annotation (Line(points={{-4.8,50},{-4.8,42},{-4,42},{-4,32},{-10,32},{-10,31.8}}, color={0,0,127}));
  connect(pSS2A.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-10,43},{-2,43},{-2,22},{-50,22},{-50,8},{-60,8},{-60,7.9},{-71.9,7.9}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine1.epp_p, slackBoundary.epp) annotation (Line(
      points={{74,0},{118,0}},
      color={28,108,200},
      thickness=0.5));
  connect(load.epp, slackBoundary.epp) annotation (Line(
      points={{104.2,-46},{98,-46},{98,0},{118,0}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
    experiment(
      StopTime=10,
      Interval=0.001,
      __Dymola_fixedstepsize=0.0001,
      __Dymola_Algorithm="Dassl"));
end testcase_3;
