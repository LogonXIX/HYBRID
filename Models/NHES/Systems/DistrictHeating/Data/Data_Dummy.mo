within NHES.Systems.DistrictHeating.Data;
model Data_Dummy

  extends BaseClasses.Record_Data;
  parameter Real NTU=24 "Characteristic NTU of HX";
  parameter Modelica.Units.SI.Volume V_Tube_HX=1 "Total tube-side volume";
  parameter Modelica.Units.SI.Volume V_Shell_HX=0.1
    "Total shell-side volume";
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p=200000
    "Fixed value of pressure";
  parameter Modelica.Media.Interfaces.Types.Temperature T_low=318.15
    "Fixed value of temperature";
  parameter Modelica.Units.SI.Volume V_sink=10 "Volume";
  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="changeMe")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end Data_Dummy;
