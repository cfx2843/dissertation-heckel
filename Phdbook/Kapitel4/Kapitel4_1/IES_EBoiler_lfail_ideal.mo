within Phdbook.Kapitel4.Kapitel4_1;
model IES_EBoiler_lfail_ideal

  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-114,-98},{-94,-78}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Central(
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000)
    annotation (Placement(transformation(extent={{14,30},{34,50}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralFault(
    activateSwitch=true,
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,
    l(displayUnit="km") = 200000)
    annotation (Placement(transformation(extent={{12,64},{32,84}})));
  Modelica.Blocks.Sources.BooleanStep  BooleanFault(startTime(displayUnit="s") = 2400400)
    annotation (Placement(transformation(extent={{-14,92},{2,108}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L1(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-64,-20})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L1(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{-78,-58},{-96,-42}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_a(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-10,2})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_a(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    T_delay=10,
    currentTap(start=0)) annotation (Placement(transformation(extent={{-14,-28},{-32,-10}})));
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
        origin={86,8})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_b(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{78,-30},{60,-12}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_c(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={156,2})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L2(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={254,40})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_c(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    currentTap(start=0)) annotation (Placement(transformation(extent={{150,-28},{132,-10}})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L2(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{270,72},{252,88}})));
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
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(IsSlack=true, R_a=0),
    Turbine(plantDynamic(initOption=3)))
    annotation (Placement(transformation(extent={{-122,36},{-94,64}})));
public
  Modelica.Blocks.Sources.Constant const(k=-biomass_G1_Slack.P_init)
    annotation (Placement(transformation(extent={{-84,86},{-98,100}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=-1.36e5)
                                                            annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-130,80})));
  Modelica.Blocks.Sources.RealExpression globalFrequency_reference(y=simCenter.f_n) annotation (Placement(transformation(extent={{-88,10},{-110,22}})));
     TransiEnt.Components.Sensors.ElectricFrequencyComplex globalFrequency annotation (Placement(transformation(extent={{-108,-14},{-120,-2}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-126,10},{-138,22}})));
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
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(R_a=0))
    annotation (Placement(transformation(extent={{86,70},{62,94}})));
public
  Modelica.Blocks.Sources.Constant const1(k=-biomass_G3.P_init)
                                                             annotation (Placement(transformation(extent={{112,96},{98,110}})));
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
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(R_a=0))
    annotation (Placement(transformation(extent={{198,62},{220,84}})));
public
  Modelica.Blocks.Sources.Constant const2(k=-biomass_G2.P_init)
                                                             annotation (Placement(transformation(extent={{188,92},{202,106}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{10,94},{22,106}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary1(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-28,72},{-44,88}})));
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
    integrateHeatFlow=true)                                                                         annotation (Placement(transformation(extent={{-148,-98},{-128,-78}})));
  Components.ClaRa_ElectricHeatSystemBoiler_Ideal L1_heating(scalingFactor=30000*1.015) annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
  Components.ClaRa_ElectricHeatSystemBoiler_Ideal La_heating(scalingFactor=1.015*15000) annotation (Placement(transformation(extent={{10,-64},{30,-44}})));
  Components.ClaRa_ElectricHeatSystemBoiler_Ideal Lb_heating(scalingFactor=1.02*7.64*15000) annotation (Placement(transformation(extent={{102,-62},{122,-42}})));
  Components.ClaRa_ElectricHeatSystemBoiler_Ideal Lc_heating(scalingFactor=1.015*15000) annotation (Placement(transformation(extent={{194,-64},{214,-44}})));
  Components.ClaRa_ElectricHeatSystemBoiler_Ideal L2_heating(scalingFactor=1.015*18750) annotation (Placement(transformation(extent={{292,-8},{312,12}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex L1_load(
    P_el_set_const=40.6e6,
    useCosPhi=false,
    Q_el_set=20.3e6,
    v_n=110e3) annotation (Placement(transformation(extent={{-48,-56},{-28,-36}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex La_load(
    P_el_set_const=20.3e6,
    useCosPhi=false,
    Q_el_set=10.15e6,
    v_n=110e3) annotation (Placement(transformation(extent={{12,-30},{32,-10}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Lb_load(
    P_el_set_const=1.02*764e6,
    useCosPhi=false,
    Q_el_set=1.02*382e6,
    v_n=110e3) annotation (Placement(transformation(extent={{100,-28},{120,-8}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Lc_load(
    P_el_set_const=1.015*30e6,
    useCosPhi=false,
    Q_el_set=1.015*15e6,
    v_n=110e3) annotation (Placement(transformation(extent={{190,-28},{210,-8}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex L2_load(
    P_el_set_const=1.015*125e6,
    useCosPhi=false,
    Q_el_set=1.015*75e6,
    v_n=110e3) annotation (Placement(transformation(extent={{294,30},{314,50}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern_2(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000) annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern_1(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 200000) annotation (Placement(transformation(extent={{-74,30},{-54,50}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary4(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-54,72},{-70,88}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower_1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 300000) annotation (Placement(transformation(extent={{94,28},{118,52}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower_2(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 300000) annotation (Placement(transformation(extent={{130,28},{154,52}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary3(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{128,68},{114,82}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary5(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{158,72},{142,86}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern_2(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 250000) annotation (Placement(transformation(extent={{204,28},{228,52}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern_1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 250000) annotation (Placement(transformation(extent={{172,28},{196,52}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary2(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{200,2},{184,16}})));
equation
  connect(transmissionLine_CentralFault.epp_p,transmissionLine_Central. epp_p)
    annotation (Line(
      points={{12,74},{2,74},{2,40},{14,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralFault.epp_n,transmissionLine_Central. epp_n)
    annotation (Line(
      points={{32,74},{44,74},{44,40},{34,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L1.RatioOut,Transformer_L1. ratio_set)
    annotation (Line(points={{-96,-50},{-96,-14},{-76,-14}}, color={0,0,127}));
  connect(Transformer_L_a.epp_p,transmissionLine_Central. epp_p) annotation (
      Line(
      points={{-10,12},{-12,12},{-12,40},{14,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_a.RatioOut,Transformer_L_a. ratio_set) annotation (Line(points={{-32,-19},{-44,-19},{-44,8},{-22,8}},
                                                color={0,0,127}));
  connect(Transformer_L_b.epp_p,transmissionLine_Central. epp_n) annotation (
      Line(
      points={{86,18},{86,40},{34,40}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_b.RatioOut,Transformer_L_b. ratio_set) annotation (Line(points={{60,-21},{52,-21},{52,14},{74,14}},
                                              color={0,0,127}));
  connect(OLTC_L_c.epp,Transformer_L_c. epp_n) annotation (Line(
      points={{150,-19},{156,-19},{156,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_c.RatioOut,Transformer_L_c. ratio_set)
    annotation (Line(points={{132,-19},{132,8},{144,8}}, color={0,0,127}));
  connect(OLTC_L2.RatioOut,Transformer_L2. ratio_set)
    annotation (Line(points={{252,80},{248,80},{248,52}}, color={0,0,127}));
  connect(const.y,biomass_G1_Slack. P_el_set) annotation (Line(points={{-98.7,93},{-108,93},{-108,63.86},{-110.1,63.86}},
                                                      color={0,0,127}));
  connect(integrator.y,biomass_G1_Slack. P_SB_set) annotation (Line(points={{-121.2,80},{-120.46,80},{-120.46,62.46}},
                                             color={0,0,127}));
  connect(globalFrequency_reference.y,feedback. u1)
    annotation (Line(points={{-111.1,16},{-127.2,16}}, color={0,0,127}));
  connect(globalFrequency.f,feedback. u2) annotation (Line(points={{-120.24,-8},{-132,-8},{-132,11.2}},
                                  color={0,0,127}));
  connect(feedback.y,integrator. u) annotation (Line(points={{-137.4,16},{-144,16},{-144,80},{-139.6,80}},
                                      color={0,0,127}));
  connect(const1.y,biomass_G3. P_el_set) annotation (Line(points={{97.3,103},{96,103},{96,102},{86,102},{86,93.88},{75.8,93.88}},
                                                    color={0,0,127}));
  connect(const2.y,biomass_G2. P_el_set) annotation (Line(points={{202.7,99},{204,99},{204,100},{214,100},{214,83.89},{207.35,83.89}},
                                                  color={0,0,127}));
  connect(BooleanFault.y,not1. u)
    annotation (Line(points={{2.8,100},{8.8,100}},  color={255,0,255}));
  connect(not1.y,transmissionLine_CentralFault. switched_input) annotation (
      Line(points={{22.6,100},{24,100},{24,84},{22,84}}, color={255,0,255}));
  connect(OLTC_L_a.epp,Transformer_L_a. epp_n) annotation (Line(
      points={{-14,-19},{-14,-20},{-10,-20},{-10,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L2.epp,Transformer_L2. epp_n) annotation (Line(
      points={{270,80},{276,80},{276,40},{264,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary1.epp,transmissionLine_Central. epp_p) annotation (Line(
      points={{-28,80},{-18,80},{-18,40},{14,40}},
      color={28,108,200},
      thickness=0.5));
  connect(biomass_G3.epp,transmissionLine_Central. epp_n) annotation (Line(
      points={{63.2,90.4},{50,90.4},{50,40},{34,40}},
      color={28,108,200},
      thickness=0.5));
  connect(La_heating.epp,Transformer_L_a. epp_n) annotation (Line(
      points={{10,-54},{-4,-54},{-4,-20},{-10,-20},{-10,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(Lc_heating.epp,Transformer_L_c. epp_n) annotation (Line(
      points={{194,-54},{156,-54},{156,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(L2_heating.epp,Transformer_L2. epp_n) annotation (Line(
      points={{292,2},{276,2},{276,40},{264,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L1.epp_n,OLTC_L1. epp) annotation (Line(
      points={{-64,-30},{-66,-30},{-66,-50},{-78,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(L1_heating.epp,OLTC_L1. epp) annotation (Line(
      points={{-50,-80},{-66,-80},{-66,-50},{-78,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(L1_load.epp,OLTC_L1. epp) annotation (Line(
      points={{-47.8,-46},{-66,-46},{-66,-50},{-78,-50}},
      color={28,108,200},
      thickness=0.5));
  connect(La_load.epp,Transformer_L_a. epp_n) annotation (Line(
      points={{12.2,-20},{-10,-20},{-10,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(Lb_load.epp,OLTC_L_b. epp) annotation (Line(
      points={{100.2,-18},{90,-18},{90,-21},{78,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_b.epp_n,OLTC_L_b. epp) annotation (Line(
      points={{86,-2},{86,-20},{84,-20},{84,-21},{78,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Lb_heating.epp,OLTC_L_b. epp) annotation (Line(
      points={{102,-52},{86,-52},{86,-21},{78,-21}},
      color={28,108,200},
      thickness=0.5));
  connect(Lc_load.epp,Transformer_L_c. epp_n) annotation (Line(
      points={{190.2,-18},{156,-18},{156,-8}},
      color={28,108,200},
      thickness=0.5));
  connect(L2_load.epp,Transformer_L2. epp_n) annotation (Line(
      points={{294.2,40},{264,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_2.epp_p,transmissionLine_Northern_1. epp_n) annotation (Line(
      points={{-44,40},{-54,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_1.epp_p,biomass_G1_Slack. epp) annotation (Line(
      points={{-74,40},{-84,40},{-84,59.8},{-95.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary4.epp,transmissionLine_Northern_1. epp_n) annotation (Line(
      points={{-54,80},{-52,80},{-52,40},{-54,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern_2.epp_n,transmissionLine_Central. epp_p) annotation (Line(
      points={{-24,40},{-20,40},{-20,42},{-18,42},{-18,40},{14,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L1.epp_p,biomass_G1_Slack. epp) annotation (Line(
      points={{-64,-10},{-64,0},{-84,0},{-84,59.8},{-95.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(globalFrequency.epp,biomass_G1_Slack. epp) annotation (Line(
      points={{-108,-8},{-96,-8},{-96,0},{-84,0},{-84,59.8},{-95.4,59.8}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_2.epp_p,transmissionLine_CentralLower_1. epp_n) annotation (Line(
      points={{130,40},{118,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary3.epp,transmissionLine_CentralLower_1. epp_n) annotation (Line(
      points={{128,75},{128,40},{118,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_1.epp_p,transmissionLine_Central. epp_n) annotation (Line(
      points={{94,40},{34,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary2.epp,transmissionLine_Southern_1. epp_n) annotation (Line(
      points={{200,9},{200,40},{196,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower_2.epp_n,transmissionLine_Southern_1. epp_p) annotation (Line(
      points={{154,40},{172,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern_2.epp_n,Transformer_L2. epp_p) annotation (Line(
      points={{228,40},{244,40}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary5.epp,transmissionLine_Southern_1. epp_p) annotation (Line(
      points={{158,79},{160,79},{160,40},{172,40}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_c.epp_p,transmissionLine_Southern_1. epp_p) annotation (Line(
      points={{156,12},{158,12},{158,40},{172,40}},
      color={28,108,200},
      thickness=0.5));
  connect(biomass_G2.epp,Transformer_L2. epp_p) annotation (Line(
      points={{218.9,80.7},{236,80.7},{236,40},{244,40}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern_2.epp_p,transmissionLine_Southern_1. epp_n) annotation (Line(
      points={{204,40},{196,40}},
      color={28,108,200},
      thickness=0.5));
  annotation (
    Diagram(coordinateSystem(extent={{-160,-100},{320,120}}), graphics={Text(
          extent={{2,26},{48,18}},
          lineColor={28,108,200},
          textString="2 parallel AC lines"),                            Text(
          extent={{-140,122},{-54,112}},
          lineColor={28,108,200},
          textString="N5area Test System (NORDIC 32 adoptation)")}),
    Icon(coordinateSystem(extent={{-160,-100},{320,120}})),
    experiment(
      StartTime=2360000,
      StopTime=2401500,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end IES_EBoiler_lfail_ideal;
