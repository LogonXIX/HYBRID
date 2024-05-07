within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L4_2sNTU
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L4_s2
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4_s2 data);

      replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_MainSteam(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_FeedWater(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,-70},{-190,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_ExtReturn(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_Ext(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-130,130},{-110,150}})));
  Fluid.Machines.ExtractionTurbine Trubine(
    redeclare package medium = Medium,
    P_in=data.P_in,
    P_out=data.P_cond,
    h_in=data.h_in,
    m_in=data.m1,
    eta_t=data.eta_t,
    P_ext1=data.P_ext1,
    P_ext2=data.P_ext2,
    P_ext3=data.P_ext3,
    m_ext1=data.m1a + data.m1d,
    m_ext2=data.m1b,
    m_ext3=data.m1c,
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
    pressureCV1(ValvePos_start=0.8, init_time=7),
    pressureCV2(ValvePos_start=0.9, init_time=5),
    pressureCV3(ValvePos_start=0.95, init_time=3))
            annotation (Placement(transformation(extent={{-60,28},{-20,68}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{154,38},{174,58}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_State port_b
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Fluid.Machines.Pump_Pressure FWP1(redeclare package Medium = Medium,
    p_a_start=data.P_cond,
    p_b_start=data.P_Dea,
    T_a_start=(45 - 0.1) + 273.15,
    T_b_start=(45 + 0.1) + 273.15,
    m_flow_start=data.m3,
    p_nominal=data.P_Dea,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{128,-70},{108,-50}})));

  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.P_cond, V_total=50)
    annotation (Placement(transformation(extent={{142,-52},{122,-32}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Deaerator(redeclare package Medium =
        Medium,
    p_start=data.P_Dea,
    T_start=383.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Medium,
    V=0.033,
    p_start=data.P_Dea,
    T_start=(45 + 0.1) + 273.15)
    annotation (Placement(transformation(extent={{102,-50},{82,-70}})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(redeclare package Medium = Medium,
    m_flow_start=data.m1a,
    dp_nominal=500000,
    m_flow_nominal=data.m1a)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-60,-82})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(redeclare package Medium = Medium,
    m_flow_start=data.m1,
    dp_nominal=50000,
    m_flow_nominal=data.m1)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-94,60})));
  Fluid.Machines.Pump_Pressure FWP2(
    redeclare package Medium = Medium,
    p_a_start=data.P_Dea,
    p_b_start=data.P_feed,
    T_a_start=373.15,
    T_b_start=373.15,
    m_flow_start=data.m1,
    p_nominal=data.P_feed - 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-46,-70},{-66,-50}})));

  TRANSFORM.Fluid.Sensors.Temperature T_feed_sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-168,-60},{-188,-40}})));
  TRANSFORM.Fluid.Sensors.Temperature T_steam_sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-166,60},{-186,80}})));
  TRANSFORM.Fluid.Sensors.Pressure P_steam_sensor(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-156,60},{-176,40}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={180,28})));
  Modelica.Blocks.Sources.RealExpression W_net(y=sensorW.W - FWP1.W - FWP2.W)
    "turbine work - pump work"
    annotation (Placement(transformation(extent={{-96,108},{-84,120}})));
  TRANSFORM.Fluid.Valves.ValveLinear DHV(
    redeclare package Medium = Medium,
    m_flow_start=data.m1d,
    dp_nominal=50000,
    m_flow_nominal=data.m1d) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={12,-26})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Medium,
    V=0.033,
    p_start=data.P_Dea - 100,
    T_start=(45 + 0.1) + 273.15)
    annotation (Placement(transformation(extent={{64,-70},{44,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = Medium,
    V=0.033,
    p_start=data.P_Dea - 50,
    T_start=(45 + 0.1) + 273.15)
    annotation (Placement(transformation(extent={{22,-70},{2,-50}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-26,-60},{-46,-40}})));
  Modelica.Blocks.Sources.RealExpression Dea_T_set(y=
        Medium.saturationTemperature_sat(Medium.setSat_p(data.P_Dea)))
    "turbine work - pump work"
    annotation (Placement(transformation(extent={{-96,98},{-84,110}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee3(
    redeclare package Medium = Medium,
    V=1,
    p_start=data.P_cond,
    use_T_start=false,
    T_start=318.15,
    h_start=2209e3)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={148,2})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-148,50},{-128,70}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
    NTU=10,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    V_Tube=0.2,
    V_Shell=0.2,
    p_start_tube=19700000,
    T_start_tube_inlet=409.15,
    T_start_tube_outlet=466.15,
    h_start_tube_inlet=587e3,
    h_start_tube_outlet=830e3,
    p_start_shell=1650000,
    use_T_start_shell=false,
    T_start_shell_inlet=533.15,
    T_start_shell_outlet=414.15,
    h_start_shell_inlet=2942e3,
    h_start_shell_outlet=596e3,
    dp_init_tube=10000,
    m_start_tube=76.68,
    m_start_shell=7.95)
    annotation (Placement(transformation(extent={{-122,-88},{-82,-48}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee4(
    redeclare package Medium = Medium,
    V=0.033,
    p_start=data.P_Dea,
    T_start=513.15)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-52,0})));
  Fluid.Machines.Pump_MassFlow FWP3(
    redeclare package Medium = Medium,
    p_a_start=data.P_feed - 1e5,
    p_b_start=data.P_feed,
    T_a_start=373.15,
    T_b_start=373.15,
    m_flow_start=data.m1,
    use_input=true,
    m_flow_nominal=76.677,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-140,-70},{-160,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance5(
      redeclare package Medium = Medium, R=0.6*(data.P_ext1 - data.P_Dea)/data.m1a)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={18,-80})));
equation

  connect(condenser.port_b,FWP1. port_a) annotation (Line(points={{132,-50},{
          128,-50},{128,-60}},       color={0,127,255}));
  connect(FWP1.port_b, tee.port_1)
    annotation (Line(points={{108,-60},{102,-60}},color={0,127,255}));
  connect(TCV.port_b, Trubine.port_a)
    annotation (Line(points={{-84,60},{-60,60}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,130},{30,130},{30,160},{-220,160},{-220,88},{-94,
          88},{-94,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FHV, FHV.opening) annotation (Line(
      points={{30,100},{30,160},{-220,160},{-220,-120},{-58,-120},{-58,-92},{
          -60,-92},{-60,-90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(FWP2.port_a, Deaerator.port_a)
    annotation (Line(points={{-46,-60},{-26,-60}},
                                                 color={0,127,255}));
  connect(port_b_FeedWater, T_feed_sensor.port)
    annotation (Line(points={{-200,-60},{-178,-60}}, color={0,127,255}));
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
  connect(Trubine.shaft_b, generator.shaft)
    annotation (Line(points={{-20,48},{154,48}}, color={0,0,0}));
  connect(Trubine.port_b_extraction2, port_b_Ext) annotation (Line(points={{-40,
          28},{-40,20},{-116,20},{-116,124},{-120,124},{-120,140}}, color={0,127,
          255}));
  connect(DHV.port_b, tee2.port_3) annotation (Line(points={{12,-36},{12,-50}},
                              color={0,127,255}));
  connect(Trubine.port_b_extraction3, tee1.port_3) annotation (Line(points={{-28,28},
          {-28,18},{54,18},{54,-50}},       color={0,127,255}));
  connect(actuatorBus.DCV, DHV.opening) annotation (Line(
      points={{30,100},{30,-42},{-4,-42},{-4,-26},{4,-26}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(sensor_T.port, Deaerator.port_a)
    annotation (Line(points={{-36,-60},{-26,-60}}, color={0,127,255}));
  connect(sensorBus.T_dea, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,162},{-222,162},{-222,-36},{-132,-36},{-132,-50},{-42,
          -50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.T_dea_set, Dea_T_set.y) annotation (Line(
      points={{-30,100},{-30,104},{-83.4,104}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tee3.port_2, condenser.port_a) annotation (Line(points={{148,-8},{148,
          -35},{139,-35}}, color={0,127,255}));
  connect(port_a_ExtReturn, tee3.port_3) annotation (Line(points={{180,-40},{
          180,-16},{164,-16},{164,2},{158,2}}, color={0,127,255}));
  connect(P_steam_sensor.port, nonLinear_Break.port_a)
    annotation (Line(points={{-166,60},{-148,60}}, color={0,127,255}));
  connect(nonLinear_Break.port_b, TCV.port_a)
    annotation (Line(points={{-128,60},{-104,60}}, color={0,127,255}));
  connect(FWP2.port_b, nTU_HX_SinglePhase.Tube_in)
    annotation (Line(points={{-66,-60},{-82,-60}}, color={0,127,255}));
  connect(FHV.port_a, nTU_HX_SinglePhase.Shell_out) annotation (Line(points={{
          -70,-82},{-76,-82},{-76,-94},{-82,-94},{-82,-72}}, color={0,127,255}));
  connect(Trubine.port_b_extraction1, tee4.port_1)
    annotation (Line(points={{-52,28},{-52,10}}, color={0,127,255}));
  connect(tee4.port_2, nTU_HX_SinglePhase.Shell_in) annotation (Line(points={{
          -52,-10},{-52,-12},{-128,-12},{-128,-54},{-130,-54},{-130,-72},{-122,
          -72}}, color={0,127,255}));
  connect(FWP3.port_b, T_feed_sensor.port)
    annotation (Line(points={{-160,-60},{-178,-60}}, color={0,127,255}));
  connect(FWP3.port_a, nTU_HX_SinglePhase.Tube_out)
    annotation (Line(points={{-140,-60},{-122,-60}}, color={0,127,255}));
  connect(FHV.port_b, resistance5.port_a) annotation (Line(points={{-50,-82},{2,
          -82},{2,-80},{11,-80}}, color={0,127,255}));
  connect(resistance5.port_b, tee.port_3)
    annotation (Line(points={{25,-80},{92,-80},{92,-70}}, color={0,127,255}));
  connect(tee4.port_3, DHV.port_a) annotation (Line(points={{-42,-6.10623e-16},
          {12,-6.10623e-16},{12,-16}}, color={0,127,255}));
  connect(actuatorBus.FCV, FWP3.inputSignal) annotation (Line(
      points={{30,100},{-62,100},{-62,-52.7},{-150,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tee.port_2, tee1.port_1)
    annotation (Line(points={{82,-60},{64,-60}}, color={0,127,255}));
  connect(tee1.port_2, tee2.port_1)
    annotation (Line(points={{44,-60},{22,-60}}, color={0,127,255}));
  connect(tee2.port_2, Deaerator.port_b)
    annotation (Line(points={{2,-60},{-14,-60}}, color={0,127,255}));
  connect(tee3.port_1, Trubine.port_b) annotation (Line(points={{148,12},{148,
          52},{-10,52},{-10,60},{-20,60}}, color={0,127,255}));
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
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{180,140}})));
end SteamTurbine_L4_2sNTU;
