within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_L2BP

  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3_BP data
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.RealExpression T_in_set(y=data.T_ms)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.T_feed)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression Power_Demand(y=3e6)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Controls.LimOffsetPIDsmooth FWCP_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-5e-1,
    Ti=30,
    yMax=2*data.mdot_ms,
    yMin=data.mdot_ms*0.1,
    offset=data.mdot_ms,
    delayTime=2,
    trans_time=10)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  Controls.LimOffsetPIDsmooth
                            TCV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=3e-5,
    Ti=200,
    yMax=1,
    yMin=0,
    offset=0.9,
    delayTime=1000,
    trans_time=100)
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Controls.LimOffsetPIDsmooth FHV_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-5,
    Ti=15,
    yMax=1,
    yMin=0,
    offset=0.9,
    trans_time=10)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression Process_Target(y=0)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Controls.LimOffsetPIDsmooth Process_PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-3e-9,
    Ti=360,
    yMax=1,
    yMin=0,
    offset=0.9,
    trans_time=10)
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Blocks.Sources.RealExpression Process_Measure(y=0)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
equation

  connect(T_feed_set.y, FHV_PID.u_s)
    annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, FHV_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,30},{0,30},{0,38}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(T_in_set.y, FWCP_PID.u_s)
    annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
  connect(Process_Target.y, Process_PID.u_s)
    annotation (Line(points={{-79,-30},{-12,-30}}, color={0,0,127}));
  connect(Power_Demand.y, TCV_PID.u_s)
    annotation (Line(points={{-79,10},{-12,10}}, color={0,0,127}));
  connect(sensorBus.W_total, TCV_PID.u_m) annotation (Line(
      points={{-29.9,-99.9},{-29.9,-12},{0,-12},{0,-2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Steam_Temperature, FWCP_PID.u_m) annotation (Line(
      points={{-30,-100},{-30,68},{0,68},{0,78}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.opening_TCV, TCV_PID.y) annotation (Line(
      points={{30.1,-99.9},{30.1,10},{11,10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.FHV, FHV_PID.y) annotation (Line(
      points={{30,-100},{30,50},{11,50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.Feed_Pump_Speed, FWCP_PID.y) annotation (Line(
      points={{30,-100},{30,90},{11,90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.ProcessCV, Process_PID.y) annotation (Line(
      points={{30,-100},{30,-30},{11,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Process_Measure.y, Process_PID.u_m)
    annotation (Line(points={{-79,-50},{0,-50},{0,-42}}, color={0,0,127}));
annotation(defaultComponentName="changeMe_CS", Icon(graphics),
    experiment(
      StopTime=1000,
      Interval=5,
      __Dymola_Algorithm="Esdirk45a"));
end CS_L2BP;
