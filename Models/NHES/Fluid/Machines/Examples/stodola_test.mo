within NHES.Fluid.Machines.Examples;
model stodola_test
  extends Modelica.Icons.Example;
  TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    m_flow_nominal=100,
    p_inlet_nominal=10000000,
    p_outlet_nominal=2000000,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = 50.89)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=true,
    p=10000000,
    h=2800e3,
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
  parameter Modelica.Units.SI.AbsolutePressure Pin =20e5 "Value of Real output";
  parameter Modelica.Units.SI.AbsolutePressure Pout =100e5 "Value of Real output";
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Pin)
    annotation (Placement(transformation(extent={{-142,10},{-122,30}})));
equation
  connect(boundary3.port, generator.port)
    annotation (Line(points={{80,0},{60,0}}, color={255,0,0}));
  connect(generator.shaft, steamTurbine.shaft_b)
    annotation (Line(points={{40,0},{20,0}}, color={0,0,0}));
  connect(realExpression.y, boundary1.p_in) annotation (Line(points={{165,20},{142,
          20}},                       color={0,0,127}));
  connect(steamTurbine.portHP, boundary.ports[1])
    annotation (Line(points={{-20,12},{-80,12}}, color={0,127,255}));
  connect(steamTurbine.portLP, boundary1.ports[1])
    annotation (Line(points={{20,12},{120,12}}, color={0,127,255}));
  connect(realExpression1.y, boundary.p_in)
    annotation (Line(points={{-121,20},{-102,20}}, color={0,0,127}));
end stodola_test;
