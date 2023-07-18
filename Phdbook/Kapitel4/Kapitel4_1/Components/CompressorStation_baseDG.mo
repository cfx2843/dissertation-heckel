within Phdbook.Kapitel4.Kapitel4_1.Components;
model CompressorStation_baseDG
  extends TransiEnt.Basics.Icons.Model;
  TransiEnt.Components.Gas.Compressor.CompressorRealGasIsentropicEff_L1_simple compressor(
    final medium=medium,
    final eta_mech=eta_mech,
    final eta_el=eta_el,
    final presetVariableType="P_shaft",
    final useMechPowerPort=useMechPowerPort,
    use_P_shaftInput=true,
    final P_el_n=P_el_n,
    final Delta_p_start=Delta_p_start,
    final allow_reverseFlow=allow_reverseFlow,
    final eta_is=eta_is,
    final Pi_start=Pi_start)          annotation (Placement(transformation(extent={{-18,-10},{2,10}})));
  TransiEnt.Components.Gas.HeatExchanger.HEXOneRealGasOuterTIdeal_L1 hEX(
    final medium=medium,
    final hEXMode="CoolingOnly",
    final T_fluidOutConst=T_cool) annotation (Placement(transformation(extent={{12,10},{32,-10}})));
  TransiEnt.Basics.Interfaces.General.MechanicalPowerIn  P_shaft_in annotation (Placement(transformation(
        rotation=270,
        extent={{-10,-10},{10,10}},
        origin={0,100})));
  TransiEnt.Basics.Interfaces.Gas.RealGasPortIn gasPortIn(Medium=medium) annotation (Placement(transformation(rotation=0, extent={{-110,-10},{-90,10}})));
  TransiEnt.Basics.Interfaces.Gas.RealGasPortOut gasPortOut(Medium=medium) annotation (Placement(transformation(rotation=0, extent={{90,-10},{110,10}})));
  outer TransiEnt.SimCenter simCenter;
  parameter TILMedia.VLEFluidTypes.BaseVLEFluid medium=simCenter.gasModel1 annotation (Dialog(group="Fundamental Definitions"));
  parameter Modelica.Units.SI.Efficiency eta_mech=0.95 "Mechanical efficiency" annotation (Dialog(group="Fundamental Definitions"));
  parameter Modelica.Units.SI.Efficiency eta_el=0.97 "Electrical efficiency" annotation (Dialog(group="Fundamental Definitions"));
  parameter Real eta_is=0.8 "Isentropic efficiency" annotation (Dialog(group="Fundamental Definitions"));
  parameter Modelica.Units.SI.Power P_el_n=1e3 "Nominal power for cost calculation" annotation (Dialog(group="Statistics"));
  parameter Modelica.Units.SI.PressureDifference Delta_p_start=100 "Start value for pressure increase" annotation (Dialog(group="Initialization"));
//   parameter SI.SpecificEnthalpy deltah_start=1e4 "Start value for specific enthalpy difference between outlet and inlet" annotation (Dialog(group="Initialization"));
  parameter Modelica.Units.SI.Temperature T_cool=303.15 "Constant cooling temperature of the medium at HEX outlet" annotation (Dialog(group="Fundamental Definitions"));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=simCenter.T_amb_const) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={22,-42})));
  parameter Boolean allow_reverseFlow=false "true if reverse flow should be prohibited (might be faster if small reverse flow occurs at almost zero flow)" annotation (Dialog(group="Expert Settings"));
  parameter Real Pi_start=1.1 "Start value for pressure ratio of compressor (is only used for determination of start value for deltah)" annotation (Dialog(group="Initialization"));
  parameter Boolean useMechPowerPort=false "true if mechanical power port shall be visible";
  TransiEnt.Basics.Interfaces.General.MechanicalPowerPort
                                                mpp if useMechPowerPort annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
equation
  connect(compressor.gasPortOut, hEX.gasPortIn) annotation (Line(
      points={{2,0},{12,0}},
      color={255,255,0},
      thickness=1.5));
  connect(gasPortIn, compressor.gasPortIn) annotation (Line(points={{-100,0},{-18,0}}, color={255,255,0},
      thickness=1.5));
  connect(gasPortOut, hEX.gasPortOut) annotation (Line(points={{100,0},{32,0}}, color={255,255,0},
      thickness=1.5));
  connect(fixedTemperature.port, hEX.heat) annotation (Line(points={{22,-32},{22,-10}}, color={191,0,0}));
  connect(mpp, compressor.mpp) annotation (Line(points={{0,-100},{0,-20},{-8,-20},{-8,-10}}, color={95,95,95}));
  connect(P_shaft_in, compressor.P_shaft_in) annotation (Line(points={{0,100},{0,20},{-11,20},{-11,11}}, color={0,0,127}));
  annotation (Icon(graphics={
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Rectangle(
          extent={{10,30},{70,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{26,-36},{26,14},{40,0},{54,14},{54,-36}}, color={0,0,0}),
        Ellipse(
          extent={{-70,30},{-10,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-62,20},{-12,8}}, color={0,0,0}),
        Line(points={{-62,-18},{-12,-6}}, color={0,0,0})}), Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>This model represents the base class of a compressor station with a compressor and a heat exchanger for cooling afterwards.</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">4. Interfaces</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>(no remarks) </p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
<p>Model created by Carsten Bode (c.bode@tuhh.de) in Aug 2019</p>
</html>"));
end CompressorStation_baseDG;
