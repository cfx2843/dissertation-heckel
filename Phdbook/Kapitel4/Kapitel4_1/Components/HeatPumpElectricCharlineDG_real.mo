within Phdbook.Kapitel4.Kapitel4_1.Components;
model HeatPumpElectricCharlineDG_real "Electric heat pump model that produces a given heat flow via fluid ports with a charline"

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

  extends TransiEnt.Producer.Heat.Base.PartialHeatPumpCharline(
                                            COP_n=3.4744);
  import      Modelica.Units.SI;

  // _____________________________________________
  //
  //             Visible Parameters
  // _____________________________________________

  parameter Boolean usePowerPort=false  annotation(Dialog(group="Fundamental Definitions"));

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  replaceable TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp if
                                                                            usePowerPort constrainedby TransiEnt.Basics.Interfaces.Electrical.PartialPowerPort "Choice of power port" annotation (Dialog(group="Replaceable Components",enable=usePowerPort),choicesAllMatching=true,Placement(transformation(extent={{100,0},{120,20}}),
                                                                                                                               iconTransformation(extent={{80,-20},{120,20}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_el_set if not
                                                                        (use_Q_flow_input) "Setpoint value of the power, should be positive" annotation (Placement(transformation(extent={{-120,62},{-80,102}}), iconTransformation(extent={{-120,62},{-80,102}})));

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________
protected
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.CollectElectricPower collectElectricPower(typeOfResource=TransiEnt.Basics.Types.TypeOfResource.Consumer)
                                                                                                                                      annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  Modelica.Blocks.Sources.RealExpression realExpression(y=P_el) if usePowerPort annotation (Placement(transformation(extent={{66,-38},{86,-18}})));
  Modelica.Blocks.Math.Gain P_el_set_(k=1) annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
                                          annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

public
  SI.Power P_el;
  TransiEnt.Components.Electrical.Machines.InductionMotorSimple asynchronousMotorComplex(
    v_n(displayUnit="kV") = 110000,
    useConverter=false,
    x_my=1000,
    r_s=2,
    x_s=15,
    x_R1=10,
    r_R1=2)                                                                              annotation (Placement(transformation(extent={{136,-62},{156,-42}})));
  TransiEnt.Components.Boundaries.Mechanical.Power MechanicalBoundary1(change_sign=true)
                                                                      annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={89,-53})));
  TransiEnt.Components.Mechanical.ConstantInertia constantInertia2(
    P_n(displayUnit="MW") = (Q_flow_n/COP_n),
    J=(Q_flow_n/COP_n)*(simCenter.T_grid)/(100*Modelica.Constants.pi)^2,
    alpha(start=0, fixed=true))                               annotation (Placement(transformation(extent={{108,-64},{128,-44}})));
equation
  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________

  if use_Q_flow_input then
    Q_flow=Q_flow_set_.u;
    P_el=-Q_flow/COP;
  else
    Q_flow=-COP*P_el;
    P_el=P_el_set_.u;
  end if;

  //charline
  COP=COP_n*1/3.4744*(0.0005*DeltaT^2-0.0973*DeltaT+6.1408); //source: Andreas Palzer. 2016. Sektorübergreifende Modellierung Und Optimierung Eines Zukünftigen Deutschen Energiesystems Unter Berücksichtigung von Energieeffizienzmaßnahmen Im Gebäudesektor. Stuttgart: Fraunhofer Verlag. http://publica.fraunhofer.de/eprints/urn_nbn_de_0011-n-408742-11.pdf.

  //collector
  collectElectricPower.powerCollector.P=P_el;

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(modelStatistics.powerCollector[collectElectricPower.typeOfResource],collectElectricPower.powerCollector);
  if usePowerPort then
  end if;

  if not
        (use_Q_flow_input) then
    connect(P_el_set_.u, P_el_set) annotation (Line(points={{-62,30},{-66,30},{-66,82},{-100,82}},
                                                                                               color={0,0,127}));
  else
    connect(const1.y, P_el_set_.u) annotation (Line(points={{-79,60},{-68,60},{-68,30},{-62,30}}, color={0,0,127}));
  end if;

  connect(realExpression.y, MechanicalBoundary1.P_mech_set) annotation (Line(points={{87,-28},{89,-28},{89,-42.38}}, color={0,0,127}));
  connect(constantInertia2.mpp_a, MechanicalBoundary1.mpp) annotation (Line(points={{108,-54},{104,-54},{104,-53},{98,-53}}, color={95,95,95}));
  connect(constantInertia2.mpp_b, asynchronousMotorComplex.mpp) annotation (Line(points={{128,-54},{132,-54},{132,-52},{136,-52}}, color={95,95,95}));
  connect(asynchronousMotorComplex.epp, epp) annotation (Line(
      points={{156.1,-52.1},{156.1,10},{110,10}},
      color={28,108,200},
      thickness=0.5));
annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Base class for simple heat pump models that produce a given heat flow via fluid ports and use a charline.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>Changing ambient temperature can be considered as well as varying COP depending on the temperature difference between waterPortOut and source. The charline is linearly scalable with COP_n and Q_flow_n is used for the cost calculation. Different heat flow boundaries, in which the heat flow is transfered to the water, can be chosen.</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>Q_flow_set: set value for the heat flow</p>
<p>T_source_input_K: source temperature (ambient temperature) in K</p>
<p>waterPortIn: inlet port for heating water</p>
<p>waterPortOut: outlet port for heating water</p>
<p>P_el: needed electric power</p>
<p>epp: electric power port</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>Temperature difference for charline = waterPortOut temperature - source temperature</p>
<p>COP=COP_n*1/3.4744*(0.0005*DeltaT^2-0.0973*DeltaT+6.1408) [1]</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(none)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>[1] A. Palzer, &quot;Sektor&uuml;bergreifende Modellierung und Optimierung eines zuk&uuml;nftigen deutschen Energiesystems unter Ber&uuml;cksichtigung von Energieeffizienzma&szlig;nahmen im Geb&auml;udesektor&quot;. Stuttgart: Fraunhofer Verlag, 2016.</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model created by Carsten Bode (c.bode@tuhh.de), Feb 2018</p>
<p>Model modified by Jan Westphal (j.westphal@tuhh.de), Jul 2019 (added boolean for using heat port instead of fluid ports)</p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{160,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
end HeatPumpElectricCharlineDG_real;
