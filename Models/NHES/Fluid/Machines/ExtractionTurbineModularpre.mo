within NHES.Fluid.Machines;
model ExtractionTurbineModularpre

  replaceable package medium=Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.MassFlowRate m_in=10;
  parameter Modelica.Units.SI.MassFlowRate m_ext1=2;
  parameter Modelica.Units.SI.MassFlowRate m_ext2=2;
  parameter Modelica.Units.SI.MassFlowRate m_ext3=2;
  parameter Modelica.Units.SI.AbsolutePressure P_in=100e5 "Nominal Turbine Inlet Pressure";
  parameter Modelica.Units.SI.AbsolutePressure P_out=20e5 "Nominal Turbine Outlet Pressure";
  parameter Integer nExt(min=1,max=3)=3 "Number of Extractions, Max=3";
  parameter Modelica.Units.SI.AbsolutePressure P_ext1=60e5 "Nominal Turbine First Extraction Pressure";
  parameter Modelica.Units.SI.AbsolutePressure P_ext2=50e5 "Nominal Turbine Second Extraction Pressure";
  parameter Modelica.Units.SI.AbsolutePressure P_ext3=30e5 "Nominal Turbine Thrid Extraction Pressure";
  parameter Modelica.Units.SI.SpecificEnthalpy h_in=2.8e6 "Nominal Turbine Inlet Enthalpy";
  parameter Real eta_t=0.9
                          "Turbine Isentropic Effiency";
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEntropy s_in(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext3(fixed=false)=5e3;
    final parameter Real eta_1(fixed=false)=0.9;
    final parameter Real eta_2(fixed=false)=0.9;
    final parameter Real eta_3(fixed=false)=0.9;
    final parameter Real eta_4(fixed=false)=0.9;
    final parameter Modelica.Units.SI.Density d_in(fixed=false)=50;
    final parameter Modelica.Units.SI.Density d_ext1(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext2(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext3(fixed=false)=15;

  TRANSFORM.Fluid.Machines.SteamTurbine ST1(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_1),
    p_a_start=P_in,
    p_b_start=P_ext1,
    use_T_start=false,
    h_a_start=h_in,
    h_b_start=h_ext1,
    m_flow_start=m_in,
    m_flow_nominal=m_in,
    p_inlet_nominal=P_in,
    p_outlet_nominal=P_ext1,
    use_T_nominal=false,
    d_nominal=d_in)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST2(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_2),
    p_a_start=P_ext1,
    p_b_start=P_ext2,
    use_T_start=false,
    h_a_start=h_ext1,
    h_b_start=h_ext2,
    m_flow_start=m_in - m_ext1,
    m_flow_nominal=m_in - m_ext1,
    p_inlet_nominal=P_ext1,
    p_outlet_nominal=P_ext2,
    use_T_nominal=false,
    d_nominal=d_ext1)
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  Valves.PressureCV pressureCV1(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext1,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_in - m_ext1,
    dp_nominal=1000) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-48,6})));
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
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext1,
    port_1(m_flow(start=m_in)),
    port_2(m_flow(start=m_ext1 - m_in)),
    port_3(m_flow(start=-m_ext1)))
    annotation (Placement(transformation(extent={{-70,12},{-58,0}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction1(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST3(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_3),
    p_a_start=P_ext1,
    p_b_start=P_ext2,
    use_T_start=false,
    h_a_start=h_ext2,
    h_b_start=h_ext3,
    m_flow_start=m_in - m_ext1 - m_ext2,
    m_flow_nominal=m_in - m_ext1 - m_ext2,
    p_inlet_nominal=P_ext2,
    p_outlet_nominal=P_ext3,
    use_T_nominal=false,
    d_nominal=d_ext2)
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  Valves.PressureCV pressureCV2(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext2,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_in - m_ext1 - m_ext2,
    dp_nominal=1000) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={8,6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext2,
    port_1(m_flow(start=m_in - m_ext1)),
    port_2(m_flow(start=m_ext1 + m_ext2 - m_in)),
    port_3(m_flow(start=-m_ext2)))
    annotation (Placement(transformation(extent={{-14,12},{-2,0}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction2(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST4(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_4),
    p_a_start=P_ext3,
    p_b_start=P_out,
    use_T_start=false,
    h_a_start=h_ext3,
    h_b_start=h_out,
    m_flow_start=m_in - m_ext1 - m_ext2 - m_ext3,
    m_flow_nominal=m_in - m_ext1 - m_ext2 - m_ext3,
    p_inlet_nominal=P_ext3,
    p_outlet_nominal=P_out,
    use_T_nominal=false,
    d_nominal=d_ext3)
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Valves.PressureCV pressureCV3(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext3,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_in - m_ext1 - m_ext2 - m_ext3,
    dp_nominal=1000) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={64,6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext3,
    port_1(m_flow(start=m_in - m_ext1 - m_ext2)),
    port_2(m_flow(start=m_ext1 + m_ext2 + m_ext3 - m_in)),
    port_3(m_flow(start=-m_ext3)))
    annotation (Placement(transformation(extent={{42,12},{54,0}})));
initial equation
  //Inlet
  s_in=medium.specificEntropy(medium.setState_ph(P_in,h_in));
  d_in=medium.density_ph(P_in,h_in);
  //Outlet
  h_out=h_in-(h_in-medium.specificEnthalpy_ps(P_out,s_in))*eta_t;
  s_out=medium.specificEntropy(medium.setState_ph(P_out,h_out));
  //Extraction
    //First
  h_ext1=((h_out-h_in)/(s_out-s_in))*s_ext1+h_in-((h_out-h_in)/(s_out-s_in))*s_in;
  h_ext1=medium.specificEnthalpy_ps(P_ext1,s_ext1);
  h_ext1=h_in-(h_in-medium.specificEnthalpy_ps(P_ext1,s_in))*eta_1;
  h_ext2=h_ext1-(h_ext1-medium.specificEnthalpy_ps(P_ext2,s_ext1))*eta_2;
  d_ext1=medium.density_ph(P_ext1,h_ext1);
    //Second
  h_ext2=((h_out-h_in)/(s_out-s_in))*s_ext2+h_in-((h_out-h_in)/(s_out-s_in))*s_in;
  h_ext2=medium.specificEnthalpy_ps(P_ext2,s_ext2);
  h_ext3=h_ext2-(h_ext2-medium.specificEnthalpy_ps(P_ext3,s_ext2))*eta_3;
  d_ext2=medium.density_ph(P_ext2,h_ext2);
    //Third
  h_ext3=((h_out-h_in)/(s_out-s_in))*s_ext3+h_in-((h_out-h_in)/(s_out-s_in))*s_in;
  h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
  h_out=h_ext3-(h_ext3-medium.specificEnthalpy_ps(P_out,s_ext3))*eta_4;
  d_ext3=medium.density_ph(P_ext3,h_ext3);

equation
  connect(ST1.portLP, tee.port_1)
    annotation (Line(points={{-74,6},{-70,6}}, color={0,127,255}));
  connect(ST1.portHP, port_a)
    annotation (Line(points={{-94,6},{-94,60},{-100,60}}, color={0,127,255}));
  connect(ST1.shaft_a, shaft_a)
    annotation (Line(points={{-94,0},{-100,0}}, color={0,0,0}));
  connect(tee.port_2, pressureCV1.port_a)
    annotation (Line(points={{-58,6},{-54,6}}, color={0,127,255}));
  connect(pressureCV1.port_b, ST2.portHP)
    annotation (Line(points={{-42,6},{-38,6}}, color={0,127,255}));
  connect(tee.port_3, port_b_extraction) annotation (Line(points={{-64,0},{-64,-100},
          {-60,-100}},            color={0,127,255}));
  connect(ST1.shaft_b, ST2.shaft_a) annotation (Line(points={{-74,0},{-74,-6},{-38,
          -6},{-38,0}}, color={0,0,0}));
  connect(tee1.port_3, port_b_extraction1)
    annotation (Line(points={{-8,0},{-8,-100},{0,-100}}, color={0,127,255}));
  connect(tee1.port_2,pressureCV2. port_a)
    annotation (Line(points={{-2,6},{2,6}}, color={0,127,255}));
  connect(pressureCV2.port_b, ST3.portHP)
    annotation (Line(points={{14,6},{18,6}}, color={0,127,255}));
  connect(tee2.port_3, port_b_extraction2) annotation (Line(points={{48,4.44089e-16},
          {48,-86},{60,-86},{60,-100}}, color={0,127,255}));
  connect(tee2.port_2,pressureCV3. port_a)
    annotation (Line(points={{54,6},{58,6}}, color={0,127,255}));
  connect(pressureCV3.port_b, ST4.portHP)
    annotation (Line(points={{70,6},{74,6}}, color={0,127,255}));
  connect(shaft_b, ST4.shaft_b)
    annotation (Line(points={{100,0},{94,0}}, color={0,0,0}));
  connect(ST2.shaft_b, ST3.shaft_a) annotation (Line(points={{-18,0},{-18,-14},{
          18,-14},{18,0}}, color={0,0,0}));
  connect(ST3.portLP, tee2.port_1)
    annotation (Line(points={{38,6},{42,6}}, color={0,127,255}));
  connect(ST3.shaft_b, ST4.shaft_a)
    annotation (Line(points={{38,0},{38,-14},{74,-14},{74,0}}, color={0,0,0}));
  connect(tee1.port_1, ST2.portLP)
    annotation (Line(points={{-14,6},{-18,6}}, color={0,127,255}));
  connect(ST4.portLP, port_b) annotation (Line(points={{94,6},{94,46},{86,46},{
          86,60},{100,60}}, color={0,127,255}));
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
end ExtractionTurbineModularpre;
