within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L3E
  extends BaseClasses.Record_Data;
  import Modelica.Units.SI;
  //main steam
  parameter SI.Temperature T_in=500+273.15;
  parameter SI.AbsolutePressure P_in=160e5;
  parameter SI.SpecificEnthalpy h_in= Modelica.Media.Water.StandardWater.specificEnthalpy_pT(P_in,T_in);
  //feed water
  parameter SI.Temperature T_feed=200+273.15;
  parameter SI.AbsolutePressure P_feed=165e5;
  //condensor
  parameter SI.AbsolutePressure P_cond=0.1e5;
  //Turbine Pressures
  parameter SI.AbsolutePressure P_ta=100e5;
  parameter SI.AbsolutePressure P_tb=2e5;
  parameter SI.AbsolutePressure P_te=20e5;
  //Efficiencies
  parameter Real eta_t=0.9;
  parameter Real eta_p=0.8;
  parameter Real eta_sep=0.99;
  parameter Real eta_mech=0.99;
  //Flow Rates
  parameter SI.MassFlowRate m1=84.107;
  parameter SI.MassFlowRate m1a=12.178;
  parameter SI.MassFlowRate m1b=7.106;
  parameter SI.MassFlowRate m1e=0;
  parameter SI.MassFlowRate m2=64.822;
  parameter SI.MassFlowRate m3=64.822;
  parameter SI.MassFlowRate m4=71.929;

   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L3E;
