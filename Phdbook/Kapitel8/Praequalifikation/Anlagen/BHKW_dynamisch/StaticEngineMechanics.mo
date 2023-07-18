within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
model StaticEngineMechanics "Static mechanical behavior of an engine"

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
  extends TransiEnt.Components.Gas.Engines.Mechanics.BasicEngineMechanics;

  // _____________________________________________
  //
  //          Instances of Other Classes
  // _____________________________________________
  Modelica.Blocks.MathBoolean.OnDelay onDelay(delayTime=Specification.syncTime)  annotation (Placement(transformation(extent={{-50,-22},{-36,-8}})));
  Modelica.Blocks.Logical.Switch clutch  annotation (Placement(transformation(extent={{-6,-22},{6,-10}})));
  Modelica.Blocks.Sources.Constant zero(k=0) annotation (Placement(transformation(extent={{-50,-58},{-34,-41}})));
  TransiEnt.Components.Boundaries.Mechanical.Power mechanicalPower(change_sign=true) annotation (Placement(transformation(
        extent={{-11,-12},{11,12}},
        rotation=0,
        origin={65,-52})));

  // _____________________________________________
  //
  //          Characteristic Equations
  // _____________________________________________

  Modelica.Blocks.Continuous.FirstOrder Bereich_1(T=3.255) "15s 0-65%" annotation (Placement(transformation(extent={{12,70},{32,90}})));
  Modelica.Blocks.Continuous.FirstOrder Bereich_2(T=2.61) "12s 65-85%" annotation (Placement(transformation(extent={{16,38},{36,58}})));
  Modelica.Blocks.Continuous.FirstOrder Bereich_3(T=2.17) "10s 85-93%" annotation (Placement(transformation(extent={{16,0},{36,20}})));
  Modelica.Blocks.Continuous.FirstOrder Bereich_4(T=1.735) "15s 93-100%" annotation (Placement(transformation(extent={{16,-30},{36,-10}})));
  VarFirstOrder varFirstOrder annotation (Placement(transformation(extent={{22,-60},{42,-40}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_el_is annotation (Placement(transformation(
        extent={{-18,-18},{18,18}},
        rotation=270,
        origin={-64,-112}), iconTransformation(extent={{-76,-106},{-40,-70}})));
equation
  if (mechanicalPower.P_mech_set/Specification.P_el_max)<0.65 then
  varFirstOrder.T=3.255;
  elseif (mechanicalPower.P_mech_set/Specification.P_el_max)<0.85 then
     varFirstOrder.T=2.61;
   elseif (mechanicalPower.P_mech_set/Specification.P_el_max)<0.93 then
    varFirstOrder.T=2.17;
  else
    varFirstOrder.T=1.1735;
  end if;
if switch then
   eta_el=partloadEfficiency.eta_is[1];
  eta_h = partloadEfficiency.eta_is[2];
else
    eta_el = 1e-10;
    eta_h = 1e-10;
  end if;

  connect(onDelay.y, clutch.u2) annotation (Line(
      points={{-34.6,-15},{-16.3,-15},{-16.3,-16},{-7.2,-16}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(zero.y, clutch.u3) annotation (Line(
      points={{-33.2,-49.5},{-33.2,-50},{-7.2,-50},{-7.2,-20.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(clutch.u1, P_el_set) annotation (Line(
      points={{-7.2,-11.2},{-12,-11.2},{-12,-14},{-16,-14},{-16,-10},{-108,-10}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(switch, onDelay.u) annotation (Line(
      points={{-108,-60},{-82,-60},{-82,-15},{-52.8,-15}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(mechanicalPower.mpp, mpp) annotation (Line(
      points={{76,-52},{80,-52},{80,-2},{100,-2}},
      color={95,95,95},
      smooth=Smooth.None));
  connect(Bereich_1.u, clutch.y) annotation (Line(points={{10,80},{10,-16},{6.6,-16}}, color={0,0,127}));
  connect(Bereich_2.u, clutch.y) annotation (Line(points={{14,48},{10,48},{10,14},{6,14},{6,-16},{6.6,-16}}, color={0,0,127}));
  connect(Bereich_1.u, Bereich_2.u) annotation (Line(points={{10,80},{10,48},{14,48}}, color={0,0,127}));
  connect(Bereich_3.u, clutch.y) annotation (Line(points={{14,10},{6,10},{6,-16},{6.6,-16}}, color={0,0,127}));
  connect(Bereich_4.u, clutch.y) annotation (Line(points={{14,-20},{12,-20},{12,-16},{6.6,-16}}, color={0,0,127}));
  connect(varFirstOrder.u, clutch.y) annotation (Line(points={{20,-50},{14,-50},{14,-16},{6.6,-16}}, color={0,0,127}));
  connect(varFirstOrder.y, mechanicalPower.P_mech_set) annotation (Line(points={{43,-50},{54,-50},{54,-37.84},{65,-37.84}}, color={0,0,127}));
  connect(varFirstOrder.y, P_el_is) annotation (Line(points={{43,-50},{46,-50},{46,-72},{-64,-72},{-64,-112}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
                                          Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Simple model for the mechanical behaviour of an engine to supply a targeted mechanical power output.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>switch - boolean input to switch the engine on/off</p>
<p>P_el - target mechanical power input</p>
<p>efficienciesOut[2] - ouput connector for electrical [1] and overall [2] efficiency of the engine</p>
<p>temperaturesIn[2] - input connector for temperature levels in the engine (as the efficiencies in the more complex models are calculated based on temperature-dependent empirical equations)</p>
<p>mpp - port for mechanical power output</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>The electrical and overall efficiencies are calculated based on a linear interpolation approach between minimum and maximum power output, as can be seen in the following picture</p>
<p><img src=\"modelica://TransiEnt/Images/interpolation_eta.png\"/></p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>This model has been parametrised and validated as part of the overall CHP-model (DACHS HKA G5.5).</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Created by Arne Koeppen (arne.koeppen@tuhh.de), Apr 2014</p>
<p>Edited by Jan Braune (jan.braune@tuhh.de), Mar 2015</p>
<p>Revised by Lisa Andresen (andresen@tuhh.de), Aug 2015</p>
<p>Edited by Anne Senkel (anne.senkel@tuhh.de), Feb 2019</p>
</html>"));
end StaticEngineMechanics;
