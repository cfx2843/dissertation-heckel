within Phdbook.Kapitel5.Kapitel5_1;
model eLIVES
//________________________________________________________________________________//
// Component of the TransiEnt Library, version: x.x.0                             //
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

extends TransiEnt.Basics.Icons.Block;

  // _____________________________________________
  //
  //              Visible Parameters
  // _____________________________________________

  parameter Modelica.Units.SI.Voltage v_n_prim=simCenter.v_n;
  parameter Modelica.Units.SI.Voltage v_n_sec=110e3;
  parameter Modelica.Units.SI.Time Toff=250;
  parameter Modelica.Units.SI.Time T_max=100;
  parameter Modelica.Units.SI.Voltage deltaV=0.025*v_n_sec;
  parameter Modelica.Units.SI.Voltage deltaVcrit=0.05*v_n_prim;
  parameter Modelica.Units.SI.Voltage VHVAlarm=0.9*v_n_prim;
  parameter Modelica.Units.SI.Time T_sample=0.05;
  parameter Real TapMax=11;

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________

  outer TransiEnt.SimCenter simCenter;

  // _____________________________________________
  //
  //                  Interfaces
  // _____________________________________________

  Modelica.Blocks.Interfaces.BooleanOutput eLIVES_Warning annotation (Placement(transformation(extent={{90,30},{110,50}}), iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput eLIVES_Alarm annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.BooleanOutput HV_Alarm annotation (Placement(transformation(extent={{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.RealInput input_from_OLTC annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp_prim "High Voltage side" annotation (Placement(transformation(extent={{-98,-10},{-78,10}})));
  TransiEnt.Basics.Interfaces.Electrical.ComplexPowerPort epp_sec "Low Voltage side" annotation (Placement(transformation(extent={{-98,-90},{-78,-70}})));

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________

  Modelica.Blocks.Continuous.Derivative derivative(initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(transformation(extent={{-68,-62},{-48,-42}})));
  TransiEnt.Components.Sensors.ElectricVoltageComplex electricVoltageComplex_sec "Low Voltage side"
                                                                                 annotation (Placement(transformation(extent={{-68,-90},{-48,-70}})));
  Modelica.Blocks.Math.ContinuousMean continuousMean "calculates mean since switch on"
                                                     annotation (Placement(transformation(extent={{12,-78},{32,-58}})));
  Modelica.Blocks.Logical.Timer Timer_recording annotation (Placement(transformation(extent={{12,52},{28,68}})));
  Modelica.Blocks.Math.RealToInteger realToInteger annotation (Placement(transformation(extent={{-72,50},{-52,70}})));
  Modelica.Blocks.Sources.BooleanExpression expression_tap_change_occurred(y=tap_change_occurred) annotation (Placement(transformation(extent={{-46,50},{-14,70}})));
  Modelica.Blocks.Logical.And andWarning annotation (Placement(transformation(extent={{54,28},{68,42}})));
  Modelica.Blocks.Logical.Greater greaterWarning annotation (Placement(transformation(extent={{8,16},{20,28}})));
  TransiEnt.Components.Sensors.ElectricVoltageComplex electricVoltageComplex_prim "High Voltage side"
                                                                                 annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
  Modelica.Blocks.Logical.LessThreshold lessHV_Alarm(threshold=VHVAlarm) annotation (Placement(transformation(extent={{-44,-36},{-24,-16}})));
  Modelica.Blocks.Logical.And andAlarm annotation (Placement(transformation(extent={{72,-14},{86,0}})));
  Modelica.Blocks.Discrete.TriggeredSampler storeHV annotation (Placement(transformation(extent={{-34,10},{-22,-2}})));
  Modelica.Blocks.Math.Feedback substractionHV annotation (Placement(transformation(extent={{10,-8},{30,12}})));
  Modelica.Blocks.Logical.GreaterThreshold
                                  greaterAlarm(threshold=deltaVcrit)
                                               annotation (Placement(transformation(extent={{44,-10},{58,6}})));
                                                 Modelica.Blocks.Logical.Switch switch "switches on the calculation of voltage gradient"
                                                                                       annotation (Placement(transformation(extent={{-26,-78},{-6,-58}})));
  Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-44,-98},{-32,-86}})));
  TransiEnt.Basics.Blocks.UserDefinedFunction DelayBlock(y=delay(DelayBlock.u, T_sample)) annotation (Placement(transformation(extent={{44,-78},{64,-58}})));
  Modelica.Blocks.Logical.Timer Timer_OLTCLimit annotation (Placement(transformation(extent={{6,80},{26,100}})));
  Modelica.Blocks.Logical.And andTimer annotation (Placement(transformation(extent={{20,34},{30,44}})));
  Modelica.Blocks.Sources.BooleanExpression expression_tapMaxreached(y=tapMaxreached == 1)
                                                                                      annotation (Placement(transformation(extent={{-50,80},{-18,100}})));
  Modelica.Blocks.Logical.GreaterThreshold greater_OLTCLimit(threshold=T_max) annotation (Placement(transformation(extent={{52,80},{72,100}})));
  Modelica.Blocks.Logical.GreaterThreshold greater_Timer_recording(threshold=Toff) annotation (Placement(transformation(extent={{48,48},{68,68}})));
  Modelica.Blocks.Logical.Pre pre_OLTCLimit annotation (Placement(transformation(extent={{82,80},{102,100}})));
  Modelica.Blocks.Logical.Pre pre_Timer_recording annotation (Placement(transformation(extent={{82,48},{102,68}})));

  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

  Boolean tap_change_occurred;
  Integer tapMaxreached;

  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________

  Modelica.Blocks.Sources.BooleanExpression expression_tapMaxreached1(y=tapMaxreached == 1 or tapMaxreached == 0)
                                                                                      annotation (Placement(transformation(extent={{-58,34},{-26,54}})));
initial equation

  tap_change_occurred=false;
  tapMaxreached=0;

equation

  //calculation of slope by Blocks
  //other implementation in Blocks

  when change(realToInteger.y) then
    if electricVoltageComplex_sec.v < v_n_sec - deltaV then
    tap_change_occurred=true;
    else

   tap_change_occurred=false;

  end if;
       elsewhen
            pre_Timer_recording.y then
    tap_change_occurred=false;

  end when;

  when input_from_OLTC>=TapMax then
    if tap_change_occurred==true then
      tapMaxreached=1;
    else
      tapMaxreached=0;
    end if;

       elsewhen
            pre_OLTCLimit.y then
    tapMaxreached=2;

  end when;

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________

  connect(electricVoltageComplex_sec.epp, epp_sec) annotation (Line(
      points={{-68,-79.8},{-77,-79.8},{-77,-80},{-88,-80}},
      color={28,108,200},
      thickness=0.5));
  connect(electricVoltageComplex_sec.v, derivative.u) annotation (Line(
      points={{-48,-74},{-70,-74},{-70,-60},{-92,-60},{-92,-52},{-70,-52}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(input_from_OLTC, realToInteger.u) annotation (Line(points={{-100,60},{-74,60}}, color={0,0,127}));
  connect(greaterWarning.y, andWarning.u2) annotation (Line(points={{20.6,22},{34,22},{34,29.4},{52.6,29.4}}, color={255,0,255}));
  connect(andWarning.y, eLIVES_Warning) annotation (Line(points={{68.7,35},{78,35},{78,40},{100,40}}, color={255,0,255}));
  connect(electricVoltageComplex_prim.epp, epp_prim) annotation (Line(
      points={{-68,0.2},{-77,0.2},{-77,0},{-88,0}},
      color={28,108,200},
      thickness=0.5));
  connect(lessHV_Alarm.y, HV_Alarm) annotation (Line(points={{-23,-26},{-20,-26},{-20,-52},{2,-52},{2,-80},{100,-80}},                       color={255,0,255}));
  connect(andAlarm.y, eLIVES_Alarm) annotation (Line(points={{86.7,-7},{88,-7},{88,-22},{94,-22},{94,-20},{100,-20}}, color={255,0,255}));
  connect(andAlarm.u1, eLIVES_Warning) annotation (Line(points={{70.6,-7},{70.6,32},{78,32},{78,40},{100,40}},
                                                                                                             color={255,0,255}));
  connect(storeHV.u, electricVoltageComplex_prim.v) annotation (Line(points={{-35.2,4},{-44,4},{-44,-4},{-48,-4},{-48,6}}, color={0,0,127}));
  connect(substractionHV.u1, storeHV.y) annotation (Line(points={{12,2},{-4,2},{-4,4},{-21.4,4}}, color={0,0,127}));
  connect(substractionHV.u2, electricVoltageComplex_prim.v) annotation (Line(points={{20,-6},{-48,-6},{-48,6}}, color={0,0,127}));
  connect(andAlarm.u2, greaterAlarm.y) annotation (Line(points={{70.6,-12.6},{64,-12.6},{64,-2},{58.7,-2}}, color={255,0,255}));
  connect(continuousMean.u, switch.y) annotation (Line(points={{10,-68},{-5,-68}}, color={0,0,127}));
  connect(derivative.y, switch.u1) annotation (Line(points={{-47,-52},{-38,-52},{-38,-60},{-28,-60}}, color={0,0,127}));
  connect(const.y, switch.u3) annotation (Line(points={{-31.4,-92},{-28,-92},{-28,-76}}, color={0,0,127}));
  connect(DelayBlock.u, continuousMean.y) annotation (Line(points={{42,-68},{33,-68}}, color={0,0,127}));
  connect(DelayBlock.y, greaterWarning.u1) annotation (Line(points={{65,-68},{72,-68},{72,-50},{-6,-50},{-6,22},{6.8,22}}, color={0,0,127}));
  connect(greaterAlarm.u, substractionHV.y) annotation (Line(points={{42.6,-2},{36,-2},{36,2},{29,2}}, color={0,0,127}));
  connect(lessHV_Alarm.u, electricVoltageComplex_prim.v) annotation (Line(points={{-46,-26},{-48,-26},{-48,6}}, color={0,0,127}));
  connect(andTimer.y, andWarning.u1) annotation (Line(points={{30.5,39},{36.35,39},{36.35,35},{52.6,35}}, color={255,0,255}));
  connect(switch.u2, andTimer.u2) annotation (Line(points={{-28,-68},{-44,-68},{-44,-42},{-12,-42},{-12,35},{19,35}},               color={255,0,255}));
  connect(storeHV.trigger, andTimer.u2) annotation (Line(points={{-28,11.08},{-28,36},{-4,36},{-4,35},{19,35}},           color={255,0,255}));
  connect(greaterWarning.u2, continuousMean.y) annotation (Line(points={{6.8,17.2},{6.8,-68},{33,-68}}, color={0,0,127}));
  connect(expression_tap_change_occurred.y, Timer_recording.u) annotation (Line(points={{-12.4,60},{10.4,60}},color={255,0,255}));
  connect(expression_tapMaxreached.y, Timer_OLTCLimit.u) annotation (Line(points={{-16.4,90},{4,90}}, color={255,0,255}));
  connect(andTimer.u2, Timer_recording.u) annotation (Line(points={{19,35},{-6,35},{-6,60},{10.4,60}}, color={255,0,255}));
  connect(Timer_OLTCLimit.y, greater_OLTCLimit.u) annotation (Line(points={{27,90},{50,90}}, color={0,0,127}));
  connect(greater_Timer_recording.u, Timer_recording.y) annotation (Line(points={{46,58},{38,58},{38,60},{28.8,60}}, color={0,0,127}));
  connect(greater_OLTCLimit.y, pre_OLTCLimit.u) annotation (Line(points={{73,90},{80,90}}, color={255,0,255}));
  connect(greater_Timer_recording.y, pre_Timer_recording.u) annotation (Line(points={{69,58},{80,58}}, color={255,0,255}));
  connect(expression_tapMaxreached1.y, andTimer.u1) annotation (Line(points={{-24.4,44},{-4,44},{-4,39},{19,39}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                           Text(
        extent={{-100,100},{100,-100}},
        lineColor={28,108,200},
        textString="!")}),                                       Diagram(coordinateSystem(preserveAspectRatio=false)));
end eLIVES;
