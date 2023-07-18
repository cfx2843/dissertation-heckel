within Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen;
model PrognosisWindpark "Takes a single wind turbine model (replacable) and applies a linear low pass filter to model wind park smoothing effects"

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

  extends TransiEnt.Basics.Icons.Windparkmodel;

  // _____________________________________________
  //
  //                 Outer Models
  // _____________________________________________
  outer TransiEnt.SimCenter simCenter;
  outer TransiEnt.ModelStatistics modelStatistics;

  // _____________________________________________
  //
  //             Visible Parameters
  // _____________________________________________

  parameter Real N=100 "Number of turbines in park";
  parameter Modelica.Units.SI.Length z_0=0.3 "Roughness length";
  parameter Modelica.Units.SI.Length h=120 "Hub height of turbines in park";
  parameter Modelica.Units.SI.Length d=100 "Average distance between turbines in park";
  parameter Modelica.Units.SI.Velocity v_mean=10 "Mean wind velocity of park site";

  parameter TransiEnt.Basics.Types.TypeOfPrimaryEnergyCarrier typeOfPrimaryEnergyCarrier=TransiEnt.Basics.Types.TypeOfPrimaryEnergyCarrier.WindOnshore "Type of primary energy carrier for co2 emissions global statistics" annotation (Dialog(group="Statistics"), HideResult=not simCenter.isExpertMode);

  replaceable model ProducerCosts =
      TransiEnt.Components.Statistics.ConfigurationData.PowerProducerCostSpecs.WindOnshore
                                                                                      constrainedby TransiEnt.Components.Statistics.ConfigurationData.PowerProducerCostSpecs.PartialPowerPlantCostSpecs
                                              "Wind turbine model" annotation (Dialog(group="Statistics"),
      __Dymola_choicesAllMatching=true);

  parameter TransiEnt.Basics.Types.TypeOfResource typeOfResource=TransiEnt.Basics.Types.TypeOfResource.Renewable "Type of energy resource for global model statistics" annotation (
    Dialog(group="Statistics"),
    HideResult=not simCenter.isExpertMode,
    Placement(transformation(extent=100)));

  TransiEnt.Producer.Electrical.Wind.Base.LinearizedWindParkFilter WindParkFilter(
    scale_output=true,
    n=N,
    z_0=z_0,
    h=h,
    d=d,
    v_mean=v_mean,
    P_el_start=P_el_start) annotation (Placement(transformation(extent={{30,-20},{50,0}})));

  // _____________________________________________
  //
  //           Instances of other Classes
  // _____________________________________________
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.CollectElectricPower collectElectricPower(typeOfResource=TransiEnt.Basics.Types.TypeOfResource.Renewable)
                                                                                                       annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.CollectGwpEmissionsElectric collectGwpEmissions(typeOfEnergyCarrier=typeOfPrimaryEnergyCarrier) annotation (Placement(transformation(extent={{-8,-100},{12,-80}})));
  TransiEnt.Components.Statistics.Collectors.LocalCollectors.PowerPlantCost collectCosts(redeclare model PowerPlantCostModel = ProducerCosts, P_n=windTurbineModel.P_el_n*(N - 1) "N-1 because the wind turbine model instance adds to statistics itself",
    produces_Q_flow=false,
    consumes_H_flow=false,
    P_el_is=-MaxP_Out)                                                                                                                                                                                                         annotation (HideResult=false, Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,-90})));
        // Hier fehlt P_el_is=-MaxP_Out
  TransiEnt.Basics.Interfaces.Ambient.VelocityIn v_wind "Input for the wind velocity" annotation (Placement(transformation(extent={{-124,-22},{-84,18}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency turbineTerminal(useInputConnector=true) annotation (Placement(transformation(extent={{-14,-10},{6,10}})));
  Modelica.Blocks.Sources.RealExpression P_Turbine(y=turbineTerminal.epp.P) annotation (Placement(transformation(extent={{-22,50},{16,70}})));

  // _____________________________________________
  //
  //             Variable Declarations
  // _____________________________________________

  parameter Real P_el_start=0 "Initial value of output (derivatives of y are zero up to nx-1-th derivative)";
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut MaxP_Out annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  replaceable TransiEnt.Producer.Electrical.Wind.PowerCurveWindPlant windTurbineModel(P_el_n(displayUnit="MW") = 4500000, PowerCurveChar=TransiEnt.Producer.Electrical.Wind.Characteristics.NordexN117_2400kW())
                                                                          annotation (Placement(transformation(extent={{-78,-20},{-24,26}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,38})));
  Modelica.Blocks.Sources.Constant const(k=50) annotation (Placement(transformation(extent={{-56,40},{-36,60}})));
equation
  // _____________________________________________
  //
  //           Characteristic Equations
  // _____________________________________________
collectElectricPower.powerCollector.P=-MaxP_Out;

  // _____________________________________________
  //
  //               Connect Statements
  // _____________________________________________
  connect(modelStatistics.powerCollector[typeOfResource],collectElectricPower.powerCollector);
  connect(modelStatistics.costsCollector, collectCosts.costsCollector);
  connect(WindParkFilter.P_el_WindPark, MaxP_Out) annotation (Line(
      points={{51,-10},{78,-10},{78,0},{106,0}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(v_wind, windTurbineModel.v_wind) annotation (Line(points={{-104,-2},{-89,-2},{-89,17.03},{-75.03,17.03}}, color={0,0,127}));
  connect(windTurbineModel.epp, turbineTerminal.epp) annotation (Line(
      points={{-26.7,19.1},{-26.7,8.55},{-14,8.55},{-14,0}},
      color={0,135,135},
      thickness=0.5));
  connect(P_Turbine.y, gain.u) annotation (Line(points={{17.9,60},{22,60},{22,50},{26,50}}, color={0,0,127}));
  connect(gain.y, WindParkFilter.P_el_WindTurbine) annotation (Line(points={{26,27},{28,27},{28,-10},{29.4,-10}},
                                                                                                              color={0,0,127}));
  connect(const.y, turbineTerminal.f_set) annotation (Line(points={{-35,50},{-22,50},{-22,12},{-9.4,12}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(                           extent={{-100,-100},{100,100}})), Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">1<b><span style=\"color: #008000;\">. Purpose of model</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Applies a third order linear filter to the input. Can be used to filter the power output of a single turbine such that the output is as smooth at it were in a windpark of n turbines. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">See Dany (2000) chapter 2.9 and 3.4.3 for details.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The amplitude spectrum is approximated by a third order transfer function. See matlab scripts in</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">\\\\transientee-sources\\matlab\\pd\\Wind\\WindParkFilter\\</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">for more details how this is done.</span></p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">3. Limits of validity </span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">4. Interfaces</span></b></p>
<p>epp: active power port</p>
<p>v_wind: input for velocity in m/s</p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">5. Nomenclature</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">6. Governing Equations</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">7. Remarks for Usage</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">8. Validation</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">(no remarks)</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">9. References</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">[1] G. Dany, &ldquo;Kraftwerksreserve in elektrischen Verbundsystemen mit hohem Windenergieanteil,&rdquo; Rheinisch-Westfälische Technische Hochschule Aachen, 2000.</span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">10. Version History</span></b></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model created by Pascal Dubucq (dubucq@tuhh.de) on Wedn Apr 14 2016</span></p>
</html>"),
    Icon(graphics={
        Text(
          extent={{-142,-103},{158,-143}},
          lineColor={0,134,134},
          textString="%name")}));
end PrognosisWindpark;
