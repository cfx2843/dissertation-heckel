within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation;
model basic_load_flow_case_stationary "basic load flow case (stationary)"

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
    v_d(start=0))       annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  TransiEnt.Components.Boundaries.Mechanical.Power power(phi_is(fixed=false))
                                                         annotation (Placement(transformation(extent={{-142,-74},{-122,-54}})));
  TransiEnt.Components.Mechanical.ConstantInertia constantInertia(
    P_n=475e6,                                                    J=40528,
    phi(start=0),
    alpha(start=0))                                                        annotation (Placement(transformation(extent={{-116,-38},{-96,-18}})));
  Components.ExcSEXS excSEXS(v_n=21000) annotation (Placement(transformation(extent={{-56,30},{-76,50}})));

  TransiEnt.Components.Electrical.PowerTransformation.TransformerComplex transformerComplex(
    U_P=21e3,
    U_S=419e3,
    X_P=0,
    X_S=56.18,
    R_P=0,
    R_S=0.5367)
           annotation (Placement(transformation(extent={{-14,-8},{6,12}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load1(useCosPhi=false, v_n=21000) annotation (Placement(transformation(extent={{-12,-66},{8,-46}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.SlackBoundary slackBoundary(
    v_gen=1.05*419000,
    f_n=50,
    P_gen(start=-783e3),
    Q_gen(start=-1.328e6))
                         annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex load(P_el_set_const=475e6,
    useCosPhi=false,
    Q_el_set=-76e6,                                                                           variability(kpu=2)) annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
  Components.GOVSTEAM0 gOVSTEAM0_1 annotation (Placement(transformation(extent={{-106,12},{-130,36}})));
  Modelica.Blocks.Sources.Constant const(k=-475e6) annotation (Placement(transformation(extent={{-176,-42},{-156,-22}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                              annotation (Placement(transformation(extent={{-134,50},{-114,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-twoAxisSynchronousMachineComplexSubtransient.P_el_is) annotation (Placement(transformation(extent={{98,32},{42,52}})));
  Components.PSS2A pSS2A(v_n=21000) annotation (Placement(transformation(extent={{0,34},{-20,54}})));
  Modelica.Blocks.Sources.RealExpression v_ref(y=21000)
                                                      annotation (Placement(transformation(extent={{-78,46},{-58,66}})));
equation
  connect(twoAxisSynchronousMachineComplexSubtransient.mpp, constantInertia.mpp_b) annotation (Line(points={{-92,0},{-94,0},{-94,-28},{-96,-28}}, color={95,95,95}));
  connect(constantInertia.mpp_a, power.mpp) annotation (Line(points={{-116,-28},{-120,-28},{-120,-64},{-122,-64}}, color={95,95,95}));
  connect(excSEXS.y, twoAxisSynchronousMachineComplexSubtransient.E_input) annotation (Line(points={{-76.6,40},{-92,40},{-92,9.9},{-82.3,9.9}}, color={0,0,127}));
  connect(excSEXS.epp1, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-56,40},{-51.5,40},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(const.y, add.u2) annotation (Line(points={{-155,-32},{-152,-32},{-152,-30},{-148,-30}}, color={0,0,127}));
  connect(gOVSTEAM0_1.y, add.u1) annotation (Line(points={{-128.2,24.12},{-128.2,24},{-148,24},{-148,-18}}, color={0,0,127}));
  connect(add.y, power.P_mech_set) annotation (Line(points={{-125,-24},{-128,-24},{-128,-52.2},{-132,-52.2}}, color={0,0,127}));
  connect(gOVSTEAM0_1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-118,12},{-86,12},{-86,20},{-51.5,20},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(const1.y, gOVSTEAM0_1.RefL) annotation (Line(points={{-113,60},{-96,60},{-96,23.76},{-108.64,23.76}}, color={0,0,127}));
  connect(slackBoundary.epp, transformerComplex.epp_n) annotation (Line(
      points={{100,2},{6,2}},
      color={28,108,200},
      thickness=0.5));
  connect(transformerComplex.epp_p, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-14,2},{-52,2},{-52,0},{-51.5,0},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(load1.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{-11.8,-56},{-18,-56},{-18,-14},{-34,-14},{-34,2},{-52,2},{-52,0},{-51.5,0},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(load.epp, transformerComplex.epp_n) annotation (Line(
      points={{100.2,-34},{78,-34},{78,2},{6,2}},
      color={28,108,200},
      thickness=0.5));
  connect(realExpression.y, pSS2A.Pgen) annotation (Line(points={{39.2,42},{20,42},{20,37.8},{0,37.8}}, color={0,0,127}));
  connect(pSS2A.epp, twoAxisSynchronousMachineComplexSubtransient.epp) annotation (Line(
      points={{0,49},{-18,49},{-18,4},{-34,4},{-34,2},{-52,2},{-52,0},{-51.5,0},{-51.5,-0.1},{-71.9,-0.1}},
      color={28,108,200},
      thickness=0.5));
  connect(pSS2A.y, excSEXS.u) annotation (Line(points={{-20.6,44},{-38,44},{-38,35},{-56,35}}, color={0,0,127}));
  connect(v_ref.y, excSEXS.voltageIn) annotation (Line(points={{-57,56},{-56,56},{-56,47.6},{-56,47.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{140,100}})),
    experiment(
      StopTime=10,
      Interval=0.001,
      __Dymola_fixedstepsize=0.0001,
      __Dymola_Algorithm="Dassl"));
end basic_load_flow_case_stationary;
