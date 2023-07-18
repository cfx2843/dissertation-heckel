within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
model PrimaryBalancingController "Primary balancing controller model based on Weissbach (2009)"

//________________________________________________________________________________//
// Component of the TransiEnt Library, version: 1.2.0                             //
//                                                                                //
// Licensed by Hamburg University of Technology under Modelica License 2.         //
// Copyright 2019, Hamburg University of Technology.                              //
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

  // _____________________________________________
  //
  //                   Parameters
  // _____________________________________________
  extends TransiEnt.Basics.Icons.Controller;

  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_Angebot annotation (Placement(transformation(extent={{-148,38},{-78,88}}), iconTransformation(extent={{-148,38},{-78,88}})));
  TransiEnt.Basics.Interfaces.Electrical.FrequencyIn Frequenzy annotation (Placement(transformation(extent={{-150,-98},{-74,-48}}), iconTransformation(extent={{-150,-98},{-74,-48}})));
  Modelica.Blocks.Sources.Constant Sollfrequenz(k=50) annotation (Placement(transformation(extent={{-94,-22},{-74,-2}})));
  Modelica.Blocks.Math.Add delta_f(k1=-1) annotation (Placement(transformation(extent={{-52,-42},{-32,-22}})));
  Modelica.Blocks.Math.Gain Verstaerker(k=-1/0.2)
                                                 annotation (Placement(transformation(extent={{4,-40},{24,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=-1) annotation (Placement(transformation(extent={{32,-40},{52,-20}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2) annotation (Placement(transformation(extent={{68,-24},{80,-12}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set annotation (Placement(transformation(extent={{92,-44},{144,8}}), iconTransformation(extent={{92,-44},{144,8}})));
equation
  if delta_f.y>-0.01 and 0.01>delta_f.y then
    Verstaerker.u=0;
  else
    Verstaerker.u=delta_f.y;
    end if;
  connect(Sollfrequenz.y, delta_f.u1) annotation (Line(points={{-73,-12},{-62,-12},{-62,-26},{-54,-26}}, color={0,0,127}));
  connect(Frequenzy, delta_f.u2) annotation (Line(points={{-112,-73},{-62,-73},{-62,-38},{-54,-38}}, color={0,127,127}));
  connect(PRL_Angebot, multiProduct.u[1]) annotation (Line(points={{-113,63},{56,63},{56,-15.9},{68,-15.9}}, color={0,127,127}));
  connect(P_set, multiProduct.y) annotation (Line(
      points={{118,-18},{81.02,-18}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(limiter.y, multiProduct.u[2]) annotation (Line(points={{53,-30},{60,-30},{60,-20.1},{68,-20.1}}, color={0,0,127}));
  connect(Verstaerker.y, limiter.u) annotation (Line(points={{25,-30},{30,-30}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>Prim&auml;rregler</p>
<p>Modifiziert durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end PrimaryBalancingController;
