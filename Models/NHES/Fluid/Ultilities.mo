within NHES.Fluid;
package Ultilities
  extends Modelica.Icons.UtilitiesPackage;
  model NonLinear_Break "Oneway non linear break for fuild systems"

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{76,0},{56,20}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-70,10},{-50,-10}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-90,0},{-70,-20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
      redeclare package Medium = Medium,
      use_p_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_h_in=true,
      nPorts=1) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      annotation (choicesAllMatching=true);
    Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Modelica.Constants.inf)
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=Modelica.Constants.inf)
      annotation (Placement(transformation(extent={{40,18},{20,38}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Modelica.Constants.inf)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  equation
    connect(boundary1.ports[1], sensor_p.port)
      annotation (Line(points={{40,0},{66,0}}, color={0,127,255}));
    connect(sensor_p.port, port_b)
      annotation (Line(points={{66,0},{100,0}}, color={0,127,255}));
    connect(port_a, sensor_h.port)
      annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
    connect(sensor_h.port, sensor_m_flow.port_a)
      annotation (Line(points={{-80,0},{-70,0}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary.ports[1])
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(limiter1.y, boundary1.h_in) annotation (Line(points={{-19,-60},{8,-60},
            {8,4},{18,4}}, color={0,0,127}));
    connect(limiter2.y, boundary.p_in)
      annotation (Line(points={{19,28},{-18,28},{-18,8}}, color={0,0,127}));
    connect(limiter2.u, sensor_p.p) annotation (Line(points={{42,28},{50,28},{50,
            10},{60,10}}, color={0,0,127}));
    connect(sensor_h.h_out, limiter1.u)
      annotation (Line(points={{-74,-10},{-74,-60},{-42,-60}}, color={0,0,127}));
    connect(limiter.y, boundary1.m_flow_in) annotation (Line(points={{-19,-30},{
            -20,-30},{-20,-14},{6,-14},{6,8},{20,8}},
                                                 color={0,0,127}));
    connect(sensor_m_flow.m_flow, limiter.u) annotation (Line(points={{-60,-3.6},
            {-60,-30},{-42,-30}},                  color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            points={{20,-44},{60,-59},{20,-74},{20,-44}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{20,-49},{50,-59},{20,-69},{20,-49}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Line(
            points={{55,-59},{-60,-59}},
            color={0,128,255},
            visible=showDesignFlowDirection),
          Rectangle(
            extent={{-100,2},{102,-4}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-14,-20},{8,20}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-14,-22},{8,18}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-20},{10,20}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-22},{10,18}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-24},{10,16}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-10,-22},{12,18}},
            color={28,108,200},
            thickness=1),
          Ellipse(
            extent={{-3.5,2.5},{3.5,-2.5}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            origin={9.5,18.5},
            rotation=90),
          Ellipse(
            extent={{-3,2},{3,-2}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            origin={-12,-21},
            rotation=90)}),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end NonLinear_Break;

  model FlowMultiplier
    "Increases outlet flow by a capcity factor.  Used to correct flow rates for Gas Turbine"
    extends Modelica.Fluid.Interfaces.PartialTwoPort;
    parameter Real capacityScaler=1;

  equation
    port_a.h_outflow = inStream(port_b.h_outflow);
    port_b.h_outflow = inStream(port_a.h_outflow);
    port_a.p = port_b.p;
    port_b.m_flow = -port_a.m_flow*capacityScaler;
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);
    port_a.C_outflow = inStream(port_b.C_outflow);
    port_b.C_outflow = inStream(port_a.C_outflow);
    //port_a.Xi = port_b.Xi;

    annotation (Icon(graphics={Text(
            extent={{-80,80},{80,-80}},
            textColor={0,0,0},
            textString="X",
            textStyle={TextStyle.Bold}), Line(
            points={{-100,0},{100,0}},
            color={0,0,0},
            thickness=0.5)}));
  end FlowMultiplier;

  model MS_ss
    replaceable package medium=Modelica.Media.Water.StandardWater;
    Modelica.Units.SI.MassFlowRate m_in;
    Modelica.Units.SI.MassFlowRate m_l;
    Modelica.Units.SI.MassFlowRate m_v;
    Modelica.Units.SI.SpecificEnthalpy h_in;
    Modelica.Units.SI.SpecificEnthalpy h_l;
    Modelica.Units.SI.SpecificEnthalpy h_v;
    Modelica.Units.SI.SpecificEnthalpy h_out;
    parameter Real eta_sep=0.99;
    parameter Modelica.Units.SI.AbsolutePressure P_start=2e5;
    Real x;
    Modelica.Units.SI.AbsolutePressure P(start=P_start);




    TRANSFORM.Fluid.Interfaces.FluidPort_State
                               port_a(redeclare package Medium = medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-70,-10},{-50,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow
                              port_Liquid(redeclare package Medium = medium, p(
          start=P_start)) annotation (Placement(transformation(extent={{-10,-110},
              {10,-90}}), iconTransformation(extent={{-50,-50},{-30,-30}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State
                               port_b(redeclare package Medium = medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{50,-10},{70,10}})));
  equation
    m_in+m_l+m_v=0;
    m_in*h_in+m_v*h_v+m_l*h_l=0;
    h_l=medium.bubbleEnthalpy(medium.setSat_p(P));
    h_v=medium.dewEnthalpy(medium.setSat_p(P));
    x=(h_in-h_l)/(h_v-h_l);
    if x>1 then
      h_out=h_in;
      else
      h_out=h_l+eta_sep*(h_v-h_l);
    end if;
    assert(x>=0,"subcooled MS",AssertionLevel.error);


    port_Liquid.m_flow = m_l;
    port_Liquid.h_outflow = h_l;
    //port_Liquid.p=P;

    port_b.h_outflow = h_out;
    port_b.p = P;
    port_b.m_flow=m_v;

    port_a.p = P;
    inStream( port_a.h_outflow) = h_in;
    port_a.h_outflow=2e6;
    port_a.m_flow=m_in;



    port_a.Xi_outflow = inStream(port_b.Xi_outflow);
    port_b.Xi_outflow = inStream(port_a.Xi_outflow);
    port_Liquid.Xi_outflow = inStream(port_a.Xi_outflow);
    port_a.C_outflow = inStream(port_b.C_outflow);
    port_b.C_outflow = inStream(port_a.C_outflow);
    port_Liquid.C_outflow = inStream(port_a.C_outflow);

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MS_ss;

  model MS_sources
    replaceable package medium=Modelica.Media.Water.StandardWater;
    Modelica.Units.SI.MassFlowRate m_in(start=m_start);
    Modelica.Units.SI.MassFlowRate m_l;
    Modelica.Units.SI.MassFlowRate m_v;
    Modelica.Units.SI.SpecificEnthalpy h_in;
    Modelica.Units.SI.SpecificEnthalpy h_l(start=medium.bubbleEnthalpy(medium.setSat_p(P)));
    Modelica.Units.SI.SpecificEnthalpy h_v(start=medium.dewEnthalpy(medium.setSat_p(P)));
    Modelica.Units.SI.SpecificEnthalpy h_out;
    parameter Real eta_sep=0.99;
    parameter Modelica.Units.SI.AbsolutePressure P=2e5;
    parameter Modelica.Units.SI.MassFlowRate m_start=10;
    Real x;

    TRANSFORM.Fluid.Interfaces.FluidPort_State
                               port_a(redeclare package Medium = medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-70,-10},{-50,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow
                              port_Liquid(redeclare package Medium = medium, p(
          start=P))       annotation (Placement(transformation(extent={{-10,-110},
              {10,-90}}), iconTransformation(extent={{-50,-50},{-30,-30}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State
                               port_b(redeclare package Medium = medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}}),
          iconTransformation(extent={{50,-10},{70,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph in_sink(redeclare package
        Medium = medium,
      use_p_in=false,
      p=P,
      nPorts=1)
      annotation (Placement(transformation(extent={{4,-10},{-16,10}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h vapor_source(redeclare
        package Medium = medium,
      use_m_flow_in=true,
      use_h_in=true,             nPorts=1)
      annotation (Placement(transformation(extent={{20,-18},{40,2}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h liquid_source(redeclare
        package Medium = medium,
      use_m_flow_in=true,
      use_h_in=true,             nPorts=1) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-14,-72})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = medium)
      annotation (Placement(transformation(extent={{48,0},{68,20}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          medium)
      annotation (Placement(transformation(extent={{-78,-8},{-58,12}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort sensor_h(redeclare package
        Medium = medium)
      annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=h_l)
      annotation (Placement(transformation(extent={{-76,-32},{-56,-12}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=m_l)
      annotation (Placement(transformation(extent={{-78,-48},{-58,-28}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=m_v)
      annotation (Placement(transformation(extent={{-24,-30},{-4,-10}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=h_out)
      annotation (Placement(transformation(extent={{-24,-44},{-4,-24}})));
  equation
    m_in+m_l+m_v=0;
    m_in*h_in+m_v*h_v+m_l*h_l=0;
    h_l=medium.bubbleEnthalpy(medium.setSat_p(P));
    h_v=medium.dewEnthalpy(medium.setSat_p(P));
    x=(h_in-h_l)/(h_v-h_l);
    if x>1 then
      h_out=h_in;
      else
      h_out=h_l+eta_sep*(h_v-h_l);
    end if;
    assert(x>=0,"subcooled MS",AssertionLevel.error);
    h_in=sensor_h.h_out;
    m_in=sensor_m_flow.m_flow;



    connect(port_Liquid, liquid_source.ports[1])
      annotation (Line(points={{0,-100},{0,-82},{-14,-82}},color={0,127,255}));
    connect(vapor_source.ports[1], port_b)
      annotation (Line(points={{40,-8},{70,-8},{70,0},{100,0}},
                                                color={0,127,255}));
    connect(port_a, sensor_m_flow.port_a) annotation (Line(points={{-100,0},{-98,0},
            {-98,2},{-78,2}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, sensor_h.port_a)
      annotation (Line(points={{-58,2},{-58,0},{-48,0}}, color={0,127,255}));
    connect(sensor_h.port_b, in_sink.ports[1])
      annotation (Line(points={{-28,0},{-16,0}}, color={0,127,255}));
    connect(sensor_p.port, port_b) annotation (Line(points={{58,0},{58,-8},{70,-8},
            {70,0},{100,0}}, color={0,127,255}));
    connect(realExpression2.y, vapor_source.m_flow_in) annotation (Line(points={{-3,
            -20},{10,-20},{10,2},{14,2},{14,8},{20,8},{20,0}}, color={0,0,127}));
    connect(vapor_source.h_in, realExpression3.y) annotation (Line(points={{18,-4},
            {8,-4},{8,-34},{-3,-34}}, color={0,0,127}));
    connect(liquid_source.h_in, realExpression.y) annotation (Line(points={{-18,-60},
            {-18,-48},{-52,-48},{-52,-22},{-55,-22}}, color={0,0,127}));
    connect(realExpression1.y, liquid_source.m_flow_in) annotation (Line(points={{
            -57,-38},{-54,-38},{-54,-62},{-22,-62}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MS_sources;

  model NonLinear_Break_delay
    "Oneway non linear break for fuild systems"
   parameter Modelica.Units.SI.AbsolutePressure p_start=1e5;
   parameter Modelica.Units.SI.SpecificEnthalpy h_start=500e3;
   parameter Modelica.Units.SI.MassFlowRate m_start=1;
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{76,0},{56,20}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-70,10},{-50,-10}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-90,0},{-70,-20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
      redeclare package Medium = Medium,
      use_p_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary1(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_h_in=true,
      nPorts=1) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      annotation (choicesAllMatching=true);
    Modelica.Blocks.Continuous.FirstOrder
                                      firstOrder1(
      T=Tau,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=h_start)
      annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
    Modelica.Blocks.Continuous.FirstOrder
                                      firstOrder2(
      T=Tau,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=p_start)
      annotation (Placement(transformation(extent={{40,18},{20,38}})));
    Modelica.Blocks.Continuous.FirstOrder
                                      firstOrder(
      T=Tau,
      initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=m_start)
      annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
    parameter SI.Time Tau=1 "Time Constant";
  equation
    connect(boundary1.ports[1], sensor_p.port)
      annotation (Line(points={{40,0},{66,0}}, color={0,127,255}));
    connect(sensor_p.port, port_b)
      annotation (Line(points={{66,0},{100,0}}, color={0,127,255}));
    connect(port_a, sensor_h.port)
      annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
    connect(sensor_h.port, sensor_m_flow.port_a)
      annotation (Line(points={{-80,0},{-70,0}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, boundary.ports[1])
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(firstOrder1.y, boundary1.h_in) annotation (Line(points={{-19,-60},{8,-60},
            {8,4},{18,4}}, color={0,0,127}));
    connect(firstOrder2.y, boundary.p_in)
      annotation (Line(points={{19,28},{-18,28},{-18,8}}, color={0,0,127}));
    connect(firstOrder2.u, sensor_p.p) annotation (Line(points={{42,28},{50,28},{50,
            10},{60,10}}, color={0,0,127}));
    connect(sensor_h.h_out, firstOrder1.u)
      annotation (Line(points={{-74,-10},{-74,-60},{-42,-60}}, color={0,0,127}));
    connect(firstOrder.y, boundary1.m_flow_in) annotation (Line(points={{-19,-30},
            {-20,-30},{-20,-14},{6,-14},{6,8},{20,8}}, color={0,0,127}));
    connect(sensor_m_flow.m_flow, firstOrder.u) annotation (Line(points={{-60,-3.6},
            {-60,-30},{-42,-30}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            points={{20,-44},{60,-59},{20,-74},{20,-44}},
            lineColor={0,128,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            visible=showDesignFlowDirection),
          Polygon(
            points={{20,-49},{50,-59},{20,-69},{20,-49}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            visible=allowFlowReversal),
          Line(
            points={{55,-59},{-60,-59}},
            color={0,128,255},
            visible=showDesignFlowDirection),
          Rectangle(
            extent={{-100,2},{102,-4}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-14,-20},{8,20}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-14,-22},{8,18}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-20},{10,20}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-22},{10,18}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-12,-24},{10,16}},
            color={28,108,200},
            thickness=1),
          Line(
            points={{-10,-22},{12,18}},
            color={28,108,200},
            thickness=1),
          Ellipse(
            extent={{-3.5,2.5},{3.5,-2.5}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            origin={9.5,18.5},
            rotation=90),
          Ellipse(
            extent={{-3,2},{3,-2}},
            lineColor={28,108,200},
            lineThickness=1,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            origin={-12,-21},
            rotation=90)}),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end NonLinear_Break_delay;
end Ultilities;
