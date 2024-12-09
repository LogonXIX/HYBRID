within NHES.Systems.BalanceOfPlant.Turbine;
model Carl_CHP
  "Three Stage Turbine with open feed water heating using high pressure steam"
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_SubSystem(
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.CS_L2BP
      CS,
    redeclare replaceable
      NHES.Systems.BalanceOfPlant.Turbine.ControlSystems.ED_Dummy ED,
    redeclare replaceable NHES.Systems.BalanceOfPlant.Turbine.Data.Data_L3_BP data);
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

  Electrical.Interfaces.ElectricalPowerPort_a port_e
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  TRANSFORM.Fluid.Machines.SteamTurbine BPT(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    eta_mech=data.eta_mech,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=data.eta_t),
    p_a_start=data.P_ms - 0.1,
    p_b_start=data.P_bp,
    T_a_start=data.T_ms,
    T_b_start=data.T_bp,
    m_flow_start=data.mdot_bp,
    m_flow_nominal=data.mdot_bp,
    p_inlet_nominal=data.P_ms,
    p_outlet_nominal=data.P_bp,
    use_T_nominal=false,
    d_nominal(displayUnit="kg/m3") = data.d_turb)
    annotation (Placement(transformation(extent={{58,50},{78,70}})));
  TRANSFORM.Electrical.Sensors.PowerSensor sensorW annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={100,22})));
  TRANSFORM.Fluid.Valves.ValveLinear TCV_BP(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow_start=data.mdot_bp,
    dp_nominal=10000,
    m_flow_nominal=data.mdot_bp)    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-44,62})));
  TRANSFORM.Fluid.Sensors.Temperature steam_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-178,154},{-158,174}})));
  TRANSFORM.Fluid.Sensors.Temperature FinalFeedwater_T(redeclare package Medium
      = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
  TRANSFORM.Fluid.Sensors.Pressure steam_p(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-188,118},{-168,138}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume BPT_header(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_start=data.P_ms - 0.1,
    T_start=data.T_ms,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=2)) annotation (Placement(transformation(extent={{-10,52},{10,72}})));
  Fluid.Machines.Pump_MassFlow                  pump2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p_a_start=data.P_cond,
    p_b_start=data.P_ms - 10e5,
    T_a_start=CT.Medium.saturationTemperature_sat(CT.Medium.setSat_p(data.P_cond))
         - 1,
    T_b_start=CT.Medium.saturationTemperature_sat(CT.Medium.setSat_p(data.P_cond))
         + 1,
    m_flow_start=data.mdot_cond,
    use_input=true,
    m_flow_nominal=data.mdot_ms,
    eta=data.eta_p)
    annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
equation

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
  connect(BPT.portLP, prt_b_steamdump) annotation (Line(points={{78,66},{90,66},
          {90,-100},{60,-100}},color={0,127,255}));
  connect(actuatorBus.ProcessCV, TCV_BP.opening) annotation (Line(
      points={{30,100},{-44,100},{-44,70}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Temperature, steam_T.T) annotation (Line(
      points={{-30,100},{-30,164},{-162,164}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Steam_Pressure, steam_p.p) annotation (Line(
      points={{-30,100},{-162,100},{-162,128},{-172,128}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Feedwater_Temp, FinalFeedwater_T.T) annotation (Line(
      points={{-30,100},{-30,10},{-94,10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(TCV_BP.port_b, BPT_header.port_a)
    annotation (Line(points={{-34,62},{-6,62}}, color={0,127,255}));
  connect(BPT_header.port_b, BPT.portHP) annotation (Line(points={{6,62},{52,62},
          {52,66},{58,66}}, color={0,127,255}));
  connect(FinalFeedwater_T.port, port_b_feed) annotation (Line(points={{-100,0},
          {-100,-60}},                       color={0,127,255}));
  connect(port_a_steam, TCV_BP.port_a) annotation (Line(points={{-100,60},{-100,
          62},{-54,62}}, color={0,127,255}));
  connect(port_a_steam, steam_p.port) annotation (Line(points={{-100,60},{-178,
          60},{-178,118}},          color={0,127,255}));
  connect(port_a_steam, steam_T.port) annotation (Line(points={{-100,60},{-164,
          60},{-164,154},{-168,154}},                   color={0,127,255}));
  connect(pump2.port_b, port_b_feed)
    annotation (Line(points={{-60,-60},{-100,-60}}, color={0,127,255}));
  connect(actuatorBus.Feed_Pump_Speed, pump2.inputSignal) annotation (Line(
      points={{30,100},{30,-40},{-50,-40},{-50,-52.7}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(port_a_return, pump2.port_a) annotation (Line(points={{-60,-100},{-60,
          -76},{-34,-76},{-34,-60},{-40,-60}}, color={0,127,255}));
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
end Carl_CHP;
