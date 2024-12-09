within NHES.Systems.BalanceOfPlant.Turbine.Data;
model Data_L3_BP
  "Density inputs have large effects on nominal turbine pressures"
  extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
  parameter Modelica.Units.SI.Pressure P_ms=120e5 "Main steam Pressure" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure P_bp=6e5 "BP turbine exit pressure" annotation(Dialog(group="Pressure Sets"));
  parameter Modelica.Units.SI.Pressure P_cond=0.1e5 "Condenser Pressure"
                                                   annotation(Dialog(group="Pressure Sets"));

  parameter Modelica.Units.SI.Temperature T_ms=540+273.15 "Main Steam Temperature" annotation(Dialog(group="Temperature Sets"));
  parameter Modelica.Units.SI.Temperature T_feed=200+273.15 "Target Feed Water Temperature" annotation(Dialog(group="Temperature Sets"));
  parameter Modelica.Units.SI.Temperature T_bp=165.96+273.15 "Nominal BP turbine exit Temperature" annotation(Dialog(group="Temperature Sets"));

  parameter Modelica.Units.SI.Density d_turb = 34.6960  "Turbines inlet density"  annotation(Dialog(group="Density Sets"));


  parameter Modelica.Units.SI.MassFlowRate mdot_ms=46.17 "Main Steam Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_fh= 9.21  "Nominal Controlled Feed Heating Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_ct= 33.085 "Condensing Turbine Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_bp= 3.869 "Back Pressure Turbine Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
  parameter Modelica.Units.SI.MassFlowRate mdot_cond= mdot_ct+mdot_bp "Condenser Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));


  parameter Real eta_t=0.9 "Isentropic Efficiency of the Turbines" annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_mech=0.99
                              "Mechincal Effieiency of the Turbines"  annotation(Dialog(group="Efficiency Sets"));
  parameter Real eta_p=0.8 "Isentropic Efficiency of the Pumps" annotation(Dialog(group="Efficiency Sets"));

  parameter Modelica.Units.SI.Temperature Thx_feed=49.39+273.15 "Nominal HX feedwater inlet temperature"  annotation(Dialog(group="HX"));
  parameter Modelica.Units.SI.TemperatureDifference TTD=125.1 "Nominal HX TTD"  annotation(Dialog(group="HX"));
  parameter Modelica.Units.SI.TemperatureDifference DCA=10 "Nominal HX DCA"  annotation(Dialog(group="HX"));

   annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_L3_BP;
