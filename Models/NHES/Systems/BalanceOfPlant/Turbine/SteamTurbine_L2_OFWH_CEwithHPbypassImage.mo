within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L2_OFWH_CEwithHPbypassImage
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L3
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3 data);
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,70},{-90,50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_feed(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  TRANSFORM.Fluid.Machines.SteamTurbine HPT(
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
         eta_nominal=data.eta_t),
    p_a_start=data.HPT_p_in,
    p_b_start=data.HPT_p_out,
    T_a_start=data.Tin,
    T_b_start=406.65,
    m_flow_start=data.mdot_hpt,
    m_flow_nominal=data.mdot_hpt,
    use_NominalInlet=true,
    p_inlet_nominal=data.HPT_p_in,
    p_outlet_nominal=data.HPT_p_out,
    use_T_nominal=false,
    T_nominal=data.Tin,
    d_nominal=data.d_HPT_in)
    annotation (Placement(transformation(extent={{-44,44},{-24,64}})));
  TRANSFORM.Fluid.Machines.SteamTurbine LPT(
    energyDynamics=TRANSFORM.Types.Dynamics.DynamicFreeInitial,
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=data.eta_t),
    p_a_start=data.LPT1_p_in,
    p_b_start=data.LPT1_p_out,
    T_a_start=384.5,
    T_b_start=314.65,
    m_flow_start=data.mdot_lpt1,
    m_flow_nominal=data.mdot_lpt1,
    p_inlet_nominal=data.LPT1_p_in,
    p_outlet_nominal=data.cond_p,
    use_T_nominal=false,
    T_nominal=384.45,
    d_nominal=data.d_LPT1_in)
    annotation (Placement(transformation(extent={{56,44},{76,64}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume Header(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in + 50,
    T_start=data.Tin,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2))
    annotation (Placement(transformation(extent={{-92,50},{-72,70}})));
  TRANSFORM.Fluid.Volumes.Separator MS(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.p_i1,
    T_start=393.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=5),
    eta_sep=0.99,
    nPorts_a=2,
    nPorts_b=1) annotation (Placement(transformation(extent={{-12,50},{8,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State prt_b_steamdump(redeclare package
      Medium =         Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{50,-90},{70,-110}})));
  TRANSFORM.Fluid.Valves.ValveLinear IBV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=200000,
    m_flow_nominal=3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,-80})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.cond_p, V_total=3.5e3)
    annotation (Placement(transformation(extent={{88,-44},{68,-24}})));
  TRANSFORM.Electrical.PowerConverters.Generator generator annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={100,44})));
  TRANSFORM.Electrical.Interfaces.ElectricalPowerPort_Flow port_a_elec
    annotation (Placement(transformation(extent={{90,10},{110,-10}})));
  Fluid.Machines.Pump_Pressure FWCP1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_nominal=data.p_i2,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{78,-70},{58,-50}})));
  Fluid.Machines.Pump_Pressure                  FWCP2(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    use_input=false,
    p_nominal=data.HPT_p_in - 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_1(redeclare package Medium =
        Modelica.Media.Water.StandardWater,
    p_start=data.p_i2,
    T_start=333.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{34,-50},{14,-70}})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_fh*1.5) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-14,-30})));
  Fluid.Machines.Pump_MassFlow FWCP3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=data.mdot_hpt,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-46,-70},{-66,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_total)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-60,60})));
  TRANSFORM.Fluid.Sensors.Temperature Feed_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-60,-54},{-80,-34}})));
  TRANSFORM.Fluid.Sensors.Temperature Steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-90,14},{-110,-6}})));
  TRANSFORM.Fluid.Sensors.Pressure Steam_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-90,14},{-110,34}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={100,20})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_return(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-70,-90},{-50,-110}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in - 1e5,
    T_start=373.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-18,-70},{-38,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear ECV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=1000,
    m_flow_nominal=data.mdot_lpt1) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={30,60})));
  TRANSFORM.Fluid.Sensors.Pressure I_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{26,26},{6,46}})));
  Fluid.Valves.ThreeWayValve threeWayValveGrad(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    switch_start=2e6,
    switch_end=1.5e6,
    v1_m_flow_nominal=5,
    v1_dp_nominal=10000,
    v2_m_flow_nominal=5,
    v2_dp_nominal=10000,
    n1=10,
    n2=10) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={54,-12})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=5e5)
    annotation (Placement(transformation(extent={{-50,-22},{-30,-2}})));
equation
  connect(Header.port_a, port_a_steam) annotation (Line(
      points={{-88,60},{-100,60}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.shaft_b, generator.shaft)
    annotation (Line(points={{76,54},{100,54}}, color={0,0,0},
      thickness=0.5));
  connect(condenser.port_b, FWCP1.port_a) annotation (Line(
      points={{78,-42},{78,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(FWCP3.port_b, port_b_feed) annotation (Line(
      points={{-66,-60},{-100,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(LPT.portLP, condenser.port_a)
    annotation (Line(points={{76,60},{86,60},{86,-27},{85,-27}},
                                                         color={0,127,255},
      thickness=0.5));
  connect(HPT.portHP, TCV.port_b)
    annotation (Line(points={{-44,60},{-50,60}}, color={0,127,255},
      thickness=0.5));
  connect(TCV.port_a, Header.port_b) annotation (Line(
      points={{-70,60},{-76,60}},
      color={0,127,255},
      thickness=0.5));
  connect(FWCP3.port_b, Feed_T.port) annotation (Line(
      points={{-66,-60},{-70,-60},{-70,-54}},
      color={0,127,255},
      thickness=0.5));
  connect(Header.port_a, Steam_T.port) annotation (Line(
      points={{-88,60},{-88,14},{-100,14}},
      color={0,127,255},
      thickness=0.5));
  connect(Steam_p.port, Steam_T.port) annotation (Line(
      points={{-100,14},{-100,14}},
      color={0,127,255},
      thickness=0.5));
  connect(generator.port, sensorW.port_a)
    annotation (Line(points={{100,34},{100,30}}, color={255,0,0},
      thickness=0.5));
  connect(port_a_elec, sensorW.port_b)
    annotation (Line(points={{100,0},{100,10}}, color={255,0,0},
      thickness=0.5));

  connect(MS.port_a[1], HPT.portLP) annotation (Line(
      points={{-8,59.75},{-20,59.75},{-20,60},{-24,60}},
      color={0,127,255},
      thickness=0.5));
  connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(points={{-24,54},{-18,54},
          {-18,48},{52,48},{52,54},{56,54}},
                                        color={0,0,0},
      thickness=0.5));
  connect(OFWH_1.port_b,FWCP2. port_a)
    annotation (Line(points={{18,-60},{10,-60}}, color={0,127,255},
      thickness=0.5));
  connect(OFWH_1.port_a, FWCP1.port_b) annotation (Line(
      points={{30,-60},{58,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(FWCP2.port_b, OFWH_2.port_a)
    annotation (Line(points={{-10,-60},{-22,-60}}, color={0,127,255},
      thickness=0.5));
  connect(OFWH_2.port_b, FWCP3.port_a) annotation (Line(
      points={{-34,-60},{-46,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(FHV.port_b, OFWH_2.port_a) annotation (Line(
      points={{-14,-40},{-14,-60},{-22,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(OFWH_1.port_a, MS.port_Liquid) annotation (Line(
      points={{30,-60},{32,-60},{32,8},{-6,8},{-6,56}},
      color={0,127,255},
      thickness=0.5));
  connect(MS.port_b[1], ECV.port_a) annotation (Line(
      points={{4,60},{20,60}},
      color={0,127,255},
      thickness=0.5));
  connect(ECV.port_b, LPT.portHP)
    annotation (Line(points={{40,60},{56,60}}, color={0,127,255},
      thickness=0.5));

  connect(port_a_return, IBV.port_a) annotation (Line(
      points={{-60,-100},{-60,-80},{-50,-80}},
      color={0,127,255},
      thickness=0.5));
  connect(IBV.port_b, OFWH_1.port_a) annotation (Line(
      points={{-30,-80},{42,-80},{42,-60},{30,-60}},
      color={0,127,255},
      thickness=0.5));
  connect(threeWayValveGrad.port_b, prt_b_steamdump) annotation (Line(points={{54,-22},
          {54,-86},{60,-86},{60,-100}},                           color={0,127,
          255},
      thickness=0.5));
  connect(threeWayValveGrad.port_a2, resistance.port_b) annotation (Line(
      points={{44,-12},{-33,-12}},
      color={0,127,255},
      thickness=0.5));
  connect(I_p.port, threeWayValveGrad.port_a1) annotation (Line(
      points={{16,26},{16,18},{54,18},{54,-2}},
      color={0,127,255},
      thickness=0.5));
  connect(I_p.port, MS.port_a[2]) annotation (Line(
      points={{16,26},{16,18},{-22,18},{-22,60.25},{-8,60.25}},
      color={0,127,255},
      thickness=0.5));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,84},{-60,84},{-60,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.ECV, ECV.opening) annotation (Line(
      points={{30,100},{30,68}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.powerset, threeWayValveGrad.y) annotation (Line(
      points={{30,100},{30,146},{122,146},{122,-12},{62,-12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.W_total, sensorW.W) annotation (Line(
      points={{-29.9,100.1},{-29.9,134},{-30,134},{-30,144},{120,144},{120,20},
          {111,20}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, Steam_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,4},{-106,4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Steam_p.p) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,24},{-106,24}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Header.port_a, Steam_p.port) annotation (Line(
      points={{-88,60},{-88,14},{-100,14}},
      color={0,127,255},
      thickness=0.5));
  connect(actuatorBus.Divert_Valve_Position, IBV.opening) annotation (Line(
      points={{30,100},{30,146},{-122,146},{-122,-72},{-40,-72}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Feedwater_Temp, Feed_T.T) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,-44},{-76,-44}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Feed_Pump_Speed, FWCP3.inputSignal) annotation (Line(
      points={{30,100},{30,146},{-122,146},{-122,-20},{-56,-20},{-56,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.LPT2_BV, FHV.opening) annotation (Line(
      points={{30,100},{30,146},{-122,146},{-122,-30},{-22,-30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.I_pressure, I_p.p) annotation (Line(
      points={{-30,100},{-30,144},{-120,144},{-120,36},{10,36}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(resistance.port_b, FHV.port_a) annotation (Line(
      points={{-33,-12},{-14,-12},{-14,-20}},
      color={0,127,255},
      thickness=0.5));
  connect(resistance.port_a, Header.port_b) annotation (Line(
      points={{-47,-12},{-76,-12},{-76,60}},
      color={0,127,255},
      thickness=0.5));
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
end SteamTurbine_L2_OFWH_CEwithHPbypassImage;
