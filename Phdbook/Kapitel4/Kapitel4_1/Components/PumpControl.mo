within Phdbook.Kapitel4.Kapitel4_1.Components;
model PumpControl
  parameter Real m_flow_max;
  parameter Real T_firstOrder;
  parameter Real c_p;
  parameter Modelica.Units.SI.Temperature T_set;
  TransiEnt.Basics.Interfaces.General.TemperatureIn T_beforeBoiler annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  TransiEnt.Basics.Interfaces.General.MassFlowRateOut m_flow annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  TransiEnt.Basics.Blocks.FirstOrder firstOrder(Tau=T_firstOrder) annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  TransiEnt.Basics.Interfaces.Thermal.HeatFlowRateIn Q_set annotation (Placement(transformation(extent={{-126,36},{-86,76}})));
  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(transformation(extent={{-124,70},{-84,110}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMin=0, uMax=m_flow_max) annotation (Placement(transformation(extent={{66,20},{86,40}})));
equation

    if u then
    firstOrder.u = Q_set/(c_p*(T_set-T_beforeBoiler));
  else
    firstOrder.u = 0;
    end if;

  connect(firstOrder.y, limiter.u) annotation (Line(points={{11,2},{36,2},{36,30},{64,30}}, color={0,0,127}));
  connect(limiter.y, m_flow) annotation (Line(points={{87,30},{92,30},{92,28},{108,28},{108,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end PumpControl;
