within Phdbook.Kapitel8.Praequalifikation.Anlagen.Brennstoffzellen;
block PEM_Elektrolyseur
  import TransiEnt;

  TransiEnt.Basics.Interfaces.Electrical.ActivePowerPort epp annotation (Placement(transformation(extent={{-126,-24},{-80,22}}), iconTransformation(extent={{-126,-24},{-80,22}})));
  TransiEnt.Producer.Gas.Electrolyzer.PEMElectrolyzer_L1 Elektrolyleur(
    integrateH2Flow=false,
    eta_n=eta_n,
    T_out=T_out,
    P_el_n=P_el_n,
    P_el_max=P_el_n,
    usePowerPort=true,
    redeclare model Charline = TransiEnt.Producer.Gas.Electrolyzer.Base.ElectrolyzerEfficiencyCharlineSilyzer200,
    redeclare model Dynamics = TransiEnt.Producer.Gas.Electrolyzer.Base.ElectrolyzerDynamics2ndOrder,
    redeclare model CostSpecsGeneral = TransiEnt.Components.Statistics.ConfigurationData.GeneralCostSpecs.Electrolyzer_2035,
    Cspec_demAndRev_el=simCenter.Cspec_demAndRev_el_70_150_GWh,
    Cspec_demAndRev_other=simCenter.Cspec_demAndRev_other_water) annotation (Placement(transformation(extent={{-24,-48},{-4,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-Elektrolyleur.gasPortOut.m_flow)
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
  parameter Modelica.Units.SI.Power P_el_n=0.5e6 "Nominal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Power P_el_min=0.05*P_el_n "Minimal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Power P_el_max=1.0*P_el_n "Maximal electrical power of the electrolyzer";
  parameter Modelica.Units.SI.Temperature T_out=273.15 + 15 "Temperature of the produced hydrogen";
  parameter Modelica.Units.SI.Efficiency eta_n=0.75 "Nominal efficiency of the electrolyzer";
  parameter Modelica.Units.SI.Pressure p_out=5000000 "Pressure of the produced hydrogen";
  inner TransiEnt.SimCenter simCenter(redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_H2_SRK gasModel1, redeclare TransiEnt.Basics.Media.Gases.VLE_VDIWA_H2_SRK gasModel3)
                                                                       annotation (Placement(transformation(extent={{104,72},{124,92}})));
  inner TransiEnt.ModelStatistics                                         modelStatisticsDetailed annotation (Placement(transformation(extent={{114,72},{134,92}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=P_el_n, uMin=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={32,-12})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_max annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=180,
        origin={-103,-65}), iconTransformation(
        extent={{-19,-19},{19,19}},
        rotation=180,
        origin={-103,-65})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=P_el_n)                         annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-46,-66})));
equation
  connect(Elektrolyleur.epp, epp) annotation (Line(
      points={{-24,-38},{-64,-38},{-64,-1},{-103,-1}},
      color={0,135,135},
      thickness=0.5));
  connect(realExpression.y, m_flow) annotation (Line(points={{-27,42},{-60,42},{-60,69},{-109,69}}, color={0,0,127}));
  connect(limiter.y, Elektrolyleur.P_el_set) annotation (Line(points={{21,-12},{0,-12},{0,-26},{-18,-26}}, color={0,0,127}));
  connect(limiter.u, electricPowerIn) annotation (Line(points={{44,-12},{70,-12},{70,-44},{108,-44}}, color={0,0,127}));
  connect(realExpression1.y, P_max) annotation (Line(points={{-57,-66},{-80,-66},{-80,-65},{-103,-65}}, color={0,0,127}));
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
<p><span style=\"font-family: MS Shell Dlg 2;\">Generischer Elektrolyseur</span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">Erstellt durch: Daniel Ducci</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </span></p>
</html>"));
end PEM_Elektrolyseur;
