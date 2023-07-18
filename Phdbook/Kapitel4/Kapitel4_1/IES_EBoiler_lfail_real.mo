within Phdbook.Kapitel4.Kapitel4_1;
model IES_EBoiler_lfail_real

protected
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-110,
            -98},{-90,-78}})));

  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Central(
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000)
    annotation (Placement(transformation(extent={{18,30},{38,50}})));

  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralFault(
    activateSwitch=true,
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,
    l(displayUnit="km") = 200000)
    annotation (Placement(transformation(extent={{16,64},{36,84}})));

  Modelica.Blocks.Sources.BooleanStep  BooleanFault(startTime(displayUnit="s") = 2400400)
    annotation (Placement(transformation(extent={{-10,92},{6,108}})));

  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L1(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,-20})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L1(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{-74,-58},{-92,-42}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_a(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-6,2})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_a(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    T_delay=10,
    currentTap(start=0)) annotation (Placement(transformation(extent={{-10,-28},{-28,-10}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_b(
    UseInput=true,
    UseRatio=false,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,8})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_b(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{82,-30},{64,-12}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_c(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={160,2})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L2(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={258,40})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_c(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    currentTap(start=0)) annotation (Placement(transformation(extent={{154,-28},{136,-10}})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L2(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{274,72},{256,88}})));
protected
  TransiEnt.Producer.Electrical.Others.Biomass biomass_G1_Slack(
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    H=11,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    set_P_init=false,
    isPrimaryControlActive=true,
    P_min_star=0.1,
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciter Exciter(
      TA=1,
      KA=80,
      LimitofExcitation=0.6),
    isSecondaryControlActive=true,
    isExternalSecondaryController=true,
    P_el_n(displayUnit="MW") = 3000000000,
    redeclare
      TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex
      Generator(IsSlack=true, R_a=0),
    Turbine(plantDynamic(initOption=3)))
    annotation (Placement(transformation(extent={{-118,36},{-90,64}})));

public
  Modelica.Blocks.Sources.Constant const(k=-biomass_G1_Slack.P_init)
    annotation (Placement(transformation(extent={{-80,86},{-94,100}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=-1.36e5)
                                                            annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-126,80})));
  Modelica.Blocks.Sources.RealExpression globalFrequency_reference(y=simCenter.f_n) annotation (Placement(transformation(extent={{-84,10},
            {-106,22}})));
     TransiEnt.Components.Sensors.ElectricFrequencyComplex globalFrequency annotation (Placement(transformation(extent={{-104,
            -14},{-116,-2}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-122,10},
            {-134,22}})));
protected
  TransiEnt.Producer.Electrical.Others.Biomass biomass_G3(
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    P_init_set=100e6,
    H=11,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    set_P_init=true,
    isPrimaryControlActive=true,
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciter Exciter(LimitofExcitation=0.5),
    isSecondaryControlActive=false,
    isExternalSecondaryController=true,
    P_el_n(displayUnit="MW") = 250000000,
    redeclare
      TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex
      Generator(R_a=0))
    annotation (Placement(transformation(extent={{90,70},{66,94}})));

public
  Modelica.Blocks.Sources.Constant const1(k=-biomass_G3.P_init)
                                                             annotation (Placement(transformation(extent={{116,96},
            {102,110}})));
protected
  TransiEnt.Producer.Electrical.Others.Biomass biomass_G2(
    integrateCDE=true,
    calculateCost=true,
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    P_init_set=50e6,
    H=11,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    set_P_init=true,
    isPrimaryControlActive=true,
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciter Exciter(LimitofExcitation=0.5),
    isSecondaryControlActive=false,
    isExternalSecondaryController=true,
    P_el_n(displayUnit="MW") = 100000000,
    redeclare
      TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex
      Generator(R_a=0))
    annotation (Placement(transformation(extent={{202,62},{224,84}})));

public
  Modelica.Blocks.Sources.Constant const2(k=-biomass_G2.P_init)
                                                             annotation (Placement(transformation(extent={{192,92},
            {206,106}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{14,94},{26,106}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary1(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-24,72},{-40,88}})));
  inner TransiEnt.SimCenter simCenter(
    redeclare TILMedia.VLEFluidTypes.TILMedia_SplineWater fluid1,
    v_n(displayUnit="kV") = 380000,
    tableInterpolationSmoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    ambientConditions(
      redeclare TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind,
      redeclare TransiEnt.Basics.Tables.Ambient.GHI_Hamburg_3600s_2012_TMY globalSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY directSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY diffuseSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_900s_2012 temperature),
    integrateHeatFlow=true)                                                                         annotation (Placement(transformation(extent={{-144,-98},{-124,-78}})));
  Components.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp L1_heating(scalingFactor=30000*1.015, electricBoilerImpedance(v_n=110e3, cosphi=0.866)) annotation (Placement(transformation(extent={{-46,-90},{-26,-70}})));
  Components.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp La_heating(scalingFactor=1.015*15000, electricBoilerImpedance(v_n=110e3, cosphi=0.866)) annotation (Placement(transformation(extent={{14,-64},{34,-44}})));
  Components.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp Lb_heating(scalingFactor=1.015*7.64*15000,electricBoilerImpedance(v_n=110e3, cosphi=0.866)) annotation (Placement(transformation(extent={{106,-62},{126,-42}})));
  Components.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp Lc_heating(scalingFactor=1.015*15000, electricBoilerImpedance(v_n=110e3, cosphi=0.866)) annotation (Placement(transformation(extent={{198,-64},{218,-44}})));
  Components.ClaRa_ElectricHeatSystemBoilerImpedance_scaled_comp L2_heating(scalingFactor=1.015*18750, electricBoilerImpedance(v_n=110e3, cosphi=0.866)) annotation (Placement(transformation(extent={{296,-8},{316,12}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex L1_load(
    P_el_set_const=40.6e6,
    useCosPhi=false,
    Q_el_set=20.3e6,
    v_n=110e3) annotation (Placement(transformation(extent={{-44,-56},{-24,-36}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex La_load(
    P_el_set_const=20.3e6,
    useCosPhi=false,
    Q_el_set=10.15e6,
    v_n=110e3) annotation (Placement(transformation(extent={{16,-30},{36,-10}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Lb_load(
    P_el_set_const=1.015*764e6,
    useCosPhi=false,
    Q_el_set=1.015*382e6,
    v_n=110e3) annotation (Placement(transformation(extent={{104,-28},{124,-8}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Lc_load(
    P_el_set_const=1.015*30e6,
    useCosPhi=false,
    Q_el_set=1.015*15e6,
    v_n=110e3) annotation (Placement(transformation(extent={{194,-28},{214,-8}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex L2_load(
    P_el_set_const=1.015*125e6,
    useCosPhi=false,
    Q_el_set=1.015*75e6,
    v_n=110e3) annotation (Placement(transformation(extent={{298,30},{318,50}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern_2(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000) annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern_1(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000) annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary4(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-50,72},{-66,88}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower_1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 300000) annotation (Placement(transformation(extent={{98,28},{122,52}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower_2(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 300000) annotation (Placement(transformation(extent={{134,28},{158,52}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary3(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{132,68},{118,82}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary5(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{162,72},{146,86}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern_2(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 250000) annotation (Placement(transformation(extent={{208,28},{232,52}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern_1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 250000) annotation (Placement(transformation(extent={{176,28},{200,52}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary2(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{204,2},{188,16}})));
equation
  connect(transmissionLine_CentralFault.epp_p, transmissionLine_Central.epp_p)
    annotation (Line(
      points={{16,74},{6,74},{6,40},{18,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralFault.epp_n, transmissionLine_Central.epp_n)
    annotation (Line(
      points={{36,74},{48,74},{48,40},{38,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L1.RatioOut, Transformer_L1.ratio_set)
    annotation (Line(points={{-92,-50},{-92,-14},{-72,-14}}, color={0,0,127}));
  connect(Transformer_L_a.epp_p, transmissionLine_Central.epp_p) annotation (
      Line(
      points={{-6,12},{-8,12},{-8,40},{18,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_a.RatioOut, Transformer_L_a.ratio_set) annotation (Line(points={{-28,-19},{-40,-19},{-40,8},{-18,8}},
                                                color={0,0,127}));
  connect(Transformer_L_b.epp_p, transmissionLine_Central.epp_n) annotation (
      Line(
      points={{90,18},{90,40},{38,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_b.RatioOut, Transformer_L_b.ratio_set) annotation (Line(points={{64,-21},{56,-21},{56,14},{78,14}},
                                              color={0,0,127}));
  connect(OLTC_L_c.epp, Transformer_L_c.epp_n) annotation (Line(
      points={{154,-19},{160,-19},{160,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_c.RatioOut, Transformer_L_c.ratio_set)
    annotation (Line(points={{136,-19},{136,8},{148,8}}, color={0,0,127}));
  connect(OLTC_L2.RatioOut, Transformer_L2.ratio_set)
    annotation (Line(points={{256,80},{252,80},{252,52}}, color={0,0,127}));
  connect(const.y, biomass_G1_Slack.P_el_set) annotation (Line(points={{-94.7,
          93},{-104,93},{-104,63.86},{-106.1,63.86}}, color={0,0,127}));
  connect(integrator.y, biomass_G1_Slack.P_SB_set) annotation (Line(points={{-117.2,
          80},{-116.46,80},{-116.46,62.46}}, color={0,0,127}));
  connect(globalFrequency_reference.y, feedback.u1)
    annotation (Line(points={{-107.1,16},{-123.2,16}}, color={0,0,127}));
  connect(globalFrequency.f, feedback.u2) annotation (Line(points={{-116.24,-8},
          {-128,-8},{-128,11.2}}, color={0,0,127}));
  connect(feedback.y, integrator.u) annotation (Line(points={{-133.4,16},{-140,
          16},{-140,80},{-135.6,80}}, color={0,0,127}));
  connect(const1.y, biomass_G3.P_el_set) annotation (Line(points={{101.3,103},{
          100,103},{100,102},{90,102},{90,93.88},{79.8,93.88}},
                                                    color={0,0,127}));
  connect(const2.y, biomass_G2.P_el_set) annotation (Line(points={{206.7,99},{
          208,99},{208,100},{218,100},{218,83.89},{211.35,83.89}},
                                                  color={0,0,127}));
  connect(BooleanFault.y, not1.u)
    annotation (Line(points={{6.8,100},{12.8,100}}, color={255,0,255}));
  connect(not1.y, transmissionLine_CentralFault.switched_input) annotation (
      Line(points={{26.6,100},{28,100},{28,84},{26,84}}, color={255,0,255}));
  connect(OLTC_L_a.epp, Transformer_L_a.epp_n) annotation (Line(
      points={{-10,-19},{-10,-19},{-10,-20},{-6,-20},{-6,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L2.epp, Transformer_L2.epp_n) annotation (Line(
      points={{274,80},{280,80},{280,40},{268,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary1.epp, transmissionLine_Central.epp_p) annotation (Line(
      points={{-24,80},{-14,80},{-14,40},{18,40}},
      color={28,108,200},
      thickness=0.5));
  connect(biomass_G3.epp, transmissionLine_Central.epp_n) annotation (Line(
      points={{67.2,90.4},{54,90.4},{54,40},{38,40}},
      color={28,108,200},
      thickness=0.5));
  connect(La_heating.epp, Transformer_L_a.epp_n) annotation (Line(
      points={{14,-54},{0,-54},{0,-20},{-6,-20},{-6,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(Lc_heating.epp, Transformer_L_c.epp_n) annotation (Line(
      points={{198,-54},{160,-54},{160,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(L2_heating.epp, Transformer_L2.epp_n) annotation (Line(
      points={{296,2},{280,2},{280,40},{268,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L1.epp_n, OLTC_L1.epp) annotation (Line(
      points={{-60,-30},{-62,-30},{-62,-50},{-74,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(L1_heating.epp, OLTC_L1.epp) annotation (Line(
      points={{-46,-80},{-62,-80},{-62,-50},{-74,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(L1_load.epp, OLTC_L1.epp) annotation (Line(
      points={{-43.8,-46},{-62,-46},{-62,-50},{-74,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(La_load.epp, Transformer_L_a.epp_n) annotation (Line(
      points={{16.2,-20},{-6,-20},{-6,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(Lb_load.epp, OLTC_L_b.epp) annotation (Line(
      points={{104.2,-18},{94,-18},{94,-21},{82,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_b.epp_n, OLTC_L_b.epp) annotation (Line(
      points={{90,-2},{90,-20},{88,-20},{88,-21},{82,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Lb_heating.epp, OLTC_L_b.epp) annotation (Line(
      points={{106,-52},{90,-52},{90,-21},{82,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Lc_load.epp, Transformer_L_c.epp_n) annotation (Line(
      points={{194.2,-18},{160,-18},{160,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(L2_load.epp, Transformer_L2.epp_n) annotation (Line(
      points={{298.2,40},{268,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_2.epp_p,transmissionLine_Northern_1. epp_n) annotation (Line(
      points={{-40,40},{-50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_1.epp_p, biomass_G1_Slack.epp) annotation (Line(
      points={{-70,40},{-80,40},{-80,59.8},{-91.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary4.epp,transmissionLine_Northern_1. epp_n) annotation (Line(
      points={{-50,80},{-48,80},{-48,40},{-50,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_2.epp_n, transmissionLine_Central.epp_p) annotation (Line(
      points={{-20,40},{-16,40},{-16,42},{-14,42},{-14,40},{18,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L1.epp_p, biomass_G1_Slack.epp) annotation (Line(
      points={{-60,-10},{-60,0},{-80,0},{-80,59.8},{-91.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(globalFrequency.epp, biomass_G1_Slack.epp) annotation (Line(
      points={{-104,-8},{-92,-8},{-92,0},{-80,0},{-80,59.8},{-91.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_2.epp_p,transmissionLine_CentralLower_1. epp_n) annotation (Line(
      points={{134,40},{122,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary3.epp,transmissionLine_CentralLower_1. epp_n) annotation (Line(
      points={{132,75},{132,40},{122,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_1.epp_p, transmissionLine_Central.epp_n) annotation (Line(
      points={{98,40},{38,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary2.epp,transmissionLine_Southern_1. epp_n) annotation (Line(
      points={{204,9},{204,40},{200,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_2.epp_n, transmissionLine_Southern_1.epp_p) annotation (Line(
      points={{158,40},{176,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern_2.epp_n, Transformer_L2.epp_p) annotation (Line(
      points={{232,40},{248,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary5.epp, transmissionLine_Southern_1.epp_p) annotation (Line(
      points={{162,79},{164,79},{164,40},{176,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_c.epp_p, transmissionLine_Southern_1.epp_p) annotation (Line(
      points={{160,12},{162,12},{162,40},{176,40}},
      color={28,108,200},
      thickness=0.5));
  connect(biomass_G2.epp, Transformer_L2.epp_p) annotation (Line(
      points={{222.9,80.7},{240,80.7},{240,40},{248,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern_2.epp_p, transmissionLine_Southern_1.epp_n) annotation (Line(
      points={{208,40},{200,40}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{320,120}}), graphics={Text(
          extent={{6,26},{52,18}},
          lineColor={28,108,200},
          textString="2 parallel AC lines"),                            Text(
          extent={{-136,122},{-50,112}},
          lineColor={28,108,200},
          textString="N5area Test System (NORDIC 32 adoptation)")}),
    Icon(coordinateSystem(extent={{-160,-100},{320,120}})),
    experiment(
      StartTime=2360000,
      StopTime=2402000,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(extent={{-160,-100},{320,120}}), graphics={Text(
          extent={{6,26},{52,18}},
          lineColor={28,108,200},
          textString="2 parallel AC lines"),                            Text(
          extent={{-136,122},{-50,112}},
          lineColor={28,108,200},
          textString="N5area Test System (NORDIC 32 adoptation)")}),
    Icon(coordinateSystem(extent={{-160,-100},{320,120}})),
    experiment(
      StartTime=2360000,
      StopTime=2401500,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end IES_EBoiler_lfail_real;
