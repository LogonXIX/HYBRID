within NHES.Electrolysis.ElectricHeaters;
package Condensor

  model SteamHydrogen_Volume
    import Modelica.Fluid.Types.Dynamics;

      replaceable package MediumW = Modelica.Media.Water.StandardWater;
      replaceable package MediumH = Media.Electrolysis.CathodeGas;

        MediumW.ThermodynamicState state_W "Thermodynamic state of the liquid water";
        MediumH.ThermodynamicState state_H "Thermodynamic state of the Hydrogen Mix";

      // Initialization
        parameter Modelica.Units.SI.Pressure p_start=103e5 "Initial pressure"
          annotation (Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Mass Mm_start=20 "Initial Mixure Mass"
          annotation (Dialog(tab="Initialization"));
        parameter Real RelLevel_start=0.5 "Initial Level" annotation(Dialog(tab="Initialization"));



        parameter Modelica.Units.SI.Temperature T_st=300 "init temp";
        parameter Modelica.Units.SI.Volume V(min=0);

        MediumW.AbsolutePressure p(min=0);
        Modelica.Units.SI.SpecificEnthalpy h_in(min=0);
        Modelica.Units.SI.SpecificEnthalpy h_v(min=0);
        Modelica.Units.SI.SpecificEnthalpy h_l(min=0);
        Modelica.Units.SI.MassFlowRate m_in;
        Modelica.Units.SI.MassFlowRate m_v;
        Modelica.Units.SI.MassFlowRate m_l;
        Modelica.Units.SI.Density rho_v;
        Modelica.Units.SI.Density rho_l;
        Modelica.Units.SI.Mass M_v(min=0);
        Modelica.Units.SI.Mass M_l(min=0);
        Modelica.Units.SI.Mass M(min=0);
        Modelica.Units.SI.Mass M_H(min=0);
        Modelica.Units.SI.Energy E(min=0);
        Modelica.Units.SI.SpecificInternalEnergy u_v(min=0);
        Modelica.Units.SI.SpecificInternalEnergy u_l(min=0);
        Modelica.Units.SI.Power Qhx;
        Modelica.Units.SI.Volume V_v(min=0);
        Modelica.Units.SI.Volume V_l(min=0);

        Modelica.Units.SI.MassFraction X_in[2];
        Modelica.Units.SI.MassFraction X_v[2];
        Modelica.Units.SI.MassFraction C_in;
        Modelica.Units.SI.MassFraction C_v;
        Modelica.Units.SI.Temperature T(start=T_st,fixed=true);


        Modelica.Fluid.Interfaces.FluidPort_a port_a_mixture(
      p(start=p_start),
      redeclare package Medium = MediumH)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));

       Modelica.Fluid.Interfaces.FluidPort_b port_b_mixture(
      p(start=p_start) = p_start,
      redeclare package Medium = MediumH)
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));

      Modelica.Fluid.Interfaces.FluidPort_b port_b_water(
      p(start=p_start),
      redeclare package Medium = MediumW)
      annotation (Placement(transformation(extent={{-10,90},{10,110}}),
          iconTransformation(extent={{-10,90},{10,110}})));

       Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  equation
    //Energy Balance
    der(E)=m_in*h_in +m_l*h_l +m_v*h_v;
    //Mass Balance
    der(M)=m_in+m_l+m_v;
    der(M_l)=m_in*(1-C_in)+m_l;
    //Hydrogen Balance
    der(M_H)=m_in*C_in+m_v*C_v;

    //System Totals
    M=M_v+M_l;
    E=M_v*u_v+M_l*u_l;
    M_H=M_v*C_v;

    //
    X_in[1]=C_in;
    X_v[1]=C_v;
    X_v[2]=1-C_v;
    V_l=M_l/rho_l;
    V_v=M_v/rho_v;
    V=V_v+V_l;



    //ThermoStates
    state_W=MediumW.setState_ph(p,h_l);
    h_l=MediumW.specificEnthalpy(state_W);
    u_l=MediumW.specificInternalEnergy(state_W);
    rho_l=MediumW.density(state_W);
    T=MediumW.temperature(state_W);
    state_H=MediumH.setState_phX(p,h_v,X_v);
    h_v=MediumH.specificEnthalpy(state_H);
    u_v=MediumH.specificInternalEnergy(state_H);
    rho_v=MediumH.density(state_H);
    T=MediumH.temperature(state_H);



    //Liquid Fix
    assert( h_l< MediumW.dewEnthalpy(MediumW.setSat_T(T)),"Water must be liquid");












    port_a_mixture.p = p;
    m_in=port_a_mixture.m_flow;
    h_in =inStream(port_a_mixture.h_outflow);
    X_in=inStream(port_a_mixture.Xi_outflow);
    port_a_mixture.h_outflow = inStream(port_b_mixture.h_outflow);
    port_a_mixture.Xi_outflow = inStream(port_b_mixture.Xi_outflow);

    port_b_mixture.p = p;
    m_v=port_b_mixture.m_flow;
    port_b_mixture.h_outflow = h_v;
    port_b_mixture.Xi_outflow = X_v;

    port_b_water.p = p;
    m_l=port_b_water.m_flow;
    port_b_water.h_outflow = h_l;

        Heat_Port.T=T;
        Qhx =Heat_Port.Q_flow;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SteamHydrogen_Volume;
end Condensor;
