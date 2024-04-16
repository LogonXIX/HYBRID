within NHES.Systems.BalanceOfPlant.Turbine.Examples;
model L3E_test
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=823.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=15000e3)  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-86,16})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary
    annotation (Placement(transformation(extent={{104,-6},{84,14}})));
  SteamTurbine_L3_extraction steamTurbine_L3_extraction(
    redeclare
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3E_Pcontrol CS(
      data(
        T_in=813.15,
        P_in=12000000,
        h_in=3455.78e3,
        T_feed=473.15,
        P_feed=12000000,
        P_cond=10000,
        P_ta=3000000,
        P_tb=150000,
        P_te=500000,
        m1=5.7715,
        m1a=1.0727,
        m1b=0.247,
        m1e=0,
        m2=4.452,
        m3=4.452,
        m4=4.698),
      Pin_PI_TCV(k=-1e-6),
      Tfeed_PI_FHV(
        k=1e-4,
        offset=0,
        delayTime=1000,
        init_output=0)),
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3E
      data(
      T_in=813.15,
      P_in=12000000,
      h_in=3455.78e3,
      T_feed=473.15,
      P_feed=12000000,
      P_cond=10000,
      P_ta=3000000,
      P_tb=150000,
      P_te=500000,
      m1=5.7715,
      m1a=1.0727,
      m1b=0.247,
      m1e=0,
      m2=4.452,
      m3=4.452,
      m4=4.698),
    Cond_inlet_mixer(V=50),
    TCV(dp_nominal=20000),
    HPT(Con3=true))
    annotation (Placement(transformation(extent={{-46,-6},{46,60}})));
equation
  connect(volume.port_b, steamTurbine_L3_extraction.port_a_MainSteam)
    annotation (Line(points={{-86,22},{-86,38},{-46,38}}, color={0,127,255}));
  connect(steamTurbine_L3_extraction.port_b, boundary.port) annotation (Line(
        points={{46,21.5},{78,21.5},{78,4},{84,4}}, color={255,0,0}));
  connect(volume.port_a, steamTurbine_L3_extraction.port_b_FeedWater)
    annotation (Line(points={{-86,10},{-86,2},{-54,2},{-54,5},{-46,5}}, color={
          0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end L3E_test;
