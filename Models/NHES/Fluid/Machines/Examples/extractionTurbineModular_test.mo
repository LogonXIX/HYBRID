within NHES.Fluid.Machines.Examples;
model extractionTurbineModular_test
  extends Modelica.Icons.Example;
  NHES.Fluid.Machines.ExtractionTurbineModular extractionTurbineModular(nExt=1)
    annotation (Placement(transformation(extent={{-20,-18},{20,22}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10000000,
    h=2800e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-102,30},{-82,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1) annotation (Placement(transformation(extent={{100,30},{80,50}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=2000000,
    nPorts=1)
    annotation (Placement(transformation(extent={{62,-100},{42,-80}})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary3
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  NHES.Fluid.Valves.FlowCV flowCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=2,
    dp_nominal=10000)
    annotation (Placement(transformation(extent={{6,-100},{26,-80}})));
equation
  connect(boundary1.ports[1], extractionTurbineModular.port_b) annotation (Line(
        points={{80,40},{30,40},{30,14},{20,14}}, color={0,127,255}));
  connect(boundary.ports[1], extractionTurbineModular.port_a) annotation (Line(
        points={{-82,40},{-30,40},{-30,14},{-20,14}}, color={0,127,255}));
  connect(boundary3.port, generator.port)
    annotation (Line(points={{80,0},{60,0}}, color={255,0,0}));
  connect(generator.shaft, extractionTurbineModular.shaft_b)
    annotation (Line(points={{40,0},{30,0},{30,2},{20,2}}, color={0,0,0}));
  connect(boundary2.ports[1], flowCV.port_b)
    annotation (Line(points={{42,-90},{26,-90}}, color={0,127,255}));
  connect(flowCV.port_a, extractionTurbineModular.port_b_extraction1)
    annotation (Line(points={{6,-90},{-12,-90},{-12,-18}}, color={0,127,255}));
  annotation (experiment(StopTime=10, __Dymola_Algorithm="Esdirk45a"));
end extractionTurbineModular_test;
