within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation;
model testcase_2
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
  TransiEnt.Components.Boundaries.Mechanical.Power power(phi_is(fixed=false))
                                                         annotation (Placement(transformation(extent={{-142,-74},{-122,-54}})));
  TransiEnt.Components.Mechanical.ConstantInertia constantInertia(
    P_n=475e6,                                                    J=40528,
    phi(start=0),
    alpha(start=0))                                                        annotation (Placement(transformation(extent={{-116,-38},{-96,-18}})));

  Modelica.Blocks.Sources.Constant const(k=-380e6) annotation (Placement(transformation(extent={{-176,-42},{-156,-22}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
  Modelica.Blocks.Sources.Step step(
    height=19e6,
    offset=380e6,
    startTime=0.1) annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load1(
    useInputConnectorP=true,
    useCosPhi=false,
    f_n=50,
    v_n=21000,
    variability(kpu=2, kqu=2))                                                                       annotation (Placement(transformation(extent={{10,-8},{30,12}})));
  Components.GOVSTEAM0 gOVSTEAM0_1 annotation (Placement(transformation(extent={{-134,22},{-116,40}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                              annotation (Placement(transformation(extent={{-170,22},{-150,42}})));
  Components.PSS2A pSS2A annotation (Placement(transformation(extent={{48,-28},{68,-8}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-twoAxisSynchronousMachineComplexSubtransient.P_el_is) annotation (Placement(transformation(extent={{114,-70},{58,-50}})));
  Modelica.Blocks.Sources.RealExpression v_ref(y=21000)
                                                      annotation (Placement(transformation(extent={{-116,46},{-96,66}})));
  Components.ExcSEXS excSEXS(
    useIntegrator=true,
    K=65,
    KI=35,
    integrator(initType=Modelica.Blocks.Types.Init.SteadyState),
    transferFunction1(initType=Modelica.Blocks.Types.Init.SteadyState)) annotation (Placement(transformation(extent={{-44,32},{-64,52}})));
equation
  connect(twoAxisSynchronousMachineComplexSubtransient.mpp, constantInertia.mpp_b) annotation (Line(points={{-92,0},{-94,0},{-94,-28},{-96,-28}}, color={95,95,95}));
  connect(constantInertia.mpp_a, power.mpp) annotation (Line(points={{-116,-28},{-120,-28},{-120,-64},{-122,-64}}, color={95,95,95}));
  connect(const.y, add.u2) annotation (Line(points={{-155,-32},{-152,-32},{-152,-30},{-148,-30}}, color={0,0,127}));
  connect(add.y, power.P_mech_set) annotation (Line(points={{-125,-24},{-122,-24},{-122,-52.2},{-132,-52.2}}, color={0,0,127}));
  connect(step.y, load1.P_el_set) annotation (Line(points={{11,62},{20,62},{20,13.6}},         color={0,0,127}));
  connect(load1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{10.2,2},{-10,2},{-10,0},{-30,0},{-30,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(gOVSTEAM0_1.y, add.u1) annotation (Line(points={{-117.35,31.09},{-117.35,8.5},{-148,8.5},{-148,-18}}, color={0,0,127}));
  connect(gOVSTEAM0_1.RefL, const1.y) annotation (Line(points={{-132.02,30.82},{-140,30.82},{-140,32},{-149,32}}, color={0,0,127}));
  connect(realExpression.y, pSS2A.Pgen) annotation (Line(points={{55.2,-60},{38,-60},{38,-24.2},{48,-24.2}}, color={0,0,127}));
  connect(pSS2A.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{48,-13},{30,-13},{30,-28},{-34,-28},{-34,0},{-32,0},{-32,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(gOVSTEAM0_1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-125,22},{-124,22},{-124,16},{-52,16},{-52,14},{-51.5,14},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(excSEXS.y, twoAxisSynchronousMachineComplexSubtransient.E_input) annotation (Line(points={{-64.6,42},{-66,42},{-66,9.9},{-82.3,9.9}}, color={0,0,127}));
  connect(excSEXS.voltageIn, v_ref.y) annotation (Line(points={{-44,49.6},{-40,49.6},{-40,50},{-36,50},{-36,56},{-95,56}}, color={0,127,127}));
  connect(excSEXS.u, pSS2A.y) annotation (Line(points={{-44,37},{20,37},{20,38},{84,38},{84,-18},{68.6,-18}}, color={0,0,127}));
  connect(excSEXS.epp1, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-44,42},{-32,42},{-32,44},{-20,44},{-20,0},{-30,0},{-30,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
    experiment(
      StopTime=15,
      Interval=0.001,
      __Dymola_fixedstepsize=0.0001,
      __Dymola_Algorithm="Dassl"));
end testcase_2;
