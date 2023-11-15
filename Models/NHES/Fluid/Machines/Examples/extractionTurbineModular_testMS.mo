within NHES.Fluid.Machines.Examples;
model extractionTurbineModular_testMS
  extends Modelica.Icons.Example;
  ExtractionTurbineModularMS HP(
    P_in=12000000,
    h_in=3455.77e3,
    P_ext1=8000000,
    P_ext2=3000000,
    P_ext3=2500000,
    m_ext1=0.5,
    m_ext2=0.5,
    m_ext3=0.5,
    Ms1=false,
    Ms2=false,
    Ms3=false,
    nExt=3) annotation (Placement(transformation(extent={{-20,-18},{20,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=12000000,
    h=3455.77e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-102,30},{-82,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1) annotation (Placement(transformation(extent={{164,34},{144,54}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{62,-100},{42,-80}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary3
    annotation (Placement(transformation(extent={{222,-8},{202,12}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{162,-8},{182,12}})));
  NHES.Fluid.Valves.FlowCV flowCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=0.5,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{6,-100},{26,-80}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary4(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{88,-60},{68,-40}})));
  Valves.FlowCV            flowCV1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=0.5,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{32,-60},{52,-40}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{170,-40},{150,-20}})));
  Valves.FlowCV            flowCV2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=0.5,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{114,-40},{134,-20}})));
  ExtractionTurbineModularMS LP(
    P_in=2000000,
    P_out=10000,
    h_in=2995e3,
    m_in=8.5,
    P_ext1=500000,
    P_ext2=200000,
    P_ext3=100000,
    m_ext1=0.5,
    m_ext2=0.5,
    m_ext3=0.5,
    Ms1=true,
    Ms2=true,
    Ms3=true,
    nExt=3) annotation (Placement(transformation(extent={{70,-18},{110,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary6(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{366,-50},{346,-30}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{284,-70},{264,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary8(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000,
    nPorts=1)
    annotation (Placement(transformation(extent={{258,-110},{238,-90}})));
equation
  connect(boundary.ports[1], HP.port_a) annotation (Line(points={{-82,40},{-30,
          40},{-30,14},{-20,14}}, color={0,127,255}));
  connect(boundary3.port, generator.port)
    annotation (Line(points={{202,2},{182,2}},
                                             color={255,0,0}));
  connect(boundary2.ports[1], flowCV.port_b)
    annotation (Line(points={{42,-90},{26,-90}}, color={0,127,255}));
  connect(flowCV.port_a, HP.port_b_extraction1)
    annotation (Line(points={{6,-90},{-12,-90},{-12,-18}}, color={0,127,255}));
  connect(boundary4.ports[1], flowCV1.port_b)
    annotation (Line(points={{68,-50},{52,-50}}, color={0,127,255}));
  connect(flowCV1.port_a, HP.port_b_extraction2)
    annotation (Line(points={{32,-50},{0,-50},{0,-18}}, color={0,127,255}));
  connect(boundary5.ports[1], flowCV2.port_b)
    annotation (Line(points={{150,-30},{134,-30}}, color={0,127,255}));
  connect(HP.port_b_extraction3, flowCV2.port_a)
    annotation (Line(points={{12,-18},{12,-30},{114,-30}}, color={0,127,255}));
  connect(LP.shaft_a, HP.shaft_b)
    annotation (Line(points={{70,2},{20,2}}, color={0,0,0}));
  connect(LP.shaft_b, generator.shaft)
    annotation (Line(points={{110,2},{162,2}}, color={0,0,0}));
  connect(boundary8.ports[1], LP.port_b_extraction1) annotation (Line(points={{
          238,-100},{94,-100},{94,-26},{78,-26},{78,-18}}, color={0,127,255}));
  connect(LP.port_b_extraction2, boundary7.ports[1]) annotation (Line(points={{
          90,-18},{90,-38},{108,-38},{108,-60},{264,-60}}, color={0,127,255}));
  connect(boundary6.ports[1], LP.port_b_extraction3) annotation (Line(points={{
          346,-40},{176,-40},{176,-14},{108,-14},{108,-26},{102,-26},{102,-18}},
        color={0,127,255}));
  connect(HP.port_b, LP.port_a)
    annotation (Line(points={{20,14},{70,14}}, color={0,127,255}));
  connect(LP.port_b, boundary1.ports[1]) annotation (Line(points={{110,14},{138,
          14},{138,44},{144,44}}, color={0,127,255}));
  annotation (experiment(StopTime=10, __Dymola_Algorithm="Esdirk45a"));
end extractionTurbineModular_testMS;
