within NHES.Fluid.HeatExchangers;
package FeedwaterHeaters

  model CFWH_with_DrainCooler
  replaceable package Medium = Modelica.Media.Water.StandardWater
      annotation (choicesAllMatching=true);

  parameter Modelica.Units.SI.TemperatureDifference TTD=15 "Terminal Temperature Difference, Tsat-T_lo";
  parameter Modelica.Units.SI.TemperatureDifference DCA=5 "T_ho-T_ci";
  parameter Modelica.Units.SI.Temperature T_ci=327.15 "Nominal Cold Feedwater Inlet Temperature";
  parameter Modelica.Units.SI.Temperature T_sat=Medium.saturationTemperature_sat(Medium.setSat_p(P_h)) "Nominal Heating Steam Inlet Temperature";
  parameter Modelica.Units.SI.AbsolutePressure P_h =2e5;
  parameter Modelica.Units.SI.AbsolutePressure P_c =2e5;
  parameter Modelica.Units.SI.MassFlowRate m_feed=1 "Nominal Feed Flow Rate";








   final parameter Modelica.Units.SI.TemperatureDifference LMDT(fixed=false)=1;
   final parameter Modelica.Units.SI.Temperature T_co(fixed=false)=T_ci;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q(fixed=false)=1e3;
   final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_h(fixed=false)=1.4;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_c(fixed=false)=1.4;
   final parameter Real NTU(fixed=false)=4;
   final parameter Modelica.Units.SI.ThermalConductance Ch(fixed=false)=2;
   final parameter Modelica.Units.SI.ThermalConductance Cc(fixed=false)=2;

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium
        = Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
      NTU=NTU,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium = Medium,
      redeclare package Shell_medium = Medium,
      p_start_tube=P_c,
      h_start_tube_inlet=h_ci,
      h_start_tube_outlet=h_co,
      p_start_shell=P_h,
      h_start_shell_inlet=h_hi,
      h_start_shell_outlet=h_hi,
      dp_init_tube=10000,
      Q_init=Q,
      m_start_tube=m_feed,
      m_start_shell=m_heating)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  initial algorithm
    if TTD==DCA then
      LMDT:=TTD;
      else
    LMDT:=(TTD-DCA)/log(TTD/DCA);
    end if;
    Q:=m_feed*(h_co-h_ci);
    UA:=Q/LMDT;
    T_co:=T_sat - TTD;
    m_heating:=Q/(h_hi - h_ho);
    Ch:=m_heating*Cp_h;
    Cc:=m_feed*Cp_c;
    NTU:=UA/min(Ch, Cc);



  initial equation
    h_ci=Medium.specificEnthalpy_pT(P_c,T_ci);
    h_co=Medium.specificEnthalpy_pT(P_c,T_sat-TTD);
    h_hi=Medium.dewEnthalpy(Medium.setSat_p(P_h));
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);
    Cp_h=Medium.heatCapacity_cp(Medium.setState_ph(P_h,((h_hi-h_ho)/2)));
    Cp_c=Medium.heatCapacity_cp(Medium.setState_ph(P_c,((h_co-h_ci)/2)));





















  equation
    connect(port_a_fw, nTU_HX_SinglePhase.Tube_in) annotation (Line(points={{100,0},
            {50,0},{50,16},{40,16}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Tube_out, port_b_fw) annotation (Line(points={{-40,
            16},{-86,16},{-86,0},{-100,0}}, color={0,127,255}));
    connect(port_a_h, nTU_HX_SinglePhase.Shell_in) annotation (Line(points={{0,100},
            {0,44},{-48,44},{-48,-8},{-40,-8}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Shell_out, port_b_h) annotation (Line(points={{40,-8},
            {84,-8},{84,-60},{100,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CFWH_with_DrainCooler;

  model CFWH_with_DrainCoolernoport
  replaceable package Medium = Modelica.Media.Water.StandardWater
      annotation (choicesAllMatching=true);

  parameter Modelica.Units.SI.TemperatureDifference TTD=15 "Terminal Temperature Difference, Tsat-T_lo";
  parameter Modelica.Units.SI.TemperatureDifference DCA=5 "T_ho-T_ci";
  parameter Modelica.Units.SI.Temperature T_ci=327.15 "Nominal Cold Feedwater Inlet Temperature";
  parameter Modelica.Units.SI.Temperature T_sat=Medium.saturationTemperature_sat(Medium.setSat_p(P_h)) "Nominal Heating Steam Inlet Temperature";
  parameter Modelica.Units.SI.AbsolutePressure P_h =2e5;
  parameter Modelica.Units.SI.AbsolutePressure P_c =2e5;
  parameter Modelica.Units.SI.MassFlowRate m_feed=1 "Nominal Feed Flow Rate";

   final parameter Modelica.Units.SI.TemperatureDifference LMDT(fixed=false)=1;
   final parameter Modelica.Units.SI.Temperature T_co(fixed=false)=T_ci;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q(fixed=false)=1e3;
   final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_h(fixed=false)=1.4;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_c(fixed=false)=1.4;
   final parameter Real NTU(fixed=false)=4;
   final parameter Modelica.Units.SI.ThermalConductance Ch(fixed=false)=2;
   final parameter Modelica.Units.SI.ThermalConductance Cc(fixed=false)=2;

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium
        = Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Generic_HXs.NTU_HX_SinglePhase nTU_HX_SinglePhase(
      NTU=NTU,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium = Medium,
      redeclare package Shell_medium = Medium,
      p_start_tube=P_c,
      h_start_tube_inlet=h_ci,
      h_start_tube_outlet=h_co,
      p_start_shell=P_h,
      h_start_shell_inlet=h_hi,
      h_start_shell_outlet=h_hi,
      dp_init_tube=10000,
      Q_init=Q,
      m_start_tube=m_feed,
      m_start_shell=m_heating)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  initial algorithm
    if TTD==DCA then
      LMDT:=TTD;
      else
    LMDT:=(TTD-DCA)/log(TTD/DCA);
    end if;
    Q:=m_feed*(h_co-h_ci);
    UA:=Q/LMDT;
    T_co:=T_sat - TTD;
    m_heating:=Q/(h_hi - h_ho);
    Ch:=m_heating*Cp_h;
    Cc:=m_feed*Cp_c;
    NTU:=UA/min(Ch, Cc);

  initial equation
    h_ci=Medium.specificEnthalpy_pT(P_c,T_ci);
    h_co=Medium.specificEnthalpy_pT(P_c,T_sat-TTD);
    h_hi=Medium.dewEnthalpy(Medium.setSat_p(P_h));
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);
    Cp_h=Medium.heatCapacity_cp(Medium.setState_ph(P_h,((h_hi-h_ho)/2)));
    Cp_c=Medium.heatCapacity_cp(Medium.setState_ph(P_c,((h_co-h_ci)/2)));

  equation
    connect(port_a_fw, nTU_HX_SinglePhase.Tube_in) annotation (Line(points={{100,0},
            {50,0},{50,16},{40,16}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Tube_out, port_b_fw) annotation (Line(points={{-40,
            16},{-86,16},{-86,0},{-100,0}}, color={0,127,255}));
    connect(port_a_h, nTU_HX_SinglePhase.Shell_in) annotation (Line(points={{0,100},
            {0,44},{-48,44},{-48,-8},{-40,-8}}, color={0,127,255}));
    connect(nTU_HX_SinglePhase.Shell_out, port_b_h) annotation (Line(points={{40,-8},
            {84,-8},{84,-60},{100,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CFWH_with_DrainCoolernoport;
end FeedwaterHeaters;
