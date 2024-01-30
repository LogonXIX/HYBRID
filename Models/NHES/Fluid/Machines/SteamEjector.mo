within NHES.Fluid.Machines;
model SteamEjector
  import Modelica.Units.SI;
  replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  parameter SI.MassFlowRate m_mnom=7.1;
  parameter SI.MassFlowRate m_snom=102.8;
  parameter SI.SpecificEnthalpy h_1nom=3350e3;
  parameter SI.SpecificEnthalpy h_4nom=2939.97e3;
  parameter SI.AbsolutePressure P_1nom=120e5;
  parameter SI.AbsolutePressure P_4nom=32.8e5;
  parameter Real eta_mix=0.99;
  parameter Real eta_diff=0.99
  "Isentropic Efficiency of the Oulet Diffuser";
  parameter Real eta_nozzle=0.99
  "Isentropic Efficiency of the Motive Steam Inlet Nozzel";
  parameter Real R_dp=0.7
  "Pressure Ratio of the Mixing Pressure to the Vaccum Inlet Pressure";
  parameter SI.Velocity v_8nom=0.01;







final parameter SI.Area A_2( start=0.001, fixed=false);
final parameter SI.Area A_3( start=0.001, fixed=false);
final parameter SI.Area A_5( start=0.001, fixed=false);
final parameter SI.Area A_6( start=0.001, fixed=false);
final parameter SI.Area A_7( start=0.001, fixed=false);
final parameter SI.Area A_8( start=0.001, fixed=false);
protected
          final parameter SI.Temperature T_outnom( start=537.15,fixed=false);
protected
          final parameter SI.Power Q_outnom(start=10e6,fixed=false);
protected
          final parameter SI.MassFlowRate m_onom(start=8,fixed=false);
protected
          final parameter SI.AbsolutePressure P_2nom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_3nom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_5nom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_6nom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_7nom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_8snom(start=1e5,fixed=false);
protected
          final parameter SI.AbsolutePressure P_8nom(start=1e5,fixed=false);
protected
          final parameter SI.Velocity v_2nom( start=100,fixed=false);
protected
          final parameter SI.Velocity v_3nom( start=100,fixed=false);
protected
          final parameter SI.Velocity v_5nom( start=100,fixed=false);
protected
          final parameter SI.Velocity v_6nom( start=100,fixed=false);
protected
          final parameter SI.Velocity v_7nom( start=100,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_2nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_2snom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_3nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_5nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_6nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_7nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_8nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_8snom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy h_8ssnom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_1nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_2nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_3nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_4nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_5nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_7nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEntropy s_8nom( start=7e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_1nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_2nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_3nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_4nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_5nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_6nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_7nom(start=2800e3,fixed=false);
protected
          final parameter SI.SpecificEnthalpy H_8nom(start=2800e3,fixed=false);
protected
          final parameter SI.Density rho_2nom(start=0.02,fixed=false);
protected
          final parameter SI.Density rho_3nom(start=0.02,fixed=false);
protected
          final parameter SI.Density rho_5nom(start=0.02,fixed=false);
protected
          final parameter SI.Density rho_6nom(start=0.02,fixed=false);
protected
          final parameter SI.Density rho_7nom(start=0.02,fixed=false);
protected
          final parameter SI.Density rho_8nom(start=0.02,fixed=false);

 //sim vars
  parameter Modelica.Units.SI.MassFlowRate m_m=7.1;
  parameter Modelica.Units.SI.MassFlowRate m_s=102.8;
  parameter Modelica.Units.SI.SpecificEnthalpy h_1=3350e3;
  parameter Modelica.Units.SI.SpecificEnthalpy h_4=2939.97e3;
  Modelica.Units.SI.AbsolutePressure P_1(start=120e5);
  Modelica.Units.SI.AbsolutePressure P_4(start=32e5);
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
  Modelica.Units.SI.Velocity v_8;
  Modelica.Units.SI.SpecificEnthalpy h_2(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_2s(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_3(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_5(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_6(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_7(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8s(start=2800e3);
  Modelica.Units.SI.SpecificEnthalpy h_8ss(start=2800e3);
  Modelica.Units.SI.SpecificEntropy s_1(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_2(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_3(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_4(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_5(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_7(start=7e3);
  Modelica.Units.SI.SpecificEntropy s_8(start=7e3);
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



















initial equation
                 //used to find cross sectional areas and nominal values
  //Primary Nossle isentropic
  H_1nom=h_1nom;
  H_2nom=h_2nom+(v_2nom^2)/2;
  H_3nom=h_3nom+(v_3nom^2)/2;
  H_1nom=H_2nom;
  H_2nom=H_3nom;
  rho_2nom=Medium.density(Medium.setState_phX(P_2nom,h_2nom));
  rho_3nom=Medium.density(Medium.setState_phX(P_3nom,h_3nom));
  v_2nom=Medium.velocityOfSound(Medium.setState_phX(P_2nom,h_2nom));
  m_mnom=v_2nom*A_2*rho_2nom;
  m_mnom=v_3nom*A_3*rho_3nom;
  s_1nom=Medium.specificEntropy(Medium.setState_phX(P_1nom,h_1nom));
  s_2nom=Medium.specificEntropy(Medium.setState_phX(P_2nom,h_2nom));
  s_3nom=Medium.specificEntropy(Medium.setState_phX(P_3nom,h_3nom));
  h_2snom=Medium.specificEnthalpy_ps(P_2nom,s_1nom);
  eta_nozzle=(h_1nom-h_2nom)/(h_1nom-h_2snom);
  //s_1=s_2;
  s_2nom=s_3nom;
  //Vaccum Inlet
  H_4nom=h_4nom;
  H_5nom=h_5nom+(v_5nom^2)/2;
  H_4nom=H_5nom;
  rho_5nom=Medium.density(Medium.setState_phX(P_5nom,h_5nom));
  m_snom=v_5nom*A_5*rho_5nom;
  P_3nom=R_dp*P_4nom;
  P_3nom=P_5nom;
  s_4nom=Medium.specificEntropy(Medium.setState_phX(P_4nom,h_4nom));
  s_5nom=Medium.specificEntropy(Medium.setState_phX(P_5nom,h_5nom));
  s_4nom=s_5nom;
  //mixing region
  m_onom=m_mnom+m_snom;
  H_6nom=h_6nom+(v_6nom^2)/2;
  m_onom*v_6nom=eta_mix*(m_mnom*v_3nom+m_snom*v_5nom);
  rho_6nom=Medium.density(Medium.setState_phX(P_6nom,h_6nom));
  m_onom=v_6nom*A_6*rho_6nom;
  m_onom*H_6nom=m_mnom*h_1nom+m_snom*h_4nom;
  P_6nom=P_3nom;
  //Shock recovery
  H_7nom=h_7nom+(v_7nom^2)/2;
  H_6nom=H_7nom;
  (P_7nom-P_6nom)=v_6nom*rho_6nom*(v_6nom-v_7nom);
  rho_7nom=Medium.density(Medium.setState_phX(P_7nom,h_7nom));
  m_onom=v_7nom*A_7*rho_7nom;
  A_6=A_7;
  //Isentropic Diffuser
  s_7nom=Medium.specificEntropy(Medium.setState_phX(P_7nom,h_7nom));
  s_8nom=Medium.specificEntropy(Medium.setState_phX(P_8snom,h_8nom));
  s_7nom=s_8nom;
  h_8snom=Medium.specificEnthalpy_ps(P_8snom,s_7nom);
  h_8ssnom=Medium.specificEnthalpy_ps(P_8nom,s_8nom);
  rho_8nom=Medium.density(Medium.setState_phX(P_8snom,h_8nom));
  m_onom=v_8nom*A_8*rho_8nom;
  H_8nom=h_8nom+(v_8nom^2)/2;
  H_7nom=H_8nom;
  eta_diff=(h_8ssnom-h_7nom)/(h_8snom-h_7nom);
  T_outnom=Medium.temperature_ph(P_8nom,h_8nom);
  Q_outnom=h_8nom*m_onom;
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
  s_2=s_3;
  //Vaccum Inlet
  H_4=h_4;
  H_5=h_5+(v_5^2)/2;
  H_4=H_5;
  rho_5=Medium.density(Medium.setState_phX(P_5,h_5));
  m_s=v_5*A_5*rho_5;
  //P_3=R_dp*P_4;
  P_3=P_5;
  s_4=Medium.specificEntropy(Medium.setState_phX(P_4,h_4));
  s_5=Medium.specificEntropy(Medium.setState_phX(P_5,h_5));
  s_4=s_5;
  //mixing region
  m_o=m_m+m_s;
  H_6=h_6+(v_6^2)/2;
  //m_o*v_6=eta_mix*(m_m*v_3+m_s*v_5);
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
  //A_6=A_7;
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
end SteamEjector;
