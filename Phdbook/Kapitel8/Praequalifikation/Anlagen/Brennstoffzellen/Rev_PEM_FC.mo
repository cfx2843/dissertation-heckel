within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block Rev_PEM_FC
  import TransiEnt;

  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{-126,-24},{-80,22}}), iconTransformation(extent={{-126,-24},{-80,22}})));
  TransiEnt.Producer.Gas.Electrolyzer.PEMElectrolyzer_L1 Elektrolyleur(
    eta_n=eta_n,
    T_out=T_out,
    P_el_n=(0.75/0.4)*P_el_n,
    P_el_max=P_el_max,
    usePowerPort=true,
    redeclare model Charline = TransiEnt.Producer.Gas.Electrolyzer.Base.ElectrolyzerEfficiencyCharlineSilyzer200,
    redeclare model Dynamics = TransiEnt.Producer.Gas.Electrolyzer.Base.ElectrolyzerDynamics2ndOrder,
    redeclare model CostSpecsGeneral = TransiEnt.Components.Statistics.ConfigurationData.GeneralCostSpecs.Electrolyzer_2035,
    Cspec_demAndRev_el=simCenter.Cspec_demAndRev_el_70_150_GWh,
    Cspec_demAndRev_other=simCenter.Cspec_demAndRev_other_water) annotation (Placement(transformation(extent={{-24,-48},{-4,-28}})));
  TransiEnt.Components.Boundaries.Gas.BoundaryRealGas_pTxi sink_2ndOrder(variable_p=false, p_const=p_out)
                                                                                        annotation (Placement(transformation(extent={{34,-96},{14,-76}})));
  Fuelcell fuelcell(eta_FC=0.4, P_max=P_el_n)
                    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,20})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-Elektrolyleur.gasPortOut.m_flow*10)
                                                                                           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-16,42})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn electricPowerIn annotation (Placement(transformation(
        extent={{-24,-24},{24,24}},
        rotation=180,
        origin={108,-44}),
                         iconTransformation(
        extent={{-24,-24},{24,24}},
        rotation=180,
        origin={108,-44})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateOut m_flow annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=180,
        origin={-109,69}), iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=180,
        origin={-109,69})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-58,36})));
  parameter Modelica.Units.SI.Power P_el_n=1e6 "Nominal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Power P_el_min=0.05*P_el_n "Minimal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Power P_el_max=1.0*P_el_n "Maximal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Temperature T_out=273.15 + 15 "Temperature of the produced hydrogen";
  parameter Modelica.Units.SI.Efficiency eta_n=0.75 "Nominal efficiency of the electrolyzer";
  parameter Modelica.Units.SI.Pressure p_out=5000000 "Pressure of the produced hydrogen";
  inner TransiEnt.SimCenter simCenter(redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_H2_SRK gasModel1, redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_H2_SRK gasModel3)
                                                                       annotation (Placement(transformation(extent={{104,72},{124,92}})));
  inner TransiEnt.ModelStatistics                                         modelStatisticsDetailed annotation (Placement(transformation(extent={{114,72},{134,92}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=(0.75/0.4)*P_el_n,
                                                         uMin=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={26,-18})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Zusatzleistung_verdichter annotation (Placement(transformation(
        extent={{-30,-31},{30,31}},
        rotation=180,
        origin={110,11}), iconTransformation(
        extent={{-23,-23},{23,23}},
        rotation=180,
        origin={93,67})));
  Modelica.Blocks.Math.Add add1(k2=-1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={58,-16})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_max_Ely annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-106,-48})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_max_FC annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-104,-76})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=P_el_n)                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-56,-48})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=-P_el_n)                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-54,-74})));
equation
  connect(sink_2ndOrder.gasPort, Elektrolyleur.gasPortOut) annotation (Line(
      points={{14,-86},{-4,-86},{-4,-38}},
      color={255,255,0},
      thickness=1.5));
  connect(fuelcell.epp, epp) annotation (Line(
      points={{-25.8,13.8},{-65.9,13.8},{-65.9,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(Elektrolyleur.epp, epp) annotation (Line(
      points={{-24,-38},{-64,-38},{-64,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(add.u2, realExpression.y) annotation (Line(points={{-46,42},{-27,42}}, color={0,0,127}));
  connect(add.u1, fuelcell.m_dot_H2) annotation (Line(points={{-46,30},{-36,30},{-36,20},{-26.4,20}}, color={0,0,127}));
  connect(add.y, m_flow) annotation (Line(points={{-69,36},{-69,70},{-109,70},{-109,69}}, color={0,0,127}));
  connect(Elektrolyleur.P_el_set, limiter.y) annotation (Line(points={{-18,-26},{4,-26},{4,-18},{15,-18}}, color={0,127,127}));
  connect(limiter.u, add1.y) annotation (Line(points={{38,-18},{44,-18},{44,-16},{47,-16}}, color={0,0,127}));
  connect(add1.y, fuelcell.P_el_set) annotation (Line(points={{47,-16},{42,-16},{42,15.6},{-0.3,15.6}}, color={0,0,127}));
  connect(electricPowerIn, add1.u1) annotation (Line(points={{108,-44},{90,-44},{90,-22},{70,-22}}, color={0,127,127}));
  connect(Zusatzleistung_verdichter, add1.u2) annotation (Line(points={{110,11},{90,11},{90,-10},{70,-10}}, color={0,127,127}));
  connect(realExpression1.y, P_max_Ely) annotation (Line(points={{-67,-48},{-106,-48}}, color={0,0,127}));
  connect(realExpression2.y, P_max_FC) annotation (Line(points={{-65,-74},{-84,-74},{-84,-76},{-104,-76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{34,84},{106,54}},
          lineColor={0,140,72},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          horizontalAlignment=TextAlignment.Left,
          textString="P_el_n=1 MW
P_el_min=0.05 MW
P_el_max=1 MW
eta_n=0.75
T_out=15 C
p_out=50 bar
costs for electrolyzers in 2035
with electricity price 103.3 EUR/MWh")}),
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Generischereversible Brennstoffzelle</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end Rev_PEM_FC;
