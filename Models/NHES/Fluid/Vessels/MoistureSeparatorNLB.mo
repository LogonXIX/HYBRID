within NHES.Fluid.Vessels;
model MoistureSeparatorNLB

  TRANSFORM.Fluid.Volumes.MoistureSeparator separator(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-56,-44},{52,46}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20,-66})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_a(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_Liquid(redeclare package
      Medium = Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={72,0})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(
      redeclare package Medium = Modelica.Media.Water.StandardWater, R=1)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-68,2})));
equation
  connect(separator.port_Liquid, resistance.port_a) annotation (Line(points={{
          -23.6,-17},{-23.6,-59},{-20,-59}}, color={0,127,255}));
  connect(resistance.port_b, port_Liquid) annotation (Line(points={{-20,-73},{
          -20,-84},{0,-84},{0,-100}}, color={0,127,255}));
  connect(separator.port_b, resistance1.port_a) annotation (Line(points={{30.4,
          1},{58,1},{58,1.33227e-15},{65,1.33227e-15}}, color={0,127,255}));
  connect(port_b, resistance1.port_b) annotation (Line(points={{100,0},{89.5,0},
          {89.5,-3.33067e-16},{79,-3.33067e-16}}, color={0,127,255}));
  connect(separator.port_a, resistance2.port_b) annotation (Line(points={{-34.4,
          1},{-34.4,50},{-61,50},{-61,2}}, color={0,127,255}));
  connect(port_a, resistance2.port_a) annotation (Line(points={{-100,0},{-82,0},
          {-82,2},{-75,2}}, color={0,127,255}));
  annotation (defaultComponentName="separator", Documentation(info="<html>
<p>Model updated to avoid breakdowns in situations where x_abs &gt; eta_sep in previous model. </p>
<p>Model based on the equations m_steam_in + m_steam_out + m_liq = dm/dt = 0 at steady state and m_steam_in*h_steam_in + m_steam_out*h_steam_out + m_liq*h_liq = m*du/dt = 0 at steady state. </p>
<p>Eta_sep is now defined as the fraction of liquid present removed by the moisture separator. Given this definition and h_liq = h_f, the expression for h_steam_out is found based on current moisture separator properties and the mass flow rate of liquid. </p>
<p>The system tends towards equilibrium at x_abs = (h_steam_in - h_f)/(h_g-h_f). </p>
</html>", revisions="<html>
<p>2020-04 | Daniel Mikkelson (dmmikkel@ncsu.edu, daniel.mikkelson@inl.gov)</p>
</html>"));
end MoistureSeparatorNLB;
