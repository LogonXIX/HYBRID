within NHES.Systems.BalanceOfPlant.Turbine;
model SteamTurbine_L2_BP2_v_
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
        origin={100,48})));
  TRANSFORM.Fluid.Volumes.IdealCondenser condenser(p=data.cond_p, V_total=3.5e3)
    annotation (Placement(transformation(extent={{80,-46},{60,-26}})));
  Fluid.Machines.Pump_Pressure                  pump1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    p_nominal=data.HPT_p_in - 1e5,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{64,-70},{44,-50}})));
  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow
                                           FWCP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_input=true,
    m_flow_nominal=data.mdot_hpt)
    annotation (Placement(transformation(extent={{-4,-70},{-24,-50}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume OFWH_2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.HPT_p_in - 1e5,
    T_start=373.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{26,-70},{6,-50}})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_total)
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-44,32})));
  TRANSFORM.Fluid.Valves.ValveLinear FHV(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=1)                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-10,-122})));
  Electrical.Interfaces.ElectricalPowerPort_a port_e
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine CT(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    m_flow_nominal=4.927992278,
    p_inlet_nominal=12000000,
    p_outlet_nominal=400000,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = 34.69607167)
    annotation (Placement(transformation(extent={{52,16},{72,36}})));
  TRANSFORM.Fluid.Machines.SteamTurbine BPT(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=0.9),
    m_flow_nominal=4.884296956,
    p_inlet_nominal=400000,
    p_outlet_nominal=10000,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = 2.193606243)
    annotation (Placement(transformation(extent={{58,50},{78,70}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,22})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV_BP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=100000,
    m_flow_nominal=data.mdot_total) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-44,62})));
  TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance(dp0=150000)
    annotation (Placement(transformation(extent={{-32,-92},{-12,-72}})));
  TRANSFORM.Fluid.Sensors.Temperature steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-210,86},{-190,106}})));
  TRANSFORM.Fluid.Sensors.Temperature FinalFeedwater_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-194,-82},{-174,-62}})));
  TRANSFORM.Fluid.Sensors.Pressure steam_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
  Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
    NTU=6,
    K_tube=1,
    K_shell=1,
    redeclare package Tube_medium = Modelica.Media.Water.StandardWater,
    redeclare package Shell_medium = Modelica.Media.Water.StandardWater,
    p_start_tube=12000000,
    use_T_start_tube=true,
    T_start_tube_inlet=473.15,
    T_start_tube_outlet=423.15,
    p_start_shell=11000000,
    use_T_start_shell=true,
    T_start_shell_inlet=813.15,
    T_start_shell_outlet=573.15,
    dp_init_tube=10000,
    m_start_tube=5,
    m_start_shell=0)
    annotation (Placement(transformation(extent={{-66,-76},{-46,-54}})));
  Modelica.Blocks.Sources.RealExpression ofwh_p(y=steam_p.p - 10e5)
    "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
    annotation (Placement(transformation(extent={{12,-36},{24,-24}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume header(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume BPT_header(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume CT_header(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=12000000,
    T_start=813.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-10,22},{10,42}})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{-178,-22},{-158,-2}})));
  Modelica.Blocks.Sources.RealExpression ofwh_p1(y=20e5)
    "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
    annotation (Placement(transformation(extent={{-228,-4},{-216,8}})));
equation

  connect(OFWH_2.port_a, pump1.port_b)
    annotation (Line(points={{22,-60},{44,-60}},  color={0,127,255}));
  connect(pump1.port_a, condenser.port_b)
    annotation (Line(points={{64,-60},{70,-60},{70,-44}}, color={0,127,255}));
  connect(OFWH_2.port_b, FWCP.port_a)
    annotation (Line(points={{10,-60},{-4,-60}},   color={0,127,255}));
  connect(actuatorBus.opening_TCV, TCV.opening) annotation (Line(
      points={{30.1,100.1},{30.1,100},{-44,100},{-44,40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.FHV, FHV.opening) annotation (Line(
      points={{30,100},{30,-44},{32,-44},{32,-120},{36,-120},{36,-148},{-10,
          -148},{-10,-130}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(BPT.shaft_b, generator.shaft)
    annotation (Line(points={{78,60},{84,60},{84,64},{100,64},{100,58}},
                                                        color={0,0,0}));
  connect(generator.port, sensorW.port_a) annotation (Line(points={{100,38},{
          100,32}},                       color={255,0,0}));
  connect(sensorW.port_b, port_e) annotation (Line(points={{100,12},{100,0}},
                                            color={255,0,0}));

  connect(sensorBus.W_total, sensorW.W) annotation (Line(
      points={{-29.9,100.1},{120,100.1},{120,22},{111,22}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(CT.portLP, condenser.port_a) annotation (Line(points={{72,32},{78,32},
          {78,-29},{77,-29}},                   color={0,127,255}));
  connect(BPT.portLP, prt_b_steamdump) annotation (Line(points={{78,66},{90,66},
          {90,-100},{60,-100}},color={0,127,255}));
  connect(CT.shaft_b, BPT.shaft_a) annotation (Line(points={{72,26},{74,26},{74,
          44},{52,44},{52,60},{58,60}},    color={0,0,0}));
  connect(actuatorBus.ProcessCV, TCV_BP.opening) annotation (Line(
      points={{30,100},{-44,100},{-44,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a_return, resistance.port_a) annotation (Line(points={{-60,-100},
          {-60,-82},{-29,-82}}, color={0,127,255}));
  connect(resistance.port_b, condenser.port_a) annotation (Line(points={{-15,
          -82},{86,-82},{86,-29},{77,-29}}, color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed, FWCP.in_m_flow) annotation (Line(
      points={{30,100},{30,-4},{2,-4},{2,-44},{-14,-44},{-14,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sensorBus.Steam_Temperature, steam_T.T) annotation (Line(
      points={{-30,100},{-184,100},{-184,96},{-194,96}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Pressure, steam_p.p) annotation (Line(
      points={{-30,100},{-116,100},{-116,74},{-194,74},{-194,60},{-204,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, FinalFeedwater_T.T) annotation (Line(
      points={{-30,100},{-30,-34},{-128,-34},{-128,-72},{-178,-72}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(FWCP.port_b, nTU_HX_SinglePhase.Tube_in) annotation (Line(points={{
          -24,-60},{-35,-60},{-35,-60.6},{-46,-60.6}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Tube_out, FinalFeedwater_T.port) annotation (Line(
        points={{-66,-60.6},{-84,-60.6},{-84,-88},{-184,-88},{-184,-82}}, color
        ={0,127,255}));
  connect(port_b_feed, nTU_HX_SinglePhase.Tube_out) annotation (Line(points={{
          -100,-60},{-83,-60},{-83,-60.6},{-66,-60.6}}, color={0,127,255}));
  connect(FHV.port_b, OFWH_2.port_a) annotation (Line(points={{-1.77636e-15,
          -122},{6,-122},{6,-74},{32,-74},{32,-60},{22,-60}}, color={0,127,255}));
  connect(nTU_HX_SinglePhase.Shell_out, FHV.port_a) annotation (Line(points={{
          -46,-67.2},{-44,-67.2},{-44,-122},{-20,-122}}, color={0,127,255}));
  connect(port_a_steam, header.port_a)
    annotation (Line(points={{-100,60},{-86,60}}, color={0,127,255}));
  connect(header.port_b, TCV_BP.port_a) annotation (Line(points={{-74,60},{-74,
          44},{-60,44},{-60,62},{-54,62}}, color={0,127,255}));
  connect(header.port_b, TCV.port_a)
    annotation (Line(points={{-74,60},{-74,32},{-54,32}}, color={0,127,255}));
  connect(TCV_BP.port_b, BPT_header.port_a)
    annotation (Line(points={{-34,62},{-6,62}}, color={0,127,255}));
  connect(BPT_header.port_b, BPT.portHP) annotation (Line(points={{6,62},{52,62},
          {52,66},{58,66}}, color={0,127,255}));
  connect(TCV.port_b, CT_header.port_a)
    annotation (Line(points={{-34,32},{-6,32}}, color={0,127,255}));
  connect(CT_header.port_b, CT.portHP)
    annotation (Line(points={{6,32},{52,32}}, color={0,127,255}));
  connect(steam_p.port, header.port_b) annotation (Line(points={{-210,50},{-210,
          44},{-74,44},{-74,60}}, color={0,127,255}));
  connect(steam_T.port, header.port_b) annotation (Line(points={{-200,86},{-200,
          72},{-120,72},{-120,44},{-74,44},{-74,60}}, color={0,127,255}));
  connect(ofwh_p.y, max1.u2) annotation (Line(points={{24.6,-30},{28,-30},{28,
          -18},{-152,-18},{-152,-28},{-188,-28},{-188,-18},{-180,-18}}, color={
          0,0,127}));
  connect(ofwh_p1.y, max1.u1) annotation (Line(points={{-215.4,2},{-190,2},{
          -190,-6},{-180,-6}}, color={0,0,127}));
  connect(max1.y, pump1.inputSignal) annotation (Line(points={{-157,-12},{54,
          -12},{54,-52.7}}, color={0,0,127}));
  connect(header.port_b, nTU_HX_SinglePhase.Shell_in) annotation (Line(points={
          {-74,60},{-74,-67.2},{-66,-67.2}}, color={0,127,255}));
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
end SteamTurbine_L2_BP2_v_;
