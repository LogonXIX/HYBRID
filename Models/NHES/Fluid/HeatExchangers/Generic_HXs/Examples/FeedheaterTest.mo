within NHES.Fluid.HeatExchangers.Generic_HXs.Examples;
model FeedheaterTest

  NHES.Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS
    cFWH_with_DrainCoolerSSnoinit(
    T_ci=323.15,
    T_hi=374.15,
    P_h=100000,
    P_c=500000,
    m_feed=10) annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=0.6185,
    T=374.15,
    nPorts=1) annotation (Placement(transformation(extent={{-24,24},{-4,44}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    h=1500e3,
    nPorts=1) annotation (Placement(transformation(extent={{90,-70},{70,-50}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=10,
    T=323.15,
    nPorts=1) annotation (Placement(transformation(extent={{74,-12},{54,8}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=500000,
    h=800e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{-52,-26},{-32,-6}})));
  TRANSFORM.Fluid.Sensors.Temperature T_feed_out(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-28,-8},{-8,12}})));
  TRANSFORM.Fluid.Sensors.Temperature T_heating_in(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{6,18},{26,38}})));
  TRANSFORM.Fluid.Sensors.Temperature T_heating_out(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-2,-68},{18,-48}})));
  TRANSFORM.Fluid.Sensors.Temperature T_feed_in(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{48,18},{68,38}})));
equation
  connect(boundary.ports[1], cFWH_with_DrainCoolerSSnoinit.port_a_h)
    annotation (Line(points={{-4,34},{10,34},{10,0}}, color={0,127,255}));
  connect(boundary1.ports[1], cFWH_with_DrainCoolerSSnoinit.port_b_h)
    annotation (Line(points={{70,-60},{28,-60},{28,-16},{20,-16}}, color={0,127,
          255}));
  connect(boundary2.ports[1], cFWH_with_DrainCoolerSSnoinit.port_a_fw)
    annotation (Line(points={{54,-2},{24,-2},{24,-6},{20,-6}}, color={0,127,255}));
  connect(boundary3.ports[1], cFWH_with_DrainCoolerSSnoinit.port_b_fw)
    annotation (Line(points={{-32,-16},{-8,-16},{-8,-6},{0,-6}}, color={0,127,
          255}));
  connect(cFWH_with_DrainCoolerSSnoinit.port_a_h, T_heating_in.port)
    annotation (Line(points={{10,0},{16,0},{16,18}}, color={0,127,255}));
  connect(T_feed_out.port, cFWH_with_DrainCoolerSSnoinit.port_b_fw) annotation
    (Line(points={{-18,-8},{-12,-8},{-12,-6},{0,-6}}, color={0,127,255}));
  connect(T_heating_out.port, cFWH_with_DrainCoolerSSnoinit.port_b_h)
    annotation (Line(points={{8,-68},{8,-70},{22,-70},{22,-16},{20,-16}}, color
        ={0,127,255}));
  connect(T_feed_in.port, cFWH_with_DrainCoolerSSnoinit.port_a_fw) annotation (
      Line(points={{58,18},{58,12},{24,12},{24,-6},{20,-6}}, color={0,127,255}));
  annotation ();
end FeedheaterTest;
