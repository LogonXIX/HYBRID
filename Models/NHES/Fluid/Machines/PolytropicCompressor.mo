within NHES.Fluid.Machines;
model PolytropicCompressor "Polytropic Compressor with defined mass flow"

  import Modelica.Units.SI;
  replaceable package Medium = Modelica.Media.IdealGases.SingleGases.H2
    "Medium in the component" annotation (choicesAllMatching=true);

  parameter SI.Power Qact_start=1e8;

  Medium.ThermodynamicState state_a;
  Medium.ThermodynamicState state_b;
  SI.Temperature T1;
  SI.Temperature T2;
  SI.AbsolutePressure P1;
  SI.AbsolutePressure P2;
  parameter Real Ep=1;
  SI.MassFlowRate m_flow;
  Real n;
  Real gamma;
  parameter SI.MolarHeatCapacity Ru=8.314;
  SI.SpecificHeatCapacity R;
  SI.Power Q;
  SI.Power Qact(start=Qact_start,fixed=false);
  Real Z;
  SI.Density rho1;
  SI.SpecificEnthalpy dh;
  Real C1;
  Real C2;
  SI.PressureDifference dP;

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=90,
        origin={0,120})));

equation

  m_flow=u;
  P2=P1+dP;
  C1=P1*((1/Medium.density(state_a))^n);
  C2=P2*((1/Medium.density(state_b))^n);
  //ports
  m_flow = port_a.m_flow;
  port_b.m_flow=-m_flow;
  port_a.h_outflow = inStream(port_b.h_outflow) + dh;
  port_a.Xi_outflow = inStream(port_b.Xi_outflow);
  port_a.C_outflow = inStream(port_b.C_outflow);
  port_b.h_outflow = inStream(port_a.h_outflow) + dh;
  port_b.Xi_outflow = inStream(port_a.Xi_outflow);
  port_b.C_outflow = inStream(port_a.C_outflow);
  P1=port_a.p;
  P2=port_b.p;
  // Port states
  state_a = Medium.setState_phX(
    port_a.p,
    inStream(port_a.h_outflow),
    inStream(port_a.Xi_outflow));
  state_b = Medium.setState_phX(
    port_b.p,
    inStream(port_a.h_outflow) + dh,
    inStream(port_b.Xi_outflow));
    T1=Medium.temperature(state_a);
    T2=Medium.temperature(state_b);
gamma=Medium.specificHeatCapacityCp(state_a)/Medium.specificHeatCapacityCv(state_a);
n=1/(1-((gamma-1)/gamma*Ep));
//R=Ru/Medium.fluidConstants.molarMass[1];

rho1=Medium.density(state_a);
Z=P1/(rho1*R*T1);
Q=(n*Z*R*T1/(n-1))*(((P2/P1)^((n-1)/n))-1)*m_flow;
Qact=Q/Ep;
dh=Qact/m_flow;
R=Ru/Medium.molarMass(state_a);
//assert(P2>P1,"Pressure Drop across compressor",level=AssertionLevel.error);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-72,70},{96,28}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-72,-70},{96,-28}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PolytropicCompressor;
