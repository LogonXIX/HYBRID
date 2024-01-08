within NHES.Fluid.Machines;
model SuperSonicNozzel
  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.MassFlowRate m_1=2;
  parameter Modelica.Units.SI.SpecificEnthalpy h_1=2800e3;
  Modelica.Units.SI.Area A_2;
  Modelica.Units.SI.Area A_3;
  parameter Modelica.Units.SI.AbsolutePressure P_1=2e5;

  Modelica.Units.SI.AbsolutePressure P_2(start=1e5);
  parameter Modelica.Units.SI.AbsolutePressure P_3=1e5;
  Modelica.Units.SI.Velocity v_2;
  Modelica.Units.SI.Velocity v_3;
  Modelica.Units.SI.SpecificEnthalpy h_2(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_3(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy H_1;
  Modelica.Units.SI.SpecificEnthalpy H_2;
  Modelica.Units.SI.SpecificEnthalpy H_3;
  Modelica.Units.SI.SpecificEntropy s_1;
  Modelica.Units.SI.SpecificEntropy s_2;
  Modelica.Units.SI.SpecificEntropy s_3;
  Modelica.Units.SI.Density rho_2;
  Modelica.Units.SI.Density rho_3;

equation
  //Primary Nossle isentropic
  //inlet velovity ~=0
  H_1=h_1;
  m_1=v_2*A_2*rho_2;
  rho_2=Medium.density(Medium.setState_phX(P_2,h_2));
  H_2=h_2+(v_2^2)/2;
  H_1=H_2;
  v_2=Medium.velocityOfSound(Medium.setState_phX(P_2,h_2));
  H_2=H_3;
  H_3=h_3+(v_3^2)/2;
  m_1=v_3*A_3*rho_3;
  rho_3=Medium.density(Medium.setState_phX(P_3,h_3));
  s_1=Medium.specificEntropy(Medium.setState_phX(P_1,h_1));
  s_2=Medium.specificEntropy(Medium.setState_phX(P_2,h_2));
  s_3=Medium.specificEntropy(Medium.setState_phX(P_3,h_3));
  s_1=s_2;
  s_3=s_2;




    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SuperSonicNozzel;
