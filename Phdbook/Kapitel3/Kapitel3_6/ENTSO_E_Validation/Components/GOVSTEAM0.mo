within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation.Components;
model GOVSTEAM0 "Controller for frequency/power"

    extends TransiEnt.Basics.Icons.Turbine;
  parameter Modelica.Units.SI.Frequency f_n=simCenter.f_n "Nominal Frequency";
  parameter Modelica.Units.SI.ActivePower P_n=475e6 "Nominal Power of Turbine";
    parameter Modelica.Units.SI.Voltage v_n=simCenter.v_n "Nominal Voltage";
    parameter Real R=0.05 "controller droop";
  parameter Modelica.Units.SI.Time T1=0.5 "governor time constant";
  parameter Modelica.Units.SI.Time T2=3 "turbine derivative time constant";
  parameter Modelica.Units.SI.Time T3=10 "turbine delay time constant";
    parameter Real Dt=0 "frictional losses factor";
    parameter Real Vmin=0 "minimum gate limit";
    parameter Real Vmax=1 "maximum gate limit";
  final parameter Modelica.Units.SI.AngularFrequency omega_n=2*Modelica.Constants.pi*f_n;
    outer TransiEnt.SimCenter simCenter;

  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  TransiEnt.Components.Sensors.ElectricFrequencyComplex electricFrequencyComplex(isDeltaMeasurement=true)
                                                                                 annotation (Placement(transformation(extent={{-50,-12},{-30,8}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{70,-14},{100,16}}), iconTransformation(extent={{70,-14},{100,16}})));
  Modelica.Blocks.Math.Gain denomilization(k=-P_n)
                                                  annotation (Placement(transformation(extent={{34,-10},{54,10}})));
  Modelica.Blocks.Math.Feedback sumControlDamping annotation (Placement(transformation(extent={{66,60},{86,80}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(extent={{-94,60},{-74,80}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction(
    b={T2,1},
    a={T3,1},
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{34,60},{54,80}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Vmax, uMin=Vmin) annotation (Placement(transformation(extent={{2,60},{22,80}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction1(
    b={1},
    a={T1,1},
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
  Modelica.Blocks.Math.Gain Droop(k=1/R) annotation (Placement(transformation(extent={{-62,60},{-42,80}})));
  Modelica.Blocks.Math.Gain FrictionLoss(k=Dt) annotation (Placement(transformation(extent={{20,24},{40,44}})));
  Modelica.Blocks.Math.Gain Nomilization(k=1/f_n) annotation (Placement(transformation(extent={{-22,-12},{-2,8}})));
  Modelica.Blocks.Interfaces.RealInput RefL annotation (Placement(transformation(extent={{-100,-24},{-56,20}}), iconTransformation(extent={{-100,-24},{-56,20}})));
equation
  connect(electricFrequencyComplex.epp, epp) annotation (Line(
      points={{-50,-2},{-50,-100},{0,-100}},
      color={28,108,200},
      thickness=0.5));
  connect(denomilization.y, y) annotation (Line(points={{55,0},{78,0},{78,1},{85,1}},
                                                                            color={0,0,127}));
  connect(sumControlDamping.y, denomilization.u) annotation (Line(points={{85,70},{86,70},{86,16},{24,16},{24,0},{32,0}},
                                                                                              color={0,0,127}));
  connect(transferFunction.y, sumControlDamping.u1) annotation (Line(points={{55,70},{68,70}},   color={0,0,127}));
  connect(limiter.y, transferFunction.u) annotation (Line(points={{23,70},{32,70}}, color={0,0,127}));
  connect(limiter.u, transferFunction1.y) annotation (Line(points={{0,70},{-9,70}},  color={0,0,127}));
  connect(transferFunction1.u, Droop.y) annotation (Line(points={{-32,70},{-41,70}},
                                                                                  color={0,0,127}));
  connect(feedback.y, Droop.u) annotation (Line(points={{-75,70},{-64,70}}, color={0,0,127}));
  connect(FrictionLoss.y, sumControlDamping.u2) annotation (Line(points={{41,34},{76,34},{76,62}},   color={0,0,127}));
  connect(electricFrequencyComplex.f, Nomilization.u) annotation (Line(points={{-29.6,-2},{-24,-2}}, color={0,0,127}));
  connect(Nomilization.y, FrictionLoss.u) annotation (Line(points={{-1,-2},{6,-2},{6,34},{18,34}}, color={0,0,127}));
  connect(feedback.u2, FrictionLoss.u) annotation (Line(points={{-84,62},{-84,34},{18,34}},                 color={0,0,127}));
  connect(feedback.u1, RefL) annotation (Line(points={{-92,70},{-96,70},{-96,-2},{-78,-2}},
                                                                          color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end GOVSTEAM0;
