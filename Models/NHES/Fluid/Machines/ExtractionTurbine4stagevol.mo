within NHES.Fluid.Machines;
model ExtractionTurbine4stagevol
  TRANSFORM.Fluid.Machines.SteamTurbine ST1(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_1),
    p_a_start=P_in,
    p_b_start=P_ext1,
    use_T_start=false,
    h_a_start=h_in,
    h_b_start=h_ext1,
    m_flow_start=m_in,
    m_flow_nominal=m_in,
    p_inlet_nominal=P_in,
    p_outlet_nominal=P_ext1,
    use_T_nominal=false,
    d_nominal=d_in)
    annotation (Placement(transformation(extent={{-94,-10},{-74,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST2(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_2),
    p_a_start=P_ext1,
    p_b_start=P_ext2,
    use_T_start=false,
    h_a_start=h_ext1,
    h_b_start=h_ext2,
    m_flow_start=m_t2,
    m_flow_nominal=m_t2,
    p_inlet_nominal=P_ext1,
    p_outlet_nominal=P_ext2,
    use_T_nominal=false,
    d_nominal=d_ext1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-48,60})));
   TRANSFORM.Fluid.Machines.SteamTurbine ST3(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_3),
    p_a_start=P_ext2,
    p_b_start= P_ext3,
    use_T_start=false,
    h_a_start=h_ext2,
    h_b_start=h_ext3,
    m_flow_start=m_t3,
    m_flow_nominal=m_t3,
    p_inlet_nominal=P_ext2,
    p_outlet_nominal= P_ext3,
    use_T_nominal=false,
    d_nominal=d_ext2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-4,26})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST4(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_4),
    p_a_start=P_ext3,
    p_b_start=P_out,
    use_T_start=false,
    h_a_start=h_ext3,
    h_b_start=2200e3,
    m_flow_start=m_t4,
    m_flow_nominal=m_t4,
    p_inlet_nominal=P_ext3,
    p_outlet_nominal=P_out,
    use_T_nominal=false,
    d_nominal=d_ext3)
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Valves.PressureCV_v2
                    pressureCV_v2_2(
    ValvePos_start=0.8,
    init_time=7,
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_t2,
    dp_nominal=1000) annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=270,
        origin={-54,30})));
  Valves.PressureCV_v2
                    pressureCV_v2_3(
    ValvePos_start=0.9,
    init_time=5,
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext2,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_t3,
    dp_nominal=1000)  annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=90,
        origin={2,60})));
  Valves.PressureCV_v2
                    pressureCV_v2_1(
    ValvePos_start=0.95,
    init_time=3,
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext3,
    PID_k=-1e-5,
    PID_Ti=20,
    m_flow_nominal=m_t4,
    dp_nominal=1000,
    valveLinear(m_flow_start=m_t4))
     annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={38,6})));
  Vessels.MoistureSeparator_fixedhvhl       MS3(
    redeclare package Medium = medium,
    p_start=P_ext3,
    use_T_start=false,
    h_start=2400e3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=MS_V),
    eta_sep=eta_sep,
    h_lsat=h_lsat,
    h_vsat=h_vsat)
    annotation (Placement(transformation(extent={{4,-4},{24,16}})));

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction1(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{-78,-110},{-58,-90}}),
        iconTransformation(extent={{-78,-110},{-58,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction2(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}}),
        iconTransformation(extent={{-40,-110},{-20,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction3(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{0,-110},{20,-90}}),
        iconTransformation(extent={{0,-110},{20,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  parameter Modelica.Units.SI.Volume MS_V=1 "Volume";
  parameter Modelica.Units.SI.Efficiency eta_sep=0.99
                                                     "Separation efficiency";
  parameter Modelica.Units.SI.MassFlowRate m_in=70 "Nominal mass flowrate";
  parameter Modelica.Units.SI.MassFlowRate m_t2=m_in-m_ext1 "Nominal mass flowrate";
  parameter Modelica.Units.SI.MassFlowRate m_t3=m_t2-m_ext2 "Nominal mass flowrate";
  parameter Modelica.Units.SI.MassFlowRate m_t4=m_t3-m_ext3-m_ext4 "Nominal mass flowrate";

   replaceable package medium=Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.AbsolutePressure P_in=100e5 "Nominal Turbine Inlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_out=20e5 "Nominal Turbine Outlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_in=2.8e6 "Nominal Turbine Inlet Enthalpy" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext1=60e5 "Nominal Turbine First Extraction Pressure" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext2=50e5 "Nominal Turbine Second Extraction Pressure" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext3=30e5 "Nominal Turbine Thrid Extraction Pressure" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext1=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext2=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext3=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext4=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));

     parameter Modelica.Units.SI.SpecificEnthalpy h_ext1=2e6;
     parameter Modelica.Units.SI.SpecificEnthalpy h_ext2=2e6;
     parameter Modelica.Units.SI.SpecificEnthalpy h_ext3=2e6;
     parameter Real eta_1=0.9;
     parameter Real eta_2=0.9;
     parameter Real eta_3=0.9;
     parameter Real eta_4=0.9;
     parameter Modelica.Units.SI.Density d_in=50;
     parameter Modelica.Units.SI.Density d_ext1=15;
     parameter Modelica.Units.SI.Density d_ext2=15;
     parameter Modelica.Units.SI.Density d_ext3=15;

  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction4(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{40,-110},{60,-90}}),
        iconTransformation(extent={{40,-110},{60,-90}})));
  parameter SI.SpecificEnthalpy h_lsat;
  parameter SI.SpecificEnthalpy h_vsat;
  TRANSFORM.Fluid.Volumes.SimpleVolume volume(
    redeclare package Medium = medium,
    p_start=P_ext1,
    use_T_start=false,
    h_start=h_ext1,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1))
    annotation (Placement(transformation(extent={{-72,-2},{-58,14}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
    redeclare package Medium = medium,
    p_start=P_ext2,
    use_T_start=false,
    h_start=h_ext2,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1))
    annotation (Placement(transformation(extent={{-32,66},{-18,82}})));
  TRANSFORM.Fluid.Volumes.SimpleVolume volume2(
    redeclare package Medium = medium,
    p_start=P_ext3,
    use_T_start=false,
    h_start=h_ext3,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=0.1))
    annotation (Placement(transformation(extent={{52,-2},{66,14}})));
equation
  connect(ST1.portHP,port_a)
    annotation (Line(points={{-94,6},{-94,46},{-86,46},{-86,60},{-100,60}},
                                                          color={0,127,255}));
  connect(ST1.shaft_a,shaft_a)
    annotation (Line(points={{-94,0},{-100,0}}, color={0,0,0}));
  connect(pressureCV_v2_2.port_b, ST2.portHP)
    annotation (Line(points={{-54,36},{-54,50}}, color={0,127,255}));
  connect(ST1.shaft_b,ST2. shaft_a) annotation (Line(points={{-74,0},{-48,0},{-48,
          50}},             color={0,0,0}));
  connect(pressureCV_v2_3.port_b, ST3.portHP)
    annotation (Line(points={{2,54},{2,45},{2,45},{2,36}}, color={0,127,255}));
  connect(ST3.portLP,MS3.port_a)
    annotation (Line(points={{2,16},{2,14},{0,14},{0,6},{8,6}},
                                             color={0,127,255}));
  connect(MS3.port_Liquid,port_b_extraction3)  annotation (Line(points={{10,2},{
          10,-100}},                    color={0,127,255}));
  connect(MS3.port_b, pressureCV_v2_1.port_a)
    annotation (Line(points={{20,6},{32,6}}, color={0,127,255}));
  connect(shaft_b,ST4. shaft_b)
    annotation (Line(points={{100,0},{94,0}}, color={0,0,0}));
  connect(ST3.shaft_b,ST4. shaft_a)
    annotation (Line(points={{-4,16},{-2,16},{-2,-24},{74,-24},{74,0}},
                                                               color={0,0,0}));
  connect(pressureCV_v2_3.port_b, ST3.portHP)
    annotation (Line(points={{2,54},{2,45},{2,45},{2,36}}, color={0,127,255}));
  connect(ST4.portLP,port_b)  annotation (Line(points={{94,6},{94,46},{100,46},{
          100,60}},      color={0,127,255}));
  connect(ST3.shaft_a, ST2.shaft_b) annotation (Line(points={{-4,36},{-4,70},{-48,
          70}},                  color={0,0,0}));
  connect(pressureCV_v2_1.port_a, port_b_extraction4) annotation (Line(points={{
          32,6},{28,6},{28,-70},{50,-70},{50,-100}}, color={0,127,255}));
  connect(volume.port_a, ST1.portLP)
    annotation (Line(points={{-69.2,6},{-74,6}}, color={0,127,255}));
  connect(volume.port_b, pressureCV_v2_2.port_a)
    annotation (Line(points={{-60.8,6},{-54,6},{-54,24}}, color={0,127,255}));
  connect(volume.port_b, port_b_extraction1) annotation (Line(points={{-60.8,6},
          {-60.8,-86},{-68,-86},{-68,-100}}, color={0,127,255}));
  connect(ST2.portLP, volume1.port_a) annotation (Line(points={{-54,70},{-54,74},
          {-29.2,74}}, color={0,127,255}));
  connect(volume1.port_b, pressureCV_v2_3.port_a)
    annotation (Line(points={{-20.8,74},{2,74},{2,66}}, color={0,127,255}));
  connect(volume1.port_b, port_b_extraction2) annotation (Line(points={{-20.8,74},
          {-14,74},{-14,-86},{-30,-86},{-30,-100}}, color={0,127,255}));
  connect(pressureCV_v2_1.port_b, volume2.port_a)
    annotation (Line(points={{44,6},{54.8,6}}, color={0,127,255}));
  connect(volume2.port_b, ST4.portHP)
    annotation (Line(points={{63.2,6},{74,6}}, color={0,127,255}));
  annotation (Icon(graphics={
        Rectangle(
          extent={{-6,31.5},{6,-31.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={10,-69.5},
          rotation=180,
          visible=DynamicSelect(true, if nExt>1 then true else false)),
        Rectangle(
          extent={{-6,18.5},{6,-18.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={-34,47.5},
          rotation=180),
        Rectangle(
          extent={{-94,66},{-40,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{40,66},{92,54}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Text(
          extent={{-149,112},{151,72}},
          lineColor={0,0,255},
          textString="%name",
          visible=DynamicSelect(true,showName)),
        Rectangle(
          extent={{-102,6},{98,-6}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={160,160,164}),
        Rectangle(
          extent={{-6,31.5},{6,-31.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={-30,-61.5},
          rotation=180,
          visible=DynamicSelect(true, if nExt>1 then true else false)),
        Rectangle(
          extent={{-74,-32},{-16,-44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-6,30.5},{6,-30.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={-68,-62.5},
          rotation=180),
        Rectangle(
          extent={{-6,17},{6,-17}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={30,-75},
          rotation=180,
          visible=DynamicSelect(true, if nExt>2 then true else false)),
        Polygon(
          points={{-40,30},{-40,-30},{40,-80},{40,80},{-40,30}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{24,-80},{56,-92}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          visible=DynamicSelect(true, if nExt>2 then true else false)),
        Rectangle(
          extent={{-6,10},{6,-10}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={50,-90},
          rotation=180,
          visible=DynamicSelect(true, if nExt>2 then true else false))}));
end ExtractionTurbine4stagevol;
