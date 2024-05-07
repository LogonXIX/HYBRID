within NHES.Systems.PrimaryHeatSystem.PHTGR;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model Subchannel_Test
     extends Modelica.Icons.Example;
    NHES.Systems.PrimaryHeatSystem.PHTGR.Components.Subchannel subchannel(
                        redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      m_flow=0.5,
      T=773.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare package
        Medium = Modelica.Media.IdealGases.SingleGases.He, nPorts=1)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=10000)
      annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
  equation
    connect(boundary.ports[1], subchannel.port_a)
      annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
    connect(subchannel.port_b, boundary1.ports[1])
      annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
    connect(realExpression.y, subchannel.PowerIn)
      annotation (Line(points={{-49,28},{-28,28}},         color={0,0,127}));
    annotation (experiment(
        StopTime=10000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end Subchannel_Test;

  model Core_Test
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      m_flow=8.75,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare package
                Medium =
                 Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-10},{80,10}})));
    Components.Core core(
      Fr=0.5,
      Q_nominal=1.5e7,
      rho_input=-0.0075,
      Fp=1.1,
      T_Fouter_start=1173.15,
      T_Finner_start=1273.15,
      T_Mod_start=1073.15,
      T_Cinlet_start=773.15,
      T_Coutlet_start=1073.15)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  equation
    connect(core.port_b, boundary1.ports[1])
      annotation (Line(points={{20,0},{80,0}}, color={0,127,255}));
    connect(boundary.ports[1], core.port_a)
      annotation (Line(points={{-80,0},{-20,0}}, color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=100,
        __Dymola_Algorithm="Esdirk45a"));
  end Core_Test;

  model Reactor_Test
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    Reactor RX(redeclare replaceable
        NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texit_rhoInset CS)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Test;

  model TES_Test
     extends Modelica.Icons.Example;
      NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_BestModel
      two_Tank_SHS_System_BestModel(
      redeclare PHTGR.Examples.CS_TES CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
        hot_tank_init_temp=838.15,
        cold_tank_init_temp=548.15,
        DHX_v_shell=1.0),
      redeclare package Storage_Medium =
          Media.SolarSaltSS60.ConstantPropertyLiquidSolarSalt,
      redeclare package Charging_Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      m_flow_min=0.1,
      Steam_Output_Temp=773.15,
      CHX(
        p_start_shell=3000000,
        use_T_start_shell=true,
        T_start_shell_inlet=903.15,
        T_start_shell_outlet=903.15),
      sensor_T1(p_start=3000000, T_start=903.15),
      sensor_m_flow(p_start=3000000, T_start=903.15),
      Level_Hot_Tank1(y=5000e3))
      annotation (Placement(transformation(extent={{-2,-40},{74,36}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=50,
      T=343.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{142,48},{122,68}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=6900000,
      T=773.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{144,-54},{124,-34}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      use_m_flow_in=false,
      m_flow=8.75,
      T=903.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-34},{-80,-14}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
  equation
    connect(boundary2.ports[1], two_Tank_SHS_System_BestModel.port_ch_a)
      annotation (Line(points={{-80,-24},{-40.62,-24},{-40.62,-25.56},{-1.24,-25.56}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_BestModel.port_ch_b, boundary3.ports[1])
      annotation (Line(points={{-1.24,18.52},{-40.62,18.52},{-40.62,18},{-80,18}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_BestModel.port_dch_b, boundary1.ports[1])
      annotation (Line(points={{74,-25.56},{120,-25.56},{120,-44},{124,-44}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_BestModel.port_dch_a, boundary.ports[1])
      annotation (Line(points={{73.24,20.04},{94,20.04},{94,58},{122,58}},
          color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=1000,
        Interval=1,
        __Dymola_Algorithm="Esdirk45a"));
  end TES_Test;

  model RX_TES_Test
     extends Modelica.Icons.Example;
    NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_BestModel
      two_Tank_SHS_System_BestModel(
      redeclare MicroGrids.HydrogenStuff.CS_TES CS,
      redeclare replaceable
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
        hot_tank_init_temp=838.15,
        cold_tank_init_temp=548.15,
        DHX_v_shell=1.0),
      redeclare package Storage_Medium =
          Media.SolarSaltSS60.ConstantPropertyLiquidSolarSalt,
      redeclare package Charging_Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      m_flow_min=0.1,
      Steam_Output_Temp=773.15,
      CHX(
        p_start_shell=3000000,
        use_T_start_shell=true,
        T_start_shell_inlet=903.15,
        T_start_shell_outlet=903.15),
      sensor_T1(p_start=3000000, T_start=903.15),
      sensor_m_flow(p_start=3000000, T_start=903.15),
      Level_Hot_Tank1(y=5000e3))
      annotation (Placement(transformation(extent={{-2,-40},{74,36}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=50,
      T=343.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,12},{82,32}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=6900000,
      T=773.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{102,-36},{82,-16}})));
    Reactor RX(redeclare replaceable CS.CS_Texit CS)
      annotation (Placement(transformation(extent={{-100,-40},{-20,40}})));
  equation
    connect(two_Tank_SHS_System_BestModel.port_dch_b, boundary1.ports[1])
      annotation (Line(points={{74,-25.56},{78,-25.56},{78,-26},{82,-26}},
          color={0,127,255}));
    connect(two_Tank_SHS_System_BestModel.port_dch_a, boundary.ports[1])
      annotation (Line(points={{73.24,20.04},{73.24,22},{82,22}},
          color={0,127,255}));
    connect(RX.port_b, two_Tank_SHS_System_BestModel.port_ch_a) annotation (Line(
          points={{-20,-28},{-20,-25.56},{-1.24,-25.56}},          color={0,127,255}));
    connect(two_Tank_SHS_System_BestModel.port_ch_b, RX.port_a) annotation (Line(
          points={{-1.24,18.52},{-12,18.52},{-12,-12},{-20,-12}},  color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StartTime=1000,
        StopTime=100000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end RX_TES_Test;

  model Reactor_Testspeed
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    ReactorCRspeed
            RX(redeclare replaceable
        NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texitspeed CS, controlRod(
          Pos(start=0.75, fixed=true)))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Testspeed;

  model Reactor_Testspeedlimit
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    ReactorCRspeedlimit
            RX(redeclare replaceable
        NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texitspeed CS, controlRod(
          Pos(start=0.75, fixed=true)))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=1000000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Testspeedlimit;

  model Reactor_Testspeedinsert
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    ReactorCRspeed
            RX(redeclare replaceable
        NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texitspeed CS, controlRod(
          Pos(start=0.75, fixed=true)),
      core(rho_input=0.3 + RX.controlRod.y + step.y))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    Modelica.Blocks.Sources.Step step(
      height=200e-5,
      offset=0,
      startTime=1e6 + 60)
      annotation (Placement(transformation(extent={{-84,36},{-64,56}})));
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=20000,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_Testspeedinsert;

  model Reactor_TestspeedinsertStartUp
     extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      T=573.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,0},{80,20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
      redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He,
      p=3000000,
      nPorts=1)
      annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
    ReactorCRspeedStartUp
            RX(redeclare replaceable
        NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texitspeed CS, controlRod(
          Pos(start=0.75, fixed=true)),
      core(rho_input=rho_start + RX.controlRod.y + step.y))
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    Modelica.Blocks.Sources.Step step(
      height=200e-5,
      offset=0,
      startTime=1e6 + 60)
      annotation (Placement(transformation(extent={{-84,36},{-64,56}})));
      parameter Real rho_start=0.3;
  equation
    connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
            -24},{42,-30},{80,-30}}, color={0,127,255}));
    connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
            24},{74,10},{80,10}},  color={0,127,255}));
    annotation (experiment(
        StopTime=20000,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"));
  end Reactor_TestspeedinsertStartUp;
end Examples;
