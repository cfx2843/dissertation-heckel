within Phdbook.Kapitel8.Praequalifikation;
model PQ_S3
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
    RL_Art=false,
    Nennleistung_ohne(displayUnit="MW") = 2000000)
                 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-104})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-156,-136})));
public
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_mitSpeicher_neu regler_Virtuelles_Kraftwerk(SOC_LiIon_soll=0.6) annotation (Placement(transformation(
        extent={{-39,-88},{39,88}},
        rotation=180,
        origin={11,-40})));
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
  Anlagen.Brennstoffzellen.Rev_PEM_FC rev_PEM_FC(P_el_n=2e6, P_el_min=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={12,-160})));
  Anlagen.Brennstoffzellen.Druckspeicher druckspeicher(
    Kapazitaet=1000,
    p_Max=80000000,
    T_b(displayUnit="K"),
    SOC_start=0.5) annotation (Placement(transformation(
        extent={{-18,-25},{18,25}},
        rotation=180,
        origin={58,-205})));
equation
  connect(const.y, windturbine_SI_DF.v_wind) annotation (Line(points={{-107,18},{-98,18},{-98,17.71},{-72.9,17.71}},color={0,0,127}));
  connect(Windleistung.y, regler_Virtuelles_Kraftwerk.Max_Wind_1) annotation (Line(points={{105,-4},{80,-4},{80,-1.44762},{52.34,-1.44762}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_5) annotation (Line(points={{89,26},{70,26},{70,37.1048},{52.34,37.1048}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_4) annotation (Line(points={{89,26},{70,26},{70,27.0476},{52.34,27.0476}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_3) annotation (Line(points={{89,26},{70,26},{70,14.4762},{52.34,14.4762}},
                                                                                                                                   color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_2) annotation (Line(points={{89,26},{72,26},{72,7.77143},{52.34,7.77143}},
                                                                                                                                     color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_1) annotation (Line(points={{107,-40},{80,-40},{80,-50.8952},{52.34,-50.8952}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_2) annotation (Line(points={{107,-40},{78,-40},{78,-41.6762},{52.34,-41.6762}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_3) annotation (Line(points={{107,-40},{78,-40},{78,-34.1333},{52.34,-34.1333}},
                                                                                                                                        color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_4) annotation (Line(points={{107,-40},{78,-40},{78,-24.9143},{52.34,-24.9143}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_5) annotation (Line(points={{107,-40},{80,-40},{80,-15.6952},{52.34,-15.6952}},
                                                                                                                                          color={0,0,127}));
  connect(pQ_Tester.P_Angebot, regler_Virtuelles_Kraftwerk.PRL_Angebot) annotation (Line(
      points={{97.8,-103.8},{74.9,-103.8},{74.9,-81.0667},{50.78,-81.0667}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(windturbine_SI_DF.epp, ElectricGrid.epp) annotation (Line(
      points={{-55,18.7},{-46,18.7},{-46,-134},{-146,-134},{-146,-136}},
      color={0,135,135},
      thickness=0.5));
  connect(erbingungszuverlaessigkeit.Erfuellt, regler_Virtuelles_Kraftwerk.PRL_erfuellt) annotation (Line(points={{-91.2,64.8},{-62.6,64.8},{-62.6,37.1048},{-32.68,37.1048}},
                                                                                                                                                                           color={255,0,255}));
  connect(pQ_Tester.P_RL_set, regler_Virtuelles_Kraftwerk.PRL_set) annotation (Line(
      points={{94.9,-96.9},{72.45,-96.9},{72.45,-73.5238},{50.78,-73.5238}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_1, gain2.u) annotation (Line(
      points={{-31.12,-10.6667},{-51.95,-10.6667},{-51.95,-20},{-72,-20}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(gain2.y, windturbine_SI_DF.P_el_set) annotation (Line(points={{-95,-20},{-110,-20},{-110,1.21},{-74.1,1.21}}, color={0,0,127}));
  connect(rev_PEM_FC.electricPowerIn, regler_Virtuelles_Kraftwerk.P_set_LiIon) annotation (Line(points={{1.2,-155.6},{-40,-155.6},{-40,-114.59},{-29.56,-114.59}}, color={0,127,127}));
  connect(druckspeicher.P_V, rev_PEM_FC.Zusatzleistung_verdichter) annotation (Line(
      points={{37.48,-191.5},{2.7,-191.5},{2.7,-166.7}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(druckspeicher.massFlowRateIn, rev_PEM_FC.m_flow) annotation (Line(points={{40.36,-203},{22.9,-203},{22.9,-166.9}}, color={0,0,127}));
  connect(druckspeicher.epp, ElectricGrid.epp) annotation (Line(
      points={{74.38,-187.75},{-78,-187.75},{-78,-136},{-52,-136},{-52,-130},{-46,-130},{-46,-134},{-146,-134},{-146,-136}},
      color={0,135,135},
      thickness=0.5));
  connect(rev_PEM_FC.epp, ElectricGrid.epp) annotation (Line(
      points={{22.3,-159.9},{22.3,-134},{-146,-134},{-146,-136}},
      color={0,135,135},
      thickness=0.5));
  connect(druckspeicher.SOC, regler_Virtuelles_Kraftwerk.SOC_LiIon) annotation (Line(points={{77.98,-222.75},{112,-222.75},{112,-115.429},{51.56,-115.429}}, color={0,0,127}));
  connect(rev_PEM_FC.P_max_FC, regler_Virtuelles_Kraftwerk.Max_P_unload_LiIon) annotation (Line(
      points={{22.4,-152.4},{66,-152.4},{66,-93.6381},{52.34,-93.6381}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(rev_PEM_FC.P_max_Ely, regler_Virtuelles_Kraftwerk.Max_P_load_LiIon) annotation (Line(
      points={{22.6,-155.2},{70,-155.2},{70,-101.181},{52.34,-101.181}},
      color={0,135,135},
      pattern=LinePattern.Dash));
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
<p>Simulation der Betriebsfahrt f&uuml;r die Pr&auml;qualifikation zum Angebot von Regelleistung des dritten Szenarios.</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021</p>
</html>"));
end PQ_S3;
