within Phdbook.Kapitel3.Kapitel3_6;
model Validation_NEPLAN_5

  inner TransiEnt.SimCenter simCenter(v_n(displayUnit="kV") = 110000)
                                                annotation (Placement(transformation(extent={{-54,-26},{-34,-6}})));
  inner TransiEnt.ModelStatistics modelStatistics annotation (Placement(transformation(extent={{-10,-26},{10,-6}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.SlackBoundary starresNetz(v_gen(displayUnit="kV") = 10000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={80,60})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced SS_D(
    l=300,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,40})));

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort SS annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex Ersatz(
    Q_el_set=200,
    P_el_set_const(displayUnit="MW") = 22290000,
    useCosPhi=true,
    cosphi_set=0.9,
    v_n(displayUnit="kV") = 10000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-24})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced SS_E(
    l=200,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,40})));

  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced SS_A(
    l=150,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,40})));

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort D annotation (Placement(transformation(extent={{30,84},{50,104}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced D_E(
    l=240,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,146})));

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort E annotation (Placement(transformation(extent={{30,190},{50,210}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex ONS4Last(
    Q_el_set=200,
    useCosPhi=true,
    cosphi_set=0.9,
    P_el_set_const(displayUnit="MW") = 500000,
    v_n(displayUnit="kV") = 10000)
                                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,94})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort A annotation (Placement(transformation(extent={{-90,84},{-70,104}})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex ONS1Last(
    Q_el_set=200,
    useCosPhi=true,
    cosphi_set=0.9,
    P_el_set_const(displayUnit="MW") = 300000,
    v_n(displayUnit="kV") = 400) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-134,94})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced A_G(
    l=158,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,144})));

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort G annotation (Placement(transformation(extent={{-90,190},{-70,210}})));
  TransiEnt.Components.Electrical.Grid.PiModelComplex_advanced E_G(
    l=147,
    MVCableType=TransiEnt.Components.Electrical.Grid.Characteristics.MVCabletypes.L1,
    ChooseVoltageLevel=4)                                                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-38,200})));

  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex SVK3(
    Q_el_set=200,
    useCosPhi=true,
    cosphi_set=0.9,
    P_el_set_const(displayUnit="MW") = 3000000,
    v_n(displayUnit="kV") = 10000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,172})));
  TransiEnt.Consumer.Electrical.ExponentialElectricConsumerComplex ONS3Last(
    Q_el_set=200,
    useCosPhi=true,
    cosphi_set=0.9,
    P_el_set_const(displayUnit="MW") = 350000,
    v_n(displayUnit="kV") = 10000)             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,200})));

  TransiEnt.Components.Electrical.PowerTransformation.TransformerComplex transformer(
    U_P=400,
    U_S(displayUnit="kV") = 10000,
    X_S=0,
    R_P=0,
    R_S=0,
    X_P=4.6e-3) annotation (Placement(transformation(extent={{-116,86},{-96,106}})));
  TransiEnt.Components.Boundaries.Electrical.ComplexPower.PQBoundary A_init(
    useInputConnectorP=false,
    useInputConnectorQ=false,
    useCosPhi=false,
    v_n(displayUnit="kV") = 10000) annotation (Placement(transformation(extent={{-58,84},{-38,104}})));
equation
  connect(Ersatz.epp, SS) annotation (Line(
      points={{80,-14.2},{80,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_D.epp_n, SS) annotation (Line(
      points={{40,30},{40,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_E.epp_n, SS) annotation (Line(
      points={{-1.77636e-15,30},{-1.77636e-15,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_A.epp_n, SS) annotation (Line(
      points={{-80,30},{-80,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_D.epp_p, D) annotation (Line(
      points={{40,50},{40,94}},
      color={28,108,200},
      thickness=0.5));
  connect(D, D_E.epp_n) annotation (Line(
      points={{40,94},{40,136}},
      color={28,108,200},
      thickness=0.5));
  connect(D_E.epp_p, E) annotation (Line(
      points={{40,156},{40,200}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_E.epp_p, E) annotation (Line(
      points={{1.77636e-15,50},{1.77636e-15,200},{40,200}},
      color={28,108,200},
      thickness=0.5));
  connect(A, A_G.epp_n) annotation (Line(
      points={{-80,94},{-80,134}},
      color={28,108,200},
      thickness=0.5));
  connect(A_G.epp_p, G) annotation (Line(
      points={{-80,154},{-80,200}},
      color={28,108,200},
      thickness=0.5));
  connect(G, E_G.epp_n) annotation (Line(
      points={{-80,200},{-48,200}},
      color={28,108,200},
      thickness=0.5));
  connect(E_G.epp_p, E) annotation (Line(
      points={{-28,200},{40,200}},
      color={28,108,200},
      thickness=0.5));
  connect(G, SVK3.epp) annotation (Line(
      points={{-80,200},{-70,200},{-70,172},{-59.8,172}},
      color={28,108,200},
      thickness=0.5));
  connect(ONS3Last.epp, E) annotation (Line(
      points={{60.2,200},{40,200}},
      color={28,108,200},
      thickness=0.5));
  connect(starresNetz.epp, SS) annotation (Line(
      points={{80,50},{80,0},{60,0}},
      color={28,108,200},
      thickness=0.5));
  connect(SS_A.epp_p, A) annotation (Line(
      points={{-80,50},{-80,94}},
      color={28,108,200},
      thickness=0.5));
  connect(ONS4Last.epp, D) annotation (Line(
      points={{60.2,94},{40,94}},
      color={28,108,200},
      thickness=0.5));
  connect(A_init.epp, A) annotation (Line(
      points={{-58,94},{-80,94}},
      color={28,108,200},
      thickness=0.5));
  connect(transformer.epp_n, A) annotation (Line(
      points={{-96,96},{-88,96},{-88,94},{-80,94}},
      color={28,108,200},
      thickness=0.5));
  connect(transformer.epp_p, ONS1Last.epp) annotation (Line(
      points={{-116,96},{-124,96},{-124,94},{-124.2,94}},
      color={28,108,200},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,-40},{120,220}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-180,-40},{120,220}}), graphics={
        Text(
          extent={{48,20},{72,10}},
          lineColor={28,108,200},
          textString="SS"),
        Text(
          extent={{-78,114},{-66,102}},
          lineColor={28,108,200},
          textString="A"),
        Text(
          extent={{-80,216},{-54,204}},
          lineColor={28,108,200},
          textString="G"),
        Text(
          extent={{40,216},{64,204}},
          lineColor={28,108,200},
          textString="E"),
        Text(
          extent={{48,114},{58,100}},
          lineColor={28,108,200},
          textString="D")}),
    experiment(Tolerance=0.001, __Dymola_Algorithm="Dassl"));
end Validation_NEPLAN_5;
