within NHES.Fluid.Vessels;
model BoundaryCondenser "Ideal condenser with fixed pressure"
  import Modelica.Fluid.Types.Dynamics;
  extends TRANSFORM.Fluid.Volumes.BaseClasses.Icon_TwoVolume;
  outer Modelica.Fluid.System system "System properties";
  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium "Medium in component" annotation(choicesAllMatching=true);
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_a(redeclare package Medium =
        Medium) "Steam port" annotation (Placement(transformation(extent={{-90,80},
            {-50,120}}, rotation=0), iconTransformation(extent={{-80,60},{-60,80}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium) "Condensed liquid port" annotation (Placement(transformation(
          extent={{-20,-120},{20,-80}}, rotation=0), iconTransformation(extent={
            {-10,-90},{10,-70}})));
  /* Parameters */
  parameter SI.Pressure p "Condenser operating pressure";

  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
    redeclare package Medium = Medium,
    p=p,
    nPorts=1) annotation (Placement(transformation(extent={{2,22},{-18,42}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium = Medium,
    p=p,
    h=Medium.bubbleEnthalpy(Medium.setSat_p(p)),
    nPorts=1) annotation (Placement(transformation(extent={{50,-40},{30,-20}})));
equation
  connect(port_a, boundary.ports[1])
    annotation (Line(points={{-70,100},{-70,32},{-18,32}}, color={0,127,255}));
  connect(boundary1.ports[1], port_b)
    annotation (Line(points={{30,-30},{0,-30},{0,-100}}, color={0,127,255}));
  annotation (defaultComponentName="condenser",
    Icon(graphics={
        Polygon(
          points={{-166,78},{-166,78}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{100,40},{-59.1953,40},{-64,40},{-68,36},{-70,30},{-68,24},{
              -64,20},{-60,20},{58,20},{64,20},{68,16},{70,10},{68,4},{64,0},{
              58,0},{-58,0},{-64,0},{-68,-4},{-70,-10},{-68,-16},{-64,-20},{-58,
              -20},{100,-20}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Polygon(
          points={{10,40},{16,38},{20,36},{20,34},{22,36},{26,38},{32,38},{34,
              38},{36,40},{10,40}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,32},{20,28}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,20},{-54,18},{-50,16},{-50,14},{-48,16},{-44,18},{-38,18},
              {-36,18},{-34,20},{-60,20}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,12},{-50,8}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{4,0},{10,-2},{14,-4},{14,-6},{16,-4},{20,-2},{26,-2},{28,-2},
              {30,0},{4,0}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{14,-8},{12,-12}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-66,-20},{-60,-22},{-56,-24},{-56,-26},{-54,-24},{-50,-22},{
              -44,-22},{-42,-22},{-40,-20},{-66,-20}},
          lineColor={0,0,0},
          smooth=Smooth.Bezier,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-56,-28},{-58,-32}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{0,62},{88,50}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={135,135,135},
          textString="IDEAL"),
        Ellipse(
          extent={{8,30},{-8,-30}},
          lineColor={0,0,0},
          fillColor={0,122,236},
          fillPattern=FillPattern.Solid,
          origin={0,-80},
          rotation=90,
          visible=set_m_flow)}),
    Documentation(revisions="<html>
</html>", info="<html>
<p>The steam enters through port a and saturated water leaves port b.</p>
<p>The total heat removed to bring the inlet steam to saturated liquid conditions at the set pressure is Q_total.</p>
</html>"));
end BoundaryCondenser;
