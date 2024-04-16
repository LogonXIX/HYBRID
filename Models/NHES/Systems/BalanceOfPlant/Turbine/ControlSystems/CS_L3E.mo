within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L3E

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Controls.LimOffsetPID Tfeed_PI_FHV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-4,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.8,
    init_output=0.8)
    annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
  Controls.LimOffsetPID Tsteam_PI_FCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.5,
    delayTime=40,
    init_output=0.5)
    annotation (Placement(transformation(extent={{-10,-18},{10,2}})));
  Controls.LimOffsetPID W_PI_TCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-7,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.8,
    init_output=0.8)
    annotation (Placement(transformation(extent={{-10,22},{10,42}})));
  Modelica.Blocks.Sources.RealExpression feed_temp(y=data.T_feed)
    annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
  Modelica.Blocks.Sources.RealExpression steam_temp(y=data.T_in)
    annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
  Modelica.Blocks.Sources.RealExpression elec_demand(y=100e6)
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
equation

  connect(sensorBus.Feedwater_Temp, Tfeed_PI_FHV.u_m) annotation (Line(
      points={{-30,-100},{-30,-70},{0,-70},{0,-60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, Tsteam_PI_FCV.u_m) annotation (Line(
      points={{-30,-100},{-30,-30},{0,-30},{0,-20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(elec_demand.y, W_PI_TCV.u_s)
    annotation (Line(points={{-39,32},{-12,32}}, color={0,0,127}));
  connect(steam_temp.y, Tsteam_PI_FCV.u_s)
    annotation (Line(points={{-39,-8},{-12,-8}}, color={0,0,127}));
  connect(feed_temp.y, Tfeed_PI_FHV.u_s)
    annotation (Line(points={{-39,-48},{-12,-48}}, color={0,0,127}));
  connect(actuatorBus.FHV, Tfeed_PI_FHV.y) annotation (Line(
      points={{30,-100},{30,-48},{11,-48}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FCV, Tsteam_PI_FCV.y) annotation (Line(
      points={{30,-100},{30,-8},{11,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, W_PI_TCV.y) annotation (Line(
      points={{30.1,-99.9},{30.1,32},{11,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_net, W_PI_TCV.u_m) annotation (Line(
      points={{-30,-100},{-30,14},{0,14},{0,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L3E;
