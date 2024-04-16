within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L3_extraction
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3E
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3E data);

      replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_MainSteam(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_FeedWater(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,-70},{-190,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_Ext(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-130,130},{-110,150}})));
  Fluid.Machines.ExtractionTurbine HPT(
    P_in=data.P_in,
    P_out=data.P_cond,
    h_in=data.h_in,
    m_in=data.m1,
    eta_t=data.eta_t,
    P_ext1=data.P_ta,
    P_ext2=data.P_te,
    P_ext3=data.P_tb,
    m_ext1=data.m1a,
    m_ext2=data.m1e,
    m_ext3=data.m1b,
    Ms1=false,
    Con1=true,
    Ms2=false,
    Con2=true,
    Ms3=true,
    Con3=true,
    fms1=data.eta_sep,
    fms2=data.eta_sep,
    fms3=data.eta_sep,
    nExt=3,
    MS3(medium(p(start=2e5, fixed=true))))
    annotation (Placement(transformation(extent={{-60,28},{-20,68}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{154,38},{174,58}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_State port_b
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Fluid.Machines.Pump_Pressure FWP1(redeclare package Medium = Medium,
    p_a_start=data.P_cond,
    p_b_start=data.P_tb*0.9,
    T_a_start=(45 - 0.1) + 273.15,
    T_b_start=(45 + 0.1) + 273.15,
    m_flow_start=data.m3,
    p_nominal=data.P_tb*0.9,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{92,-70},{72,-50}})));

  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.P_cond, V_total=100)
    annotation (Placement(transformation(extent={{112,-52},{92,-32}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH1(
    redeclare package Medium = Medium,
    p_start=data.P_tb*0.9,
    T_start=293.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-14,-70},{6,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(redeclare package Medium = Medium,
    m_flow_start=data.m1e,
    dp_nominal=data.P_tb*0.1*0.5,
    m_flow_nominal=data.m1a)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-64,-28})));
  TRANSFORM.Fluid.Volumes.SimpleVolume SteamHeader(redeclare package Medium =
        Medium,
    p_start=data.P_in,
    T_start=data.T_in + 1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-160,50},{-140,70}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(redeclare package Medium = Medium,
    m_flow_start=data.m1,
    dp_nominal=50000,
    m_flow_nominal=data.m1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-94,60})));
  Fluid.Machines.Pump_MassFlow FWP3(
    redeclare package Medium = Medium,
    m_flow_start=data.m1,
    use_input=true,
    m_flow_nominal=data.m1,
    eta=data.eta_p) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-158,-60})));
  Fluid.Machines.Pump_Pressure FWP2(
    redeclare package Medium = Medium,
    p_a_start=data.P_tb*0.9,
    p_b_start=data.P_ta*0.9,
    T_a_start=294.15,
    T_b_start=293.15,
    m_flow_start=data.m4,
    p_nominal=data.P_ta*0.9,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-24,-70},{-44,-50}})));

  TRANSFORM.Fluid.Sensors.Temperature T_feed_sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-168,-60},{-188,-40}})));
  TRANSFORM.Fluid.Sensors.Temperature T_steam_sensor(redeclare package Medium
      = Medium)
    annotation (Placement(transformation(extent={{-166,60},{-186,80}})));
  TRANSFORM.Fluid.Sensors.Pressure P_steam_sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-156,60},{-176,40}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={180,28})));
  Modelica.Blocks.Sources.RealExpression W_net(y=sensorW.W - FWP1.W - FWP2.W -
        FWP3.W -FWP3.W)  "turbine work - pump work"
    annotation (Placement(transformation(extent={{-96,108},{-84,120}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH2(
    redeclare package Medium = Medium,
    p_start=data.P_ta*0.9,
    T_start=data.T_feed - 20,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-106,-70},{-86,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Medium,
    V=0.1,
    p_start=data.P_ta*0.9,
    T_start=373.15)
    annotation (Placement(transformation(extent={{-54,-70},{-74,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance HP_FH_res(
      redeclare package Medium = Medium, R=data.P_ta*0.1*0.5/data.m1a)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-52,2})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance LP_FH_res(
      redeclare package Medium = Medium, R=data.P_tb*0.1/data.m1b) annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-22,-6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume Cond_inlet_mixer(
    redeclare package Medium = Medium,
    V=10,
    p_start=data.P_cond,
    T_start=313.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-8})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_ExtReturn(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{170,-30},{190,-10}})));
equation


  connect(condenser.port_b,FWP1. port_a) annotation (Line(points={{102,-50},{98,
          -50},{98,-60},{92,-60}},   color={0,127,255}));
  connect(port_a_MainSteam, SteamHeader.port_a)
    annotation (Line(points={{-200,60},{-156,60}}, color={0,127,255}));
  connect(SteamHeader.port_b, TCV.port_a)
    annotation (Line(points={{-144,60},{-104,60}}, color={0,127,255}));
  connect(TCV.port_b, HPT.port_a)
    annotation (Line(points={{-84,60},{-60,60}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,130},{30,130},{30,160},{-220,160},{-220,88},{-94,
          88},{-94,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FHV, FHV.opening) annotation (Line(
      points={{30,100},{30,160},{-220,160},{-220,-28},{-72,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(FWP2.port_a, OFWH1.port_a)
    annotation (Line(points={{-24,-60},{-10,-60}},
                                                 color={0,127,255}));
  connect(port_b_FeedWater, T_feed_sensor.port)
    annotation (Line(points={{-200,-60},{-178,-60}}, color={0,127,255}));
  connect(T_feed_sensor.port, FWP3.port_b)
    annotation (Line(points={{-178,-60},{-168,-60}}, color={0,127,255}));
  connect(sensorBus.Feedwater_Temp, T_feed_sensor.T) annotation (Line(
      points={{-30,100},{-30,162},{-222,162},{-222,-52},{-184,-52},{-184,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(port_a_MainSteam, T_steam_sensor.port)
    annotation (Line(points={{-200,60},{-176,60}}, color={0,127,255}));
  connect(sensorBus.Steam_Temperature, T_steam_sensor.T) annotation (Line(
      points={{-30,100},{-30,162},{-222,162},{-222,70},{-182,70}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(port_a_MainSteam, P_steam_sensor.port)
    annotation (Line(points={{-200,60},{-166,60}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, P_steam_sensor.p) annotation (Line(
      points={{-30,100},{-30,162},{-222,162},{-222,50},{-172,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{174,48},{180,48},{180,38}}, color={255,0,0}));
  connect(sensorW.port_b, port_b)
    annotation (Line(points={{180,18},{180,0}}, color={255,0,0}));
  connect(sensorBus.W_turbines, sensorW.W) annotation (Line(
      points={{-30,100},{-30,162},{210,162},{210,28},{191,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_net, W_net.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,114},{-83.4,114}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(HPT.shaft_b, generator.shaft)
    annotation (Line(points={{-20,48},{154,48}}, color={0,0,0}));
  connect(tee1.port_2, OFWH2.port_b)
    annotation (Line(points={{-74,-60},{-90,-60}}, color={0,127,255}));
  connect(tee1.port_1, FWP2.port_b)
    annotation (Line(points={{-54,-60},{-44,-60}},
                                                color={0,127,255}));
  connect(FHV.port_b, tee1.port_3) annotation (Line(points={{-64,-38},{-64,-50}},
                              color={0,127,255}));
  connect(HPT.port_b_extraction2, port_b_Ext) annotation (Line(points={{-40,28},
          {-40,20},{-120,20},{-120,140}}, color={0,127,255}));
  connect(HPT.port_b_extraction1, HP_FH_res.port_a)
    annotation (Line(points={{-52,28},{-52,9}}, color={0,127,255}));
  connect(HP_FH_res.port_b, FHV.port_a) annotation (Line(points={{-52,-5},{-52,-6},
          {-64,-6},{-64,-18}}, color={0,127,255}));
  connect(Cond_inlet_mixer.port_3, port_a_ExtReturn) annotation (Line(points={{
          120,-8},{164,-8},{164,-20},{180,-20}}, color={0,127,255}));
  connect(Cond_inlet_mixer.port_1, HPT.port_b)
    annotation (Line(points={{110,2},{110,60},{-20,60}}, color={0,127,255}));
  connect(Cond_inlet_mixer.port_2, condenser.port_a) annotation (Line(points={{
          110,-18},{110,-26.5},{109,-26.5},{109,-35}}, color={0,127,255}));
  connect(LP_FH_res.port_a, HPT.port_b_extraction3) annotation (Line(points={{
          -22,1},{-22,20},{-28,20},{-28,28}}, color={0,127,255}));
  connect(OFWH1.port_b, FWP1.port_b)
    annotation (Line(points={{2,-60},{72,-60}}, color={0,127,255}));
  connect(FWP3.port_a, OFWH2.port_a)
    annotation (Line(points={{-148,-60},{-102,-60}}, color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed, FWP3.inputSignal) annotation (Line(
      points={{30,100},{-122,100},{-122,-42},{-158,-42},{-158,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(LP_FH_res.port_b, OFWH1.port_b) annotation (Line(points={{-22,-13},{
          -22,-42},{12,-42},{12,-60},{2,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {180,140}}),                                        graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{180,140}})),
    experiment(
      StopTime=1000,
      Interval=10,
      __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_L3_extraction;
