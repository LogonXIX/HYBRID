within NHES.Fluid.Machines.Examples;
model DualHXSEtest

replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);

  NHES.Fluid.Machines.SteamEjectorDesign steamEjectorDesign(m_m=m_m,
    m_s=m_LWR,
    h_4=h7)
    annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  Modelica.Units.SI.MassFlowRate m_bp;
  Modelica.Units.SI.MassFlowRate m_m;
  parameter Modelica.Units.SI.MassFlowRate m_LWR=1;

  Modelica.Units.SI.Temperature T1;
  Modelica.Units.SI.Temperature T2;
  parameter Modelica.Units.SI.Temperature T3=382.2+273.15;
  Modelica.Units.SI.Temperature T4;
  Modelica.Units.SI.Temperature T5;
  Modelica.Units.SI.Temperature T6;
  Modelica.Units.SI.Temperature T7;

  parameter Modelica.Units.SI.AbsolutePressure P1=120e5;
  Modelica.Units.SI.AbsolutePressure P2(start=41.3e5);
  parameter Modelica.Units.SI.AbsolutePressure P3=41.3e5;
  parameter Modelica.Units.SI.AbsolutePressure P4=115e5;
  parameter Modelica.Units.SI.AbsolutePressure P5=110e5;
  parameter Modelica.Units.SI.AbsolutePressure P6=32.8e5;
  Modelica.Units.SI.AbsolutePressure P7(start=32.8e5);

  parameter Modelica.Units.SI.SpecificEnthalpy h1= 3350e3;
  Modelica.Units.SI.SpecificEnthalpy h2(start=3100e3);
  Modelica.Units.SI.SpecificEnthalpy h3(start=3169.55e3);
  Modelica.Units.SI.SpecificEnthalpy h4(start=2700e3);
  Modelica.Units.SI.SpecificEnthalpy h5(start=1287e3);
  parameter Modelica.Units.SI.SpecificEnthalpy h6=2939.97e3;
  Modelica.Units.SI.SpecificEnthalpy h7(start=3000e3);

equation
  T1=Medium.temperature_ph(P1,h1);
  T2=Medium.temperature_ph(P2,h2);
  T3=Medium.temperature_ph(P3,h3);
  T4=Medium.temperature_ph(P4,h4);
  T5=Medium.temperature_ph(P5,h5);
  T6=Medium.temperature_ph(P6,h6);
  T7=Medium.temperature_ph(P7,h7);

  P2=P3;
  P6=P7;
  P2=steamEjectorDesign.P_8;

  h2=steamEjectorDesign.h_8;

  T2+5=T4;
  T5=290+273.15;

  m_LWR*(h7-h6)=m_bp*(h4-h5);
  steamEjectorDesign.m_o*(h3-h2)=m_bp*(h1-h4);

  annotation (                                                    experiment(
        __Dymola_Algorithm="Esdirk45a"));
end DualHXSEtest;
