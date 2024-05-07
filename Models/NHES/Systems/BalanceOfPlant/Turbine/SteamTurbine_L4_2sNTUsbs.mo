within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L4_2sNTUsbs
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
    annotation (Placement(transformation(extent={{154,38},{174,58}})));

  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={180,28})));
  TRANSFORM.Electrical.Sources.FrequencySource boundary2
    annotation (Placement(transformation(extent={{208,-24},{188,-4}})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=10000)
    annotation (Placement(transformation(extent={{90,-26},{70,-6}})));
  Fluid.Machines.ExtractionTurbine4stagevol
                                         extractionTurbine4stagevol(
    m_in=6.017,
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
    h_ext1=2855.449491e3,
    h_ext2=2754.454699e3,
    h_ext3=2518.03123e3,
    h_out=2310.159498e3,
    eta_1=0.863,
    eta_2=0.8746,
    eta_3=0.8854,
    eta_4=0.9,
    d_in(displayUnit="kg/m3") = 37.27199754,
    d_ext1(displayUnit="kg/m3") = 5.889949818,
    d_ext2(displayUnit="kg/m3") = 3.680893506,
    d_ext3(displayUnit="kg/m3") = 0.871251356,
    h_lsat=467.0807237e3,
    h_vsat=2693.113266e3,
    MS3(port_b(m_flow(start=-4))),
    pressureCV_v2_1(ValvePos_start=0.2, trans_time=5),
    pressureCV_v2_3(ValvePos_start=0.2, trans_time=5),
    pressureCV_v2_2(ValvePos_start=0.2, trans_time=5))
    annotation (Placement(transformation(extent={{8,30},{54,76}})));
  Fluid.Valves.FlowCV flowCV1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    Use_input=false,
    FlowRate_target=0,
    ValvePos_start=0,
    m_flow_nominal=1,
    dp_nominal=50000)
    annotation (Placement(transformation(extent={{-16,-4},{-36,16}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=35000,
    m_flow_nominal=0.7)
    annotation (Placement(transformation(extent={{-12,-34},{-32,-14}})));
  Fluid.Machines.Pump_Pressure pump(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    T_a_start=316.15,
    T_b_start=317.15,
    eta=0.8) annotation (Placement(transformation(extent={{46,-92},{26,-72}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=100000,
    T_start=358.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1))
    annotation (Placement(transformation(extent={{-46,-92},{-66,-72}})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{26,-32},{6,-12}})));
  Modelica.Blocks.Sources.RealExpression W_balance1(y=273.15 + 90)
    "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
    annotation (Placement(transformation(extent={{-96,106},{-84,118}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-142,-56},{-122,-36}})));
  Fluid.Machines.Pump_Pressure pump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=12000000,
    p_b_start=100000,
    T_a_start=363.15,
    T_b_start=364.15,
    p_nominal=12000000,
    eta=0.8)
    annotation (Placement(transformation(extent={{-142,-92},{-162,-72}})));
  Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS
    cFWH_with_DrainCoolerSS(
    TTD=16.8,
    DCA=5,
    T_ci=363.15,
    T_hi=489.15,
    P_h=1250000,
    P_c=12000000,
    m_feed=6)
    annotation (Placement(transformation(extent={{-214,-98},{-194,-78}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=35000,
    m_flow_nominal=0.7)
    annotation (Placement(transformation(extent={{-140,-150},{-120,-130}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-228,-26},{-208,-6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    h=3349e3,
    nPorts=1)
    annotation (Placement(transformation(extent={{22,-150},{2,-130}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=6.016,
    dp_nominal=35000,
    m_flow_nominal=0.7)
    annotation (Placement(transformation(extent={{-126,54},{-106,74}})));
  TRANSFORM.Fluid.Sensors.Pressure    sensor_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-164,78},{-144,98}})));
  Fluid.Machines.Pump_MassFlow pump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=12000000,
    p_b_start=100000,
    T_a_start=363.15,
    T_b_start=364.15,
    m_flow_nominal=6.016,
    eta=0.8)
    annotation (Placement(transformation(extent={{-238,-94},{-258,-74}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12500000,
    T_start=773.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=10),
    Q_gen=15e6) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-294,-30})));
  Fluid.Ultilities.NonLinear_Break nonLinear_Break2(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-88,-92},{-108,-72}})));
equation

  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{174,48},{180,48},{180,38}}, color={255,0,0}));
  connect(sensorBus.W_turbines, sensorW.W) annotation (Line(
      points={{-30,100},{-30,162},{210,162},{210,28},{191,28}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));

  connect(sensorW.port_b, boundary2.port)
    annotation (Line(points={{180,18},{180,-14},{188,-14}}, color={255,0,0}));
  connect(extractionTurbine4stagevol.shaft_b, generator.shaft) annotation (Line(
        points={{65.04,53},{148,53},{148,48},{154,48}}, color={0,0,0}));
  connect(extractionTurbine4stagevol.port_b, condenser.port_a) annotation (Line(
        points={{65.04,66.8},{68,66.8},{68,0},{96,0},{96,-9},{87,-9}}, color={0,
          127,255}));
  connect(extractionTurbine4stagevol.port_b_extraction2, flowCV1.port_a)
    annotation (Line(points={{24.1,30},{24,30},{24,6},{-16,6}}, color={0,127,
          255}));
  connect(condenser.port_b, pump.port_a)
    annotation (Line(points={{80,-24},{80,-82},{46,-82}}, color={0,127,255}));
  connect(pump.port_b, volume.port_a)
    annotation (Line(points={{26,-82},{-50,-82}}, color={0,127,255}));
  connect(valveLinear.port_b, volume.port_a) annotation (Line(points={{-32,-24},
          {-40,-24},{-40,-82},{-50,-82}}, color={0,127,255}));
  connect(valveLinear.port_a, nonLinear_Break.port_b)
    annotation (Line(points={{-12,-24},{-4,-24},{-4,-22},{6,-22}},
                                                 color={0,127,255}));
  connect(nonLinear_Break.port_a, extractionTurbine4stagevol.port_b_extraction4)
    annotation (Line(points={{26,-22},{42.5,-22},{42.5,30}}, color={0,127,255}));
  connect(sensorBus.T_dea_set, W_balance1.y) annotation (Line(
      points={{-30,100},{-78,100},{-78,112},{-83.4,112}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.DCV, valveLinear.opening) annotation (Line(
      points={{30,100},{30,-12},{-4,-12},{-4,-16},{-22,-16}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.T_dea, sensor_T.T) annotation (Line(
      points={{-30,100},{-30,62},{-100,62},{-100,-46},{-126,-46}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(extractionTurbine4stagevol.port_b_extraction3, volume.port_a)
    annotation (Line(points={{33.3,30},{33.3,-66},{-40,-66},{-40,-82},{-50,-82}},
        color={0,127,255}));
  connect(cFWH_with_DrainCoolerSS.port_a_fw, pump1.port_b) annotation (Line(
        points={{-194,-84},{-192,-84},{-192,-82},{-162,-82}}, color={0,127,255}));
  connect(valveLinear1.port_a, cFWH_with_DrainCoolerSS.port_b_h) annotation (
      Line(points={{-140,-140},{-188,-140},{-188,-94},{-194,-94}}, color={0,127,
          255}));
  connect(extractionTurbine4stagevol.port_b_extraction1,
    cFWH_with_DrainCoolerSS.port_a_h) annotation (Line(points={{15.36,30},{
          15.36,-8},{-94,-8},{-94,-30},{-204,-30},{-204,-78}}, color={0,127,255}));
  connect(actuatorBus.FHV, valveLinear1.opening) annotation (Line(
      points={{30,100},{-50,100},{-50,-132},{-130,-132}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, sensor_T1.T) annotation (Line(
      points={{-30,100},{-204,100},{-204,-16},{-212,-16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(flowCV1.port_b, boundary3.ports[1]) annotation (Line(points={{-36,6},
          {-38,6},{-38,-140},{2,-140}}, color={0,127,255}));
  connect(valveLinear1.port_b, volume.port_a) annotation (Line(points={{-120,
          -140},{-40,-140},{-40,-82},{-50,-82}}, color={0,127,255}));
  connect(actuatorBus.opening_TCV, valveLinear2.opening) annotation (Line(
      points={{30.1,100.1},{-116,100.1},{-116,72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensor_p.port, valveLinear2.port_a) annotation (Line(points={{-154,78},
          {-154,64},{-126,64}}, color={0,127,255}));
  connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
      points={{-30,100},{-138,100},{-138,88},{-148,88}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pump2.port_a, cFWH_with_DrainCoolerSS.port_b_fw)
    annotation (Line(points={{-238,-84},{-214,-84}}, color={0,127,255}));
  connect(pump2.port_b, sensor_T1.port) annotation (Line(points={{-258,-84},{
          -264,-84},{-264,-32},{-218,-32},{-218,-26}}, color={0,127,255}));
  connect(pump2.port_b, volume1.port_a) annotation (Line(points={{-258,-84},{
          -294,-84},{-294,-36}}, color={0,127,255}));
  connect(nonLinear_Break2.port_b, pump1.port_a)
    annotation (Line(points={{-108,-82},{-142,-82}}, color={0,127,255}));
  connect(sensor_T.port, volume.port_b) annotation (Line(points={{-132,-56},{
          -132,-64},{-72,-64},{-72,-82},{-62,-82}}, color={0,127,255}));
  connect(nonLinear_Break2.port_a, volume.port_b)
    annotation (Line(points={{-88,-82},{-62,-82}}, color={0,127,255}));
  connect(volume1.port_b, valveLinear2.port_a) annotation (Line(points={{-294,
          -24},{-294,-4},{-136,-4},{-136,64},{-126,64}}, color={0,127,255}));
  connect(valveLinear2.port_b, extractionTurbine4stagevol.port_a) annotation (
      Line(points={{-106,64},{0,64},{0,66.8},{8,66.8}}, color={0,127,255}));
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
end SteamTurbine_L4_2sNTUsbs;
