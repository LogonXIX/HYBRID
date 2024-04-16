within NHES.Fluid.Machines.Examples;
model ExtractionTurbine_Test
  extends Modelica.Icons.Example;
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=10000000,
    h=3297.3e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-100,2},{-80,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=2000000,
    nPorts=1) annotation (Placement(transformation(extent={{140,2},{120,22}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary3
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=Pout)
    annotation (Placement(transformation(extent={{186,10},{166,30}})));
  parameter Modelica.Units.SI.AbsolutePressure Pin =160e5
                                                         "Value of Real output";
  parameter Modelica.Units.SI.AbsolutePressure Pout =0.1e5
                                                          "Value of Real output";
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Pin)
    annotation (Placement(transformation(extent={{-142,10},{-122,30}})));
  ExtractionTurbine extractionTurbine(
    P_in=16000000,
    P_out=10000,
    h_in=3297.3e3,
    m_in=84.106,
    P_ext1=10000000,
    P_ext2=2000000,
    P_ext3=500000,
    m_ext1=12.178,
    m_ext2=0,
    m_ext3=7.106,
    Ms1=false,
    Ms2=false,
    Con3=false)
    annotation (Placement(transformation(extent={{-22,-20},{18,20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=100000,
    nPorts=1) annotation (Placement(transformation(extent={{74,-70},{54,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=9900000,
    nPorts=1) annotation (Placement(transformation(extent={{12,-100},{-8,-80}})));
  Valves.FlowCV flowCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=12.178,
    ValvePos_start=0.9) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,-48})));
equation
  connect(boundary3.port, generator.port)
    annotation (Line(points={{80,0},{60,0}}, color={255,0,0}));
  connect(realExpression.y, boundary1.p_in) annotation (Line(points={{165,20},{142,
          20}},                       color={0,0,127}));
  connect(realExpression1.y, boundary.p_in)
    annotation (Line(points={{-121,20},{-102,20}}, color={0,0,127}));
  connect(extractionTurbine.shaft_b, generator.shaft)
    annotation (Line(points={{18,0},{40,0}}, color={0,0,0}));
  connect(boundary.ports[1], extractionTurbine.port_a)
    annotation (Line(points={{-80,12},{-22,12}}, color={0,127,255}));
  connect(extractionTurbine.port_b, boundary1.ports[1])
    annotation (Line(points={{18,12},{120,12}}, color={0,127,255}));
  connect(extractionTurbine.port_b_extraction3, boundary2.ports[1])
    annotation (Line(points={{10,-20},{10,-60},{54,-60}}, color={0,127,255}));
  connect(flowCV.port_a, extractionTurbine.port_b_extraction1) annotation (Line(
        points={{-26,-38},{-26,-30},{-14,-30},{-14,-20}}, color={0,127,255}));
  connect(flowCV.port_b, boundary5.ports[1]) annotation (Line(points={{-26,-58},
          {-16,-58},{-16,-90},{-8,-90}}, color={0,127,255}));
end ExtractionTurbine_Test;
