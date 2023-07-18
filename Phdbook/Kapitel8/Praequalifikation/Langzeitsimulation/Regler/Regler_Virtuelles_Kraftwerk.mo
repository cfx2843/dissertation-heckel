within Phdbook.Kapitel8.Praequalifikation.Langzeitsimulation.Regler;
block Regler_Virtuelles_Kraftwerk
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_1 annotation (Placement(transformation(extent={{-114,72},{-94,92}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_1 annotation (Placement(transformation(extent={{-114,-64},{-94,-44}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_1 annotation (Placement(transformation(extent={{94,80},{114,100}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_1 annotation (Placement(transformation(extent={{94,-62},{114,-42}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_set "negativ für positive PRL" annotation (Placement(transformation(extent={{-114,148},{-94,168}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn PRL_Angebot "immer negativ" annotation (Placement(transformation(extent={{-114,178},{-94,198}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_2 annotation (Placement(transformation(extent={{-114,50},{-94,70}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_3 annotation (Placement(transformation(extent={{-116,32},{-96,52}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_4 annotation (Placement(transformation(extent={{-114,10},{-94,30}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_PV_5 annotation (Placement(transformation(extent={{-114,-12},{-94,8}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_2 annotation (Placement(transformation(extent={{-114,-86},{-94,-66}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_3 annotation (Placement(transformation(extent={{-114,-112},{-94,-92}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_4 annotation (Placement(transformation(extent={{-112,-136},{-92,-116}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerIn Max_Wind_5 annotation (Placement(transformation(extent={{-112,-156},{-92,-136}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_2 annotation (Placement(transformation(extent={{94,60},{114,80}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_3 annotation (Placement(transformation(extent={{94,42},{114,62}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_4 annotation (Placement(transformation(extent={{94,22},{114,42}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_PV_5 annotation (Placement(transformation(extent={{94,2},{114,22}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_2 annotation (Placement(transformation(extent={{94,-86},{114,-66}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_3 annotation (Placement(transformation(extent={{96,-110},{116,-90}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_4 annotation (Placement(transformation(extent={{96,-134},{116,-114}})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut P_set_Wind_5 annotation (Placement(transformation(extent={{96,-158},{116,-138}})));
  Modelica.Blocks.Interfaces.BooleanOutput PRL_erfuellt annotation (Placement(transformation(extent={{92,182},{112,202}})));
  Modelica.Blocks.Interfaces.BooleanOutput PRL_geliefert annotation (Placement(transformation(extent={{92,158},{112,178}})));
  Modelica.Blocks.Math.MultiSum Sum_PV(nu=5) annotation (Placement(transformation(extent={{-48,16},{-8,56}})));
  Modelica.Blocks.Math.MultiSum Sum_Wind(nu=5) annotation (Placement(transformation(extent={{-50,-114},{-10,-74}})));
  Modelica.Blocks.Interfaces.RealOutput Usage annotation (Placement(transformation(extent={{94,134},{114,154}})));
  Modelica.Blocks.Math.MultiSum Sum_Wind1(nu=2)
                                               annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-30,130})));
  TransiEnt.Basics.Interfaces.Electrical.ElectricPowerOut Max_Sum annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,126})));
equation
  if Sum_PV.y + Sum_Wind.y - PRL_Angebot + PRL_set <= 0 then
    PRL_geliefert=true;
    if Max_PV_1 - PRL_Angebot + PRL_set < 0 then
      P_set_PV_1 = Max_PV_1 - PRL_Angebot + PRL_set;
      P_set_PV_2 = Max_PV_2;
      P_set_PV_3 = Max_PV_3;
      P_set_PV_4 = Max_PV_4;
      P_set_PV_5 = Max_PV_5;
      P_set_Wind_1 = Max_Wind_1;
      P_set_Wind_2 = Max_Wind_2;
      P_set_Wind_3 = Max_Wind_3;
      P_set_Wind_4 = Max_Wind_4;
      P_set_Wind_5 = Max_Wind_5;
    else
      P_set_PV_1 = 0;
      if Max_PV_1 + Max_PV_2 - PRL_Angebot + PRL_set < 0 then
        P_set_PV_2 = Max_PV_2 - (PRL_Angebot-Max_PV_1) +PRL_set;
        P_set_PV_3 = Max_PV_3;
        P_set_PV_4 = Max_PV_4;
        P_set_PV_5 = Max_PV_5;
        P_set_Wind_1 = Max_Wind_1;
        P_set_Wind_2 = Max_Wind_2;
        P_set_Wind_3 = Max_Wind_3;
        P_set_Wind_4 = Max_Wind_4;
        P_set_Wind_5 = Max_Wind_5;
      else
        P_set_PV_2 = 0;
        if Max_PV_1 + Max_PV_2 + Max_PV_3 - PRL_Angebot + PRL_set < 0 then
          P_set_PV_3 = Max_PV_3 - (PRL_Angebot-Max_PV_1-Max_PV_2) +PRL_set;
          P_set_PV_4 = Max_PV_4;
          P_set_PV_5 = Max_PV_5;
          P_set_Wind_1 = Max_Wind_1;
          P_set_Wind_2 = Max_Wind_2;
          P_set_Wind_3 = Max_Wind_3;
          P_set_Wind_4 = Max_Wind_4;
          P_set_Wind_5 = Max_Wind_5;
        else
          P_set_PV_3 = 0;
          if Max_PV_1 + Max_PV_2 + Max_PV_3 + Max_PV_4 - PRL_Angebot + PRL_set < 0 then
            P_set_PV_4 = Max_PV_4 - (PRL_Angebot-Max_PV_1-Max_PV_2-Max_PV_3) +PRL_set;
            P_set_PV_5 = Max_PV_5;
            P_set_Wind_1 = Max_Wind_1;
            P_set_Wind_2 = Max_Wind_2;
            P_set_Wind_3 = Max_Wind_3;
            P_set_Wind_4 = Max_Wind_4;
            P_set_Wind_5 = Max_Wind_5;
          else
            P_set_PV_4 = 0;
            if Sum_PV.y - PRL_Angebot + PRL_set < 0 then
              P_set_PV_5 = Sum_PV.y - PRL_Angebot + PRL_set;
              P_set_Wind_1 = Max_Wind_1;
              P_set_Wind_2 = Max_Wind_2;
              P_set_Wind_3 = Max_Wind_3;
              P_set_Wind_4 = Max_Wind_4;
              P_set_Wind_5 = Max_Wind_5;
            else
              P_set_PV_5 = 0;
              if Sum_PV.y + Max_Wind_1 - PRL_Angebot + PRL_set < 0 then
                P_set_Wind_1 = Max_Wind_1+Sum_PV.y - PRL_Angebot + PRL_set;
                P_set_Wind_2 = Max_Wind_2;
                P_set_Wind_3 = Max_Wind_3;
                P_set_Wind_4 = Max_Wind_4;
                P_set_Wind_5 = Max_Wind_5;
              else
                P_set_Wind_1=0;
                if Sum_PV.y + Max_Wind_1 +Max_Wind_2- PRL_Angebot + PRL_set < 0 then
                  P_set_Wind_2 = Max_Wind_2+Max_Wind_1+Sum_PV.y - PRL_Angebot + PRL_set;
                  P_set_Wind_3 = Max_Wind_3;
                  P_set_Wind_4 = Max_Wind_4;
                  P_set_Wind_5 = Max_Wind_5;
                else
                  P_set_Wind_2=0;
                  if Sum_PV.y + Max_Wind_1 +Max_Wind_2 +Max_Wind_3 - PRL_Angebot + PRL_set < 0 then
                    P_set_Wind_3 = Max_Wind_3 + Max_Wind_2+Max_Wind_1+Sum_PV.y - PRL_Angebot + PRL_set;
                    P_set_Wind_4 = Max_Wind_4;
                    P_set_Wind_5 = Max_Wind_5;
                  else
                    P_set_Wind_3 = 0;
                    if Sum_PV.y + Max_Wind_1 +Max_Wind_2 +Max_Wind_3 + Max_Wind_4 - PRL_Angebot + PRL_set < 0 then
                      P_set_Wind_4 = Max_Wind_4 + Max_Wind_3 + Max_Wind_2+Max_Wind_1+Sum_PV.y - PRL_Angebot + PRL_set;
                      P_set_Wind_5 = Max_Wind_5;
                    else
                      P_set_Wind_4 = 0;
                      if Sum_PV.y + Sum_Wind.y - PRL_Angebot + PRL_set < 0 then
                        P_set_Wind_5 = Sum_Wind.y+Sum_PV.y - PRL_Angebot + PRL_set;
                      else
                        P_set_Wind_5 = 0;
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  else
    PRL_geliefert=false;
    P_set_PV_1=0;
    P_set_PV_2=0;
    P_set_PV_3=0;
    P_set_PV_4=0;
    P_set_PV_5=0;
    P_set_Wind_1 = 0;
    P_set_Wind_2 = 0;
    P_set_Wind_3 = 0;
    P_set_Wind_4 = 0;
    P_set_Wind_5 = 0;
  end if;
if Sum_PV.y+Sum_Wind.y<=2*PRL_Angebot then
    PRL_erfuellt=true;
else
    PRL_erfuellt=false;
end if;
if (Sum_PV.y+Sum_Wind.y)<0 then
  Usage=(P_set_PV_1+P_set_PV_2+P_set_PV_3+P_set_PV_4+P_set_PV_5+P_set_Wind_1+P_set_Wind_2+P_set_Wind_3+P_set_Wind_4+P_set_Wind_5)/(Sum_PV.y+Sum_Wind.y);
else
  Usage=1;
end if;
  connect(P_set_Wind_1, P_set_Wind_1) annotation (Line(
      points={{104,-52},{104,-52}},
      color={0,135,135},
      pattern=LinePattern.Dash));
  connect(Max_PV_1, Sum_PV.u[1]) annotation (Line(points={{-104,82},{-76,82},{-76,47.2},{-48,47.2}}, color={0,127,127}));
  connect(Max_PV_2, Sum_PV.u[2]) annotation (Line(points={{-104,60},{-76,60},{-76,41.6},{-48,41.6}}, color={0,127,127}));
  connect(Max_PV_4, Sum_PV.u[3]) annotation (Line(points={{-104,20},{-75,20},{-75,36},{-48,36}}, color={0,127,127}));
  connect(Max_PV_3, Sum_PV.u[4]) annotation (Line(points={{-106,42},{-74,42},{-74,30.4},{-48,30.4}}, color={0,127,127}));
  connect(Max_PV_5, Sum_PV.u[5]) annotation (Line(points={{-104,-2},{-76,-2},{-76,24.8},{-48,24.8}}, color={0,127,127}));
  connect(Max_Wind_1, Sum_Wind.u[1]) annotation (Line(points={{-104,-54},{-78,-54},{-78,-82.8},{-50,-82.8}}, color={0,127,127}));
  connect(Max_Wind_2, Sum_Wind.u[2]) annotation (Line(points={{-104,-76},{-76,-76},{-76,-88.4},{-50,-88.4}}, color={0,127,127}));
  connect(Max_Wind_3, Sum_Wind.u[3]) annotation (Line(points={{-104,-102},{-78,-102},{-78,-94},{-50,-94}}, color={0,127,127}));
  connect(Max_Wind_4, Sum_Wind.u[4]) annotation (Line(points={{-102,-126},{-75,-126},{-75,-99.6},{-50,-99.6}}, color={0,127,127}));
  connect(Max_Wind_5, Sum_Wind.u[5]) annotation (Line(points={{-102,-146},{-76,-146},{-76,-105.2},{-50,-105.2}}, color={0,127,127}));
  connect(Sum_PV.y, Sum_Wind1.u[1]) annotation (Line(points={{-4.6,36},{8,36},{8,123},{-10,123}}, color={0,0,127}));
  connect(Sum_Wind1.y, Max_Sum) annotation (Line(points={{-53.4,130},{-78,130},{-78,126},{-110,126}}, color={0,0,127}));
  connect(Sum_Wind.y, Sum_Wind1.u[2]) annotation (Line(points={{-6.6,-94},{18,-94},{18,-90},{34,-90},{34,137},{-10,137}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,200}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{100,200}})),
    Documentation(info="<html>
<p>Betriebsf&uuml;hrung und &quot;Fallregler&quot; f&uuml;r ein virtuelles Kraftwerk mit rein volatilen Erzeugern</p>
<p><br>Erstellt durch: Daniel Ducci</p>
<p>Weitere Dokumentation: Untersuchung der Bereitstellung von Regelleistung durch virtuelle Kraftwerke in sektorengekoppelten Energiesystemen von Daniel Ducci. 2021 </p>
</html>"));
end Regler_Virtuelles_Kraftwerk;
