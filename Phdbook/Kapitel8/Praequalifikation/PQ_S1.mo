within Phdbook.Kapitel8.Praequalifikation;
model PQ_S1
public
  Anlagen.Windkraftanlage_dynamisch.Windturbine windturbine_SI_DF(
    P_el_n(displayUnit="MW") = 6000000,
    height_data=120,
    height_hub=120,
    J=1.4e6,
    operationRanges=TransiEnt.Producer.Electrical.Wind.Characteristics.VariableSpeed.ExampleTurbineRanges(),
    controllerType_p=Modelica.Blocks.Types.SimpleController.PID,
    k_p=10,
    Ti_p=2,
    Td_p=2,
    beta_start=0,
    v_wind_start=15) annotation (Placement(transformation(extent={{-74,0},{-54,22}})));

  Modelica.Blocks.Sources.Constant const(k=15) annotation (Placement(transformation(extent={{-128,8},{-108,28}})));

public
  PQ_Tester pQ_Tester(
    Nennleistung(displayUnit="MW") = 6000000,
    g=0.5,
    RL_Art=true,
    Nennleistung_ohne(displayUnit="MW") = 1600000)
                 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-92})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{22,-154},{42,-134}})));
public
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitvarErzeuger regler_Virtuelles_Kraftwerk(SOC_Thermal_min=0.9) annotation (Placement(transformation(
        extent={{-39,-88},{39,88}},
        rotation=180,
        origin={11,-40})));
  Anlagen.BHKW_dynamisch.BHKW bHKW(
    P_el_n(displayUnit="MW") = 1600000,
    m_dot=0.04,
    m_Speicher=1200) annotation (Placement(transformation(extent={{-78,-192},{10,-140}})));
  Langzeitsimulation.Messung.Erbingungszuverlaessigkeit erbingungszuverlaessigkeit annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-102,66})));
  Modelica.Blocks.Sources.Constant Windleistung(k=-6e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,-4})));
  Modelica.Blocks.Sources.Constant Windleistung1(k=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={100,26})));
  Modelica.Blocks.Sources.Constant Windleistung2(k=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={118,-40})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
                                       annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-84,-20})));
equation
  connect(const.y, windturbine_SI_DF.v_wind) annotation (Line(points={{-107,18},{-98,18},{-98,17.71},{-72.9,17.71}},color={0,0,127}));
  connect(bHKW.P_el_max,regler_Virtuelles_Kraftwerk. Max_P_Erzeuger) annotation (Line(
      points={{14.4,-185.5},{88,-185.5},{88,-66.4},{52.34,-66.4}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(bHKW.SOF_Gas,regler_Virtuelles_Kraftwerk. SOF_Gas) annotation (Line(points={{-50.72,-196.42},{-50.72,-228},{72,-228},{72,-106},{51.56,-106}},            color={0,0,127}));
  connect(bHKW.SOC_Thermal,regler_Virtuelles_Kraftwerk. SOC_Thermal) annotation (Line(points={{-20.8,-195.9},{-20.8,-216},{62,-216},{62,-122.72},{51.56,-122.72}}, color={0,0,127}));
  connect(regler_Virtuelles_Kraftwerk.P_set_Erzeuger, bHKW.electricPowerIn) annotation (Line(
      points={{-31.12,-76.96},{-134,-76.96},{-134,-179},{-81.2267,-179}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Windleistung.y, regler_Virtuelles_Kraftwerk.Max_Wind_1) annotation (Line(points={{105,-4},{80,-4},{80,-3.92},{51.56,-3.92}}, color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_5) annotation (Line(points={{89,26},{70,26},{70,20.72},{51.56,20.72}}, color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_4) annotation (Line(points={{89,26},{70,26},{70,14.56},{51.56,14.56}}, color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_3) annotation (Line(points={{89,26},{70,26},{70,8.4},{51.56,8.4}}, color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_2) annotation (Line(points={{89,26},{72,26},{72,2.24},{51.56,2.24}}, color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_1) annotation (Line(points={{107,-40},{80,-40},{80,-47.92},{50.78,-47.92}}, color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_2) annotation (Line(points={{107,-40},{78,-40},{78,-41.76},{50.78,-41.76}}, color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_3) annotation (Line(points={{107,-40},{78,-40},{78,-35.6},{50.78,-35.6}}, color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_4) annotation (Line(points={{107,-40},{78,-40},{78,-29.44},{50.78,-29.44}}, color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_5) annotation (Line(points={{107,-40},{80,-40},{80,-23.28},{50.78,-23.28}}, color={0,0,127}));
  connect(pQ_Tester.P_Angebot, regler_Virtuelles_Kraftwerk.PRL_Angebot) annotation (Line(
      points={{97.8,-91.8},{74.9,-91.8},{74.9,-91.92},{51.56,-91.92}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(ElectricGrid.epp, bHKW.epp) annotation (Line(
      points={{22,-144},{16,-144},{16,-143.12},{10,-143.12}},
      color={0,135,135},
      thickness=0.5));
  connect(windturbine_SI_DF.epp, ElectricGrid.epp) annotation (Line(
      points={{-55,18.7},{-46,18.7},{-46,-134},{22,-134},{22,-144}},
      color={0,135,135},
      thickness=0.5));
  connect(erbingungszuverlaessigkeit.Erfuellt, regler_Virtuelles_Kraftwerk.PRL_erfuellt) annotation (Line(points={{-91.2,64.8},{-62.6,64.8},{-62.6,41.84},{-33.46,41.84}}, color={255,0,255}));
  connect(pQ_Tester.P_RL_set, regler_Virtuelles_Kraftwerk.PRL_set) annotation (Line(
      points={{94.9,-84.9},{72.45,-84.9},{72.45,-82.24},{51.56,-82.24}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_1, gain2.u) annotation (Line(
      points={{-31.9,-10.08},{-51.95,-10.08},{-51.95,-20},{-72,-20}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(gain2.y, windturbine_SI_DF.P_el_set) annotation (Line(points={{-95,-20},{-110,-20},{-110,1.21},{-74.1,1.21}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-240},{100,100}})),
                                                                 Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-240},{100,100}}),
                                                                                                                      graphics={Text(
          extent={{-48,200},{76,138}},
          lineColor={28,108,200},
          textString="5min Einschwingen
15min Sollwertsprung max")}),
    experiment(
      StopTime=1200,
      Interval=0.1000002,
      __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>Simulation der Betriebsfahrt f&uuml;r die Pr&auml;qualifikation zum Angebot von Regelleistung des ersten Szenarios.</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021</p>
</html>"));
end PQ_S1;
