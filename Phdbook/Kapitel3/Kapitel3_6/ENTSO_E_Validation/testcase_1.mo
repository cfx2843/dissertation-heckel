within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation;
model testcase_1
  //There are some differences in the models compared to the reference model due to several reasons.
  //One of the resons is the lack of the Power system stabilizer which resulted in stronger oscillations.
  //Another reason was the lack of the limits in the voltage regulator and governor which can be seen most prominently in a comparison of Exitation Voltage in test case 3.
  //Lastly the voltage regulator and Governor are using different values compared to the reference case either due to lack of said values in the reference paper and because the voltage regular didnt work in the form given in the paper.

  inner TransiEnt.SimCenter simCenter(v_n(displayUnit="kV") = 21000, P_n_low=475e6)
                                                                      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-44,72},{-24,92}})));
  TransiEnt.Components.Electrical.Machines.TwoAxisSynchronousMachineComplexSubtransient twoAxisSynchronousMachineComplexSubtransient(
    v_n=21000,
    v_grid(start=21000),
    P_el_n=475e6,
    S_n=500e6,
    IsSlack=true,
    OwnFrequency=false,
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
    v_d(start=0))       annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Components.GOVSTEAM0 gOVSTEAM0_1 annotation (Placement(transformation(extent={{-150,16},{-130,36}})));
  TransiEnt.Components.Boundaries.Mechanical.Power power(phi_is(fixed=false))
                                                         annotation (Placement(transformation(extent={{-142,-74},{-122,-54}})));
  TransiEnt.Components.Mechanical.ConstantInertia constantInertia(
    P_n=475e6,                                                    J=40528,
    phi(start=0),
    alpha(start=0))                                                        annotation (Placement(transformation(extent={{-116,-38},{-96,-18}})));

  Modelica.Blocks.Sources.Constant const(k=0)      annotation (Placement(transformation(extent={{-176,-42},{-156,-22}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
  Modelica.Blocks.Math.Add add1
                               annotation (Placement(transformation(extent={{-110,38},{-90,58}})));
  Modelica.Blocks.Sources.Step step1(
    height=1050,
    offset=0,
    startTime=0.1) annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                              annotation (Placement(transformation(extent={{-186,16},{-166,36}})));
  Components.ExcSEXS excSEXS(
    useIntegrator=true,
    K=40,
    KI=35,
    integrator(initType=Modelica.Blocks.Types.Init.SteadyState),
    transferFunction1(initType=Modelica.Blocks.Types.Init.SteadyState)) annotation (Placement(transformation(extent={{-8,24},{12,44}})));
  Components.PSS2A pSS2A annotation (Placement(transformation(extent={{-50,-16},{-30,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-twoAxisSynchronousMachineComplexSubtransient.P_el_is) annotation (Placement(transformation(extent={{16,-62},{-40,-42}})));
  Modelica.Blocks.Sources.RealExpression v_ref(y=21000)
                                                      annotation (Placement(transformation(extent={{-164,42},{-144,62}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load1(useCosPhi=false, v_n=21000) annotation (Placement(transformation(extent={{-62,-84},{-42,-64}})));
equation
  connect(twoAxisSynchronousMachineComplexSubtransient.mpp, constantInertia.mpp_b) annotation (Line(points={{-92,0},{-94,0},{-94,-28},{-96,-28}}, color={95,95,95}));
  connect(constantInertia.mpp_a, power.mpp) annotation (Line(points={{-116,-28},{-120,-28},{-120,-64},{-122,-64}}, color={95,95,95}));
  connect(const.y, add.u2) annotation (Line(points={{-155,-32},{-152,-32},{-152,-30},{-148,-30}}, color={0,0,127}));
  connect(add.y, power.P_mech_set) annotation (Line(points={{-125,-24},{-122,-24},{-122,-52.2},{-132,-52.2}}, color={0,0,127}));
  connect(gOVSTEAM0_1.y, add.u1) annotation (Line(points={{-131.5,26.1},{-131.5,8.5},{-148,8.5},{-148,-18}}, color={0,0,127}));
  connect(step1.y, add1.u1) annotation (Line(points={{-119,80},{-116,80},{-116,54},{-112,54}}, color={0,0,127}));
  connect(gOVSTEAM0_1.RefL, const1.y) annotation (Line(points={{-147.8,25.8},{-156,25.8},{-156,26},{-165,26}}, color={0,0,127}));
  connect(pSS2A.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-50,-1},{-60,-1},{-60,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(gOVSTEAM0_1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-140,16},{-124,16},{-124,-6},{-106,-6},{-106,-16},{-60,-16},{-60,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(excSEXS.u, pSS2A.y) annotation (Line(points={{-8,29},{-21,29},{-21,-6},{-29.4,-6}}, color={0,0,127}));
  connect(realExpression.y, pSS2A.Pgen) annotation (Line(points={{-42.8,-52},{-52,-52},{-52,-12.2},{-50,-12.2}}, color={0,0,127}));
  connect(excSEXS.epp1, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-8,34},{-22,34},{-22,14},{-60,14},{-60,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(add1.u2, v_ref.y) annotation (Line(points={{-112,42},{-124,42},{-124,52},{-143,52}}, color={0,0,127}));
  connect(add1.y, excSEXS.voltageIn) annotation (Line(points={{-89,48},{-50,48},{-50,41.6},{-8,41.6}}, color={0,0,127}));
  connect(excSEXS.y, twoAxisSynchronousMachineComplexSubtransient.E_input) annotation (Line(points={{12.6,34},{14,34},{14,56},{-82.3,56},{-82.3,9.9}}, color={0,0,127}));
  connect(load1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-61.8,-74},{-68,-74},{-68,-16},{-60,-16},{-60,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
    experiment(
      StopTime=2,
      Interval=0.001,
      __Dymola_fixedstepsize=0.0001,
      __Dymola_Algorithm="Dassl"));
end testcase_1;
