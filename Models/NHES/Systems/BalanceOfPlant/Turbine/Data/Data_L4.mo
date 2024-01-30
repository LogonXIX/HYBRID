within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L4
  extends BaseClasses.Record_Data;
  import Modelica.Units.SI;
  //main steam
  parameter SI.Temperature T_in=500+273.15;
  parameter SI.AbsolutePressure P_in=160e5;
  parameter SI.SpecificEnthalpy h_in= Modelica.Media.Water.StandardWater.specificEnthalpy_pT(P_in,T_in);
  //feed water
  parameter SI.Temperature T_feed=200+273.15;
  parameter SI.AbsolutePressure P_feed=190e5;
  //condensor
  parameter SI.AbsolutePressure P_cond=0.1e5;
  //Turbine Pressures
  parameter SI.AbsolutePressure P_hpt1=30e5;
  parameter SI.AbsolutePressure P_hpt2=20e5;
  parameter SI.AbsolutePressure P_hpt3=15e5;
  parameter SI.AbsolutePressure P_lpt_inlet=10e5;
  parameter SI.AbsolutePressure P_lpt1=8e5;
  parameter SI.AbsolutePressure P_lpt2=6e5;
  parameter SI.AbsolutePressure P_lpt3=3e5;
  parameter Boolean HPT1ext=true;
  parameter Boolean HPT2ext=false;
  parameter Boolean HPT3ext=false;
  parameter Boolean LPT1ext=false;
  parameter Boolean LPT2ext=false;
  parameter Boolean LPT3ext=true;
  //FeedWater Heater Pressures
  parameter SI.AbsolutePressure P_FWH1=3e5;
  parameter SI.AbsolutePressure P_FWH2=6e5;
  parameter SI.AbsolutePressure P_FWH3=60e5;
  //FeedWater dTs
  parameter SI.TemperatureDifference TTD_FWH1=15;
  parameter SI.TemperatureDifference TTD_FWH2=15;
  parameter SI.TemperatureDifference TTD_FWH3=15;
  parameter SI.TemperatureDifference TTD_FWH4=32;
  parameter SI.TemperatureDifference DCA_FWH1=5;
  parameter SI.TemperatureDifference DCA_FWH2=5;
  parameter SI.TemperatureDifference DCA_FWH3=5;
  parameter SI.TemperatureDifference DCA_FWH4=5;
  //Feed Water Temps
  parameter SI.Temperature T_FW1=273.15+60.08;
  parameter SI.Temperature T_FW2=273.15+60.12;
  parameter SI.Temperature T_FW3=273.15+143.83;
  parameter SI.Temperature T_FW4=273.15+155.41;
  parameter SI.Temperature T_FW5=273.15+156.39;
  parameter SI.Temperature T_FW6=273.15+164.88;
  parameter SI.Temperature T_FW7=273.15+196.97;
  //Efficiencies
  parameter Real eta_t=0.9;
  parameter Real eta_p=0.8;
  parameter Real eta_sep=0.99;
  parameter Real eta_mech=0.99;
  //Flow Rates
  parameter SI.MassFlowRate m1=82.549;
  parameter SI.MassFlowRate m1a=4.366;
  parameter SI.MassFlowRate m1b=1.498;
  parameter SI.MassFlowRate m1e=0;
  parameter SI.MassFlowRate m2=77.386;
  parameter SI.MassFlowRate m2a=2.0145;
  parameter SI.MassFlowRate m2b=12.52;
  parameter SI.MassFlowRate m2e=0;
  parameter SI.MassFlowRate m3=62.83;
  parameter SI.MassFlowRate m4=62.83;
  parameter SI.MassFlowRate m5=20.74;


   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L4;
