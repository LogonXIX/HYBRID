within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L4
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L4
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4 data);

      replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_MainSteam(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,50},{-190,70}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_FeedWater(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-210,-70},{-190,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_ExtReturn1(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_ExtReturn2(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{170,-70},{190,-50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_Ext1(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-130,130},{-110,150}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_Ext2(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{110,130},{130,150}})));
  Fluid.Machines.ExtractionTurbine HPT(
    P_in=data.P_in,
    P_out=data.P_lpt_inlet,
    h_in=Medium.specificEnthalpy_pT(data.P_in, data.T_in),
    m_in=data.m1,
    eta_t=data.eta_t,
    P_ext1=data.P_hpt1,
    P_ext2=data.P_hpt2,
    P_ext3=data.P_hpt3,
    m_ext1=if data.HPT1ext then data.m1e else data.m1a,
    m_ext2=if data.HPT1ext then data.m1a elseif data.HPT2ext then data.m1e
         else data.m1b,
    m_ext3=if data.HPT1ext then data.m1b elseif data.HPT2ext then data.m1b
         else data.m1e,
    Ms1=false,
    Con1=true,
    Ms2=false,
    Con2=true,
    Ms3=false,
    Con3=true,
    fms1=data.eta_sep,
    fms2=data.eta_sep,
    fms3=data.eta_sep,
    nExt=3)
    annotation (Placement(transformation(extent={{-60,28},{-20,68}})));
  Fluid.Machines.ExtractionTurbine LPT(
    P_in=data.P_lpt_inlet,
    P_out=data.P_cond,
    m_in=data.m2,
    eta_t=data.eta_t,
    P_ext1=data.P_lpt1,
    P_ext2=data.P_lpt2,
    P_ext3=data.P_lpt3,
    m_ext1=if data.LPT1ext then data.m2e elseif data.LPT2ext then data.m2a
         else data.m2a,
    m_ext2=if data.LPT1ext then data.m2a elseif data.LPT2ext then data.m2e
         else data.m2b,
    m_ext3=if data.LPT1ext then data.m2b elseif data.LPT2ext then data.m2b
         else data.m2e,
    Ms1=false,
    Con1=true,
    Ms2=false,
    Con2=true,
    Ms3=false,
    Con3=true,
    fms1=data.eta_sep,
    fms2=data.eta_sep,
    fms3=data.eta_sep)
    annotation (Placement(transformation(extent={{20,28},{60,68}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{154,38},{174,58}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_State port_b
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS FWH1(redeclare
      package Medium = Medium,
    TTD=data.TTD_FWH1,
    DCA=data.DCA_FWH1,
    T_ci=data.T_FW2,
    T_hi=data.T_FW3 + data.TTD_FWH1,
    P_h=if data.LPT3ext then data.P_lpt2 else data.P_lpt3,
    P_c=data.P_FWH2,
    m_feed=data.m1,
    T_fw_in(start=data.T_FW2, fixed=true),
    T_fw_out(start=data.T_FW3, fixed=true),
    m_hs(start=data.m2b, fixed=true))
    annotation (Placement(transformation(extent={{4,-74},{24,-54}})));
  Fluid.Machines.Pump_Pressure FWP1(redeclare package Medium = Medium,
    p_a_start=data.P_cond,
    p_b_start=data.P_FWH1,
    T_a_start=(45 - 0.1) + 273.15,
    T_b_start=(45 + 0.1) + 273.15,
    m_flow_start=data.m4,
    p_nominal=data.P_FWH1,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{122,-70},{102,-50}})));

  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.P_cond)
    annotation (Placement(transformation(extent={{142,-52},{122,-32}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Deaerator(redeclare package Medium =
        Medium,
    p_start=data.P_FWH1,
    T_start=323.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{54,-70},{74,-50}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
      package Medium = Medium,
    V=0.1,
    p_start=data.P_FWH1,
    T_start=318.15)
    annotation (Placement(transformation(extent={{98,-50},{78,-70}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss        resistance(
      redeclare package Medium = Medium, dp0=0.95*(FWH1.P_h - data.P_cond))
    annotation (Placement(transformation(extent={{62,-100},{82,-80}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss        resistance1(
      redeclare package Medium = Medium, dp0=0.95*(FWH4.P_h - FWH3.P_h))
    annotation (Placement(transformation(extent={{-92,-100},{-72,-80}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss        resistance2(
      redeclare package Medium = Medium, dp0=0.95*(FWH3.P_h - FWH2.P_h))
    annotation (Placement(transformation(extent={{-36,-100},{-16,-80}})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss        resistance3(
      redeclare package Medium = Medium, dp0=0.95*(FWH2.P_h - FWH1.P_h))
    annotation (Placement(transformation(extent={{10,-100},{30,-80}})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(redeclare package Medium = Medium,
    m_flow_start=data.m1e,
    dp_nominal=50000,
    m_flow_nominal=data.m1e)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-106,-28})));
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
  TRANSFORM.Fluid.Valves.ValveLinear FHV1(redeclare package Medium = Medium,
    m_flow_start=data.m1,
    dp_nominal=100000,
    m_flow_nominal=data.m1)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-158,-60})));
  Fluid.Machines.Pump_Pressure FWP2(
    redeclare package Medium = Medium,
    p_a_start=data.P_FWH1,
    p_b_start=data.P_FWH2,
    T_a_start=data.T_FW1,
    T_b_start=data.T_FW2,
    m_flow_start=data.m1,
    p_nominal=data.P_FWH2,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{50,-70},{30,-50}})));
  Fluid.Machines.Pump_Pressure FWP3(
    redeclare package Medium = Medium,
    p_a_start=data.P_FWH2,
    p_b_start=data.P_FWH3,
    T_a_start=data.T_FW4,
    T_b_start=data.T_FW5,
    m_flow_start=data.m1,
    p_nominal=data.P_FWH3,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-36,-70},{-56,-50}})));
  Fluid.Machines.Pump_Pressure FWP4(
    redeclare package Medium = Medium,
    p_a_start=data.P_FWH3,
    p_b_start=data.P_feed + 1e5,
    T_a_start=data.T_FW7,
    T_b_start=data.T_feed,
    m_flow_start=data.m1,
    p_nominal=data.P_feed + 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-120,-70},{-140,-50}})));



  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS FWH2(
    redeclare package Medium = Medium,
    TTD=data.TTD_FWH2,
    DCA=data.DCA_FWH2,
    T_ci=data.T_FW3,
    T_hi=data.T_FW4 + data.TTD_FWH2,
    P_h=if data.LPT2ext then data.P_lpt1 else data.P_lpt2,
    P_c=data.P_FWH2,
    m_feed=data.m1,
    T_fw_out(start=data.T_FW4, fixed=true),
    m_hs(start=data.m2a, fixed=true))
    annotation (Placement(transformation(extent={{-28,-74},{-8,-54}})));
  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS FWH3(
    redeclare package Medium = Medium,
    TTD=data.TTD_FWH3,
    DCA=data.DCA_FWH3,
    T_ci=data.T_FW5,
    T_hi=data.T_FW6 + data.TTD_FWH3,
    P_h=if data.HPT3ext then data.P_hpt2 else data.P_hpt3,
    P_c=data.P_FWH3,
    m_feed=data.m1,
    T_fw_out(start=data.T_FW6, fixed=true),
    m_hs(start=data.m1b, fixed=true))
    annotation (Placement(transformation(extent={{-84,-74},{-64,-54}})));
  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS FWH4(
    redeclare package Medium = Medium,
    TTD=data.TTD_FWH4,
    DCA=data.DCA_FWH4,
    T_ci=data.T_FW6,
    T_hi=data.T_FW7 + data.TTD_FWH4,
    P_h=if data.HPT2ext then data.P_hpt1 else data.P_hpt2,
    P_c=data.P_FWH3,
    m_feed=data.m1,
    T_fw_out(start=data.T_FW7, fixed=true),
    m_hs(start=data.m1a, fixed=false),
    h_hs_out(start=2700e3, fixed=false))
    annotation (Placement(transformation(extent={{-116,-74},{-96,-54}})));
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
  Modelica.Blocks.Sources.RealExpression W_net(y=sensorW.W - FWP1.W - FWP2.W -
        FWP3.W - FWP4.W) "turbine work - pump work"
    annotation (Placement(transformation(extent={{-96,108},{-84,120}})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = Medium,
    V=0.1,
    p_start=FWH3.P_h,
    T_start=373.15)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-54,-90})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = Medium,
    V=0.1,
    p_start=FWH2.P_h,
    T_start=373.15)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-4,-90})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee3(
    redeclare package Medium = Medium,
    V=0.1,
    p_start=0.95*(FWH1.P_h - data.P_cond) + data.P_cond,
    T_start=373.15)
    annotation (Placement(transformation(extent={{10,10},{-10,-10}},
        rotation=180,
        origin={46,-90})));
equation

  //extraction connections
  if data.HPT1ext then
    connect(HPT.port_b_extraction1,port_b_Ext1);
    connect(HPT.port_b_extraction2,FHV.port_a);
  elseif data.HPT2ext then
    connect(HPT.port_b_extraction1,FHV.port_a);
    connect(HPT.port_b_extraction2,port_b_Ext1);
  else
    connect(HPT.port_b_extraction1,FHV.port_a);
    connect(HPT.port_b_extraction3,port_b_Ext1);
  end if;

  if data.LPT1ext then
    connect(LPT.port_b_extraction1,port_b_Ext2);
    connect(LPT.port_b_extraction3,FWH1.port_a_h);
  elseif data.LPT2ext then
    connect(LPT.port_b_extraction2,port_b_Ext2);
    connect(LPT.port_b_extraction3,FWH1.port_a_h);
  else
    connect(LPT.port_b_extraction2,FWH1.port_a_h);
    connect(LPT.port_b_extraction3,port_b_Ext2);
  end if;







  connect(HPT.shaft_b, LPT.shaft_a)
    annotation (Line(points={{-20,48},{20,48}},  color={0,0,0}));
  connect(generator.shaft, LPT.shaft_b)
    annotation (Line(points={{154,48},{60,48}},  color={0,0,0}));
  connect(HPT.port_b, LPT.port_a)
    annotation (Line(points={{-20,60},{20,60}},  color={0,127,255}));
  connect(condenser.port_b,FWP1. port_a) annotation (Line(points={{132,-50},{
          128,-50},{128,-60},{122,-60}},
                                     color={0,127,255}));
  connect(FWP1.port_b, tee.port_1)
    annotation (Line(points={{102,-60},{98,-60}}, color={0,127,255}));
  connect(tee.port_2, Deaerator.port_b)
    annotation (Line(points={{78,-60},{70,-60}}, color={0,127,255}));
  connect(resistance.port_b, tee.port_3) annotation (Line(points={{79,-90},{88,
          -90},{88,-70}},  color={0,127,255}));
  connect(port_a_ExtReturn1, condenser.port_a) annotation (Line(points={{180,-40},
          {146,-40},{146,-35},{139,-35}}, color={0,127,255}));
  connect(port_a_ExtReturn2, condenser.port_a) annotation (Line(points={{180,-60},
          {152,-60},{152,-40},{146,-40},{146,-35},{139,-35}},
                                          color={0,127,255}));
  connect(LPT.port_b, condenser.port_a) annotation (Line(points={{60,60},{148,
          60},{148,-35},{139,-35}},                          color={0,127,255}));
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
      points={{30,100},{30,160},{-220,160},{-220,-28},{-114,-28}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.FCV, FHV1.opening) annotation (Line(
      points={{30,100},{30,160},{-220,160},{-220,-28},{-158,-28},{-158,-52}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(FWP2.port_a, Deaerator.port_a)
    annotation (Line(points={{50,-60},{58,-60}}, color={0,127,255}));
  connect(FWP2.port_b, FWH1.port_a_fw)
    annotation (Line(points={{30,-60},{24,-60}}, color={0,127,255}));
  connect(FWP4.port_b, FHV1.port_a)
    annotation (Line(points={{-140,-60},{-148,-60}}, color={0,127,255}));
  connect(FWH2.port_b_fw, FWP3.port_a)
    annotation (Line(points={{-28,-60},{-36,-60}}, color={0,127,255}));
  connect(FWH1.port_b_fw, FWH2.port_a_fw)
    annotation (Line(points={{4,-60},{-8,-60}}, color={0,127,255}));
  connect(FWH3.port_a_fw, FWP3.port_b)
    annotation (Line(points={{-64,-60},{-56,-60}}, color={0,127,255}));
  connect(FWH4.port_b_fw, FWP4.port_a)
    annotation (Line(points={{-116,-60},{-120,-60}}, color={0,127,255}));
  connect(FWH4.port_a_fw, FWH3.port_b_fw)
    annotation (Line(points={{-96,-60},{-84,-60}}, color={0,127,255}));
  connect(FWH4.port_b_h, resistance1.port_a) annotation (Line(points={{-96,-70},
          {-94,-70},{-94,-90},{-89,-90}}, color={0,127,255}));
  connect(FHV.port_b, FWH4.port_a_h)
    annotation (Line(points={{-106,-38},{-106,-54}}, color={0,127,255}));
  connect(port_b_FeedWater, T_feed_sensor.port)
    annotation (Line(points={{-200,-60},{-178,-60}}, color={0,127,255}));
  connect(T_feed_sensor.port, FHV1.port_b)
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
  connect(FWH3.port_b_h, tee1.port_3) annotation (Line(points={{-64,-70},{-60,
          -70},{-60,-80},{-54,-80}}, color={0,127,255}));
  connect(resistance1.port_b, tee1.port_1)
    annotation (Line(points={{-75,-90},{-64,-90}}, color={0,127,255}));
  connect(tee1.port_2, resistance2.port_a)
    annotation (Line(points={{-44,-90},{-33,-90}}, color={0,127,255}));
  connect(resistance2.port_b, tee2.port_1)
    annotation (Line(points={{-19,-90},{-14,-90}}, color={0,127,255}));
  connect(tee2.port_2, resistance3.port_a)
    annotation (Line(points={{6,-90},{13,-90}}, color={0,127,255}));
  connect(FWH2.port_b_h, tee2.port_3) annotation (Line(points={{-8,-70},{-8,-74},
          {-4,-74},{-4,-80}}, color={0,127,255}));
  connect(resistance3.port_b, tee3.port_1)
    annotation (Line(points={{27,-90},{36,-90}}, color={0,127,255}));
  connect(FWH1.port_b_h, tee3.port_3) annotation (Line(points={{24,-70},{24,-68},
          {28,-68},{28,-80},{46,-80}}, color={0,127,255}));
  connect(tee3.port_2, resistance.port_a)
    annotation (Line(points={{56,-90},{65,-90}}, color={0,127,255}));
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
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{180,140}}),
        graphics={
        Line(
          points={{-106,-18},{-106,4},{-92,4},{-40,4},{-40,32}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-28,28},{-28,-2},{-74,-2},{-74,-54}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{-52,28},{-52,8},{-120,8},{-120,68},{-120,96},{-120,140}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{52,28},{52,12},{72,12},{120,12},{120,32},{120,70},{120,80},{120,
              88},{120,140}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{28,40},{28,-8},{-18,-8},{-18,-54}},
          color={28,108,200},
          pattern=LinePattern.Dash),
        Line(
          points={{40,46},{40,14},{40,-14},{14,-14},{14,-54}},
          color={28,108,200},
          pattern=LinePattern.Dash)}));
end SteamTurbine_L4;
