within Phdbook.Kapitel8.Praequalifikation.Anlagen.BHKW_dynamisch;
model Check_BHKW
  BHKW bHKW(
    P_el_n=1600000,
    m_dot=0.09,          m_Speicher=1000*1.2)
                                         annotation (Placement(transformation(extent={{-38,-26},{32,8}})));
  Modelica.Blocks.Sources.Step step(
    height=-400e3,
    offset=0,
    startTime=0)   annotation (Placement(transformation(extent={{-198,-24},{-178,-4}})));
  Modelica.Blocks.Sources.Constant Spotmarkt(k=-1.5e6)
                                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-24})));
  Modelica.Blocks.Math.Sum sum1(nin=2) annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
public
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid1(useInputConnector=true)
                                                                                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={98,-42})));
  TransiEnt.Basics.Tables.GenericDataTable Frequenzdaten(
    multiple_outputs=false,
    use_absolute_path=true,
    absolute_path="C:/Users/MIni-Tower/Git/ducci/Wetterdaten/2016/Frequenz2016.txt",
    shiftTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-176,-60})));
  Langzeitsimulation.Regler.PrimaryBalancingController primaryBalancingController annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-52})));
equation
  connect(Frequenzdaten.y1,ElectricGrid1. f_set) annotation (Line(points={{-165,-60},{-165,-72},{126,-72},{126,-36.6},{110,-36.6}},
                                                                                                               color={0,0,127}));
  connect(Frequenzdaten.y1,primaryBalancingController. Frequenzy) annotation (Line(points={{-165,-60},{-148,-60},{-148,-59.3},{-121.2,-59.3}},
                                                                                                                                     color={0,0,127}));
  connect(step.y,primaryBalancingController. PRL_Angebot) annotation (Line(points={{-177,-14},{-160,-14},{-160,-45.7},{-121.3,-45.7}}, color={0,0,127}));
  connect(Spotmarkt.y,sum1. u[1]) annotation (Line(points={{-99,-24},{-98,-24},{-98,-25},{-92,-25}},     color={0,0,127}));
  connect(primaryBalancingController.P_set,sum1. u[2]) annotation (Line(
      points={{-98.2,-53.8},{-98.2,-43.9},{-92,-43.9},{-92,-23}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(sum1.y, bHKW.electricPowerIn) annotation (Line(points={{-69,-24},{-56,-24},{-56,-17.5},{-40.5667,-17.5}},   color={0,0,127}));
  connect(bHKW.epp, ElectricGrid1.epp) annotation (Line(
      points={{32,5.96},{65.2059,5.96},{65.2059,-32},{98,-32}},
      color={0,135,135},
      thickness=0.5));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=172800,
      Interval=10.000008,
      __Dymola_Algorithm="Dassl"));
end Check_BHKW;
