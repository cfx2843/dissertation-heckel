within Phdbook.Kapitel8.Praequalifikation.Anlagen.Photovoltaikanlagen;
model CheckPrognosisPVModule
  PrognosisPVModule prognosisPVModule(use_input_data=true) annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  TransiEnt.Basics.Tables.Ambient.Temperature_Hamburg_900s_2012 temperature_Hamburg_900s_2012_1 annotation (Placement(transformation(extent={{-82,24},{-62,44}})));
  TransiEnt.Basics.Tables.Ambient.Wind_Hamburg_Fuhlsbuettel_3600s_2012 wind_Hamburg_Fuhlsbuettel_3600s_2012_1 annotation (Placement(transformation(extent={{-84,-54},{-64,-34}})));
  TransiEnt.Basics.Tables.Ambient.DNI_Hamburg_3600s_2012_TMY dNI_Hamburg_3600s_2012_TMY annotation (Placement(transformation(extent={{-82,-2},{-62,18}})));
  TransiEnt.Basics.Tables.Ambient.DHI_Hamburg_3600s_2012_TMY dHI_Hamburg_3600s_2012_TMY annotation (Placement(transformation(extent={{-82,-28},{-62,-8}})));
equation
  connect(temperature_Hamburg_900s_2012_1.value, prognosisPVModule.T_in) annotation (Line(points={{-63.2,34},{-38,34},{-38,8},{-10,8}}, color={0,0,127}));
  connect(dNI_Hamburg_3600s_2012_TMY.value, prognosisPVModule.DNI_in) annotation (Line(points={{-63.2,8},{-36,8},{-36,2.4},{-10,2.4}}, color={0,0,127}));
  connect(dHI_Hamburg_3600s_2012_TMY.value, prognosisPVModule.DHI_in) annotation (Line(points={{-63.2,-18},{-36,-18},{-36,-2.6},{-10,-2.6}}, color={0,0,127}));
  connect(wind_Hamburg_Fuhlsbuettel_3600s_2012_1.value, prognosisPVModule.WindSpeed_in) annotation (Line(points={{-65.2,-44},{-38,-44},{-38,-8},{-10,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end CheckPrognosisPVModule;
