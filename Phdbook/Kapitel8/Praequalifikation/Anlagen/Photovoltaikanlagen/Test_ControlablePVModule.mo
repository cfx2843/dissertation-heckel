within Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen;
model Test_ControlablePVModule
  import MABook;
  TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_900s_2012 temperature_Hamburg_900s_2012_1 annotation (Placement(transformation(extent={{-86,42},{-66,62}})));
  TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind_Hamburg_Fuhlsbuettel_3600s_2012_1 annotation (Placement(transformation(extent={{-88,-36},{-68,-16}})));
  TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY dNI_Hamburg_3600s_2012_TMY annotation (Placement(transformation(extent={{-86,16},{-66,36}})));
  TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY dHI_Hamburg_3600s_2012_TMY annotation (Placement(transformation(extent={{-86,-10},{-66,10}})));
  Modelica.Blocks.Sources.Constant const(k=-20) annotation (Placement(transformation(extent={{-22,-38},{-2,-18}})));
  TransiEnt.Components.Boundaries.Electrical.ActivePower.Frequency ElectricGrid annotation (Placement(transformation(extent={{38,2},{58,22}})));
  Anlagen.Photovoltaikanlagen.ControlablePVModule controlablePVModule(use_input_data=true) annotation (Placement(transformation(extent={{6,26},{26,46}})));
equation
  connect(ElectricGrid.epp, controlablePVModule.epp) annotation (Line(
      points={{38,12},{32,12},{32,35.4},{25.3,35.4}},
      color={0,135,135},
      thickness=0.5));
  connect(temperature_Hamburg_900s_2012_1.y1, controlablePVModule.T_in) annotation (Line(points={{-65,52},{-30,52},{-30,44},{4,44}}, color={0,0,127}));
  connect(dNI_Hamburg_3600s_2012_TMY.value, controlablePVModule.DNI_in) annotation (Line(points={{-67.2,26},{-32,26},{-32,38.4},{4,38.4}}, color={0,0,127}));
  connect(dHI_Hamburg_3600s_2012_TMY.value, controlablePVModule.DHI_in) annotation (Line(points={{-67.2,0},{-32,0},{-32,33.4},{4,33.4}}, color={0,0,127}));
  connect(wind_Hamburg_Fuhlsbuettel_3600s_2012_1.value, controlablePVModule.WindSpeed_in) annotation (Line(points={{-69.2,-26},{-32,-26},{-32,28},{4,28}}, color={0,0,127}));
  connect(controlablePVModule.P_set, const.y) annotation (Line(points={{13.4,25.5},{13.4,-1.25},{-1,-1.25},{-1,-28}}, color={0,127,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end Test_ControlablePVModule;
