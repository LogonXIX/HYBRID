within NHES.Fluid.Machines;
model ExtractionTurbine

  replaceable package medium=Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.MassFlowRate m_in=10;
  parameter Modelica.Units.SI.MassFlowRate m_ext=2;
  parameter Modelica.Units.SI.AbsolutePressure P_in=100e5 "Nominal Turbine Inlet Pressure";
  parameter Modelica.Units.SI.AbsolutePressure P_out=20e5 "Nominal Turbine Outlet Pressure";
  parameter Modelica.Units.SI.AbsolutePressure P_ext=30e5 "Nominal Turbine Extraction Pressure";
  parameter Modelica.Units.SI.SpecificEnthalpy h_in=2.8e6 "Nominal Turbine Inlet Enthalpy";
  parameter Real eta_t=0.9
                          "Turbine Isentropic Effiency";
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEntropy s_in(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext(fixed=false)=5e3;
    final parameter Real eta_1(fixed=false)=0.9;
    final parameter Real eta_2(fixed=false)=0.9;
    final parameter Modelica.Units.SI.Density d_in(fixed=false)=50;
    final parameter Modelica.Units.SI.Density d_ext(fixed=false)=15;



  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_1),
    p_a_start=P_in,
    p_b_start=P_ext,
    use_T_start=false,
    h_a_start=h_in,
    h_b_start=h_ext,
    m_flow_start=m_in,
    m_flow_nominal=m_in,
    p_inlet_nominal=P_in,
    p_outlet_nominal=P_ext,
    use_T_nominal=false,
    d_nominal=d_in)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine1(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_2),
    p_a_start=P_ext,
    p_b_start=P_out,
    use_T_start=false,
    h_a_start=h_ext,
    h_b_start=h_out,
    m_flow_start=m_in - m_ext,
    m_flow_nominal=m_in - m_ext,
    p_inlet_nominal=P_ext,
    p_outlet_nominal=P_out,
    use_T_nominal=false,
    d_nominal=d_ext)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Valves.PressureCV pressureCV(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext,
    ValvePos_start=0.991,
    PID_k=-1e-2,
    m_flow_nominal=m_ext,
    dp_nominal=1000) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={20,6})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext,
    port_1(m_flow(start=m_in)),
    port_2(m_flow(start=m_ext - m_in)),
    port_3(m_flow(start=-m_ext)))
    annotation (Placement(transformation(extent={{-30,16},{-10,-4}})));
initial equation
  s_in=medium.specificEntropy(medium.setState_ph(P_in,h_in));
  h_out=h_in-(h_in-medium.specificEnthalpy_ps(P_out,s_in))*eta_t;
  s_out=medium.specificEntropy(medium.setState_ph(P_out,h_out));
  h_ext=((h_out-h_in)/(s_out-s_in))*s_ext+h_in-((h_out-h_in)/(s_out-s_in))*s_in;
  h_ext=medium.specificEnthalpy_ps(P_ext,s_ext);
  h_ext=h_in-(h_in-medium.specificEnthalpy_ps(P_ext,s_in))*eta_1;
  h_out=h_ext-(h_ext-medium.specificEnthalpy_ps(P_out,s_ext))*eta_2;
  d_in=medium.density_ph(P_in,h_in);
  d_ext=medium.density_ph(P_ext,h_ext);



equation
  connect(steamTurbine.portLP, tee.port_1)
    annotation (Line(points={{-40,6},{-30,6}}, color={0,127,255}));
  connect(steamTurbine1.portLP, port_b) annotation (Line(points={{60,6},{84,6},
          {84,60},{100,60}}, color={0,127,255}));
  connect(steamTurbine.portHP, port_a) annotation (Line(points={{-60,6},{-86,6},
          {-86,60},{-100,60}}, color={0,127,255}));
  connect(steamTurbine.shaft_a, shaft_a)
    annotation (Line(points={{-60,0},{-100,0}}, color={0,0,0}));
  connect(steamTurbine1.shaft_b, shaft_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,0,0}));
  connect(tee.port_2, pressureCV.port_a)
    annotation (Line(points={{-10,6},{10,6}}, color={0,127,255}));
  connect(pressureCV.port_b, steamTurbine1.portHP)
    annotation (Line(points={{30,6},{35,6},{35,6},{40,6}}, color={0,127,255}));
  connect(tee.port_3, port_b_extraction) annotation (Line(points={{-20,-4},{-20,
          -84},{0,-84},{0,-100}}, color={0,127,255}));
  connect(steamTurbine.shaft_b, steamTurbine1.shaft_a) annotation (Line(points=
          {{-40,0},{-34,0},{-34,-8},{34,-8},{34,0},{40,0}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-6,18.5},{6,-18.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={-34,47.5},
          rotation=180),
        Rectangle(
          extent={{-94,66},{-40,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{40,66},{92,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Text(
          extent={{-149,112},{151,72}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true,showName)),
        Rectangle(
          extent={{-102,6},{98,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Rectangle(
          extent={{-6,21.5},{6,-21.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={0,-71.5},
          rotation=180),
        Polygon(
          points={{-40,30},{-40,-30},{40,-80},{40,80},{-40,30}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
Turbine model designed for steam extraction.  Controlled extraction is done using a pressure control valve between the turbine sections.
A straight expansion line is assumed for this model.
</html>"));
end ExtractionTurbine;
