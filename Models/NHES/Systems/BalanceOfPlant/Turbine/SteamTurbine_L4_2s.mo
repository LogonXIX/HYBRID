within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L4_2s
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L4_s2TCVP
      CS(Tdea_PI_FHV1(k=1e-3,
        offset=0.01,
        delayTime=150,
        trans_time=10),                    Tfeed_PI_FHV(offset=0.01,delayTime=
            100),
      W_PI_TCV(offset=0.7)),
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L4_s2 data);

      replaceable package Medium = Modelica.Media.Water.StandardWater
    annotation (choicesAllMatching=true);

  TRANSFORM.Electrical.PowerConverters.Generator generator
    annotation (Placement(transformation(extent={{40,54},{60,74}})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={180,28})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(redeclare package Medium =
        Medium, p=10000)
    annotation (Placement(transformation(extent={{134,-26},{114,-6}})));
  Fluid.Machines.ExtractionTurbine4stagevol Turbine(
    eta_sep=data.eta_sep,
    m_in=data.m1,
    redeclare package medium = Medium,
    P_in=12000000,
    P_out=10000,
    h_in=3350e3,
    P_ext1=1250000,
    P_ext2=700000,
    P_ext3=150000,
    m_ext1=1.1426,
    m_ext2=0,
    m_ext3=0.338,
    m_ext4=0.2877,
    h_ext1=data.h_ext1,
    h_ext2=data.h_ext2,
    h_ext3=data.h_ext3,
    eta_1=data.eta_t1,
    eta_2=data.eta_t2,
    eta_3=data.eta_t3,
    eta_4=data.eta_t4,
    d_in(displayUnit="kg/m3") = data.d_in,
    d_ext1(displayUnit="kg/m3") = data.d_ext1,
    d_ext2(displayUnit="kg/m3") = data.d_ext2,
    d_ext3(displayUnit="kg/m3") = data.d_ext3,
    h_lsat=data.hl_ms,
    h_vsat=data.hv_ms,
    MS3(port_b(m_flow(start=-4))),
    pressureCV_v2_1(ValvePos_start=0.2, trans_time=5),
    pressureCV_v2_3(ValvePos_start=0.2, trans_time=5),
    pressureCV_v2_2(ValvePos_start=0.2, trans_time=5))
    annotation (Placement(transformation(extent={{-18,40},{32,90}})));
  TRANSFORM.Fluid.Valves.ValveLinear ECV(
    redeclare package Medium = Medium,
    m_flow_nominal=data.m1b,
    dp_nominal=50000)
    annotation (Placement(transformation(extent={{162,70},{142,90}})));
  TRANSFORM.Fluid.Valves.ValveLinear DCV(
    redeclare package Medium = Medium,
    dp_nominal=35000,
    m_flow_nominal=data.m1d) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={16,-38})));
  Fluid.Machines.Pump_Pressure FWP1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=data.P_cond,
    p_b_start=data.P_Dea,
    T_a_start=316.15,
    T_b_start=317.15,
    m_flow_start=data.m3,
    p_nominal=data.P_Dea,
    eta=data.eta_p)
             annotation (Placement(transformation(extent={{104,-90},{84,-70}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Deaerator(
    redeclare package Medium = Medium,
    p_start=data.P_Dea,
    T_start=data.T_Dea,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-10,-88},{-30,-68}})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={16,20})));
  TRANSFORM.Fluid.Sensors.Temperature Dea_T(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-22,-60},{-42,-40}})));
  Fluid.Machines.Pump_Pressure FWP2(
    redeclare package Medium = Medium,
    p_a_start=data.P_feed,
    p_b_start=data.P_Dea,
    T_a_start=data.T_Dea,
    T_b_start=data.T_Dea + 1,
    m_flow_start=data.m1,
    p_nominal=data.P_feed,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-66,-90},{-86,-70}})));
  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS
    cFWH_with_DrainCoolerSS(
    redeclare package Medium = Medium,
    TTD=data.TTD_FWH1,
    DCA=data.DCA_FWH1,
    T_ci=data.T_Dea,
    T_hi=data.T_1a,
    P_h=data.P_ext1,
    P_c=data.P_feed,
    m_feed=data.m1)
    annotation (Placement(transformation(extent={{-120,-94},{-100,-74}})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(
    redeclare package Medium = Medium,
    dp_nominal=35000,
    m_flow_nominal=data.m1a)
    annotation (Placement(transformation(extent={{-30,-90},{-10,-110}})));
  TRANSFORM.Fluid.Sensors.Temperature Feed_T(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-160,-72},{-180,-52}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Medium,
    m_flow_start=data.m1,
    dp_nominal=35000,
    m_flow_nominal=data.m1)
    annotation (Placement(transformation(extent={{-122,70},{-102,90}})));
  TRANSFORM.Fluid.Sensors.Pressure Steam_P(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-122,92},{-142,112}})));
  Fluid.Machines.Pump_MassFlow FWCP(
    redeclare package Medium = Medium,
    p_a_start=12000000,
    p_b_start=100000,
    T_a_start=363.15,
    T_b_start=364.15,
    use_input=true,
    m_flow_nominal=6.016,
    eta=0.8)
    annotation (Placement(transformation(extent={{-132,-70},{-152,-90}})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-40,-90},{-60,-70}})));
  TRANSFORM.Fluid.FittingsAndResistances.MultiPort multiPort(nPorts_b=4)
    annotation (Placement(transformation(extent={{-6,-90},{2,-70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_ext(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{170,70},{190,90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_ext(redeclare package
      Medium = Medium)
    annotation (Placement(transformation(extent={{-130,130},{-110,150}})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_State port_e
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-210,70},{-190,90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-210,-90},{-190,-70}})));
  TRANSFORM.Fluid.Sensors.Temperature Steam_T(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-150,80},{-170,100}})));
  Modelica.Blocks.Sources.RealExpression W_Net(y=sensorW.W - FWP1.W - FWP2.W -
        FWCP.W)
    "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
    annotation (Placement(transformation(extent={{-96,106},{-84,118}})));
equation

  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{60,64},{180,64},{180,38}},  color={255,0,0}));
  connect(sensorBus.W_turbines, sensorW.W) annotation (Line(
      points={{-30,100},{-30,162},{210,162},{210,28},{191,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(Turbine.shaft_b, generator.shaft)
    annotation (Line(points={{32,65},{36,65},{36,64},{40,64}}, color={0,0,0}));
  connect(Turbine.port_b, condenser.port_a)
    annotation (Line(points={{32,80},{131,80},{131,-9}}, color={0,127,255}));
  connect(condenser.port_b,FWP1. port_a)
    annotation (Line(points={{124,-24},{124,-80},{104,-80}},
                                                          color={0,127,255}));
  connect(DCV.port_a, nonLinear_Break.port_b)
    annotation (Line(points={{16,-28},{16,10}}, color={0,127,255}));
  connect(nonLinear_Break.port_a, Turbine.port_b_extraction4)
    annotation (Line(points={{16,30},{16,40},{19.5,40}}, color={0,127,255}));
  connect(actuatorBus.DCV, DCV.opening) annotation (Line(
      points={{30,100},{212,100},{212,-102},{32,-102},{32,-38},{24,-38}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.T_dea, Dea_T.T) annotation (Line(
      points={{-30,100},{-30,162},{-220,162},{-220,-50},{-38,-50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(cFWH_with_DrainCoolerSS.port_a_fw, FWP2.port_b)
    annotation (Line(points={{-100,-80},{-86,-80}}, color={0,127,255}));
  connect(FHV.port_a, cFWH_with_DrainCoolerSS.port_b_h) annotation (Line(points
        ={{-30,-100},{-94,-100},{-94,-90},{-100,-90}}, color={0,127,255}));
  connect(Turbine.port_b_extraction1, cFWH_with_DrainCoolerSS.port_a_h)
    annotation (Line(points={{-10,40},{-10,-34},{-110,-34},{-110,-74}}, color={
          0,127,255}));
  connect(actuatorBus.FHV, FHV.opening) annotation (Line(
      points={{30,100},{212,100},{212,-102},{32,-102},{32,-114},{-20,-114},{-20,
          -108}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, Feed_T.T) annotation (Line(
      points={{-30,100},{-30,162},{-220,162},{-220,-50},{-194,-50},{-194,-62},{
          -176,-62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{-112,100.1},{-112,88}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Steam_P.port, TCV.port_a) annotation (Line(points={{-132,92},{-128,92},
          {-128,80},{-122,80}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, Steam_P.p) annotation (Line(
      points={{-30,100},{-30,162},{-220,162},{-220,102},{-138,102}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWCP.port_a, cFWH_with_DrainCoolerSS.port_b_fw)
    annotation (Line(points={{-132,-80},{-120,-80}}, color={0,127,255}));
  connect(FWCP.port_b, Feed_T.port) annotation (Line(points={{-152,-80},{-156,
          -80},{-156,-72},{-170,-72}}, color={0,127,255}));
  connect(nonLinear_Break2.port_b, FWP2.port_a)
    annotation (Line(points={{-60,-80},{-66,-80}}, color={0,127,255}));
  connect(Dea_T.port, Deaerator.port_b) annotation (Line(points={{-32,-60},{-32,
          -78},{-26,-78}}, color={0,127,255}));
  connect(nonLinear_Break2.port_a, Deaerator.port_b) annotation (Line(points={{
          -40,-80},{-34,-80},{-34,-78},{-26,-78}}, color={0,127,255}));
  connect(TCV.port_b, Turbine.port_a)
    annotation (Line(points={{-102,80},{-18,80}}, color={0,127,255}));
  connect(multiPort.port_a, Deaerator.port_a) annotation (Line(points={{-6,-80},
          {-10,-80},{-10,-78},{-14,-78}}, color={0,127,255}));
  connect(FHV.port_b, multiPort.ports_b[1]) annotation (Line(points={{-10,-100},
          {10,-100},{10,-81.5},{2,-81.5}}, color={0,127,255}));
  connect(DCV.port_b, multiPort.ports_b[2]) annotation (Line(points={{16,-48},{
          16,-80.5},{2,-80.5}}, color={0,127,255}));
  connect(Turbine.port_b_extraction3, multiPort.ports_b[3]) annotation (Line(
        points={{9.5,40},{8,40},{8,-79.5},{2,-79.5}}, color={0,127,255}));
  connect(FWP1.port_b, multiPort.ports_b[4]) annotation (Line(points={{84,-80},
          {44,-80},{44,-78.5},{2,-78.5}}, color={0,127,255}));
  connect(sensorW.port_b, port_e)
    annotation (Line(points={{180,18},{180,0}}, color={255,0,0}));
  connect(port_e, port_e)
    annotation (Line(points={{180,0},{180,0}}, color={255,0,0}));
  connect(port_a, TCV.port_a)
    annotation (Line(points={{-200,80},{-122,80}}, color={0,127,255}));
  connect(FWCP.port_b, port_b)
    annotation (Line(points={{-152,-80},{-200,-80}}, color={0,127,255}));
  connect(port_a, Steam_T.port)
    annotation (Line(points={{-200,80},{-160,80}}, color={0,127,255}));
  connect(sensorBus.Steam_Temperature, Steam_T.T) annotation (Line(
      points={{-30,100},{-30,162},{-220,162},{-220,90},{-166,90}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_Speed, FWCP.inputSignal) annotation (Line(
      points={{30,100},{212,100},{212,-102},{32,-102},{32,-114},{-142,-114},{
          -142,-87.3}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.W_net, W_Net.y) annotation (Line(
      points={{-30,100},{-80,100},{-80,112},{-83.4,112}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.ECV, ECV.opening) annotation (Line(
      points={{30,100},{152,100},{152,88}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Turbine.port_b_extraction2, port_b_ext) annotation (Line(points={{
          -0.5,40},{-0.5,34},{-60,34},{-60,144},{-102,144},{-102,140},{-120,140}},
        color={0,127,255}));
  connect(port_a_ext, ECV.port_a)
    annotation (Line(points={{180,80},{162,80}}, color={0,127,255}));
  connect(ECV.port_b, condenser.port_a)
    annotation (Line(points={{142,80},{131,80},{131,-9}}, color={0,127,255}));
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
      StopTime=5000,
      Interval=1,
      __Dymola_Algorithm="Esdirk45a"));
end SteamTurbine_L4_2s;
