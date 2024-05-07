within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L4_s2_4test
  extends Modelica.Icons.Example;

  SteamTurbine_L4_2s
                  steamTurbine_L4_2sNTU(
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
      Tfeed_PI_FHV(offset=0.01, delayTime=100),
      W_PI_TCV(offset=0.7)),
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
      m1b=0,
      m1c=0.338,
      m1d=0.2877,
      m2=4.53,
      m3=4.53),
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Turbine(pressureCV_v2_1(ValvePos_start=0.01, init_time=50)))
    annotation (Placement(transformation(extent={{-52,-26},{46,42}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=773.15,
    h_start=3000e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=15e6)     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,16})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{104,-6},{84,14}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    T=333.15,
    nPorts=1) annotation (Placement(transformation(extent={{-54,68},{-34,88}})));
equation
  connect(steamTurbine_L4_2sNTU.port_e, boundary.port) annotation (Line(points=
          {{46,2.33333},{48,2.33333},{48,4},{84,4}}, color={255,0,0}));
  connect(steamTurbine_L4_2sNTU.port_b, volume.port_a) annotation (Line(points=
          {{-52,-20.3333},{-88,-20.3333},{-88,10}}, color={0,127,255}));
  connect(steamTurbine_L4_2sNTU.port_a, volume.port_b) annotation (Line(points=
          {{-52,25},{-74,25},{-74,30},{-88,30},{-88,22}}, color={0,127,255}));
  connect(steamTurbine_L4_2sNTU.port_b_ext, boundary1.ports[1]) annotation (
      Line(points={{-31.3684,42},{-31.3684,64},{-30,64},{-30,78},{-34,78}},
        color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=5000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end L4_s2_4test;
