within Phdbook.Kapitel8.Praequalifikation;
model PQ_S2
  import MABook;
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
    Nennleistung_ohne(displayUnit="MW") = 0)
                 annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-104})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-156,-136})));
public
  Langzeitsimulation.Regler.Regler_Virtuelles_Kraftwerk_Elektrolyseur regler_Virtuelles_Kraftwerk annotation (Placement(transformation(
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
  Anlagen.Brennstoffzellen.PEM_Elektrolyseur pEM_Elektrolyseur(P_el_n=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-158})));
equation
  connect(const.y, windturbine_SI_DF.v_wind) annotation (Line(points={{-107,18},{-98,18},{-98,17.71},{-72.9,17.71}},color={0,0,127}));
  connect(Windleistung.y, regler_Virtuelles_Kraftwerk.Max_Wind_1) annotation (Line(points={{105,-4},{80,-4},{80,-9.68889},{51.56,-9.68889}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_5) annotation (Line(points={{89,26},{70,26},{70,17.6889},{51.56,17.6889}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_4) annotation (Line(points={{89,26},{70,26},{70,10.8444},{51.56,10.8444}},
                                                                                                                                       color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_3) annotation (Line(points={{89,26},{70,26},{70,4},{51.56,4}},     color={0,0,127}));
  connect(Windleistung1.y, regler_Virtuelles_Kraftwerk.Max_Wind_2) annotation (Line(points={{89,26},{72,26},{72,-2.84444},{51.56,-2.84444}},
                                                                                                                                     color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_1) annotation (Line(points={{107,-40},{80,-40},{80,-58.5778},{50.78,-58.5778}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_2) annotation (Line(points={{107,-40},{78,-40},{78,-51.7333},{50.78,-51.7333}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_3) annotation (Line(points={{107,-40},{78,-40},{78,-44.8889},{50.78,-44.8889}},
                                                                                                                                        color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_4) annotation (Line(points={{107,-40},{78,-40},{78,-38.0444},{50.78,-38.0444}},
                                                                                                                                          color={0,0,127}));
  connect(Windleistung2.y, regler_Virtuelles_Kraftwerk.Max_PV_5) annotation (Line(points={{107,-40},{80,-40},{80,-31.2},{50.78,-31.2}},   color={0,0,127}));
  connect(pQ_Tester.P_Angebot, regler_Virtuelles_Kraftwerk.PRL_Angebot) annotation (Line(
      points={{97.8,-103.8},{74.9,-103.8},{74.9,-107.467},{51.56,-107.467}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(windturbine_SI_DF.epp, ElectricGrid.epp) annotation (Line(
      points={{-55,18.7},{-46,18.7},{-46,-134},{-146,-134},{-146,-136}},
      color={0,135,135},
      thickness=0.5));
  connect(erbingungszuverlaessigkeit.Erfuellt, regler_Virtuelles_Kraftwerk.PRL_erfuellt) annotation (Line(points={{-91.2,64.8},{-62.6,64.8},{-62.6,41.1556},{-33.46,41.1556}},
                                                                                                                                                                           color={255,0,255}));
  connect(pQ_Tester.P_RL_set, regler_Virtuelles_Kraftwerk.PRL_set) annotation (Line(
      points={{94.9,-96.9},{72.45,-96.9},{72.45,-96.7111},{51.56,-96.7111}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(regler_Virtuelles_Kraftwerk.P_set_Wind_1, gain2.u) annotation (Line(
      points={{-31.9,-16.5333},{-51.95,-16.5333},{-51.95,-20},{-72,-20}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(gain2.y, windturbine_SI_DF.P_el_set) annotation (Line(points={{-95,-20},{-110,-20},{-110,1.21},{-74.1,1.21}}, color={0,0,127}));
  connect(pEM_Elektrolyseur.epp, ElectricGrid.epp) annotation (Line(
      points={{60.3,-157.9},{-53.15,-157.9},{-53.15,-136},{-146,-136}},
      color={0,135,135},
      thickness=0.5));
  connect(pEM_Elektrolyseur.P_max, regler_Virtuelles_Kraftwerk.Max_P_Erzeuger) annotation (Line(
      points={{60.3,-151.5},{132,-151.5},{132,-82.0444},{51.56,-82.0444}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(pEM_Elektrolyseur.electricPowerIn, regler_Virtuelles_Kraftwerk.P_set_Elektrolyseur) annotation (Line(points={{39.2,-153.6},{-31.12,-153.6},{-31.12,-90.8444}}, color={0,127,127}));
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
<p>Simulation der Betriebsfahrt f&uuml;r die Pr&auml;qualifikation zum Angebot von Regelleistung des zweiten Szenarios.</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021</p>
</html>"));
end PQ_S2;
