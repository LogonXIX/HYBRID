within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L4_Pcontrol
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
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
  Controls.LimOffsetPID Tsteam_PI_FCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-4,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.8,
    init_output=0.8)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Controls.LimOffsetPID Pin_PI_TCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-8,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.8,
    init_output=0.8)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.RealExpression feed_temp(y=data.T_feed)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.RealExpression steam_temp(y=data.T_in)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.RealExpression steam_press(y=data.P_in)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation

  connect(sensorBus.Feedwater_Temp, Tfeed_PI_FHV.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{0,-74},{0,-62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Temperature, Tsteam_PI_FCV.u_m) annotation (Line(
      points={{-30,-100},{-30,-28},{0,-28},{0,-22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Pin_PI_TCV.u_m) annotation (Line(
      points={{-30,-100},{-30,10},{0,10},{0,18}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(steam_press.y, Pin_PI_TCV.u_s)
    annotation (Line(points={{-39,30},{-12,30}}, color={0,0,127}));
  connect(steam_temp.y, Tsteam_PI_FCV.u_s)
    annotation (Line(points={{-39,-10},{-12,-10}}, color={0,0,127}));
  connect(feed_temp.y, Tfeed_PI_FHV.u_s)
    annotation (Line(points={{-39,-50},{-12,-50}}, color={0,0,127}));
  connect(actuatorBus.FHV, Tfeed_PI_FHV.y) annotation (Line(
      points={{30,-100},{30,-50},{11,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FCV, Tsteam_PI_FCV.y) annotation (Line(
      points={{30,-100},{30,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_TCV, Pin_PI_TCV.y) annotation (Line(
      points={{30.1,-99.9},{30,-99.9},{30,30},{11,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L4_Pcontrol;
