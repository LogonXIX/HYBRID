within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L4_test
  extends Modelica.Icons.Example;

  SteamTurbine_L4 steamTurbine_L4_1(
    redeclare NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L4 CS(
        Tfeed_PI_FHV(offset=0.01, init_output=0.01)),
    redeclare package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-52,-26},{46,42}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=16200000,
    T_start=793.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=205000e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,16})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=
        0.35e5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,-8})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{104,-6},{84,14}})));
equation
  connect(resistance.port_b, volume.port_a)
    annotation (Line(points={{-88,-1},{-88,10}}, color={0,127,255}));
  connect(resistance.port_a, steamTurbine_L4_1.port_b_FeedWater) annotation (
      Line(points={{-88,-15},{-88,-24},{-62,-24},{-62,-14.6667},{-52,-14.6667}},
        color={0,127,255}));
  connect(volume.port_b, steamTurbine_L4_1.port_a_MainSteam) annotation (Line(
        points={{-88,22},{-88,24},{-62,24},{-62,19.3333},{-52,19.3333}}, color=
          {0,127,255}));
  connect(boundary.port, steamTurbine_L4_1.port_b) annotation (Line(points={{84,
          4},{54,4},{54,2.33333},{46,2.33333}}, color={255,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=20000,
      Interval=20,
      __Dymola_Algorithm="Esdirk45a"));
end L4_test;
