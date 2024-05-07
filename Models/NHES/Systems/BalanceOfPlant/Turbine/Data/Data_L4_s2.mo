within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L4_s2
  extends BaseClasses.Record_Data;
  import Modelica.Units.SI;
  //main steam
  parameter SI.Power P_nom_e=6e6;

  parameter SI.Temperature T_in=500+273.15;
  parameter SI.AbsolutePressure P_in=160e5;
  parameter SI.SpecificEnthalpy h_in= Modelica.Media.Water.StandardWater.specificEnthalpy_pT(P_in,T_in);
  parameter SI.Density d_in=Modelica.Media.Water.StandardWater.density_pT(P_in,T_in);

  //Turbine Pressures
  parameter SI.AbsolutePressure P_ext1=16.5e5;
  parameter SI.AbsolutePressure P_ext2=5e5;
  parameter SI.AbsolutePressure P_ext3=3e5;
  parameter SI.SpecificEnthalpy h_ext1=2855e3;
  parameter SI.SpecificEnthalpy h_ext2=2754e3;
  parameter SI.SpecificEnthalpy h_ext3=2670e3;
  parameter SI.SpecificEnthalpy hl_ms=467e3;
  parameter SI.SpecificEnthalpy hv_ms=2674e3;
  parameter SI.Temperature T_1a=273.15+260.27;
  parameter SI.Density d_ext1=5.8899;
  parameter SI.Density d_ext2=3.6808;
  parameter SI.Density d_ext3=0.8713;


  //feed water
  parameter SI.Temperature T_feed=200+273.15;
  parameter SI.Temperature T_Dea=90+273.15;
  parameter SI.AbsolutePressure P_feed=190e5;
  parameter SI.AbsolutePressure P_Dea=1e5;
  //condensor
  parameter SI.AbsolutePressure P_cond=0.1e5;

  //FeedWater dTs
  parameter SI.TemperatureDifference TTD_FWH1=15;
  parameter SI.TemperatureDifference DCA_FWH1=5;



  //Efficiencies
  parameter Real eta_t1=0.9;
  parameter Real eta_t2=0.9;
  parameter Real eta_t3=0.9;
  parameter Real eta_t4=0.9;
  parameter Real eta_p=0.8;
  parameter Real eta_sep=0.99;
  parameter Real eta_mech=0.99;
  //Flow Rates
  parameter SI.MassFlowRate m1=76.677;
  parameter SI.MassFlowRate m1a=7.953;
  parameter SI.MassFlowRate m1b=0;
  parameter SI.MassFlowRate m1c=1.814;
  parameter SI.MassFlowRate m1d=9.484;
  parameter SI.MassFlowRate m2=66.910;
  parameter SI.MassFlowRate m3=66.910;



   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L4_s2;
