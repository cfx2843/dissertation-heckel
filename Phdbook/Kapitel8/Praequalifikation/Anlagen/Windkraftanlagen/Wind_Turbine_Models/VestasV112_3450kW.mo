within Phdbook.Kapitel8.Praequalifikation.Anlagen.Windkraftanlagen.Wind_Turbine_Models;
record VestasV112_3450kW "Vestas model V112_3450kW"
 extends GenericPowerCurve(
  P_el_n=3.45e6,
    PowerCurve=[
    0,0;
    2.9,0;
3.0,7000;
3.5,53000;
4.0,123000;
4.5,208000;
5.0,309000;
5.5,427000;
6.0,567000;
6.5,732000;
7.0,927000;
7.5,1149000;
8.0,1401000;
8.5,1688000;
9.0,2006000;
9.5,2348000;
10.0,2693000;
10.5,3011000;
11.0,3252000;
11.5,3388000;
12.0,3436000;
13.0,3450000;
14.0,3450000;
15.0,3450000;
16.0,3450000;
17.0,3450000;
18.0,3450000;
19.0,3450000;
20.0,3450000;
21.0,3450000;
22.0,3450000;
23.0,3450000;
24.0,3450000;
25.0,3450000;
25.001,0;
30.001, 0;
50, 0],
cut_out=25,
cut_backin=23);

end VestasV112_3450kW;
