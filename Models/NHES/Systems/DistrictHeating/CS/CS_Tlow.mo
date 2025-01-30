within NHES.Systems.DistrictHeating.CS;
model CS_Tlow

  extends BaseClasses.Partial_ControlSystem;

  NHES.Controls.LimOffsetPID PID(
    k=0.01,
    Ti=200,
    yMax=60,
    yMin=0.5,
    offset=10,
    delayTime=10000,
    init_output=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Tlow_set)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  parameter Modelica.Units.SI.Temperature Tlow_set=273.15 + 45
    "Value of Real output";
equation

  connect(PID.u_s,realExpression2. y)
    annotation (Line(points={{-12,0},{-29,0}},   color={0,0,127}));
  connect(sensorBus.T_low, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-22},{0,-22},{0,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Pump_speed, PID.y) annotation (Line(
      points={{30,-100},{30,0},{11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_Tlow;
