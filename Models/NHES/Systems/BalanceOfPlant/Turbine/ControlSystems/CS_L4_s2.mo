within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L4_s2

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4_s2 data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Controls.LimOffsetPIDsmooth
                        Tfeed_PI_FHV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-4,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0,
    delayTime=10,
    trans_time=10)
    annotation (Placement(transformation(extent={{-10,-58},{10,-38}})));
  Controls.LimOffsetPIDsmooth
                        Tsteam_PI_FCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=100,
    yMax=data.m1*1.5,
    yMin=data.m1*0.1,
    offset=data.m1,
    delayTime=200,
    trans_time=20)
    annotation (Placement(transformation(extent={{-10,-18},{10,2}})));
  Controls.LimOffsetPIDsmooth
                        W_PI_TCV(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-8,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.6,
    delayTime=10,
    trans_time=2)
    annotation (Placement(transformation(extent={{-10,22},{10,42}})));
  Modelica.Blocks.Sources.RealExpression feed_temp(y=data.T_feed)
    annotation (Placement(transformation(extent={{-60,-58},{-40,-38}})));
  Modelica.Blocks.Sources.RealExpression steam_temp(y=data.T_in)
    annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
  Modelica.Blocks.Sources.RealExpression elec_demand(y=120e5)
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
  Controls.LimOffsetPIDsmooth
                        Tdea_PI_FHV1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5e-4,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.1,
    delayTime=1,
    trans_time=1)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Blocks.Sources.RealExpression elec_demand1(y=data.T_Dea)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Controls.LimOffsetPIDsmooth
                        Tdea_PI_FHV2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5e-4,
    Ti=100,
    yMax=1,
    yMin=0,
    offset=0.1,
    delayTime=1,
    trans_time=1)
    annotation (Placement(transformation(extent={{-10,100},{10,120}})));
  Modelica.Blocks.Sources.RealExpression process_demand(y=0)
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  Modelica.Blocks.Sources.RealExpression elec_measure(y=0)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
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
  connect(actuatorBus.opening_TCV, W_PI_TCV.y) annotation (Line(
      points={{30.1,-99.9},{30.1,32},{11,32}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.DCV, Tdea_PI_FHV1.y) annotation (Line(
      points={{30,-100},{30,70},{11,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.T_dea, Tdea_PI_FHV1.u_m) annotation (Line(
      points={{-30,-100},{-30,48},{0,48},{0,58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_Speed, Tsteam_PI_FCV.y) annotation (Line(
      points={{30,-100},{30,-8},{11,-8}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(elec_demand1.y, Tdea_PI_FHV1.u_s)
    annotation (Line(points={{-39,70},{-12,70}}, color={0,0,127}));
  connect(actuatorBus.ECV, Tdea_PI_FHV2.y) annotation (Line(
      points={{30,-100},{30,110},{11,110}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(elec_measure.y, Tdea_PI_FHV2.u_m)
    annotation (Line(points={{-39,90},{0,90},{0,98}}, color={0,0,127}));
  connect(process_demand.y, Tdea_PI_FHV2.u_s)
    annotation (Line(points={{-39,110},{-12,110}}, color={0,0,127}));
  connect(sensorBus.W_net, W_PI_TCV.u_m) annotation (Line(
      points={{-30,-100},{-30,10},{0,10},{0,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L4_s2;
