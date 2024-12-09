within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L2
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L2new
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_feed(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State prt_b_steamdump(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_return(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={54,30})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.cond_p, V_total=3.5e3)
    annotation (Placement(transformation(extent={{80,-46},{60,-26}})));
  Fluid.Machines.Pump_Pressure                  pump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.HPT_p_in - 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{32,-70},{12,-50}})));
  Fluid.Machines.Pump_MassFlow             FWCP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=data.mdot_hpt,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in - 1e5,
    T_start=373.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_total)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-72,60})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_fh*1.5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-86,-10})));
  TRANSFORM.Fluid.Valves.ValveLinear ProcessCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=200000,
    m_flow_nominal=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-32,-86})));
  Electrical.Interfaces.ElectricalPowerPort_a port_e
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    m_flow_nominal=4.927992278,
    p_inlet_nominal=12000000,
    p_outlet_nominal=400000,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = 34.69607167)
    annotation (Placement(transformation(extent={{-30,44},{-10,64}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume HP_vol(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-54,50},{-34,70}})));
  Fluid.Valves.PressureCV_v2      pressureCV_v2_1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    Pressure_target=400000,
    PID_k=-1e-3)
    annotation (Placement(transformation(extent={{10,50},{30,70}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    m_flow_nominal=4.884296956,
    p_inlet_nominal=400000,
    p_outlet_nominal=10000,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = 2.193606243)
    annotation (Placement(transformation(extent={{34,44},{54,64}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={72,0})));
  TRANSFORM.Fluid.Sensors.PressureTemperature MainSteam_Sensor(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,80},{-130,100}})));
  TRANSFORM.Fluid.Sensors.PressureTemperature FinalFeedWater_Sensor(redeclare
      package Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-150,-38},{-130,-18}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Ext_vol(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=400000,
    T_start=423.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={4,22})));
equation

  connect(OFWH_2.port_a, pump1.port_b)
    annotation (Line(points={{-24,-60},{12,-60}}, color={0,127,255}));
  connect(pump1.port_a, condenser.port_b)
    annotation (Line(points={{32,-60},{70,-60},{70,-44}}, color={0,127,255}));
  connect(OFWH_2.port_b, FWCP.port_a)
    annotation (Line(points={{-36,-60},{-60,-60}}, color={0,127,255}));
  connect(FWCP.port_b, port_b_feed)
    annotation (Line(points={{-80,-60},{-100,-60}}, color={0,127,255}));
  connect(TCV.port_a, port_a_steam)
    annotation (Line(points={{-82,60},{-100,60}}, color={0,127,255}));
  connect(port_a_steam, FHV.port_a)
    annotation (Line(points={{-100,60},{-86,60},{-86,0}},  color={0,127,255}));
  connect(port_a_return, ProcessCV.port_a) annotation (Line(points={{-60,-100},{
          -60,-86},{-42,-86}}, color={0,127,255}));
  connect(ProcessCV.port_b, condenser.port_a) annotation (Line(points={{-22,-86},
          {86,-86},{86,-29},{77,-29}}, color={0,127,255}));
  connect(HP_vol.port_b, HPT.portHP)
    annotation (Line(points={{-38,60},{-30,60}}, color={0,127,255}));
  connect(HPT.portLP, pressureCV_v2_1.port_a)
    annotation (Line(points={{-10,60},{10,60}}, color={0,127,255}));
  connect(LPT.portHP, pressureCV_v2_1.port_b)
    annotation (Line(points={{34,60},{30,60}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30,100.1},{30,80},{-72,80},{-72,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.FHV, FHV.opening) annotation (Line(
      points={{30,100},{30,80},{-120,80},{-120,-10},{-94,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_Speed, FWCP.inputSignal) annotation (Line(
      points={{30,100},{30,80},{-120,80},{-120,-36},{-70,-36},{-70,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.ProcessCV, ProcessCV.opening) annotation (Line(
      points={{30,100},{30,80},{-120,80},{-120,-72},{-32,-72},{-32,-78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(points={{-10,54},{-10,44},
          {34,44},{34,54}},             color={0,0,0}));
  connect(LPT.shaft_b, generator.shaft)
    annotation (Line(points={{54,54},{54,40}},          color={0,0,0}));
  connect(generator.port, sensorW.port_a) annotation (Line(points={{54,20},{54,
          1.72085e-15},{62,1.72085e-15}}, color={255,0,0}));
  connect(sensorW.port_b, port_e) annotation (Line(points={{82,-7.21645e-16},{
          91,-7.21645e-16},{91,0},{100,0}}, color={255,0,0}));
  connect(MainSteam_Sensor.port, port_a_steam) annotation (Line(points={{-140,
          80},{-140,60},{-100,60}}, color={0,127,255}));
  connect(FinalFeedWater_Sensor.port, port_b_feed) annotation (Line(points={{
          -140,-38},{-140,-60},{-100,-60}}, color={0,127,255}));
  connect(sensorBus.Steam_Temperature, MainSteam_Sensor.T) annotation (Line(
      points={{-30,100},{-128,100},{-128,88},{-132,88},{-132,87.8},{-134,87.8}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(sensorBus.Steam_Pressure, MainSteam_Sensor.p) annotation (Line(
      points={{-30,100},{-128,100},{-128,92},{-132,92},{-132,92.4},{-134,92.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(sensorBus.Feedwater_Temp, FinalFeedWater_Sensor.T) annotation (Line(
      points={{-30,100},{-128,100},{-128,-30},{-132,-30},{-132,-30.2},{-134,
          -30.2}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.W_total, sensorW.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,84},{118,84},{118,20},{72,20},{72,11}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(HPT.portLP, Ext_vol.port_a)
    annotation (Line(points={{-10,60},{4,60},{4,28}}, color={0,127,255}));
  connect(FHV.port_b, FWCP.port_a) annotation (Line(points={{-86,-20},{-86,-34},
          {-54,-34},{-54,-60},{-60,-60}}, color={0,127,255}));
  connect(TCV.port_b, HP_vol.port_a)
    annotation (Line(points={{-62,60},{-50,60}}, color={0,127,255}));
  connect(Ext_vol.port_b, prt_b_steamdump)
    annotation (Line(points={{4,16},{4,-100},{60,-100}}, color={0,127,255}));
  connect(LPT.portLP, condenser.port_a) annotation (Line(points={{54,60},{74,60},
          {74,16},{114,16},{114,-29},{77,-29}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-2.09756,2},{83.9024,-2}},
          lineColor={0,0,0},
          origin={-45.902,-64},
          rotation=360,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-1.81329,5},{66.1867,-5}},
          lineColor={0,0,0},
          origin={-68.187,-41},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-16,3},{16,-3}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder,
          origin={4,30},
          rotation=-90),
        Rectangle(
          extent={{-1.81332,3},{66.1869,-3}},
          lineColor={0,0,0},
          origin={-18.187,-3},
          rotation=0,
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-70,46},{-22,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{0,16},{0,-14},{30,-32},{30,36},{0,16}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{11,-8},{21,6}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="T"),
        Ellipse(
          extent={{46,12},{74,-14}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.4,3},{15.5,-3}},
          lineColor={0,0,0},
          origin={30.427,-29},
          rotation=0,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.43805,2.7864},{15.9886,-2.7864}},
          lineColor={0,0,0},
          origin={45.214,-41.989},
          rotation=90,
          fillColor={0,128,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{32,-42},{60,-68}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-0.373344,2},{13.6267,-2}},
          lineColor={0,0,0},
          origin={18.373,-56},
          rotation=0,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.487802,2},{19.5122,-2}},
          lineColor={0,0,0},
          origin={20,-38.488},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.243902,2},{9.7562,-2}},
          lineColor={0,0,0},
          origin={-46,-62.244},
          rotation=-90,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-0.578156,2.1722},{23.1262,-2.1722}},
          lineColor={0,0,0},
          origin={21.422,-39.828},
          rotation=180,
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-4,-34},{8,-46}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,100,199}),
        Polygon(
          points={{-2,-44},{-6,-48},{10,-48},{6,-44},{-2,-44}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-20,46},{6,34}},
          lineColor={0,0,0},
          fillColor={66,200,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-30,49},{-12,31}},
          lineColor={95,95,95},
          fillColor={175,175,175},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{-20,49},{-22,61}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.VerticalCylinder),
        Rectangle(
          extent={{-30,63},{-12,61}},
          lineColor={0,0,0},
          fillColor={181,0,0},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-19,49},{-23,31}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={162,162,0}),
        Text(
          extent={{55,-10},{65,4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="G"),
        Text(
          extent={{41,-62},{51,-48}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="C"),
        Polygon(
          points={{3,-37},{3,-43},{-1,-40},{3,-37}},
          lineColor={0,0,0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,255,255})}),                            Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteamTurbine_L2;
