within Phdbook.Kapitel3.Kapitel3_6.ENTSO_E_Validation.Components;
model ExcSEXS "AUTOMATIC VOLTAGE REGULATOR
from ENTSO-E"

//________________________________________________________________________________//
// Component of the TransiEnt Library, version: 1.3.0                             //
//                                                                                //
// Licensed by Hamburg University of Technology under Modelica License 2.         //
// Copyright 2020, Hamburg University of Technology.                              //
//________________________________________________________________________________//
//                                                                                //
// TransiEnt.EE and ResiliEntEE are research projects supported by the German     //
// Federal Ministry of Economics and Energy (FKZ 03ET4003 and 03ET4048).          //
// The TransiEnt Library research team consists of the following project partners://
// Institute of Engineering Thermodynamics (Hamburg University of Technology),    //
// Institute of Energy Systems (Hamburg University of Technology),                //
// Institute of Electrical Power and Energy Technology                            //
// (Hamburg University of Technology)                                             //
// Institute of Electrical Power Systems and Automation                           //
// (Hamburg University of Technology)                                             //
// and is supported by                                                            //
// XRG Simulation GmbH (Hamburg, Germany).                                        //
//________________________________________________________________________________//

  // _____________________________________________
  //
  //          Imports and Class Hierarchy
  // _____________________________________________

  extends TransiEnt.Components.Electrical.Machines.ExcitationSystemsVoltageController.PartialExcitationSystem(redeclare TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp1);

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  // _____________________________________________
  //
  //        Constants and Parameters
  // _____________________________________________

  parameter Boolean useIntegrator=false;
  parameter Modelica.Units.SI.Voltage v_n=simCenter.v_n "Nominal Voltage";
  parameter Real K=200 "controller gain";
  parameter Real KI=20 "integrator gain";
  parameter Modelica.Units.SI.Time TA=3 "filter derivative time constant";
  parameter Modelica.Units.SI.Time TB=10 "filter delay time";
  parameter Modelica.Units.SI.Time TE=0.05 "exciter time constant";
  parameter Real Emin=0 "minimum gate limit";
  parameter Real Emax=4 "maximum gate limit";

  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________
  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  TransiEnt.Components.Sensors.ElectricVoltageComplex electricVoltageComplex "Vc" annotation (Placement(transformation(extent={{-98,26},{-78,46}})));

  Modelica.Blocks.Math.MultiSum multiSum(k={+1,-1,+1}, nu=3)
                                                       annotation (Placement(transformation(extent={{-58,68},{-46,80}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction(
    b={TA,1},
    a={TB,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1})                                     annotation (Placement(transformation(extent={{-12,64},{8,84}})));
  Modelica.Blocks.Continuous.TransferFunction transferFunction1(b={K}, a={TE,1},
    initType=Modelica.Blocks.Types.Init.SteadyState,
    x_start={1})                                                                 annotation (Placement(transformation(extent={{20,64},{40,84}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Emax, uMin=Emin,
    homotopyType=Modelica.Blocks.Types.LimiterHomotopy.Linear)    annotation (Placement(transformation(extent={{78,66},{98,86}})));
  Modelica.Blocks.Math.Gain denomilization(k=v_n) annotation (Placement(transformation(extent={{106,66},{126,86}})));
  Modelica.Blocks.Math.Gain nomilization(k=1/v_n) annotation (Placement(transformation(extent={{-40,64},{-20,84}})));
  TransiEnt.Basics.Interfaces.Electrical.VoltageIn voltageIn annotation (Placement(transformation(extent={{-110,66},{-90,86}})));
  Modelica.Blocks.Continuous.Integrator integrator(k=KI, initType=Modelica.Blocks.Types.Init.NoInit)       annotation (Placement(transformation(extent={{-18,-24},{2,-4}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(extent={{52,-60},{72,-40}})));
  Modelica.Blocks.Math.Gain gain(k=if useIntegrator then 1 else 0) annotation (Placement(transformation(extent={{14,-64},{34,-44}})));
equation

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(y, y) annotation (Line(points={{106,0},{106,0}}, color={0,0,127}));
  connect(electricVoltageComplex.epp, epp1) annotation (Line(
      points={{-98,36.2},{-100,36.2},{-100,0}},
      color={28,108,200},
      thickness=0.5));
  connect(transferFunction.y, transferFunction1.u) annotation (Line(points={{9,74},{18,74}},  color={0,0,127}));
  connect(limiter.y, denomilization.u) annotation (Line(points={{99,76},{104,76}}, color={0,0,127}));
  connect(denomilization.y, y) annotation (Line(points={{127,76},{140,76},{140,26},{78,26},{78,0},{106,0}}, color={0,0,127}));
  connect(transferFunction.u, nomilization.y) annotation (Line(points={{-14,74},{-19,74}},
                                                                                       color={0,0,127}));
  connect(multiSum.y, nomilization.u) annotation (Line(points={{-44.98,74},{-42,74}}, color={0,0,127}));
  connect(voltageIn, multiSum.u[1]) annotation (Line(points={{-100,76},{-72,76},{-72,76.8},{-58,76.8}}, color={0,127,127}));
  connect(electricVoltageComplex.v, multiSum.u[2]) annotation (Line(
      points={{-78,42},{-60,42},{-60,74},{-58,74}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(u, multiSum.u[3]) annotation (Line(points={{-100,-50},{-100,12},{-58,12},{-58,71.2}}, color={0,0,127}));
  connect(limiter.u, add.y) annotation (Line(points={{76,76},{74,76},{74,-50},{73,-50}},
                                                                                       color={0,0,127}));
  connect(add.u1, transferFunction1.y) annotation (Line(points={{50,-44},{46,-44},{46,74},{41,74}},
                                                                                                  color={0,0,127}));
  connect(integrator.u, transferFunction1.u) annotation (Line(points={{-20,-14},{-36,-14},{-36,52},{14,52},{14,74},{18,74}}, color={0,0,127}));
  connect(gain.u, integrator.y) annotation (Line(points={{12,-54},{8,-54},{8,-14},{3,-14}}, color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(points={{35,-54},{44,-54},{44,-56},{50,-56}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Voltage Control</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>L2E only transfer functions with PT1-elements</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>No PSS</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>epp (ComplexPowerPort) for Voltage measurement and real output</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>simple voltage controller for many applications</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">[1] E. Handschin, &ldquo;Elektrische Energieübertragungssysteme&rdquo;, Dr. Alfred Hüthig Verlag Heidelberg, 2nd edition , 1987, p. 255</span></p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Created by Jan-Peter Heckel (jan.heckel@tuhh.de), Apr 2018</p>
</html>"),
Icon(graphics,
     coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end ExcSEXS;
