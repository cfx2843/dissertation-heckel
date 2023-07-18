within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation.Components;
model PSS2A "Power System Stabilizer from ENTSO-E"

  extends TransiEnt.Basics.Icons.Controller;

  parameter Modelica.Units.SI.Voltage v_n=simCenter.v_n "Nominal Voltage";
  parameter Modelica.Units.SI.Frequency f_n=simCenter.f_n "Nominal Frequency";
  parameter Modelica.Units.SI.ActivePower P_n=475e6 "Nominal Power of Turbine";
  parameter Real KS1=10 "PSS gain";
  parameter Real KS2=0.1564 "2nd signal transducer factor";
  parameter Real KS3=1 "washouts coupling factor";
  parameter Modelica.Units.SI.Time TW1=2 "1st washout 1th time constant";
  parameter Modelica.Units.SI.Time TW2=2 "1st washout 2th time constant";
  parameter Modelica.Units.SI.Time TW3=2 "2nd washout 1th time constant";
  parameter Modelica.Units.SI.Time TW4=0 "2nd washout 2th time constant";
  parameter Modelica.Units.SI.Time T1=0.25 "1st lead-lag derivative time constant";
  parameter Modelica.Units.SI.Time T2=0.03 "1st lead-lag delay time constant";
  parameter Modelica.Units.SI.Time T3=0.15 "2nd lead-lag derivative time constant";
  parameter Modelica.Units.SI.Time T4=0.015 "2nd lead-lag delay time constant";
  parameter Modelica.Units.SI.Time T6=0 "1st signal transducer time constant";
  parameter Modelica.Units.SI.Time T7=2 "2nd signal transducer time constant";
  parameter Real VSTmin=-0.1 "controller maximum output";
  parameter Real VSTmax=0.1 "controller minimum output";

  outer TransiEnt.SimCenter simCenter;

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Pgen annotation (Placement(transformation(extent={{-110,-72},{-90,-52}})));
  TransiEnt.Components.Sensors.ElectricFrequencyComplex deltaOmega(isDeltaMeasurement=true) annotation (Placement(transformation(extent={{-88,40},{-68,60}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction(
    b={TW1,0},
    a={TW1,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{-30,40},{-10,60}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction1(
    b={TW2,0},
    a={TW2,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{-4,40},{16,60}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction3(
    b={TW3,0},
    a={TW3,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{-56,-72},{-36,-52}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction5(
    b={KS2},
    a={T7,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{4,-72},{24,-52}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{64,-18},{84,2}})));
  Modelica.Blocks.Math.Gain gain(k=KS3) annotation (Placement(transformation(extent={{36,-24},{56,-4}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{86,34},{106,54}})));
  Modelica.Blocks.Math.Gain gain1(k=KS1) annotation (Placement(transformation(extent={{112,34},{132,54}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction6(
    b={T1,1},
    a={T2,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{142,34},{162,54}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction7(
    b={T3,1},
    a={T4,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1}) annotation (Placement(transformation(extent={{172,34},{192,54}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=VSTmax, uMin=VSTmin)
                                                                  annotation (Placement(transformation(extent={{202,34},{222,54}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Math.Gain nomilizationf(k=1/f_n) annotation (Placement(transformation(extent={{-58,40},{-38,60}})));
  Modelica.Blocks.Math.Gain nomilizationP(k=1/P_n) annotation (Placement(transformation(extent={{-84,-72},{-64,-52}})));
  Modelica.Blocks.Math.Gain denomilizationV(k=v_n) annotation (Placement(transformation(extent={{238,34},{258,54}})));
equation
  connect(epp, deltaOmega.epp) annotation (Line(
      points={{-100,50},{-88,50}},
      color={28,108,200},
      thickness=0.5));
  connect(transferFunction.y, transferFunction1.u) annotation (Line(points={{-9,50},{-6,50}},  color={0,0,127}));
  connect(add.u2, gain.y) annotation (Line(points={{62,-14},{57,-14}}, color={0,0,127}));
  connect(transferFunction5.y, gain.u) annotation (Line(points={{25,-62},{30,-62},{30,-14},{34,-14}},
                                                                                                   color={0,0,127}));
  connect(feedback.u1, add.u1) annotation (Line(points={{88,44},{46,44},{46,-2},{62,-2}}, color={0,0,127}));
  connect(feedback.u2, add.y) annotation (Line(points={{96,36},{86,36},{86,-8},{85,-8}},   color={0,0,127}));
  connect(feedback.y, gain1.u) annotation (Line(points={{105,44},{110,44}}, color={0,0,127}));
  connect(transferFunction6.y, transferFunction7.u) annotation (Line(points={{163,44},{170,44}}, color={0,0,127}));
  connect(transferFunction6.u, gain1.y) annotation (Line(points={{140,44},{133,44}},                   color={0,0,127}));
  connect(transferFunction7.y, limiter.u) annotation (Line(points={{193,44},{200,44}}, color={0,0,127}));
  connect(transferFunction.u, nomilizationf.y) annotation (Line(points={{-32,50},{-37,50}}, color={0,0,127}));
  connect(deltaOmega.f, nomilizationf.u) annotation (Line(points={{-67.6,50},{-60,50}}, color={0,0,127}));
  connect(Pgen, nomilizationP.u) annotation (Line(points={{-100,-62},{-86,-62}}, color={0,127,127}));
  connect(transferFunction3.u, nomilizationP.y) annotation (Line(points={{-58,-62},{-63,-62}}, color={0,0,127}));
  connect(limiter.y, denomilizationV.u) annotation (Line(points={{223,44},{236,44}}, color={0,0,127}));
  connect(denomilizationV.y, y) annotation (Line(points={{259,44},{276,44},{276,12},{92,12},{92,0},{106,0}}, color={0,0,127}));
  connect(transferFunction1.y, add.u1) annotation (Line(points={{17,50},{32,50},{32,44},{46,44},{46,-2},{62,-2}}, color={0,0,127}));
  connect(transferFunction3.y, transferFunction5.u) annotation (Line(points={{-35,-62},{2,-62}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PSS2A;
