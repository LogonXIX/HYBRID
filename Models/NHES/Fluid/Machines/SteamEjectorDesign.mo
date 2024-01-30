within NHES.Fluid.Machines;
model SteamEjectorDesign
  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  input Modelica.Units.SI.MassFlowRate m_m=7.1 annotation(Dialog(group=General));
  input Modelica.Units.SI.MassFlowRate m_s=102.8 annotation(Dialog(group=General));
  input Modelica.Units.SI.SpecificEnthalpy h_1=3350e3 annotation(Dialog(group=General));
  input Modelica.Units.SI.SpecificEnthalpy h_4=2939.97e3 annotation(Dialog(group=General));
  Modelica.Units.SI.Area A_2;
  Modelica.Units.SI.Area A_3;
  Modelica.Units.SI.Area A_5;
  Modelica.Units.SI.Area A_6;
  Modelica.Units.SI.Area A_7;
  Modelica.Units.SI.Area A_8;
  input Modelica.Units.SI.AbsolutePressure P_1=120e5 annotation(Dialog(group=General));
  input Modelica.Units.SI.AbsolutePressure P_4=32.8e5 annotation(Dialog(group=General));
  parameter Real eta_mix=0.99;
  parameter Real eta_diff=0.99
  "Isentropic Efficiency of the Oulet Diffuser";
  parameter Real eta_nozzle=0.99
  "Isentropic Efficiency of the Motive Steam Inlet Nozzel";
  parameter Real R_dp=0.7
  "Pressure Ratio of the Mixing Pressure to the Vaccum Inlet Pressure";
  Modelica.Units.SI.Temperature T_out;
  Modelica.Units.SI.Power Q_out;

  Modelica.Units.SI.MassFlowRate m_o;
  Modelica.Units.SI.AbsolutePressure P_2(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_3(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_5(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_6(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_7(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_8s(start=1e5);
  Modelica.Units.SI.AbsolutePressure P_8(start=1e5);
  Modelica.Units.SI.Velocity v_2;
  Modelica.Units.SI.Velocity v_3;
  Modelica.Units.SI.Velocity v_5;
  Modelica.Units.SI.Velocity v_6;
  Modelica.Units.SI.Velocity v_7;
  Modelica.Units.SI.Velocity v_8=0.01;
  Modelica.Units.SI.SpecificEnthalpy h_2(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_2s(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_3(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_5(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_6(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_7(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8s(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8ss(start=2800e3);
  Modelica.Units.SI.SpecificEntropy s_1;
  Modelica.Units.SI.SpecificEntropy s_2;
  Modelica.Units.SI.SpecificEntropy s_3;
  Modelica.Units.SI.SpecificEntropy s_4;
  Modelica.Units.SI.SpecificEntropy s_5;
  Modelica.Units.SI.SpecificEntropy s_7;
  Modelica.Units.SI.SpecificEntropy s_8;
  Modelica.Units.SI.SpecificEnthalpy H_1;
  Modelica.Units.SI.SpecificEnthalpy H_2;
  Modelica.Units.SI.SpecificEnthalpy H_3;
  Modelica.Units.SI.SpecificEnthalpy H_4;
  Modelica.Units.SI.SpecificEnthalpy H_5;
  Modelica.Units.SI.SpecificEnthalpy H_6;
  Modelica.Units.SI.SpecificEnthalpy H_7;
  Modelica.Units.SI.SpecificEnthalpy H_8;
  Modelica.Units.SI.Density rho_2;
  Modelica.Units.SI.Density rho_3;
  Modelica.Units.SI.Density rho_5;
  Modelica.Units.SI.Density rho_6;
  Modelica.Units.SI.Density rho_7;
  Modelica.Units.SI.Density rho_8;

equation
  //Primary Nossle isentropic
  H_1=h_1;
  H_2=h_2+(v_2^2)/2;
  H_3=h_3+(v_3^2)/2;
  H_1=H_2;
  H_2=H_3;
  rho_2=Medium.density(Medium.setState_phX(P_2,h_2));
  rho_3=Medium.density(Medium.setState_phX(P_3,h_3));
  v_2=Medium.velocityOfSound(Medium.setState_phX(P_2,h_2));
  m_m=v_2*A_2*rho_2;
  m_m=v_3*A_3*rho_3;
  s_1=Medium.specificEntropy(Medium.setState_phX(P_1,h_1));
  s_2=Medium.specificEntropy(Medium.setState_phX(P_2,h_2));
  s_3=Medium.specificEntropy(Medium.setState_phX(P_3,h_3));
  h_2s=Medium.specificEnthalpy_ps(P_2,s_1);
  eta_nozzle=(h_1-h_2)/(h_1-h_2s);
  //s_1=s_2;
  s_2=s_3;
  //Vaccum Inlet
  H_4=h_4;
  H_5=h_5+(v_5^2)/2;
  H_4=H_5;
  rho_5=Medium.density(Medium.setState_phX(P_5,h_5));
  m_s=v_5*A_5*rho_5;
  P_3=R_dp*P_4;
  P_3=P_5;
  s_4=Medium.specificEntropy(Medium.setState_phX(P_4,h_4));
  s_5=Medium.specificEntropy(Medium.setState_phX(P_5,h_5));
  s_4=s_5;
  //mixing region
  m_o=m_m+m_s;
  H_6=h_6+(v_6^2)/2;
  m_o*v_6=eta_mix*(m_m*v_3+m_s*v_5);
  rho_6=Medium.density(Medium.setState_phX(P_6,h_6));
  m_o=v_6*A_6*rho_6;
  m_o*H_6=m_m*h_1+m_s*h_4;
  P_6=P_3;
  //Shock recovery
  H_7=h_7+(v_7^2)/2;
  H_6=H_7;
  (P_7-P_6)=v_6*rho_6*(v_6-v_7);
  rho_7=Medium.density(Medium.setState_phX(P_7,h_7));
  m_o=v_7*A_7*rho_7;
  A_6=A_7;
  //Isentropic Diffuser
  s_7=Medium.specificEntropy(Medium.setState_phX(P_7,h_7));
  s_8=Medium.specificEntropy(Medium.setState_phX(P_8s,h_8));
  s_7=s_8;
  h_8s=Medium.specificEnthalpy_ps(P_8s,s_7);
  h_8ss=Medium.specificEnthalpy_ps(P_8,s_8);
  rho_8=Medium.density(Medium.setState_phX(P_8s,h_8));
  m_o=v_8*A_8*rho_8;
  H_8=h_8+(v_8^2)/2;
  H_7=H_8;
  eta_diff=(h_8ss-h_7)/(h_8s-h_7);
  T_out=Medium.temperature_ph(P_8,h_8);
  Q_out=h_8*m_o;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteamEjectorDesign;
