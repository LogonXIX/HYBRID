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
  parameter Modelica.Units.SI.PressureDifference dp_shell=0.1e5
                                                               "Nominal shell side pressure drop";
  parameter Modelica.Units.SI.PressureDifference dp_tube=0.1e5
                                                              "Nominal tube side pressure drop";





   final parameter Modelica.Units.SI.TemperatureDifference LMDT_init(fixed=false)=1;
   final parameter Modelica.Units.SI.Temperature T_co(fixed=false)=350;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q_init(fixed=false)=1e3;
   final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;

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
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_Tco(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_Thi(redeclare package Medium =
          Medium) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-10,80})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_Tci(redeclare package Medium =
          Medium) annotation (Placement(transformation(extent={{70,0},{90,20}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_Tho(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance tube_dp(redeclare
        package Medium = Medium, R=R_tube)
      annotation (Placement(transformation(extent={{60,-10},{40,10}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance shell_dp(
        redeclare package Medium = Medium, R=R_shell)
                                           annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,50})));
    TRANSFORM.Fluid.Volumes.SimpleVolume feedwater_tube(
      redeclare package Medium = Medium,
      p_start=P_c,
      use_T_start=false,
      h_start=h_start_tube,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=V_tube),
      Q_gen=Q) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume heatingsteam_shell(
      redeclare package Medium = Medium,
      p_start=P_h,
      use_T_start=false,
      h_start=h_start_shell,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=V_shell),
      Q_gen=-Q) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-30})));
    parameter SI.Volume V_tube=0.5 "Volume";
    parameter SI.Volume V_shell=0.5 "Volume";
    final parameter TRANSFORM.Units.HydraulicResistance R_tube(fixed=false)= 1
                                                                              "Hydraulic resistance";
    final parameter TRANSFORM.Units.HydraulicResistance R_shell(fixed=false)=1 "Hydraulic resistance";

    Modelica.Units.SI.Power Q;
    Modelica.Units.SI.TemperatureDifference LMDT;


    parameter SI.SpecificEnthalpy h_start_tube=(h_ci + h_co)/2
      "Specific enthalpy";
    parameter SI.SpecificEnthalpy h_start_shell=(h_hi + h_ho)/2
      "Specific enthalpy";
  initial algorithm
    if TTD==DCA then
      LMDT_init:=TTD;
      else
    LMDT_init:=(TTD-DCA)/log(TTD/DCA);
    end if;
    Q_init:=m_feed*(h_co-h_ci);
    UA:=Q_init/LMDT_init;
    m_heating:=Q_init/(h_hi - h_ho);
    R_tube:=dp_tube/m_feed;
    R_shell:=dp_shell/m_heating;


  initial equation
    h_ci=Medium.specificEnthalpy_pT(P_c,T_ci);
    h_co=Medium.specificEnthalpy_pT(P_c,T_co);
    h_co=Medium.specificEnthalpy_pT(P_c,T_sat-TTD);
    h_hi=Medium.dewEnthalpy(Medium.setSat_p(P_h));
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);

  equation

    if sensor_Thi.T-sensor_Tco.T == sensor_Tho.T-sensor_Tci.T then
      LMDT= sensor_Thi.T-sensor_Tco.T;
      else
    LMDT= (abs(sensor_Thi.T-sensor_Tco.T)-abs(sensor_Tho.T-sensor_Tci.T))/log(abs(sensor_Thi.T-sensor_Tco.T)/abs(sensor_Tho.T-sensor_Tci.T));
    end if;
    Q=UA*LMDT;

















    connect(sensor_Tho.port, port_b_h)
      annotation (Line(points={{80,-60},{100,-60}}, color={0,127,255}));
    connect(port_a_fw, sensor_Tci.port)
      annotation (Line(points={{100,0},{80,0}}, color={0,127,255}));
    connect(sensor_Thi.port, port_a_h)
      annotation (Line(points={{0,80},{0,100}}, color={0,127,255}));
    connect(sensor_Tco.port, port_b_fw)
      annotation (Line(points={{-80,0},{-100,0}}, color={0,127,255}));
    connect(tube_dp.port_a, sensor_Tci.port)
      annotation (Line(points={{57,0},{80,0}}, color={0,127,255}));
    connect(shell_dp.port_a, sensor_Thi.port) annotation (Line(points={{4.44089e-16,
            57},{4.44089e-16,68},{0,68},{0,80}}, color={0,127,255}));
    connect(heatingsteam_shell.port_b, sensor_Tho.port) annotation (Line(points={{
            -4.44089e-16,-36},{-4.44089e-16,-60},{80,-60}}, color={0,127,255}));
    connect(heatingsteam_shell.port_a, shell_dp.port_b) annotation (Line(points={{
            4.44089e-16,-24},{4.44089e-16,9.5},{-3.88578e-16,9.5},{-3.88578e-16,43}},
          color={0,127,255}));
    connect(tube_dp.port_b, feedwater_tube.port_a)
      annotation (Line(points={{43,0},{-24,0}}, color={0,127,255}));
    connect(feedwater_tube.port_b, sensor_Tco.port)
      annotation (Line(points={{-36,0},{-80,0}}, color={0,127,255}));
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

   //final parameter Modelica.Units.SI.TemperatureDifference LMDT(fixed=false)=1;
   final parameter Modelica.Units.SI.Temperature T_co(fixed=false)=T_ci;
   final parameter Modelica.Units.SI.Temperature T_ho(fixed=false)=327.15;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q(fixed=false)=1e3;
   //final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_h(fixed=false)=1.4;
   final parameter Modelica.Units.SI.SpecificHeatCapacityAtConstantPressure Cp_c(fixed=false)=1.4;
   final parameter Real NTU(fixed=false)=4;
   final parameter Modelica.Units.SI.ThermalConductance Ch(fixed=false)=2;
   final parameter Modelica.Units.SI.ThermalConductance Cc(fixed=false)=2;
   final parameter Modelica.Units.SI.Power q(fixed=false)=1e3;
   final parameter Modelica.Units.SI.Power qmax(fixed=false)=1e3;
   final parameter Real Cr(fixed=false)=2;
   final parameter Real ep(fixed=false)=1;


  //
    Generic_HXs.NTU_HX_SinglePhaseinput
                                   nTU_HX_SinglePhaseinput(
      NTU=NTU,
      K_tube=1,
      K_shell=1,
      redeclare package Tube_medium = Medium,
      redeclare package Shell_medium = Medium,
      p_start_tube=P_c,
      use_T_start_tube=false,
      h_start_tube_inlet=h_ci,
      h_start_tube_outlet=h_co,
      p_start_shell=P_h,
      h_start_shell_inlet=h_hi,
      h_start_shell_outlet=h_hi,
      dp_init_tube=10000,
      Q_init=Q,
      m_start_tube=m_feed,
      m_start_shell=m_heating,
      Tube(h_start=(h_ci + h_co)/2),
      Shell(h_start=(h_hi + h_ho)/2))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package
        Medium = Medium)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package
        Medium = Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package
        Medium = Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  initial algorithm
    //if TTD==DCA then
    //  LMDT:=TTD;
    //  else
    //LMDT:=(TTD-DCA)/log(TTD/DCA);
    //end if;
    Q:=m_feed*(h_co-h_ci);
    //UA:=Q/LMDT;
    T_co:=T_sat - TTD;
    m_heating:=Q/(h_hi - h_ho);
    Ch:=m_heating*Cp_h;
    Cc:=m_feed*Cp_c;
    Cr:=min(Ch, Cc)/max(Ch, Cc);
    qmax:=min(Ch, Cc)*(T_sat - T_ci);
    T_ho:=T_ci + DCA;
    q:=Ch*(T_sat - T_ho);
    ep:=q/qmax;
    if Cr>= 1-1e-8 then
      NTU:=ep/(1 - ep);
      else
    NTU:=log(abs((ep - 1)/(ep*Cr - 1)))/(Cr - 1);
    end if;


  initial equation
    h_ci=Medium.specificEnthalpy_pT(P_c,T_ci);
    h_co=Medium.specificEnthalpy_pT(P_c,T_sat-TTD);
    h_hi=Medium.dewEnthalpy(Medium.setSat_p(P_h));
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);
    Cp_h=Medium.heatCapacity_cp(Medium.setState_ph(P_h,((h_hi-h_ho)/2)));
    Cp_c=Medium.heatCapacity_cp(Medium.setState_ph(P_c,((h_co-h_ci)/2)));

  equation
    connect(port_a_fw, nTU_HX_SinglePhaseinput.Tube_in) annotation (Line(points={{
            100,0},{50,0},{50,16},{40,16}}, color={0,127,255}));
    connect(nTU_HX_SinglePhaseinput.Tube_out, port_b_fw) annotation (Line(points={
            {-40,16},{-86,16},{-86,0},{-100,0}}, color={0,127,255}));
    connect(port_a_h, nTU_HX_SinglePhaseinput.Shell_in) annotation (Line(points={{
            0,100},{0,44},{-48,44},{-48,-8},{-40,-8}}, color={0,127,255}));
    connect(nTU_HX_SinglePhaseinput.Shell_out, port_b_h) annotation (Line(points={
            {40,-8},{84,-8},{84,-60},{100,-60}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CFWH_with_DrainCoolernoport;

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
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ci(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_co(fixed=false)=1000e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_hi(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.SpecificEnthalpy h_ho(fixed=false)=2700e3;
   final parameter Modelica.Units.SI.Power Q_init(fixed=false)=1e3;
   final parameter Modelica.Units.SI.ThermalConductance UA(fixed=false)=1e3;
   final parameter Modelica.Units.SI.MassFlowRate m_heating(fixed=false)=1;

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
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


    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package Medium =
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
    h_co=Medium.specificEnthalpy_pT(P_c,T_hi-TTD);
    h_hi=Medium.specificEnthalpy_pT(P_h,T_hi);
    h_ho=Medium.specificEnthalpy_pT(P_h,T_ci+DCA);

  equation

    if T_hs_in-T_fw_out == T_hs_out-T_fw_in then
      LMDT= T_hs_in-T_fw_out;
      else
    LMDT= ((T_hs_in-T_fw_out)-(T_hs_out-T_fw_in))/log(((T_hs_in-T_fw_out)/(T_hs_out-T_fw_in)));
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

    h_fw_out=h_fw_in+Q/m_fw;
    h_hs_out=h_hs_in-Q/m_hs;

    P_fw=port_a_fw.p;
    P_fw=port_b_fw.p;
    P_hs=port_a_h.p;
    P_hs=port_b_h.p;

























    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
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

  model CFWH_with_DrainCoolerSSnoinit
  replaceable package Medium = Modelica.Media.Water.StandardWater
      annotation (choicesAllMatching=true);


   parameter Modelica.Units.SI.ThermalConductance UA=1e3;


    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_fw(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_fw(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));

   // final parameter TRANSFORM.Units.HydraulicResistance R_tube(fixed=false)= 1
    //                                                                          "Hydraulic resistance";
    //final parameter TRANSFORM.Units.HydraulicResistance R_shell(fixed=false)=1 "Hydraulic resistance";

    Modelica.Units.SI.Power Q;
    Modelica.Units.SI.TemperatureDifference LMDT;

    Modelica.Units.SI.SpecificEnthalpy h_fw_in;
    Modelica.Units.SI.SpecificEnthalpy h_fw_out;
    Modelica.Units.SI.SpecificEnthalpy h_hs_in;
    Modelica.Units.SI.SpecificEnthalpy h_hs_out;
    Modelica.Units.SI.MassFlowRate m_fw;
    Modelica.Units.SI.MassFlowRate m_hs;
    Modelica.Units.SI.AbsolutePressure P_hs;
    Modelica.Units.SI.AbsolutePressure P_fw;
    Modelica.Units.SI.Temperature T_fw_in;
    Modelica.Units.SI.Temperature T_fw_out;
    Modelica.Units.SI.Temperature T_hs_in;
    Modelica.Units.SI.Temperature T_hs_out;

    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_h(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  initial algorithm

  equation

    if T_hs_in-T_fw_out == T_hs_out-T_fw_in then
      LMDT= T_hs_in-T_fw_out;
      else
    LMDT= ((T_hs_in-T_fw_out)-(T_hs_out-T_fw_in))/log((T_hs_in-T_fw_out)/(T_hs_out-T_fw_in));
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

    h_fw_out=h_fw_in+Q/m_fw;
    h_hs_out=h_hs_out-Q/m_hs;

    P_fw=port_a_fw.p;
    P_fw=port_b_fw.p;
    P_hs=port_a_h.p;
    P_hs=port_b_h.p;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CFWH_with_DrainCoolerSSnoinit;
end FeedwaterHeaters;
