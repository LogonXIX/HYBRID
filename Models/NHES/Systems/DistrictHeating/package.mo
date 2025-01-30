within NHES.Systems;
package DistrictHeating "District Heating Loop model"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Polygon(
          points={{-40,-44},{-40,16},{-54,16},{-34,30},{-34,46},{-24,46},{-24,
              38},{0,56},{0,56},{54,16},{40,16},{40,-44},{32,-44},{16,-44},{6,
              -44},{-6,-44},{-40,-44}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,-32},{6,-24},{-6,-16},{0,-8}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{14,-32},{20,-24},{8,-16},{14,-8}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier),
        Line(
          points={{-14,-32},{-8,-24},{-20,-16},{-14,-8}},
          color={0,0,0},
          thickness=1,
          smooth=Smooth.Bezier)}));
end DistrictHeating;
