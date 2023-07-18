within Phdbook.Kapitel5.Kapitel5_1;
model OLTC_OutputCurrentTap
  extends TransiEnt.Components.Electrical.PowerTransformation.OLTC.TapChangerController;
  Modelica.Blocks.Interfaces.RealOutput CurrentTapOut annotation (Placement(transformation(extent={{90,-86},{110,-66}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=currentTap) annotation (Placement(transformation(extent={{40,-86},{60,-66}})));
equation
  connect(realExpression.y, CurrentTapOut) annotation (Line(points={{61,-76},{100,-76}}, color={0,0,127}));
end OLTC_OutputCurrentTap;
