within NHES.Fluid.HeatExchangers;
package FeedwaterHeaters

  model CFWH_with_DrainCoolerSS
  replaceable package Medium = Modelica.Media.Water.StandardWater
      annotation (choicesAllMatching=true);

  parameter Modelica.Units.SI.TemperatureDifference TTD=15 "Terminal Temperature Difference, Tsat-T_lo";
  parameter Modelica.Units.SI.TemperatureDifference DCA=5 "T_ho-T_ci";
  parameter Modelica.Units.SI.Temperature T_ci=327.15 "Nominal Cold Feedwater Inlet Temperature";
  parameter Modelica.Units.SI.Temperature T_hi=Medium.saturationTemperature_sat(Medium.setSat_p(P_h)) "Nominal Heating Steam Inlet Temperature";
  parameter Modelica.Units.SI.AbsolutePressure P_h =2e5;
  parameter Modelica.Units.SI.AbsolutePressure P_c =2e5;
  parameter Modelica.Units.SI.MassFlowRate m_feed=1 "Nominal Feed Flow Rate";
  parameter Modelica.Units.SI.PressureDifference dp_shell=0.1e5
                                                               "Nominal shell side pressure drop";
  parameter Modelica.Units.SI.PressureDifference dp_tube=0.1e5
                                                              "Nominal tube side pressure drop";

   final parameter Modelica.Units.SI.TemperatureDifference LMDT_init(fixed=false)=1;
   final parameter Modelica.Units.SI.Temperature T_co(fixed=false)=350;
   final parameter Modelica.Units.SI.Temperature T_ho(fixed=false)=350;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q_init(fixed=false)=1e3;
   final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,30},{110,50}}),
          iconTransformation(extent={{90,30},{110,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));

   // final parameter TRANSFORM.Units.HydraulicResistance R_tube(fixed=false)= 1
    //                                                                          "Hydraulic resistance";
    //final parameter TRANSFORM.Units.HydraulicResistance R_shell(fixed=false)=1 "Hydraulic resistance";

    Modelica.Units.SI.Power Q;
    Modelica.Units.SI.TemperatureDifference LMDT;


    Modelica.Units.SI.SpecificEnthalpy h_fw_in(start=h_ci);
    Modelica.Units.SI.SpecificEnthalpy h_fw_out(start=h_co);
    Modelica.Units.SI.SpecificEnthalpy h_hs_in(start=h_hi);
    Modelica.Units.SI.SpecificEnthalpy h_hs_out(start=h_ho);
    Modelica.Units.SI.MassFlowRate m_fw;
    Modelica.Units.SI.MassFlowRate m_hs;
    Modelica.Units.SI.AbsolutePressure P_hs;
    Modelica.Units.SI.AbsolutePressure P_fw;
    Modelica.Units.SI.Temperature T_fw_in;
    Modelica.Units.SI.Temperature T_fw_out;
    Modelica.Units.SI.Temperature T_hs_in;
    Modelica.Units.SI.Temperature T_hs_out;


    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  initial algorithm
    if TTD==DCA then
      LMDT_init:=TTD;
      else
    LMDT_init:=(TTD-DCA)/log(TTD/DCA);
    end if;
    Q_init:=m_feed*(h_co-h_ci);
    UA:=Q_init/LMDT_init;
    m_heating:=Q_init/(h_hi - h_ho);
   // R_tube:=dp_tube/m_feed;
   // R_shell:=dp_shell/m_heating;

  initial equation
    h_ci=Medium.specificEnthalpy_pT(P_c,T_ci);
    h_co=Medium.specificEnthalpy_pT(P_c,T_co);
    T_co=T_hi-TTD;
    h_hi=Medium.specificEnthalpy_pT(P_h,T_hi);
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);
    T_ho=T_ci+DCA;

  equation

    if T_hs_in-T_fw_out == T_hs_out-T_fw_in then
      LMDT= T_hs_in-T_fw_out;
      else
    LMDT= ((T_hs_in-T_fw_out)-(T_hs_out-T_fw_in))/log(abs((T_hs_in-T_fw_out)/(T_hs_out-T_fw_in)));
    end if;
    Q=UA*LMDT;

    T_fw_in= Medium.temperature_ph(P_fw,h_fw_in);
    T_fw_out= Medium.temperature_ph(P_fw,h_fw_out);
    T_hs_in= Medium.temperature_ph(P_hs,h_hs_in);
    T_hs_out= Medium.temperature_ph(P_hs,h_hs_out);



    port_a_fw.m_flow=m_fw;
    port_a_h.m_flow=m_hs;
    port_b_fw.m_flow=-m_fw;
    port_b_h.m_flow=-m_hs;

    h_fw_in=inStream(port_a_fw.h_outflow);
    h_hs_in=inStream(port_a_h.h_outflow);
    port_a_h.h_outflow=inStream(port_b_h.h_outflow);
    port_a_fw.h_outflow=inStream(port_b_fw.h_outflow);
    h_fw_out=port_b_fw.h_outflow;
    h_hs_out=port_b_h.h_outflow;

    h_fw_out=h_fw_in+Q/(max(m_fw,1e-8));
    h_hs_out=h_hs_in-Q/(max(m_hs,1e-8));

    P_fw=port_a_fw.p;
    P_fw=port_b_fw.p-dp_tube;
    P_hs=port_a_h.p;
    P_hs=port_b_h.p-dp_shell;

























    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,0},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid,
            lineThickness=0.5),
          Line(
            points={{-100,40},{-40,40},{-40,66},{-10,16},{-10,66},{20,16},{20,
                64},{40,40},{100,40}},
            color={0,0,0},
            thickness=0.5),
          Rectangle(
            extent={{-100,-100},{100,-20}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={85,170,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CFWH_with_DrainCoolerSS;

  model test

    NHES.Fluid.HeatExchangers.FeedwaterHeaters.CFWH_with_DrainCoolerSS
      cFWH_with_DrainCoolerSS(T_hi=473.15, m_feed=10)
      annotation (Placement(transformation(extent={{-42,-32},{46,44}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=10,
      T=327.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{118,-4},{98,16}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,-2},{-88,18}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{116,-44},{96,-24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=10,
      T=473.15,
      nPorts=1) annotation (Placement(transformation(extent={{42,64},{22,84}})));
  equation
    connect(boundary2.ports[1], cFWH_with_DrainCoolerSS.port_b_fw) annotation (
        Line(points={{-88,8},{-50,8},{-50,6},{-42,6}}, color={0,127,255}));
    connect(cFWH_with_DrainCoolerSS.port_a_fw, boundary.ports[1]) annotation (
        Line(points={{46,6},{74,6},{74,4},{98,4},{98,6}}, color={0,127,255}));
    connect(cFWH_with_DrainCoolerSS.port_b_h, boundary3.ports[1]) annotation (
        Line(points={{46,-16.8},{90,-16.8},{90,-34},{96,-34}}, color={0,127,255}));
    connect(boundary1.ports[1], cFWH_with_DrainCoolerSS.port_a_h)
      annotation (Line(points={{22,74},{2,74},{2,44}}, color={0,127,255}));
  end test;

end FeedwaterHeaters;
