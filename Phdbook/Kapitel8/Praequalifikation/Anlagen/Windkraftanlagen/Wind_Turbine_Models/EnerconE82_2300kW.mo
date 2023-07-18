within Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models;
record EnerconE82_2300kW "Enercon model E82 2300kW"
//________________________________________________________________________________//
// Component of the TransiEnt Library, version: 1.2.0                             //
//                                                                                //
// Licensed by Hamburg University of Technology under Modelica License 2.         //
// Copyright 2019, Hamburg University of Technology.                              //
//________________________________________________________________________________//
//                                                                                //
// TransiEnt.EE and ResiliEntEE are research projects supported by the German     //
// Federal Ministry of Economics and Energy (FKZ 03ET4003 and 03ET4048).          //
// The TransiEnt Library research team consists of the following project partners://
// Institute of Engineering Thermodynamics (Hamburg University of Technology),    //
// Institute of Energy Systems (Hamburg University of Technology),                //
// Institute of Electrical Power and Energy Technology                            //
// (Hamburg University of Technology)                                             //
// Institute of Electrical Power Systems and Automation                           //
// (Hamburg University of Technology)                                             //
// and is supported by                                                            //
// XRG Simulation GmbH (Hamburg, Germany).                                        //
//________________________________________________________________________________//

  // _____________________________________________
  //
  //          Imports and Class Hierarchy
  // _____________________________________________

  extends TransiEnt.Producer.Electrical.Wind.Characteristics.GenericPowerCurve(
    P_el_n=2.3e6,
    PowerCurve=[0,0;
     1,0;
     2,3000;
     3,25000;
     4,82000;
     5,174000;
     6,321000;
     7,532000;
     8,815000;
     9,1180000;
     10,1580000;
     11,1890000;
     12,2100000;
     13,2250000;
     14,2350000;
     14.2,2350000;
     14.3,2350000;
     14.5,2350000;
     15,2350000;
     15.5,2350000;
     16,2350000;
     16.5,2350000;
     17,2350000;
     17.5,2350000;
     18,2350000;
     18.5,2350000;
     19,2350000;
     20,2350000;
     25,2350000;
     26.5,2350000;
     27,2350000;
     28,2350000;
     29,2350000;
     30,2350000;
     31,2350000;
     32,2350000;
     32.5,2350000;
     33,2350000;
     33.5,2350000;
     34,2350000;
     34.001,0;
     35.001,0;
    50,0],
    cut_out=34,
    cut_backin=32);

  annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">1. Purpose of model</span></h4>
<p>Record containing the data of the Enercon model E92 with 2350 kW</p>
<h4><span style=\"color: #008000\">2. Level of detail, physical effects considered, and physical insight</span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">3. Limits of validity </span></h4>
<p>(Purely technical component without physical modeling.)</p>
<h4><span style=\"color: #008000\">4.Interfaces</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">5. Nomenclature</span></h4>
<p>(no elements)</p>
<h4><span style=\"color: #008000\">6. Governing Equations</span></h4>
<p>(no equations)</p>
<h4><span style=\"color: #008000\">7. Remarks for Usage</span></h4>
<p>(no remarks)</p>
<h4><span style=\"color: #008000\">8. Validation</span></h4>
<p>(no validation or testing necessary)</p>
<h4><span style=\"color: #008000\">9. References</span></h4>
<p>[1]  Enercon GmbH, URL: https://www.enercon.de/produkte/ep-2/e-92/</p>
<h4><span style=\"color: #008000\">10. Version History</span></h4>
</html>"));
end EnerconE82_2300kW;
