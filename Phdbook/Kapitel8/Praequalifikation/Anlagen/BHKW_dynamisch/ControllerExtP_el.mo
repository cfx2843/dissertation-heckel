within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
model ControllerExtP_el "CHP Controller that sets plant to a given electric power"

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
  //           Imports and Class Hierarchy
  // _____________________________________________
  extends Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch.PartialCHPController;
  extends TransiEnt.Basics.Icons.Controller;

  import TransiEnt;

  // _____________________________________________
  //
  //                   Parameters
  // _____________________________________________
  parameter Modelica.Units.SI.Power P_const=nDevices*Specification.P_el_max "Constant Power";
  parameter Boolean use_P_in=true "Use external controller";
  parameter Integer nDevices=1 "number of Devices";

  // _____________________________________________
  //
  //                    Variables
  // _____________________________________________
 Boolean offCondition(start=true);
Boolean onCondition;
  // _____________________________________________
  //
  //                    Complex Components
  // _____________________________________________
  Modelica.Blocks.Nonlinear.Limiter limiter(uMin=Specification.P_el_min, uMax=
        nDevices*Specification.P_el_max)
    annotation (Placement(transformation(extent={{-4,0},{16,20}})));

  // _____________________________________________
  //
  //                    Interfaces
  // _____________________________________________
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn P_el_set_external if use_P_in "Input for electric power" annotation (Placement(transformation(extent={{-112,-3},
            {-86,23}})));

  Modelica.Blocks.Interfaces.RealOutput t_running( final quantity="Time", final unit="s", displayUnit="h") "total time of operation of CHP"
    annotation (Placement(transformation(extent={{13,-13},{-13,13}},
        rotation=90,
        origin={-39,-99})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateOut Q_flow_meas_out "Produced heatflow rate"
    annotation (Placement(transformation(extent={{13,-13},{-13,13}},
        rotation=90,
        origin={-13,-99}), iconTransformation(
        extent={{13,-13},{-13,13}},
        rotation=90,
        origin={-10,-99})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_el_meas_out "Produced electric power"
    annotation (Placement(transformation(extent={{13,-13},{-13,13}},
        rotation=90,
        origin={19,-99})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-100,-46},{-80,-26}})));
  Modelica.Blocks.Interfaces.RealInput SOF_Speicher annotation (Placement(transformation(extent={{-130,58},{-90,98}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=0.01,
    uHigh=0.05,
    pre_y_start=true) annotation (Placement(transformation(extent={{-94,44},{-74,64}})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(extent={{44,-100},{64,-80}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                              annotation (Placement(transformation(extent={{14,-144},{34,-124}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Specification.P_el_max) annotation (Placement(transformation(extent={{-106,-82},{-86,-62}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_el_max(start=Specification.P_el_max) "Maximum Power Output" annotation (Placement(transformation(extent={{96,-109},{136,-70}}), iconTransformation(extent={{86,-101},{108,-79}})));
equation
onCondition = P_el_set > Specification.P_el_min and (time-stopTime >= t_OnOff);
offCondition = P_el_set<Specification.P_el_min+1 or T_return > T_return_max;

//  if pre(switch) == false and pre(onCondition) then
//    switch = true;
 // elseif pre(switch) and pre(offCondition) then
 //   switch = false;
 // else
 //   switch = pre(switch);
//  end if;
switch=true;
 if not use_P_in then
    limiter.u = P_const;
  end if;

  connect(P_el_meas, P_el_meas_out);
  connect(Q_flow_meas, Q_flow_meas_out);

  connect(P_el_set, limiter.y) annotation (Line(
      points={{80,10},{17,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Q_flow_meas_out, Q_flow_meas_out) annotation (Line(
      points={{-13,-99},{-13,-99}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(timer.y, t_running) annotation (Line(
      points={{33,-10},{-39,-10},{-39,-99}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(limiter.u, switch1.y) annotation (Line(points={{-6,10},{-29,10}}, color={0,0,127}));
  connect(P_el_set_external, switch1.u1) annotation (Line(points={{-99,10},{-76,10},{-76,18},{-52,18}}, color={0,127,127}));
  connect(const.y, switch1.u3) annotation (Line(points={{-79,-36},{-78,-36},{-78,2},{-52,2}}, color={0,0,127}));
  connect(SOF_Speicher, hysteresis.u) annotation (Line(points={{-110,78},{-104,78},{-104,54},{-96,54}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{-73,54},{-62,54},{-62,10},{-52,10}}, color={255,0,255}));
  connect(const1.y, switch2.u3) annotation (Line(points={{35,-134},{38,-134},{38,-98},{42,-98}}, color={0,0,127}));
  connect(switch2.u2, switch1.u2) annotation (Line(points={{42,-90},{30,-90},{30,-68},{-62,-68},{-62,10},{-52,10}}, color={255,0,255}));
  connect(realExpression.y, switch2.u1) annotation (Line(points={{-85,-72},{-18,-72},{-18,-82},{42,-82}}, color={0,0,127}));
  connect(switch2.y, P_el_max) annotation (Line(points={{65,-90},{90,-90},{90,-89.5},{116,-89.5}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
          Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Model for external electrical power control of CHP.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>controlBus</p>
<p>P_el_set_external: input for electric power in [W]</p>
<p>t_running: RealOutput for total hours of CHP operating</p>
<p>Q_flow_meas_out: output for produced heat flow rate in [W]</p>
<p>P_el_meas_out: output for produced power in [W]</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Created by Arne Koeppen (arne.koeppen@tuhh.de), Jun 2013</p>
<p>Revised by Lisa Andresen (andresen@tuhh.de), Aug 2013</p>
</html>"));
end ControllerExtP_el;
