within NHES.Fluid.Machines;
model ExtractionTurbine

  replaceable package medium=Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.AbsolutePressure P_in=100e5 "Nominal Turbine Inlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_out=20e5 "Nominal Turbine Outlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_in=2.8e6 "Nominal Turbine Inlet Enthalpy" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.MassFlowRate m_in=10 "Nominal Inlet Mass Flow Rate" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Real eta_t=0.9 "Turbine Isentropic Efficiency" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext1=60e5 "Nominal Turbine First Extraction Pressure" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext2=50e5 "Nominal Turbine Second Extraction Pressure" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Modelica.Units.SI.AbsolutePressure P_ext3=30e5 "Nominal Turbine Thrid Extraction Pressure" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Modelica.Units.SI.MassFlowRate m_ext1=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext2=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Modelica.Units.SI.MassFlowRate m_ext3=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Boolean Ms1=true "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points"));
  parameter Boolean Con1=true "True=Controled Extraction, False=Uncontrolled" annotation (Dialog(group="Extraction Points"));
  parameter Boolean Ms2=true "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Boolean Con2=true "True=Controled Extraction, False=Uncontrolled" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Boolean Ms3=true "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Boolean Con3=true "True=Controled Extraction, False=Uncontrolled" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Real fms1=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points"));
  parameter Real fms2=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Real fms3=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Integer nExt(min=1,max=3)=3 "Number of Extractions, Max=3";

    final parameter Modelica.Units.SI.SpecificEnthalpy h_out0(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEntropy s_in(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out0(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext3(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR3(fixed=false)=5e3;
    final parameter Real eta_1(fixed=false)=0.9;
    final parameter Real eta_2(fixed=false)=0.9;
    final parameter Real eta_3(fixed=false)=0.9;
    final parameter Real eta_4(fixed=false)=0.9;
    final parameter Real X1(fixed=false)=0.9;
    final parameter Real X2(fixed=false)=0.9;
    final parameter Real X3(fixed=false)=0.9;
    final parameter Modelica.Units.SI.Density d_in(fixed=false)=50;
    final parameter Modelica.Units.SI.Density d_ext1(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext2(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext3(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t1(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t2(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t3(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t4(fixed=false)=15;

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
    p_b_start=if nExt > 1 then P_ext2 else P_out,
    use_T_start=false,
    h_a_start=h_AR1,
    h_b_start=h_ext2,
    m_flow_start=m_flow_t2,
    m_flow_nominal=m_flow_t2,
    p_inlet_nominal=P_ext1,
    p_outlet_nominal=if nExt > 1 then P_ext2 else P_out,
    use_T_nominal=false,
    d_nominal=d_ext1)
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
   TRANSFORM.Fluid.Machines.SteamTurbine ST3(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_3),
    p_a_start=P_ext2,
    p_b_start=if nExt > 2 then P_ext3 else P_out,
    use_T_start=false,
    h_a_start=h_AR2,
    h_b_start=h_ext3,
    m_flow_start=m_flow_t3,
    m_flow_nominal=m_flow_t3,
    p_inlet_nominal=P_ext2,
    p_outlet_nominal=if nExt > 2 then P_ext3 else P_out,
    use_T_nominal=false,
    d_nominal=d_ext2) if nExt>1
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  TRANSFORM.Fluid.Machines.SteamTurbine ST4(
    redeclare package Medium = medium,
    redeclare model Eta_wetSteam =
        TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant (
          eta_nominal=eta_4),
    p_a_start=P_ext3,
    p_b_start=P_out,
    use_T_start=false,
    h_a_start=h_AR3,
    h_b_start=h_out0,
    m_flow_start=m_flow_t4,
    m_flow_nominal=m_flow_t4,
    p_inlet_nominal=P_ext3,
    p_outlet_nominal=P_out,
    use_T_nominal=false,
    d_nominal=d_ext3) if nExt>2
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Valves.PressureCV pressureCV1(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext1,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_flow_t2,
    dp_nominal=1000) if Con1 annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={-48,6})));
  Valves.PressureCV pressureCV2(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext2,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_flow_t3,
    dp_nominal=1000) if nExt>1 and Con2 annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={8,6})));
  Valves.PressureCV pressureCV3(
    redeclare package Medium = medium,
    Use_input=false,
    Pressure_target=P_ext3,
    ValvePos_start=0.99,
    init_time=1,
    PID_k=-1e-6,
    PID_Ti=20,
    m_flow_nominal=m_flow_t4,
    dp_nominal=1000)  if nExt>2 and Con3
     annotation (Placement(transformation(
        extent={{6,6},{-6,-6}},
        rotation=180,
        origin={64,6})));
  TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee1(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext1,
    port_1(m_flow(start=m_in)),
    port_2(m_flow(start=-m_flow_t2)),
    port_3(m_flow(start=-m_ext1))) if not Ms1
    annotation (Placement(transformation(extent={{-70,12},{-58,0}})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee2(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext2,
    port_1(m_flow(start=m_in - m_ext1)),
    port_2(m_flow(start=m_ext1 + m_ext2 - m_in)),
    port_3(m_flow(start=-m_ext2)))  if nExt>1 and not Ms2
    annotation (Placement(transformation(extent={{-14,12},{-2,0}})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee3(
    redeclare package Medium = medium,
    V=1,
    p_start=P_ext3,
    port_1(m_flow(start=m_in - m_ext1 - m_ext2)),
    port_2(m_flow(start=m_ext1 + m_ext2 + m_ext3 - m_in)),
    port_3(m_flow(start=-m_ext3)))  if nExt>2 and not Ms3
    annotation (Placement(transformation(extent={{42,12},{54,0}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction1(redeclare
      package Medium = medium)
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction2(redeclare
      package Medium = medium)  if nExt>1
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_extraction3(redeclare
      package Medium = medium)  if nExt>2
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b shaft_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  TRANSFORM.Fluid.Volumes.MoistureSeparator MS1(
    redeclare package Medium = medium,
    p_start=P_ext1,
    use_T_start=false,
    h_start=h_in,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    eta_sep=fms1) if Ms1
    annotation (Placement(transformation(extent={{-74,24},{-54,44}})));
  TRANSFORM.Fluid.Volumes.MoistureSeparator MS2(
    redeclare package Medium = medium,
    p_start=P_ext2,
    use_T_start=false,
    h_start=h_in,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    eta_sep=fms2) if Ms2 and nExt>1
    annotation (Placement(transformation(extent={{-2,24},{18,44}})));
  TRANSFORM.Fluid.Volumes.MoistureSeparator MS3(
    redeclare package Medium = medium,
    p_start=P_ext3,
    use_T_start=false,
    h_start=h_in,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
        (V=1),
    eta_sep=fms3) if Ms3 and nExt>2
    annotation (Placement(transformation(extent={{54,22},{74,42}})));
initial equation
  //Inlet
  s_in=medium.specificEntropy(medium.setState_ph(P_in,h_in));
  d_in=medium.density_ph(P_in,h_in);
  //First Expansion Line
  h_out0=h_in-(h_in-medium.specificEnthalpy_ps(P_out,s_in))*eta_t;
  s_out0=medium.specificEntropy(medium.setState_ph(P_out,h_out0));
  //Extraction
  h_ext1=((h_out0-h_in)/(s_out0-s_in))*s_ext1+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
  h_ext1=medium.specificEnthalpy_ps(P_ext1,s_ext1);

  //is the first extraction a MS
  if Ms1 then
      //check quality
      X1=(h_ext1-medium.bubbleEnthalpy(medium.setSat_p(P_ext1)))/(medium.dewEnthalpy(medium.setSat_p(P_ext1))-medium.bubbleEnthalpy(medium.setSat_p(P_ext1)));
      assert(X1>0,"Subcooled Extraction",AssertionLevel.error);
      assert(X1>1,"Superheated Moisture Separation",AssertionLevel.warning);
    //for SH, nominally the same as no MS
    if X1>1 then
      h_AR1=h_ext1;
      s_AR1=s_ext1;
    else
    //for two phase
      h_AR1=(m_in*h_ext1-m_in*fms1*(1-X1)*medium.bubbleEnthalpy(medium.setSat_p(P_ext1)))/(m_in-m_in*fms1*(1-X1));
      s_AR1=medium.specificEntropy(medium.setState_ph(P_ext1,h_AR1));
    end if;
    //no MS
   else
     h_AR1=h_ext1;
     s_AR1=s_ext1;
     X1=0.9;
   end if;

  //for 2nd extration point
  if nExt>1 then
    //which expansion line?
    if Ms1 then  //second
      h_out1=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_out,s_AR1))*eta_t;
      s_out1=medium.specificEntropy(medium.setState_ph(P_out,h_out1));
      h_ext2=((h_out1-h_AR1)/(s_out1-s_AR1))*s_ext2+h_AR1-((h_out1-h_AR1)/(s_out1-s_AR1))*s_AR1;
      h_ext2=medium.specificEnthalpy_ps(P_ext2,s_ext2);
    else //first
      h_out1=h_out0;
      s_out1=s_out0;
      h_ext2=((h_out0-h_in)/(s_out0-s_in))*s_ext2+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
      h_ext2=medium.specificEnthalpy_ps(P_ext2,s_ext2);
    end if;
    //is the second extraction a MS?
    if Ms2 then
      //check qual
      X2=(h_ext2-medium.bubbleEnthalpy(medium.setSat_p(P_ext2)))/(medium.dewEnthalpy(medium.setSat_p(P_ext2))-medium.bubbleEnthalpy(medium.setSat_p(P_ext2)));
      assert(X2>0,"Subcooled Extraction",AssertionLevel.error);
      assert(X2>1,"Superheated Moisture Separation",AssertionLevel.warning);
      if X2>1 then  //SH
        h_AR2=h_ext2;
        s_AR2=s_ext2;
      else  //two phase
        h_AR2=(m_in*h_ext2-m_in*fms2*(1-X2)*medium.bubbleEnthalpy(medium.setSat_p(P_ext2)))/(m_in-m_in*fms2*(1-X2));
        s_AR2=medium.specificEntropy(medium.setState_ph(P_ext2,h_AR2));
      end if;
    else
      h_AR2=h_ext2;
      s_AR2=s_ext2;
      h_out2=h_out0;
      X2=0.9;
    end if;
  else
    eta_3=eta_1;
    h_AR2=h_AR1;
    h_ext2=h_ext1;
    h_out2=h_out0;
    s_AR2=s_AR1;
    s_ext2=s_ext1;
    s_out1=s_out0;
    X2=X1;
  end if;
  //for 3rd extraction point
  if nExt>2 then
  //which expansion line?
    if Ms2 then //third
      h_out2=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_out,s_AR2))*eta_t;
      s_out2=medium.specificEntropy(medium.setState_ph(P_out,h_out2));
      h_ext3=((h_out2-h_AR2)/(s_out2-s_AR2))*s_ext3+h_AR2-((h_out2-h_AR2)/(s_out2-s_AR2))*s_AR2;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    elseif Ms1 then //second
      s_out2=s_out0;
      h_ext3=((h_out1-h_AR1)/(s_out1-s_AR1))*s_ext3+h_AR1-((h_out1-h_AR1)/(s_out1-s_AR1))*s_AR1;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    else //first
      s_out2=s_out0;
      h_ext3=((h_out0-h_in)/(s_out0-s_in))*s_ext3+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    end if;
    //is the third extraction a MS?
    if Ms3 then
        //check qual
        X3=(h_ext3-medium.bubbleEnthalpy(medium.setSat_p(P_ext3)))/(medium.dewEnthalpy(medium.setSat_p(P_ext3))-medium.bubbleEnthalpy(medium.setSat_p(P_ext3)));
        assert(X3>0,"Subcooled Extraction",AssertionLevel.error);
        assert(X3>1,"Superheated Moisture Separation",AssertionLevel.warning);
      if X3>1 then  //SH
        h_AR3=h_ext3;
        s_AR3=s_ext3;
      else  //two phase
        h_AR3=(m_in*h_ext3-m_in*fms3*(1-X3)*medium.bubbleEnthalpy(medium.setSat_p(P_ext3)))/(m_in-m_in*fms3*(1-X3));
        s_AR3=medium.specificEntropy(medium.setState_ph(P_ext3,h_AR3));
      end if;
      //make last expansion line
      h_out3=h_AR3-(h_AR3-medium.specificEnthalpy_ps(P_out,s_AR3))*eta_t;
    else
      h_AR3=h_ext3;
      s_AR3=s_ext3;
      h_out3=h_out0;
      X3=0.9;
    end if;
  else
    h_AR3=h_AR1;
    h_ext3=h_ext1;
    h_out3=h_out0;
    s_AR3=s_AR1;
    s_ext3=s_ext1;
    X3=X1;
    eta_4=eta_1;
    s_out2=s_out0;
  end if;

 //now with all of the extraction enthalpys, nominal turbine conditions can be found (densities, mass flows and etas)
 h_ext1=h_in-(h_in-medium.specificEnthalpy_ps(P_ext1,s_in))*eta_1;
 d_ext1=medium.density_ph(P_ext1,h_AR1);
 if nExt==3 then
 h_ext2=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_ext2,s_AR1))*eta_2;
 d_ext2=medium.density_ph(P_ext2,h_AR2);
 h_ext3=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_ext3,s_AR2))*eta_3;
 d_ext3=medium.density_ph(P_ext3,h_AR3);
 h_out3=h_AR3-(h_AR3-medium.specificEnthalpy_ps(P_out,s_AR3))*eta_4;
 elseif nExt==2 then
 h_ext2=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_ext2,s_AR1))*eta_2;
 d_ext2=medium.density_ph(P_ext2,h_AR2);
 h_out2=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_out,s_AR2))*eta_3;
 d_ext3=d_ext2;
 if Ms2 then
 eta_4=eta_3;
 end if;
 else
 h_out1=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_out,s_AR1))*eta_2;
 d_ext2=d_ext1;
 eta_3=eta_2;
 d_ext3=d_ext2;
 //eta_4=eta_3;
 end if;

 m_flow_t1=m_in;
 if Ms1 then
   m_flow_t2=m_flow_t1-m_flow_t1*fms1*(1-X1);
 else
   m_flow_t2=m_flow_t1-m_ext1;
 end if;

 if Ms2 then
   m_flow_t3=m_flow_t2-m_flow_t2*fms2*(1-X2);
 else
   m_flow_t3=m_flow_t2-m_ext2;
 end if;

 if Ms3 then
   m_flow_t4=m_flow_t3-m_flow_t3*fms3*(1-X3);
 else
   m_flow_t4=m_flow_t3-m_ext3;
 end if;

equation
  connect(ST1.portHP, port_a)
    annotation (Line(points={{-94,6},{-94,60},{-100,60}}, color={0,127,255}));
  connect(ST1.shaft_a, shaft_a)
    annotation (Line(points={{-94,0},{-100,0}}, color={0,0,0}));
  if Con1 then
  connect(pressureCV1.port_b, ST2.portHP)
    annotation (Line(points={{-42,6},{-38,6}}, color={0,127,255}));
  end if;
  connect(ST1.shaft_b, ST2.shaft_a) annotation (Line(points={{-74,0},{-74,-14},{
          -38,-14},{-38,0}},color={0,0,0}));
  if Ms1 then
    connect(ST1.portLP, MS1.port_a)
    annotation (Line(points={{-74,6},{-72,6},{-72,34},{-70,34}},
                                               color={0,127,255}));
  if Con1 then
  connect(MS1.port_b, pressureCV1.port_a)
    annotation (Line(points={{-58,34},{-56,34},{-56,6},{-54,6}},
                                               color={0,127,255}));
  else
    connect(MS1.port_b,ST2.portHP);
  end if;
  connect(MS1.port_Liquid, port_b_extraction1) annotation (Line(points={{-68,30},
            {-68,-100},{-60,-100}},
                             color={0,127,255}));
  else
  connect(ST1.portLP, tee1.port_1)
    annotation (Line(points={{-74,6},{-70,6}}, color={0,127,255}));
  if Con1 then
  connect(tee1.port_2, pressureCV1.port_a)
    annotation (Line(points={{-58,6},{-54,6}}, color={0,127,255}));
   else
    connect(tee1.port_2,ST2.portHP);
  end if;
  connect(tee1.port_3, port_b_extraction1) annotation (Line(points={{-64,0},{-64,
          -100},{-60,-100}}, color={0,127,255}));
  end if;

  if nExt==1 then
  connect(ST2.portLP,port_b)
    annotation (Line( points={{-18,6},{94,6},{94,60},{100,60}},  color={0,127,255}));
  connect(ST2.shaft_b,shaft_b)
    annotation (Line( points={{-18,0},{100,0}},color={0,0,0}));
    //two extraction
  elseif nExt==2 then
    if Con2 then
  connect(pressureCV2.port_b, ST3.portHP)
    annotation (Line(points={{14,6},{18,6}}, color={0,127,255}));
    end if;
  connect(ST2.shaft_b, ST3.shaft_a) annotation (Line(points={{-18,0},{-18,-14},{
          18,-14},{18,0}}, color={0,0,0}));
  connect(ST3.portLP,port_b)
    annotation (Line( points={{38,6},{94,6},{94,60},{100,60}},   color={0,127,255}));
  connect(ST3.shaft_b,shaft_b)
    annotation (Line( points={{38,0},{100,0}}, color={0,0,0}));
  if Ms2 then
  connect(MS2.port_Liquid,port_b_extraction2)
    annotation (Line(points={{4,30},{4,-100},{0,-100}},  color={0,127,255}));
  connect(MS2.port_a, ST2.portLP)
    annotation (Line(points={{2,34},{-8,34},{-8,6},{-18,6}},
                                               color={0,127,255}));
  if Con2 then
  connect(MS2.port_b,pressureCV2. port_a)
    annotation (Line(points={{14,34},{8,34},{8,6},{2,6}},
                                            color={0,127,255}));
  else
    connect(MS2.port_b,ST3.portHP);
  end if;
  else
  connect(tee2.port_3,port_b_extraction2)
    annotation (Line(points={{-8,0},{-8,-100},{0,-100}}, color={0,127,255}));
  connect(tee2.port_1, ST2.portLP)
    annotation (Line(points={{-14,6},{-18,6}}, color={0,127,255}));
  if Con2 then
  connect(tee2.port_2,pressureCV2. port_a)
    annotation (Line(points={{-2,6},{2,6}}, color={0,127,255}));
  else
    connect(tee2.port_2,ST3.portHP);
  end if;
  end if;
  else
    if Ms2 then

  connect(MS2.port_Liquid,port_b_extraction2)
    annotation (Line(points={{4,30},{4,-100},{0,-100}},  color={0,127,255}));

  connect(MS2.port_a, ST2.portLP)
    annotation (Line(points={{2,34},{-8,34},{-8,6},{-18,6}},
                                               color={0,127,255}));
  if Con2 then
    connect(MS2.port_b,pressureCV2. port_a)
    annotation (Line(points={{14,34},{8,34},{8,6},{2,6}},
                                            color={0,127,255}));
  end if;
    else
   connect(tee2.port_3,port_b_extraction2)
    annotation (Line(points={{-8,0},{-8,-100},{0,-100}}, color={0,127,255}));
  if Con2 then
  connect(tee2.port_2,pressureCV2. port_a)
    annotation (Line(points={{-2,6},{2,6}}, color={0,127,255}));
   else
    connect(tee2.port_2,ST3.portHP);
  end if;
  connect(tee2.port_1, ST2.portLP)
    annotation (Line(points={{-14,6},{-18,6}}, color={0,127,255}));
    end if;
    //three extraction
    if Ms3 then
  connect(ST3.portLP,MS3.port_a)
    annotation (Line(points={{38,6},{48,6},{48,32},{58,32}},
                                             color={0,127,255}));

  connect(MS3.port_Liquid,port_b_extraction3)  annotation (Line(points={{60,28},
              {60,-86},{60,-86},{60,-100}},
                                        color={0,127,255}));
  if Con3 then
  connect(MS3.port_b,pressureCV3. port_a)
    annotation (Line(points={{70,32},{64,32},{64,6},{58,6}},
                                             color={0,127,255}));
  else
    connect(MS3.port_b, ST4.portHP);
  end if;
  else
  connect(ST3.portLP,tee3. port_1)
    annotation (Line(points={{38,6},{42,6}}, color={0,127,255}));
  connect(tee3.port_3,port_b_extraction3)  annotation (Line(points={{48,4.44089e-16},
          {48,-86},{60,-86},{60,-100}}, color={0,127,255}));
  if Con3 then
  connect(tee3.port_2,pressureCV3. port_a)
    annotation (Line(points={{54,6},{58,6}}, color={0,127,255}));
  else
    connect(tee3.port_2, ST4.portHP);
    end if;
    end if;
    if Con3 then
  connect(pressureCV3.port_b, ST4.portHP)
    annotation (Line(points={{70,6},{74,6}}, color={0,127,255}));
    end if;
  connect(shaft_b, ST4.shaft_b)
    annotation (Line(points={{100,0},{94,0}}, color={0,0,0}));
  connect(ST2.shaft_b, ST3.shaft_a) annotation (Line(points={{-18,0},{-18,-14},{
          18,-14},{18,0}}, color={0,0,0}));

  connect(ST3.shaft_b, ST4.shaft_a)
    annotation (Line(points={{38,0},{38,-14},{74,-14},{74,0}}, color={0,0,0}));
  if Con2 then
  connect(pressureCV2.port_b, ST3.portHP)
    annotation (Line(points={{14,6},{18,6}}, color={0,127,255}));
  end if;
  connect(ST4.portLP, port_b) annotation (Line(points={{94,6},{94,60},{100,60}},
                         color={0,127,255}));
  end if;

 annotation (Line(points={{94,6},{94,46},{86,46},{86,
          60},{100,60}}, color={0,127,255}), Icon(graphics={
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
          extent={{-6,21.5},{6,-21.5}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={0,-71.5},
          rotation=180,
          visible=DynamicSelect(true, if nExt>1 then true else false)),
        Rectangle(
          extent={{-66,-32},{-14,-44}},
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
          origin={-60,-62.5},
          rotation=180),
        Rectangle(
          extent={{-6,17},{6,-17}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,127,255},
          origin={20,-77},
          rotation=180,
          visible=DynamicSelect(true, if nExt>2 then true else false)),
        Polygon(
          points={{-40,30},{-40,-30},{40,-80},{40,80},{-40,30}},
          lineColor={0,0,0},
          fillColor={0,114,208},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{14,-82},{66,-94}},
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
          origin={60,-92},
          rotation=180,
          visible=DynamicSelect(true, if nExt>2 then true else false))}));
end ExtractionTurbine;
