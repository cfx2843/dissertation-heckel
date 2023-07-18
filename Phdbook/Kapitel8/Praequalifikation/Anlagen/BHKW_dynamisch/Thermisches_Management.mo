within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
block Thermisches_Management
  outer TransiEnt.SimCenter simCenter;
  parameter Modelica.Units.SI.SpecificHeatCapacity c_p=4184 "Spezifische Wärmekapazität Wasser";
  parameter Modelica.Units.SI.Energy E_thermal=360000000 "Speichergroße";
  parameter Modelica.Units.SI.Energy E_start=0.5*E_thermal "Füllstand start";
  parameter Modelica.Units.SI.HeatFlowRate Q_fermenter=200e3 "Benötigter Wärmestrom für Fermenter";
  TransiEnt.Basics.Interfaces.General.TemperatureIn Eingangstemperatur annotation (Placement(transformation(extent={{-124,68},{-84,108}})));
  TransiEnt.Basics.Interfaces.General.TemperatureIn Ausgangstemperatur annotation (Placement(transformation(extent={{-124,36},{-84,76}})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateIn Durchfluss annotation (Placement(transformation(extent={{-124,-2},{-84,38}})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateIn Thermischer_Verbraucher annotation (Placement(transformation(extent={{-126,-48},{-86,-8}})));
  Modelica.Blocks.Interfaces.RealOutput SOC annotation (Placement(transformation(extent={{94,-22},{138,22}}), iconTransformation(extent={{94,-22},{138,22}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-56,56})));
  Modelica.Blocks.Math.Gain gain(k=-c_p) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-56,34})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2) annotation (Placement(transformation(extent={{-44,2},{-32,14}})));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(
    outMax=E_thermal,
    outMin=0,
    y_start=E_start)                                     annotation (Placement(transformation(extent={{10,8},{30,28}})));
  Modelica.Blocks.Math.MultiSum multiSum(k={1,-1,-1}, nu=3) annotation (Placement(transformation(extent={{-10,-32},{2,-20}})));
  Modelica.Blocks.Math.Gain gain1(k=1/E_thermal)
                                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={60,2})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Q_fermenter) annotation (Placement(transformation(extent={{-72,-70},{-52,-50}})));
  Modelica.Blocks.Math.Max Waerme_von_BHKW annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-18,-4})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-12,42})));
equation
  connect(Ausgangstemperatur, feedback.u2) annotation (Line(points={{-104,56},{-64,56}}, color={0,0,127}));
  connect(Eingangstemperatur, feedback.u1) annotation (Line(points={{-104,88},{-56,88},{-56,64}}, color={0,0,127}));
  connect(feedback.y, gain.u) annotation (Line(points={{-56,47},{-56,46}}, color={0,0,127}));
  connect(gain.y, multiProduct.u[1]) annotation (Line(points={{-56,23},{-56,10.1},{-44,10.1}},
                                                                                     color={0,0,127}));
  connect(multiProduct.u[2], Durchfluss) annotation (Line(points={{-44,5.9},{-96,5.9},{-96,18},{-104,18}},     color={0,0,127}));
  connect(limIntegrator.u, multiSum.y) annotation (Line(points={{8,18},{4,18},{4,-26},{3.02,-26}}, color={0,0,127}));
  connect(limIntegrator.y, gain1.u) annotation (Line(points={{31,18},{40,18},{40,2},{48,2}}, color={0,0,127}));
  connect(SOC, gain1.y) annotation (Line(points={{116,0},{94,0},{94,2},{71,2}}, color={0,0,127}));
  connect(multiProduct.y, Waerme_von_BHKW.u2) annotation (Line(points={{-30.98,8},{-24,8}}, color={0,0,127}));
  connect(Waerme_von_BHKW.y, multiSum.u[1]) annotation (Line(points={{-18,-15},{-18,-23.2},{-10,-23.2}}, color={0,0,127}));
  connect(Thermischer_Verbraucher, multiSum.u[2]) annotation (Line(
      points={{-106,-28},{-58,-28},{-58,-26},{-10,-26}},
      color={175,0,0},
      pattern=LinePattern.Dash));
  connect(realExpression.y, multiSum.u[3]) annotation (Line(points={{-51,-60},{-30,-60},{-30,-28.8},{-10,-28.8}}, color={0,0,127}));
  connect(const.y, Waerme_von_BHKW.u1) annotation (Line(points={{-12,31},{-12,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Thermisches_Management;
