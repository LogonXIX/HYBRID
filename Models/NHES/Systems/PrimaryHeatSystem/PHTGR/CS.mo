within NHES.Systems.PrimaryHeatSystem.PHTGR;
package CS "Control systems package"
  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Dummy;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  model CS_Texit

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    TRANSFORM.Controls.LimPID PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.00002,
      Ti=360,
      yMax=1,
      yMin=-1,
      Ni=3,
      y_start=8.75)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Math.Gain gain(k=-CR_worth)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPID RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=7,
      init_output=7)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(actuatorBus.CR_pos, gain.y) annotation (Line(
        points={{30,-100},{30,50},{21,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(gain.u, PID_exit_T.y)
      annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_Texit;

  model CS_Texit_rhoInset

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    TRANSFORM.Controls.LimPID PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.00002,
      Ti=360,
      yMax=1,
      yMin=-1,
      Ni=3)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Math.Gain gain(k=-CR_worth)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.Step step(height=300e-5, startTime=3.1E6)
      annotation (Placement(transformation(extent={{0,0},{20,20}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{40,20},{60,40}})));
    Modelica.Blocks.Sources.Step step1(height=0, startTime=0)
      annotation (Placement(transformation(extent={{14,70},{34,90}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(gain.u, PID_exit_T.y)
      annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
    connect(step.y, add.u2) annotation (Line(points={{21,10},{32,10},{32,24},
            {38,24}}, color={0,0,127}));
    connect(actuatorBus.CR_pos, add.y) annotation (Line(
        points={{30,-100},{30,8},{66,8},{66,30},{61,30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(gain.y, add.u1)
      annotation (Line(points={{21,50},{38,50},{38,36}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_Texit_rhoInset;

  package TES_CS
    model CS_TES

      extends
        NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

      NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      Controls.LimOffsetPID CV_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-4,
        Ti=10,
        yMax=1,
        yMin=0,
        offset=0.1)
        annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=HotTankT)
        annotation (Placement(transformation(extent={{-94,-40},{-74,-20}})));
      Controls.LimOffsetPID DV_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3e-5,
        Ti=360,
        yMax=1,
        yMin=0,
        offset=0.9,
        delayTime=4000,
        init_output=0.9)
        annotation (Placement(transformation(extent={{-44,22},{-24,42}})));
      Modelica.Blocks.Sources.RealExpression P_in_set(y=MSP)
        annotation (Placement(transformation(extent={{-92,22},{-72,42}})));

    parameter Modelica.Units.SI.Temperature HotTankT=565+273.15;
    parameter Modelica.Units.SI.AbsolutePressure MSP=120e5;
      Modelica.Blocks.Sources.RealExpression P_in_set2
        annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    equation

      connect(realExpression.y, CV_PID.u_s) annotation (Line(points={{-73,-30},{-60,
              -30},{-60,-28},{-48,-28}}, color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, CV_PID.y) annotation (Line(
          points={{30,-100},{30,-28},{-25,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(P_in_set.y, DV_PID.u_s)
        annotation (Line(points={{-71,32},{-46,32}}, color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, DV_PID.y) annotation (Line(
          points={{30,-100},{30,32},{-23,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Hot_Tank_Temp, CV_PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-48},{-36,-48},{-36,-40}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(P_in_set2.y, DV_PID.u_m) annotation (Line(points={{-67,12},{-34,
              12},{-34,20}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_TES;

    model CS_TESsmooth

      extends
        NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

      NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      Controls.LimOffsetPIDsmooth
                            CV_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-4,
        Ti=10,
        yMax=1,
        yMin=0,
        offset=0.1,
        trans_time=0)
        annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=HotTankT)
        annotation (Placement(transformation(extent={{-94,-40},{-74,-20}})));
      Controls.LimOffsetPIDsmooth
                            DV_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=3e-5,
        Ti=360,
        yMax=1,
        yMin=0,
        offset=0.9,
        delayTime=4000,
        trans_time=200)
        annotation (Placement(transformation(extent={{-44,22},{-24,42}})));
      Modelica.Blocks.Sources.RealExpression P_in_set(y=MSP)
        annotation (Placement(transformation(extent={{-92,22},{-72,42}})));

    parameter Modelica.Units.SI.Temperature HotTankT=565+273.15;
    parameter Modelica.Units.SI.AbsolutePressure MSP=120e5;
      Modelica.Blocks.Sources.RealExpression P_in_set2
        annotation (Placement(transformation(extent={{-88,2},{-68,22}})));
    equation

      connect(realExpression.y, CV_PID.u_s) annotation (Line(points={{-73,-30},{-60,
              -30},{-60,-28},{-48,-28}}, color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, CV_PID.y) annotation (Line(
          points={{30,-100},{30,-28},{-25,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(P_in_set.y, DV_PID.u_s)
        annotation (Line(points={{-71,32},{-46,32}}, color={0,0,127}));
      connect(actuatorBus.Discharge_Valve_Position, DV_PID.y) annotation (Line(
          points={{30,-100},{30,32},{-23,32}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Hot_Tank_Temp, CV_PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-48},{-36,-48},{-36,-40}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(P_in_set2.y, DV_PID.u_m) annotation (Line(points={{-67,12},{-34,
              12},{-34,20}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_TESsmooth;

    model CS_TESbound

      extends
        NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

      NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
        annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
      Controls.LimOffsetPID CV_PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-4,
        Ti=10,
        yMax=1,
        yMin=0,
        offset=0.1)
        annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=HotTankT)
        annotation (Placement(transformation(extent={{-94,-40},{-74,-20}})));

    parameter Modelica.Units.SI.Temperature HotTankT=565+273.15;
    parameter Modelica.Units.SI.AbsolutePressure MSP=120e5;
    equation

      connect(realExpression.y, CV_PID.u_s) annotation (Line(points={{-73,-30},{-60,
              -30},{-60,-28},{-48,-28}}, color={0,0,127}));
      connect(actuatorBus.Charge_Valve_Position, CV_PID.y) annotation (Line(
          points={{30,-100},{30,-28},{-25,-28}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Hot_Tank_Temp, CV_PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-48},{-36,-48},{-36,-40}},
          color={239,82,82},
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
    end CS_TESbound;
  end TES_CS;

  model CS_Texitspeed

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    Controls.LimOffsetPIDsmooth
                              PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0000001,
      Ti=3600,
      yMax=0.0032,
      yMin=-0.0032,
      Ni=3,
      y_start=8.75,
      delayTime=1e4,
      trans_time=100)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPIDsmooth
                          RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=6,
      delayTime=0,
      trans_time=0)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.CR_speed, PID_exit_T.y) annotation (Line(
        points={{30,-100},{30,50},{-19,50}},
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
            textString="%name")}));
  end CS_Texitspeed;

  model CS_Texit_fissionControl

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    TRANSFORM.Controls.LimPID PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.00002,
      Ti=360,
      yMax=1,
      yMin=-1,
      Ni=3,
      y_start=8.75)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Math.Gain gain(k=-CR_worth)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPID RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=7,
      init_output=7)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(actuatorBus.CR_pos, gain.y) annotation (Line(
        points={{30,-100},{30,50},{21,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(gain.u, PID_exit_T.y)
      annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.FissionPower, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_Texit_fissionControl;

  model CS_TexitspeedfissionControl

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    TRANSFORM.Controls.LimPID PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0000001,
      Ti=3600,
      yMax=0.0032,
      yMin=-0.0032,
      Ni=3,
      y_start=8.75)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPID RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=6,
      delayTime=0,
      init_output=6)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.CR_speed, PID_exit_T.y) annotation (Line(
        points={{30,-100},{30,50},{-19,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.FissionPower, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_TexitspeedfissionControl;

  model CS_Texitspeedswitch

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    Controls.LimOffsetPIDsmooth
                              PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0000001,
      Ti=3600,
      yMax=0.0032,
      yMin=-0.0032,
      Ni=3,
      y_start=8.75,
      delayTime=1e4,
      trans_time=100)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPIDsmooth
                          RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=6,
      delayTime=0,
      trans_time=0)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.CR_speed, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.Pump_flow, PID_exit_T.y) annotation (Line(
        points={{30,-100},{30,50},{-19,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_Texitspeedswitch;

  model CS_TexitspeedswitchPowerramp

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    Controls.LimOffsetPIDsmooth
                              PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0000001,
      Ti=3600,
      yMax=0.0032,
      yMin=-0.0032,
      Ni=3,
      y_start=8.75,
      delayTime=1e4,
      trans_time=100)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.Ramp           power_ref(
      height=-15e6 + Power_nom,
      duration=100000,
      offset=15e6,
      startTime=400000)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPIDsmooth
                          RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=6,
      delayTime=0,
      trans_time=0)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.CR_speed, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.Pump_flow, PID_exit_T.y) annotation (Line(
        points={{30,-100},{30,50},{-19,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_TexitspeedswitchPowerramp;

  model CS_TexitspeedPowerramp

    extends BaseClasses.Partial_ControlSystem;
    parameter Modelica.Units.SI.Power Power_nom= 15e6;
    parameter Real CR_worth=2000e-5;
    parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
    Controls.LimOffsetPIDsmooth
                              PID_exit_T(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-0.0000001,
      Ti=3600,
      yMax=0.0032,
      yMin=-0.0032,
      Ni=3,
      y_start=8.75,
      delayTime=1e4,
      trans_time=100)
      annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
    Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
      annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
    Modelica.Blocks.Sources.Ramp           power_ref(
      height=-15e6 + Power_nom,
      duration=100000,
      offset=15e6,
      startTime=400000)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
      "Value of Real output";
    Controls.LimOffsetPIDsmooth
                          RCP_PID(
      k=1e-8,
      Ti=360,
      yMax=12,
      yMin=2,
      offset=6,
      delayTime=0,
      trans_time=0)
      annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  equation

    connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
        points={{-30,-100},{-30,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
      annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
    connect(power_ref.y, RCP_PID.u_s)
      annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
    connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
        points={{30,-100},{30,-30},{1,-30}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.CR_speed, PID_exit_T.y) annotation (Line(
        points={{30,-100},{30,50},{-19,50}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="%name")}));
  end CS_TexitspeedPowerramp;
end CS;
