within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L4_s2_4test_2
  extends Modelica.Icons.Example;

  SteamTurbine_L4_2s BOP(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L4_s2TCVP CS(
      redeclare NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4_s2 data(
        T_in=773.15,
        P_in=12000000,
        h_in=3349.9e3,
        d_in(displayUnit="kg/m3") = 37.270,
        P_ext1=1250000,
        P_ext2=700000,
        P_ext3=150000,
        h_ext1=2855e3,
        h_ext2=2754e3,
        h_ext3=2670e3,
        hl_ms=417.4e3,
        hv_ms=2674e3,
        T_1a=489.95,
        d_ext1(displayUnit="kg/m3") = 5.8899,
        d_ext2(displayUnit="kg/m3") = 3.6809,
        d_ext3(displayUnit="kg/m3") = 0.8713,
        T_feed=473.15,
        T_Dea=363.15,
        P_feed=12500000,
        P_Dea=100000,
        P_cond=10000,
        TTD_FWH1=16.82,
        DCA_FWH1=5,
        eta_t1=0.8633,
        eta_t2=0.8747,
        eta_t3=0.885,
        eta_t4=0.9,
        eta_p=0.8,
        eta_sep=0.99,
        eta_mech=0.99,
        m1=6.0169,
        m1a=1.142,
        m1b=0,
        m1c=0.338,
        m1d=0.2877,
        m2=4.53,
        m3=4.53),
      Tdea_PI_FHV1(
        k=1e-3,
        offset=0.01,
        delayTime=150,
        trans_time=10),
      Tfeed_PI_FHV(
        k=0.5e-4,  offset=0.01, delayTime=100),
      W_PI_TCV(
        k=1e-7,offset=0.7, delayTime=1000),
      process_demand(y=1),
      elec_measure(y=sensor_m_flow.m_flow),
      Tdea_PI_FHV2(
        k=3e-8,
        Ti=360,
        offset=0,
        delayTime=1000,
        trans_time=100),
      elec_demand(y=ramp.y)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4_s2
      data(
      T_in=773.15,
      P_in=12000000,
      h_in=3349.9e3,
      d_in(displayUnit="kg/m3") = 37.270,
      P_ext1=1250000,
      P_ext2=700000,
      P_ext3=150000,
      h_ext1=2855e3,
      h_ext2=2754e3,
      h_ext3=2670e3,
      hl_ms=417.4e3,
      hv_ms=2674e3,
      T_1a=489.95,
      d_ext1(displayUnit="kg/m3") = 5.8899,
      d_ext2(displayUnit="kg/m3") = 3.6809,
      d_ext3(displayUnit="kg/m3") = 0.8713,
      T_feed=473.15,
      T_Dea=363.15,
      P_feed=12500000,
      P_Dea=100000,
      P_cond=10000,
      TTD_FWH1=16.82,
      DCA_FWH1=5,
      eta_t1=0.8633,
      eta_t2=0.8747,
      eta_t3=0.885,
      eta_t4=0.9,
      eta_p=0.8,
      eta_sep=0.99,
      eta_mech=0.99,
      m1=6.0169,
      m1a=1.142,
      m1b=1,
      m1c=0.338,
      m1d=0.2877,
      m2=4.53,
      m3=4.53),
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Turbine(pressureCV_v2_1(ValvePos_start=0.01, init_time=50)))
    annotation (Placement(transformation(extent={{-52,-28},{46,40}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=773.15,
    h_start=3000e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    use_HeatPort=true)
                    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-88,-2})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{116,-10},{96,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=200)
    annotation (Placement(transformation(extent={{-26,94},{-6,114}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=600000,
    T_start=373.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    use_HeatPort=true)
    annotation (Placement(transformation(extent={{10,112},{30,92}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(T
      =373.15)
    annotation (Placement(transformation(extent={{-42,128},{-22,148}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
      = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{30,92},{50,112}})));
  Fluid.Valves.ThreeWayValve threeWayValve(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    switch_start=0.5*6e6,
    switch_end=0.45*6e6,
    v1_m_flow_nominal=1,
    v1_dp_nominal=100000,
    v2_m_flow_nominal=1,
    v2_dp_nominal=1000000,
    n1=8,
    n2=6) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-44,90})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW
    annotation (Placement(transformation(extent={{62,-10},{82,10}})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-32,60})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    V=0.5,
    p_start=12000000,
    T_start=773.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-88,28})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-6e6,
    duration=100000,
    offset=6e6,
    startTime=100000)
    annotation (Placement(transformation(extent={{-170,42},{-150,62}})));
  Controls.LimOffsetPIDsmooth PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=20e6,
    yMin=1e6,
    offset=15e6,
    delayTime=7500,
    trans_time=300)
    annotation (Placement(transformation(extent={{-242,-16},{-222,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=BOP.Steam_P.p)
    annotation (Placement(transformation(extent={{-272,-52},{-252,-32}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=120e5)
    annotation (Placement(transformation(extent={{-284,-16},{-264,4}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=473.15,
    h_start=3000e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10))     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-70,-22})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary4(
      use_port=true)
    annotation (Placement(transformation(extent={{-174,-10},{-154,10}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss        resistance1(
      redeclare package Medium = Modelica.Media.Water.StandardWater, dp0=
        9000000)
    annotation (Placement(transformation(extent={{-88,80},{-68,100}})));
equation
  connect(volume1.heatPort, boundary1.port)
    annotation (Line(points={{20,108},{20,138},{-22,138}}, color={191,0,0}));
  connect(resistance.port_b, volume1.port_a) annotation (Line(points={{-9,104},{
          2,104},{2,102},{14,102}}, color={0,127,255}));
  connect(sensor_m_flow.port_a, volume1.port_b)
    annotation (Line(points={{30,102},{26,102}}, color={0,127,255}));
  connect(threeWayValve.port_b, resistance.port_a) annotation (Line(points={{-44,
          100},{-44,104},{-23,104}}, color={0,127,255}));
  connect(boundary.port, sensorW.port_b)
    annotation (Line(points={{96,0},{82,0}}, color={255,0,0}));
  connect(sensorW.port_a, BOP.port_e) annotation (Line(points={{62,0},{54,0},{54,
          0.333333},{46,0.333333}}, color={255,0,0}));
  connect(sensorW.W, threeWayValve.y) annotation (Line(points={{72,11},{72,88},{
          -2,88},{-2,116},{-36,116},{-36,90}}, color={0,0,127}));
  connect(BOP.port_b_ext, nonLinear_Break1.port_a) annotation (Line(points={{
          -31.3684,40},{-31.3684,45},{-32,45},{-32,50}},
                                                color={0,127,255}));
  connect(nonLinear_Break1.port_b, threeWayValve.port_a1) annotation (Line(
        points={{-32,70},{-31.3684,80},{-44,80}}, color={0,127,255}));
  connect(volume.port_b, tee.port_1)
    annotation (Line(points={{-88,4},{-88,18}},         color={0,127,255}));
  connect(tee.port_3, BOP.port_a) annotation (Line(points={{-78,28},{-62,28},{-62,
          23},{-52,23}}, color={0,127,255}));
  connect(realExpression1.y, PID.u_s)
    annotation (Line(points={{-263,-6},{-244,-6}}, color={0,0,127}));
  connect(realExpression.y, PID.u_m) annotation (Line(points={{-251,-42},{-232,-42},
          {-232,-18}}, color={0,0,127}));
  connect(BOP.port_b, volume2.port_a) annotation (Line(points={{-52,-22.3333},{
          -58,-22.3333},{-58,-22},{-64,-22}}, color={0,127,255}));
  connect(volume2.port_b, volume.port_a) annotation (Line(points={{-76,-22},{
          -88,-22.3333},{-88,-8}}, color={0,127,255}));
  connect(boundary4.port, volume.heatPort) annotation (Line(points={{-154,0},{
          -100,0},{-100,10},{-72,10},{-72,-2},{-94,-2}}, color={191,0,0}));
  connect(PID.y, boundary4.Q_flow_ext) annotation (Line(points={{-221,-6},{-184,
          -6},{-184,0},{-168,0}}, color={0,0,127}));
  connect(tee.port_2, resistance1.port_a)
    annotation (Line(points={{-88,38},{-88,90},{-85,90}}, color={0,127,255}));
  connect(resistance1.port_b, threeWayValve.port_a2)
    annotation (Line(points={{-71,90},{-54,90}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, BOP.port_a_ext) annotation (Line(points={{50,
          102},{52,102},{52,32},{54,32},{54,23},{46,23}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=300000,
      Interval=50,
      __Dymola_Algorithm="Esdirk45a"));
end L4_s2_4test_2;
