within Phdbook.Kapitel6.Kapitel6_2;
model IES_MA_50_50_CHPfail_DGneuload
protected
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-252,122},{-224,150}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Central(
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-118,126},{-98,146}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralFault(
    activateSwitch=true,
    ChooseVoltageLevel=3,
    p=2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L4,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-122,152},{-102,172}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-16,124},{8,148}})));
public
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{132,124},{156,148}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L1(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-262,76})));
protected
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L1(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{-276,38},{-294,54}})));
public
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_a(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-144,98})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_a(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    T_delay=10,
    currentTap(start=7)) annotation (Placement(transformation(extent={{-152,68},{-170,86}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_b(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-36,80})));
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_b(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{-42,52},{-60,70}})));
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L_c(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={122,106})));
protected
  TransiEnt.Components.Electrical.PowerTransformation.SimpleTransformerComplex Transformer_L2(
    UseInput=true,
    U_P(displayUnit="kV") = 380000,
    U_S(displayUnit="kV") = 110000,
    P_p(displayUnit="MW", start=15000000),
    P_n(displayUnit="MW", start=-15000000)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={190,136})));
public
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L_c(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000,
    currentTap(start=-11)) annotation (Placement(transformation(extent={{114,76},{96,94}})));
protected
  TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController OLTC_L2(
    numberTaps=11,
    v_prim_n(displayUnit="kV") = 380000,
    v_sec_n(displayUnit="kV") = 110000) annotation (Placement(transformation(extent={{206,168},{188,184}})));
public
  TransiEnt.Producer.Electrical.Others.Biomass biomass_G1_Slack(
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    H=11,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    set_P_init=false,
    isPrimaryControlActive=true,
    P_min_star=0.1,
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciterWithOEL Exciter(oEL_summation(
        VfLimit=simCenter.v_n,
        L1=-20e3,
        L2=30e3,
        L3=380e3,
        K1=1,
        K3=0.01)),
    isSecondaryControlActive=true,
    isExternalSecondaryController=true,
    P_el_n(displayUnit="MW") = 3000000000,
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(IsSlack=true, R_a=0))
    annotation (Placement(transformation(extent={{-322,132},{-294,160}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=-1.36e7)
                                                            annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=0,
        origin={-364,164})));
  Modelica.Blocks.Sources.RealExpression globalFrequency_reference(y=simCenter.f_n) annotation (Placement(transformation(extent={{-286,106},{-308,118}})));
     TransiEnt.Components.Sensors.ElectricFrequencyComplex globalFrequency annotation (Placement(transformation(extent={{-306,82},{-318,94}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-324,106},{-336,118}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-122,182},{-110,194}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary1(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-154,160},{-170,176}})));
protected
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary2(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-14,156},{-34,174}})));
public
  Modelica.Blocks.Sources.Step bioinput(
    height=biomass_G1_Slack.P_init,
    offset=-biomass_G1_Slack.P_init,
    startTime=100000) annotation (Placement(transformation(extent={{-348,194},{-328,214}})));
protected
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Southern1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K1,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=90,
        origin={164,6})));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=false, fixedSeed=112981042)
                                                    annotation (Placement(transformation(extent={{112,210},{132,230}})));
public
  inner TransiEnt.SimCenter simCenter(
    redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_NG7_H2_SRK_var gasModel1,
    p_eff_2=1150000,
    tableInterpolationSmoothness=Modelica.Blocks.Types.Smoothness.MonotoneContinuousDerivative2,
    useHomotopy=true,
    v_n=380e3,
    ambientConditions(
      redeclare TransiEnt.Basics.Tables.Ambient.GHI_Hamburg_3600s_2012_TMY globalSolarRadiation(startTime=0),
      redeclare TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY directSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY diffuseSolarRadiation,
      redeclare TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_Fuhlsbuettel_3600s_2012 temperature,
      redeclare TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_3600s_TMY wind))                                annotation (Placement(transformation(extent={{144,212},{164,232}})));
protected
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{174,212},{194,232}})));
public
  TransiEnt.Producer.Combined.LargeScaleCHP.CHP CHP(
    PQCharacteristics=TransiEnt.Producer.Combined.LargeScaleCHP.Base.Characteristics.PQ_Characteristics_WW1(),
    P_el_n(displayUnit="W") = 50e6,
    Q_flow_n_CHP(displayUnit="MW") = 40000000,
    P_el_init=0,
    useConstantEfficiencies=false,
    integrateHeatFlow=false,
    integrateElectricPower=false,
    integrateElectricPowerChp=false,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    isPrimaryControlActive=true,
    isSecondaryControlActive=true,
    isExternalSecondaryController=true,
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    m_flow_nom=ScaleFactor.k/4200/20,
    useGasPort=true,
    usePowerBoundary=false,
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(R_a=0),
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.DCExciterWithOEL Exciter(oEL_summation(
        VfLimit=simCenter.v_n,
        L1=-20e3,
        L2=30e3,
        L3=380e3,
        K1=1,
        K3=0.01))) "Stromgesteuerte KWK zur Kogeneration von Wärme und Strom"                                                            annotation (Placement(transformation(extent={{52,-136},{102,-84}})));
  Modelica.Blocks.Sources.Step chpinput(
    height=0,
    offset=0,
    startTime=100)    annotation (Placement(transformation(extent={{82,8},{102,28}})));
protected
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_Northern1(
    ChooseVoltageLevel=3,
    p=2,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{-198,122},{-170,150}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary3(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{-222,176},{-238,192}})));
public
  TransiEnt.Producer.Gas.Electrolyzer.PEMElectrolyzer_L1 electrolyzer(
    usePowerPort=true,
    P_el_n=100e6,                                                     redeclare TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary powerBoundary(useInputConnectorQ=false), whichInput=1,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp) "Der Elektrolyseur wird bei Überfrequenzen aktiviert, sodass er zur Stabilisierung der Netzfrequenz beiträgt."
                                                                                                                                                                  annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-120,-2})));
  TransiEnt.Components.Gas.VolumesValvesFittings.Fittings.RealGasJunction_L2_isoth junction_FIS(volume=150) annotation (Placement(transformation(extent={{-130,-75},{-110,-95}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryRealGas_pTxi boundary_pTxi "Konstante Gasquelle"
                                                                         annotation (Placement(transformation(extent={{-212,-94},{-192,-74}})));
  TransiEntDevZone.Sketchbook.jh.AdditionalComponentModels.DynamicExponentialElectricConsumerComplex_Frequency
                                                                          L1(
    Tp=60,
    Tq=30,
    alpha_s=0.1,
    alpha_t=2.26,
    beta_s=0.6,
    beta_t=2.5,
    kpf=2.6,
    kqf=1.6,
    v_n(displayUnit="kV") = 110000,
    P_n(displayUnit="MW") = 203000000,
    Q_n=101.5e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-262,-6})));
  TransiEntDevZone.Sketchbook.jh.AdditionalComponentModels.DynamicExponentialElectricConsumerComplex_Frequency
                                                                          La(
    Tp=60,
    Tq=30,
    alpha_s=0.1,
    alpha_t=2.26,
    beta_s=0.6,
    beta_t=2.5,
    kpf=2.6,
    kqf=1.6,
    v_n(displayUnit="kV") = 110000,
    P_n(displayUnit="MW") = 101500000,
    Q_n=50.75e6) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-144,44})));
  TransiEntDevZone.Sketchbook.jh.AdditionalComponentModels.DynamicExponentialElectricConsumerComplex_Frequency
                                                                          Lb(
    Tp=60,
    Tq=30,
    alpha_s=0.1,
    alpha_t=2.26,
    beta_s=0.6,
    beta_t=10,
    kpf=2.6,
    kqf=1.6,
    v_n(displayUnit="kV") = 110000,
    P_n(displayUnit="MW") = 1522500000,
    Q_n=558.25e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-36,12})));
  Phdbook.Kapitel4.N5areaLoadTest.Components.ClaRa_HeatpumpCharline_Speicher_Real L2(scalingFactor=1.015*18750, PID_CHP1(ramp(duration=50000, startTime=10000))) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={212,104})));
  Modelica.Blocks.Sources.RealExpression SetPower1(y=max(0, -5e8*(50 - CHP.epp.f))) "P-Einstellung anhand von Überfrequenzen"                                                                             annotation (Placement(transformation(extent={{-208,-8},{-188,12}})));
protected
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced transmissionLine_CentralLower1(
    activateSwitch=false,
    ChooseVoltageLevel=3,
    p=2,
    LVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.LVCabletypes.K2,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    HVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.HVCabletypes.L6,
    l(displayUnit="km") = 150000)
    annotation (Placement(transformation(extent={{44,124},{68,148}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary pQBoundary4(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    v_n(displayUnit="kV") = 380000)
                                   annotation (Placement(transformation(extent={{90,158},{70,176}})));
  Modelica.Blocks.Logical.Switch switch1 "Schalter zum Ausschalten der Wärmestromversorgung in der KWK"
                                         annotation (Placement(transformation(extent={{120,-48},{140,-28}})));
public
  TransiEnt.Producer.Heat.Power2Heat.ElectricBoiler.ElectricBoiler electricBoiler(
    Q_flow_n(displayUnit="MW") = 25000000,
    usePowerPort=true,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    redeclare TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary powerBoundary(
      useInputConnectorP=true,
      P_el_set_const(displayUnit="MW") = 100000000,
      useInputConnectorQ=false,
      cosphi_boundary=1,
      v_n=110e3) "Power Boundary for ComplexPowerPort",
    redeclare TransiEnt.Components.Boundaries.Heat.Heatflow_L1 heatFlowBoundary) annotation (Placement(transformation(extent={{238,-206},{218,-226}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempAfterCons annotation (Placement(transformation(extent={{-130,-234},{-110,-218}})));
  TransiEnt.Components.Sensors.TemperatureSensor tempBeforeCons annotation (Placement(transformation(extent={{-44,-204},{-60,-188}})));
  ClaRa.Basics.ControlVolumes.FluidVolumes.VolumeVLE_2 hEXHeatCons(
    redeclare model HeatTransfer = TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.HeatTransfer_EN442 (
        T_mean_supply=353.15,
        DT_nom=30,
        Q_flow_nom=ScaleFactor.k,
        T_air_nom=295.15),
    redeclare model PressureLoss = ClaRa.Basics.ControlVolumes.Fundamentals.PressureLoss.Generic_PL.LinearPressureLoss_L2,
    redeclare model Geometry = ClaRa.Basics.ControlVolumes.Fundamentals.Geometry.GenericGeometry (volume=1*ScaleFactor.k/1.81e6),
    m_flow_nom=ScaleFactor.k/4200/30,
    h_start=291204,
    p_start=6.0276e5,
    initOption=0) annotation (Placement(transformation(extent={{-140,-214},{-160,-194}})));
protected
  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpGrid(presetVariableType="m_flow", m_flowInput=true) "Steuerung des Masseflusses zum Wärmeverbraucher."
                                                                                                      annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-92,-204})));
  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpProd(presetVariableType="m_flow", m_flowInput=true) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={84,-235})));
  TransiEnt.Storage.Heat.HotWaterStorage_constProp_L4.HotWaterStorage_constProp_L4 hotWaterStorage(
    V=ScaleFactor.k*1*3600/(hotWaterStorage.c_v*hotWaterStorage.rho*(90 - 60)),
    h=(hotWaterStorage.V*4*5^2/Modelica.Constants.pi)^(1/3),
    n_prodIn=2,
    T_start(displayUnit="degC") = {358.15,358.15,358.15,358.15,343.25}) "Wärmespeicher mit der Kapazität den Nennwärmestrom der KWK über 2 Stunden zu versorgen."
                                                                        annotation (Placement(transformation(
        extent={{13,-12},{-13,12}},
        rotation=0,
        origin={13,-230})));
public
  TransiEnt.Components.Heat.Grid.IdealizedExpansionVessel idealizedExpansionVessel1(p(displayUnit="bar") = 600000) annotation (Placement(transformation(extent={{-12,-196},{2,-180}})));
protected
  ClaRa.Components.VolumesValvesFittings.Valves.ThreeWayValveVLE_L1_simple tWV(splitRatio_input=true) annotation (Placement(transformation(extent={{-34,-226},{-18,-242}})));
  ClaRa.Components.VolumesValvesFittings.Fittings.JoinVLE_L2_Y joinGrid(
    volume=0.1*ScaleFactor.k/1.81e6,
    m_flow_in_nom={ScaleFactor.k/4200/30,ScaleFactor.k/4200/30},
    h_start=356128,
    redeclare model PressureLossIn1 = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    redeclare model PressureLossIn2 = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    redeclare model PressureLossOut = ClaRa.Components.VolumesValvesFittings.Fittings.Fundamentals.NoFriction,
    p_start=6e5) annotation (Placement(transformation(extent={{-18,-196},{-36,-212}})));
public
  TransiEnt.Components.Heat.HeatFlowMultiplier heatFlowMultiplier1(factor=ScaleFactor.k/4793.46) "Skalierung des Wärmestroms auf den Verbrauch eines Gebäudes."
                                                                                                 annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-150,-180})));
 TransiEnt.Basics.Blocks.LimPID PID_TWV(
    Tau_d=0,
    initOption=503,
    y_max=1,
    y_min=0,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=10,
    Tau_i=0.01,
    y_start=1,
    y_inactive=0) "Regelung der Mischverhältnisse von Vor- und Rücklauftemperaturen."
                  annotation (Placement(transformation(extent={{-52,-269},{-34,-251}})));
  TransiEnt.Basics.Blocks.LimPID PID_PumpGrid(
    u_ref=22 + 273.15,
    y_ref=PID_PumpGrid.y_max,
    Tau_d=0,
    initOption=503,
    y_max=ScaleFactor.k/4200/30,
    y_min=1e-2,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=1000,
    Tau_i=1000,
    y_start=1,
    y_inactive=0) annotation (Placement(transformation(extent={{-104,-180},{-92,-168}})));
  Modelica.Blocks.Sources.RealExpression setValueTemperature(y=273.15 + 22) annotation (Placement(transformation(extent={{-132,-184},{-112,-164}})));
  Modelica.Blocks.Sources.RealExpression set_m_flow_pump(y=max(0, -6e3*(50 - CHP.epp.f)))
                                                                                     annotation (Placement(transformation(extent={{314,-256},{294,-236}})));
protected
  TransiEnt.Basics.Tables.HeatGrid.HeatingCurves.HeatingCurve_FromDataPath heatingCurve(datapath="heat/HeatingCurve_80_60.txt") annotation (Placement(transformation(extent={{-110,-274},{-90,-254}})));
public
  TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.ThermalHeatConsumer_L3 thermalHeatConsumer_CHP(
    T_start(displayUnit="degC") = 295.13,
    k_Win=1.3,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Ext matLayExt,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Flo matLayFlo,
    redeclare TransiEnt.Consumer.Heat.ThermalHeatConsumer_L3.Base.ConstructionData.EnEV_Roof matLayRoof) annotation (Placement(transformation(
        extent={{-11,-8},{11,8}},
        rotation=180,
        origin={-161,-160})));
  Modelica.Blocks.Sources.Constant ScaleFactor(k=CHP.Q_flow_n_CHP)              annotation (Placement(transformation(extent={{-200,-260},{-180,-240}})));
protected
  TransiEnt.Components.Heat.PumpVLE_L1_simple pumpProd1(presetVariableType="m_flow", m_flowInput=true)
                                                                                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={228,-269})));
public
  Modelica.Blocks.Sources.RealExpression set_m_flow_pump2(y=CHP.m_flow_nom)          annotation (Placement(transformation(extent={{-48,-162},{-28,-142}})));
   TransiEnt.Basics.Blocks.LimPID PID_CHP(
    u_ref=273.15 + 85,
    y_ref=ScaleFactor.k,
    Tau_d=0,
    initOption=503,
    y_max=ScaleFactor.k,
    y_min=0,
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=100,
    Tau_i=0.01,
    y_start=1,
    y_inactive=0) "Regelung des produzierten Wärmestroms in der CHP nhand der Temperatur im Speicher."
                  annotation (Placement(transformation(extent={{20,34},{36,50}})));
  Modelica.Blocks.Sources.RealExpression meas_temperature_storage(y=hotWaterStorage.controlVolume[1].T) annotation (Placement(transformation(extent={{-12,13},{8,34}})));
  Modelica.Blocks.Sources.RealExpression set_temperature_storage(y=273.15 + 85) annotation (Placement(transformation(extent={{-14,30},{6,54}})));
  Modelica.Blocks.Math.Gain gain_CHP(k=-1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={64,42})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(
    width=5,
    period=72000,
    startTime=1000000000) annotation (Placement(transformation(extent={{-190,182},{-170,202}})));
  TransiEnt.Components.Sensors.RealGas.GCVSensor gCVSensor_boundary annotation (Placement(transformation(extent={{-172,-84},{-152,-64}})));
  TransiEnt.Components.Sensors.RealGas.GCVSensor gCVSensor_electrolyzer annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-110,-56})));
  TransiEnt.Components.Sensors.RealGas.GCVSensor gCVSensor_chp annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-48,-76})));
  Modelica.Blocks.Sources.RealExpression SetPower2(y=max(0, -125e6*(50 - CHP.epp.f)))
                                                                                    "P-Einstellung anhand von Überfrequenzen"                                                                             annotation (Placement(transformation(extent={{138,-198},{158,-178}})));
  Modelica.Blocks.Math.Gain gain_CHP1(k=-1)
                                           annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={182,-188})));
  TransiEnt.Producer.Electrical.Others.Biomass biomass_G3(
    primaryBalancingController(maxGradientPrCtrl=0.03/30, maxValuePrCtrl=0.03),
    H=11,
    redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp,
    set_P_init=true,
    isPrimaryControlActive=true,
    redeclare TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.SimpleExcitationSystemWithOEL Exciter(oEL_summation(
        VfLimit=simCenter.v_n,
        L1=-20e3,
        L2=30e3,
        L3=380e3,
        K1=1,
        K3=0.01)),
    isSecondaryControlActive=false,
    isExternalSecondaryController=true,
    P_el_n(displayUnit="MW") = 50000000,
    redeclare TransiEnt.Components.Electrical.Machines.SynchronousMachineComplex Generator(R_a=0))
    annotation (Placement(transformation(extent={{-32,202},{-56,226}})));
  Modelica.Blocks.Sources.Pulse    pulse(
    amplitude=biomass_G3.P_init,
    width=25,
    period=100000,
    offset=-biomass_G3.P_init,
    startTime=7000000000)                                    annotation (Placement(transformation(extent={{-6,228},{-20,242}})));
  TransiEntDevZone.Sketchbook.jh.AdditionalComponentModels.DynamicExponentialElectricConsumerComplex_Frequency
                                                                          Lc(
    Tp=60,
    Tq=30,
    alpha_s=0.1,
    alpha_t=2.26,
    beta_s=0.6,
    beta_t=2,
    kpf=2.6,
    kqf=1.6,
    v_n(displayUnit="kV") = 110000,
    Q_n=50.75e6,
    P_n(displayUnit="MW") = 100500000) annotation (Placement(transformation(
        extent={{-11,-11},{11,11}},
        rotation=-90,
        origin={121,49})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-70e6,
    duration=5000,
    offset=-30e6,
    startTime=0) annotation (Placement(transformation(extent={{-48,-42},{-28,-22}})));
  Modelica.Blocks.Logical.Switch switch2 "Schalter zum Ausschalten der Wärmestromversorgung in der KWK"
                                         annotation (Placement(transformation(extent={{28,-38},{48,-18}})));
  Modelica.Blocks.Sources.BooleanPulse BooleanFault2(
    width=25,
    period=100000,
    startTime(displayUnit="s") = 7000)
    annotation (Placement(transformation(extent={{-8,-60},{8,-44}})));
  Modelica.Blocks.Sources.Step chpinput1(
    height=0,
    offset=0,
    startTime=100)    annotation (Placement(transformation(extent={{-14,-18},{6,2}})));
  Modelica.Blocks.Sources.BooleanPulse BooleanFault3(
    width=25,
    period=100000,
    startTime(displayUnit="s") = 7000)
    annotation (Placement(transformation(extent={{84,-32},{100,-16}})));
protected
  TransiEnt.Basics.Adapters.Gas.RealH2_to_RealNG h2toNG                         annotation (Placement(transformation(
        extent={{8,-8},{-8,8}},
        rotation=90,
        origin={-120,-26})));
equation
  connect(transmissionLine_CentralFault.epp_p,transmissionLine_Central. epp_p)
    annotation (Line(
      points={{-122,162},{-130,162},{-130,136},{-118,136}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralFault.epp_n,transmissionLine_Central. epp_n)
    annotation (Line(
      points={{-102,162},{-88,162},{-88,136},{-98,136}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_CentralLower.epp_p,transmissionLine_Central. epp_n)
    annotation (Line(
      points={{-16,136},{-98,136}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L1.epp_p,transmissionLine_Northern. epp_p) annotation (
      Line(
      points={{-262,86},{-262,136},{-252,136}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L1.RatioOut,Transformer_L1. ratio_set)
    annotation (Line(points={{-294,46},{-294,82},{-274,82}}, color={0,0,127}));
  connect(Transformer_L_a.epp_p,transmissionLine_Central. epp_p) annotation (
      Line(
      points={{-144,108},{-144,136},{-118,136}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_a.RatioOut,Transformer_L_a. ratio_set) annotation (Line(points={{-170,77},{-176,77},{-176,104},{-156,104}},
                                                color={0,0,127}));
  connect(Transformer_L_b.epp_p,transmissionLine_Central. epp_n) annotation (
      Line(
      points={{-36,90},{-36,136},{-98,136}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_b.RatioOut,Transformer_L_b. ratio_set) annotation (Line(points={{-60,61},{-62,61},{-62,86},{-48,86}},
                                              color={0,0,127}));
  connect(OLTC_L_c.epp,Transformer_L_c. epp_n) annotation (Line(
      points={{114,85},{122,85},{122,96}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L_c.RatioOut,Transformer_L_c. ratio_set)
    annotation (Line(points={{96,85},{96,112},{110,112}},color={0,0,127}));
  connect(OLTC_L2.RatioOut,Transformer_L2. ratio_set)
    annotation (Line(points={{188,176},{184,176},{184,148}},
                                                          color={0,0,127}));
  connect(Transformer_L2.epp_p,transmissionLine_Southern. epp_n) annotation (
      Line(
      points={{180,136},{156,136}},
      color={28,108,200},
      thickness=0.5));
  connect(biomass_G1_Slack.epp,transmissionLine_Northern. epp_p) annotation (
      Line(
      points={{-295.4,155.8},{-286.5,155.8},{-286.5,136},{-252,136}},
      color={28,108,200},
      thickness=0.5));
  connect(integrator.y,biomass_G1_Slack. P_SB_set) annotation (Line(points={{-355.2,164},{-320.46,164},{-320.46,158.46}},
                                             color={0,0,127}));
  connect(globalFrequency.epp,transmissionLine_Northern. epp_p) annotation (
      Line(
      points={{-306,88},{-282,88},{-282,136},{-252,136}},
      color={28,108,200},
      thickness=0.5));
  connect(globalFrequency_reference.y,feedback. u1)
    annotation (Line(points={{-309.1,112},{-325.2,112}},
                                                       color={0,0,127}));
  connect(globalFrequency.f,feedback. u2) annotation (Line(points={{-318.24,88},{-330,88},{-330,107.2}},
                                  color={0,0,127}));
  connect(feedback.y,integrator. u) annotation (Line(points={{-335.4,112},{-396,112},{-396,164},{-373.6,164}},
                                      color={0,0,127}));
  connect(not1.y,transmissionLine_CentralFault. switched_input) annotation (
      Line(points={{-109.4,188},{-108,188},{-108,172},{-112,172}},
                                                         color={255,0,255}));
  connect(OLTC_L2.epp,Transformer_L2. epp_n) annotation (Line(
      points={{206,176},{212,176},{212,136},{200,136}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary1.epp,transmissionLine_Central. epp_p) annotation (Line(
      points={{-154,168},{-150,168},{-150,136},{-118,136}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary2.epp,transmissionLine_CentralLower. epp_n) annotation (
      Line(
      points={{-14,165},{26,165},{26,136},{8,136}},
      color={28,108,200},
      thickness=0.5));
  connect(OLTC_L1.epp,Transformer_L1. epp_n) annotation (Line(
      points={{-276,46},{-262,46},{-262,66}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_b.epp_n,OLTC_L_b. epp) annotation (Line(
      points={{-36,70},{-36,61},{-42,61}},
      color={28,108,200},
      thickness=0.5));
  connect(bioinput.y, biomass_G1_Slack.P_el_set) annotation (Line(points={{-327,204},{-310.1,204},{-310.1,159.86}}, color={0,0,127}));
  connect(OLTC_L_a.epp,Transformer_L_a. epp_n) annotation (Line(
      points={{-152,77},{-152,76},{-144,76},{-144,88}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern1.epp_n, transmissionLine_Southern.epp_n) annotation (Line(
      points={{164,18},{164,136},{156,136}},
      color={28,108,200},
      thickness=0.5));
  connect(CHP.epp, transmissionLine_Southern1.epp_p) annotation (Line(
      points={{100.75,-102.2},{164,-102.2},{164,-6}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern.epp_n, transmissionLine_Northern1.epp_p) annotation (Line(
      points={{-224,136},{-198,136}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Northern1.epp_n, transmissionLine_Central.epp_p) annotation (Line(
      points={{-170,136},{-118,136}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary3.epp, transmissionLine_Northern1.epp_p) annotation (Line(
      points={{-222,184},{-208,184},{-208,136},{-198,136}},
      color={28,108,200},
      thickness=0.5));
  connect(electrolyzer.epp, transmissionLine_Central.epp_n) annotation (Line(
      points={{-120,8},{-120,108},{-36,108},{-36,136},{-98,136}},
      color={28,108,200},
      thickness=0.5));
  connect(L1.epp, Transformer_L1.epp_n) annotation (Line(
      points={{-262,4},{-262,66}},
      color={28,108,200},
      thickness=0.5));
  connect(La.epp, Transformer_L_a.epp_n) annotation (Line(
      points={{-144,54},{-144,88}},
      color={28,108,200},
      thickness=0.5));
  connect(Lb.epp, OLTC_L_b.epp) annotation (Line(
      points={{-36,22},{-36,61},{-42,61}},
      color={28,108,200},
      thickness=0.5));
  connect(L2.epp, Transformer_L2.epp_n) annotation (Line(
      points={{204.909,113.571},{204.909,136},{200,136}},
      color={28,108,200},
      thickness=0.5));
  connect(h2toNG.gasPortIn, electrolyzer.gasPortOut) annotation (Line(
      points={{-120,-18},{-120,-12}},
      color={255,255,0},
      thickness=1.5));
  connect(transmissionLine_CentralLower1.epp_p, transmissionLine_CentralLower.epp_n) annotation (Line(
      points={{44,136},{8,136}},
      color={28,108,200},
      thickness=0.5));
  connect(transmissionLine_Southern.epp_p, transmissionLine_CentralLower1.epp_n) annotation (Line(
      points={{132,136},{68,136}},
      color={28,108,200},
      thickness=0.5));
  connect(pQBoundary4.epp, transmissionLine_CentralLower1.epp_n) annotation (Line(
      points={{90,167},{96,167},{96,136},{68,136}},
      color={28,108,200},
      thickness=0.5));
  connect(Transformer_L_c.epp_p, transmissionLine_CentralLower1.epp_n) annotation (Line(
      points={{122,116},{122,136},{68,136}},
      color={28,108,200},
      thickness=0.5));
  connect(SetPower1.y, electrolyzer.P_el_set) annotation (Line(points={{-187,2},{-132,2}}, color={0,0,127}));
  connect(integrator.y, CHP.P_SB_set) annotation (Line(points={{-355.2,164},{-352,164},{-352,-70},{54.75,-70},{54.75,-95.05}}, color={0,0,127}));
  connect(switch1.y, CHP.Q_flow_set) annotation (Line(points={{141,-38},{148,-38},{148,-90.0667},{86.25,-90.0667}},  color={0,0,127}));
  connect(chpinput.y, switch1.u1) annotation (Line(points={{103,18},{118,18},{118,-30}}, color={0,0,127}));
  connect(electricBoiler.epp, Transformer_L2.epp_n) annotation (Line(
      points={{228,-206},{228,136},{200,136}},
      color={28,108,200},
      thickness=0.5));
  connect(setValueTemperature.y,PID_PumpGrid. u_s) annotation (Line(points={{-111,-174},{-105.2,-174}}, color={0,0,127}));
  connect(hotWaterStorage.waterPortOut_prod[1],pumpProd. fluidPortIn) annotation (Line(
      points={{26,-234.8},{26,-235},{74,-235}},
      color={175,0,0},
      thickness=0.5));
  connect(thermalHeatConsumer_CHP.T_room,PID_PumpGrid. u_m) annotation (Line(points={{-149.4,-161.2},{-144,-161.2},{-144,-184},{-97.94,-184},{-97.94,-181.2}},   color={0,0,127}));
  connect(PID_PumpGrid.y,pumpGrid. m_flow_in) annotation (Line(points={{-91.4,-174},{-84,-174},{-84,-193}},    color={0,0,127}));
  connect(tWV.outlet2,joinGrid. inlet2) annotation (Line(
      points={{-26,-226},{-26,-212},{-27,-212}},
      color={175,0,0},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hotWaterStorage.waterPortOut_grid[1],joinGrid. inlet1) annotation (Line(
      points={{0,-225.2},{0,-204},{-18,-204}},
      color={175,0,0},
      thickness=0.5));
  connect(hotWaterStorage.waterPortIn_grid[1],tWV. outlet1) annotation (Line(
      points={{0,-234.8},{-12,-234.8},{-12,-234.889},{-18,-234.889}},
      color={175,0,0},
      thickness=0.5));
  connect(thermalHeatConsumer_CHP.port_HeatDemand,heatFlowMultiplier1. port_a) annotation (Line(points={{-150.4,-167.6},{-150.4,-170.8},{-150,-170.8},{-150,-174}},
                                                                                                                                                            color={191,0,0}));
  connect(pumpGrid.fluidPortIn,joinGrid. outlet) annotation (Line(
      points={{-82,-204},{-36,-204}},
      color={175,0,0},
      thickness=0.5));
  connect(pumpGrid.fluidPortIn,tempBeforeCons. port) annotation (Line(
      points={{-82,-204},{-52,-204}},
      color={175,0,0},
      thickness=0.5));
  connect(tempAfterCons.port,tWV. inlet) annotation (Line(
      points={{-120,-234},{-78,-234},{-78,-234.889},{-34,-234.889}},
      color={0,131,169},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hEXHeatCons.inlet,pumpGrid. fluidPortOut) annotation (Line(
      points={{-140,-204},{-102,-204}},
      color={162,29,33},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(hEXHeatCons.outlet,tWV. inlet) annotation (Line(
      points={{-160,-204},{-160,-234.889},{-34,-234.889}},
      color={162,29,33},
      pattern=LinePattern.Solid,
      thickness=0.5));
  connect(heatFlowMultiplier1.port_b,hEXHeatCons. heat) annotation (Line(points={{-150,-186},{-150,-194}},
                                                                                                        color={191,0,0}));
  connect(idealizedExpansionVessel1.waterPort,hotWaterStorage. waterPortOut_grid[1]) annotation (Line(
      points={{-5,-196},{0,-196},{0,-225.2}},
      color={175,0,0},
      thickness=0.5));
  connect(tempBeforeCons.T,PID_TWV. u_m) annotation (Line(points={{-60.8,-196},{-70,-196},{-70,-270.8},{-42.91,-270.8}},     color={0,0,127}));
  connect(heatingCurve.T_Supply,PID_TWV. u_s) annotation (Line(points={{-89.2,-260.4},{-58,-260.4},{-58,-260},{-53.8,-260}},     color={0,0,127}));
  connect(PID_TWV.y,tWV. splitRatio_external) annotation (Line(points={{-33.1,-260},{-26,-260},{-26,-242.889}},  color={0,0,127}));
  connect(CHP.outlet, hotWaterStorage.waterPortIn_prod[1]) annotation (Line(
      points={{102.5,-115.633},{116,-115.633},{116,-210},{26,-210},{26,-225.8}},
      color={175,0,0},
      thickness=0.5));
  connect(CHP.inlet, pumpProd.fluidPortOut) annotation (Line(
      points={{102.5,-121.7},{102.5,-235},{94,-235}},
      color={175,0,0},
      thickness=0.5));
  connect(hotWaterStorage.waterPortOut_prod[2], pumpProd1.fluidPortIn) annotation (Line(
      points={{26,-234.8},{26,-268},{110,-268},{110,-269},{218,-269}},
      color={175,0,0},
      thickness=0.5));
  connect(hotWaterStorage.waterPortIn_prod[2], electricBoiler.fluidPortOut) annotation (Line(
      points={{26,-224.6},{26,-222},{192,-222},{192,-216},{218,-216}},
      color={175,0,0},
      thickness=0.5));
  connect(electricBoiler.fluidPortIn, pumpProd1.fluidPortOut) annotation (Line(
      points={{237.8,-216},{258,-216},{258,-269},{238,-269}},
      color={175,0,0},
      thickness=0.5));
  connect(set_temperature_storage.y,PID_CHP. u_s) annotation (Line(points={{7,42},{18.4,42}},                      color={0,0,127}));
  connect(meas_temperature_storage.y, PID_CHP.u_m) annotation (Line(points={{9,23.5},{28.08,23.5},{28.08,32.4}}, color={0,0,127}));
  connect(PID_CHP.y, gain_CHP.u) annotation (Line(points={{36.8,42},{59.2,42}}, color={0,0,127}));
  connect(gain_CHP.y, switch1.u3) annotation (Line(points={{68.4,42},{74,42},{74,-46},{118,-46}}, color={0,0,127}));
  connect(set_m_flow_pump.y, pumpProd1.m_flow_in) annotation (Line(points={{293,-246},{220,-246},{220,-258}}, color={0,0,127}));
  connect(set_m_flow_pump2.y, pumpProd.m_flow_in) annotation (Line(points={{-27,-152},{76,-152},{76,-224}}, color={0,0,127}));
  connect(booleanPulse.y, not1.u) annotation (Line(points={{-169,192},{-123.2,192},{-123.2,188}}, color={255,0,255}));
  connect(boundary_pTxi.gasPort, gCVSensor_boundary.gasPortIn) annotation (Line(
      points={{-192,-84},{-172,-84}},
      color={255,255,0},
      thickness=1.5));
  connect(gCVSensor_boundary.gasPortOut, junction_FIS.gasPort1) annotation (Line(
      points={{-152,-84},{-148,-84},{-148,-85},{-130,-85}},
      color={255,255,0},
      thickness=1.5));
  connect(h2toNG.gasPortOut, gCVSensor_electrolyzer.gasPortIn) annotation (Line(
      points={{-120,-34},{-120,-46}},
      color={255,255,0},
      thickness=1.5));
  connect(gCVSensor_electrolyzer.gasPortOut, junction_FIS.gasPort2) annotation (Line(
      points={{-120,-66},{-120,-75}},
      color={255,255,0},
      thickness=1.5));
  connect(junction_FIS.gasPort3, gCVSensor_chp.gasPortIn) annotation (Line(
      points={{-110,-85},{-84,-85},{-84,-86},{-58,-86}},
      color={255,255,0},
      thickness=1.5));
  connect(gCVSensor_chp.gasPortOut, CHP.gasPortIn) annotation (Line(
      points={{-38,-86},{102,-86},{102,-92.2333}},
      color={255,255,0},
      thickness=1.5));
  connect(SetPower2.y, gain_CHP1.u) annotation (Line(points={{159,-188},{177.2,-188}}, color={0,0,127}));
  connect(gain_CHP1.y, electricBoiler.Q_flow_set) annotation (Line(points={{186.4,-188},{202,-188},{202,-236},{228,-236},{228,-226}}, color={0,0,127}));
  connect(pulse.y, biomass_G3.P_el_set) annotation (Line(points={{-20.7,235},{-22,235},{-22,234},{-32,234},{-32,225.88},{-42.2,225.88}}, color={0,0,127}));
  connect(biomass_G3.epp, transmissionLine_Central.epp_n) annotation (Line(
      points={{-54.8,222.4},{-68,222.4},{-68,136},{-98,136}},
      color={28,108,200},
      thickness=0.5));
  connect(Lc.epp, Transformer_L_c.epp_n) annotation (Line(
      points={{121,60},{122,84},{122,96}},
      color={28,108,200},
      thickness=0.5));
  connect(ramp1.y,switch2. u3) annotation (Line(points={{-27,-32},{-10,-32},{-10,-38},{26,-38},{26,-36}}, color={0,0,127}));
  connect(BooleanFault2.y,switch2. u2) annotation (Line(points={{8.8,-52},{16,-52},{16,-28},{26,-28}}, color={255,0,255}));
  connect(chpinput1.y,switch2. u1) annotation (Line(points={{7,-8},{20,-8},{20,-20},{26,-20}},   color={0,0,127}));
  connect(switch2.y, CHP.P_set) annotation (Line(points={{49,-28},{62,-28},{62,-90.0667},{61.75,-90.0667}}, color={0,0,127}));
  connect(BooleanFault3.y, switch1.u2) annotation (Line(points={{100.8,-24},{112,-24},{112,-38},{118,-38}}, color={255,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-400,-280},{360,260}}), graphics={
        Text(
          extent={{30,-54},{-420,-188}},
          lineColor={28,108,200},
          textString="IES-Modell bestehend aus einem Strom und Gassektor und zwei Wärmesektoren. Ein KWK-Ausfall wird simuliert  ")}),
                                                                         Icon(coordinateSystem(extent={{-400,-280},{360,260}})),
    experiment(
      StopTime=70000,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end IES_MA_50_50_CHPfail_DGneuload;
