within Phdbook.Kapitel4.Kapitel4_2;
model IES_dynamicload_lfail_2s
  extends IES_dynamicload_normal_2s(BooleanFault(startTime=13300));
  annotation (Diagram(graphics={
        Text(
          extent={{-314,-122},{-318,-124}},
          lineColor={28,108,200},
          textString="IES-Modell für einen Leitungsausfall bei t=13300 s unter Normallast.
")}));
end IES_dynamicload_lfail_2s;
