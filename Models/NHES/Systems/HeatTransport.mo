within NHES.Systems;
package HeatTransport

  package Examples
      extends Modelica.Icons.ExamplesPackage;
    model HTtest
      extends Modelica.Icons.Example;
      Modelica.Units.SI.MassFlowRate m_diff;
      Modelica.Units.SI.TemperatureDifference dT;
      Modelica.Units.SI.PressureDifference dP;
      TwoWayTransport twoWayTransport(
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=twoWayTransport.L_supply,
          D=twoWayTransport.D_s,
          ith=twoWayTransport.th_i_supply,
          nV=35),
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        nominal_h_sink_supply=2969.5e3,
        L_supply=1000,
        nominal_m_flow_return=5,
        nominal_P_sink_return=200000,
        nominal_h_sink_return=958.4e3,
        S_use_T_start=true,
        S_T_a_start=524.15,
        S_T_b_start=522.15,
        S_m_flow_a_start=5,
        S_m_flow_b_start=-5,
        R_use_T_start=true,
        R_T_a_start=373.15,
        R_T_b_start=373.15,
        Supply(p_a_start=300000, p_b_start=300000),
        Return(p_a_start=250000, p_b_start=250000))
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=false,
        use_T_in=true,
        m_flow=5,
        T=523.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=5,
        T=373.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-34},{80,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-102,-34},{-82,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=250000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,14},{80,34}})));
      Modelica.Blocks.Sources.Pulse pulse(
        width=100,
        period=10,
        nperiod=1,
        offset=5,
        startTime=10005)
        annotation (Placement(transformation(extent={{-160,22},{-140,42}})));
      Modelica.Blocks.Sources.ContinuousClock continuousClock(offset=-5,
          startTime=10000)
        annotation (Placement(transformation(extent={{-160,64},{-140,84}})));
      Modelica.Blocks.Sources.Step step(
        height=20,
        offset=250 + 273.15,
        startTime=10005)
        annotation (Placement(transformation(extent={{-160,-12},{-140,8}})));
    equation
      m_diff=twoWayTransport.Supply.port_a.m_flow+twoWayTransport.Supply.port_b.m_flow;
      dT=twoWayTransport.sensor_T_S_in.T-twoWayTransport.sensor_T_S_out.T;
      dP=twoWayTransport.sensor_p_S_in.p-twoWayTransport.sensor_p_S_out.p;
      connect(boundary.ports[1], twoWayTransport.port_a_supply)
        annotation (Line(points={{-80,24},{-40,24}}, color={0,127,255}));
      connect(twoWayTransport.port_b_supply, boundary3.ports[1])
        annotation (Line(points={{40,24},{80,24}}, color={0,127,255}));
      connect(boundary1.ports[1], twoWayTransport.port_a_return)
        annotation (Line(points={{80,-24},{40,-24}}, color={0,127,255}));
      connect(twoWayTransport.port_b_return, boundary2.ports[1])
        annotation (Line(points={{-40,-24},{-82,-24}}, color={0,127,255}));
      connect(pulse.y, boundary.m_flow_in)
        annotation (Line(points={{-139,32},{-100,32}}, color={0,0,127}));
      connect(step.y, boundary.T_in) annotation (Line(points={{-139,-2},{-112,-2},{-112,
              28},{-102,28}}, color={0,0,127}));
      annotation (experiment(
          StartTime=10000,
          StopTime=10500,
          Interval=0.25,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest;

    model HTtest2
      extends Modelica.Icons.Example;
      OneWayTransport oneWayTransport(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        nominal_h_sink_supply=2969.5e3,
        S_use_T_start=true,
        S_T_a_start=523.15,
        S_T_b_start=523.15,
        Supply(p_a_start=300000, p_b_start=300000))
        annotation (Placement(transformation(extent={{-40,-16},{40,64}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        m_flow=5,
        T=523.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Sink(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=250000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,14},{80,34}})));
    equation
      connect(Source.ports[1], oneWayTransport.port_a_supply)
        annotation (Line(points={{-80,24},{-40,24}}, color={0,127,255}));
      connect(oneWayTransport.port_b_supply, Sink.ports[1])
        annotation (Line(points={{40,24},{80,24}}, color={0,127,255}));
      annotation (experiment(
          StopTime=1000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end HTtest2;

    model SteamTransOil
      extends Modelica.Icons.Example;
      OneWayTransport oneWayTransport(
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=2000,
          D=0.3334,
          ith=2*0.0127,
          pth=0.01748,
          nV=40),
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        th_i_supply=0.035,
        lambda_supply=0.04,
        nominal_h_sink_supply=2969.5e3,
        K_supply=2.8,
        L_supply=2000,
        U_dist_s=125,
        S_use_T_start=true,
        S_T_a_start=593.15,
        S_T_b_start=573.15,
        Supply(
          p_a_start=4400000,
          p_b_start=4200000,
          m_flow_a_start=42,
          m_flow_b_start=-42))
        annotation (Placement(transformation(extent={{-44,-18},{36,62}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_in=true,
        m_flow=42,
        T=585.75,
        nPorts=1)
        annotation (Placement(transformation(extent={{-166,14},{-146,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Sink(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=4200000,
        nPorts=1)
        annotation (Placement(transformation(extent={{166,8},{146,28}})));
      parameter Modelica.Media.Interfaces.Types.Temperature T=573.15
        "Fixed value of temperature";
        Modelica.Units.SI.Velocity vmax;
        Modelica.Units.SI.Power hloss;
        Modelica.Units.SI.Power hloss2;
      TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{42,24},{62,44}})));
      Controls.LimOffsetPID PID(
        k=0.01,
        Ti=10,
        yMax=680,
        yMin=0,
        offset=305 + 273.15,
        delayTime=10,
        init_output=305 + 273.15)
        annotation (Placement(transformation(extent={{10,98},{-10,118}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 300)
        annotation (Placement(transformation(extent={{62,96},{42,116}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-102,40},{-82,60}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort
                                               sensor_h(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-134,14},{-114,34}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpyTwoPort
                                               sensor_h1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{72,20},{92,40}})));
      Modelica.Blocks.Math.Add add(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{-60,134},{-40,154}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-2,130},{18,150}})));
      TRANSFORM.Blocks.RealExpression realExpression1
        annotation (Placement(transformation(extent={{42,128},{62,148}})));
      TRANSFORM.Fluid.Sensors.RelativePressure relativePressure(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        precision=2,
        redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
        annotation (Placement(transformation(extent={{-42,-58},{4,-36}})));
    equation
      vmax=max(oneWayTransport.Supply.flowModel.vs[:]);
        hloss=sum(oneWayTransport.S_res[:].port_a.Q_flow);
        hloss2=oneWayTransport.Supply.port_a.m_flow*(sensor_h.h_out-sensor_h1.h_out);
      connect(oneWayTransport.port_b_supply, sensor_T.port)
        annotation (Line(points={{36,22},{44,22},{44,24},{52,24}},
                                                   color={0,127,255}));
      connect(PID.u_m, sensor_T.T) annotation (Line(points={{0,96},{0,76},{68,
              76},{68,34},{58,34}}, color={0,0,127}));
      connect(realExpression.y, PID.u_s) annotation (Line(points={{41,106},{20,
              106},{20,108},{12,108}}, color={0,0,127}));
      connect(PID.y, Source.T_in) annotation (Line(points={{-11,108},{-154,108},
              {-154,38},{-176,38},{-176,28},{-168,28}}, color={0,0,127}));
      connect(sensor_m_flow.port_b, oneWayTransport.port_a_supply)
        annotation (Line(points={{-58,24},{-52,24},{-52,22},{-44,22}},
                                                     color={0,127,255}));
      connect(sensor_h.h_out, add.u1) annotation (Line(points={{-124,27.6},{
              -124,150},{-62,150}},
                               color={0,0,127}));
      connect(add.u2, sensor_h1.h_out) annotation (Line(points={{-62,138},{-62,
              124},{92,124},{92,33.6},{82,33.6}},
                                              color={0,0,127}));
      connect(add.y, product1.u1) annotation (Line(points={{-39,144},{-39,146},
              {-4,146}}, color={0,0,127}));
      connect(sensor_m_flow.m_flow, product1.u2) annotation (Line(points={{-68,
              27.6},{-68,126},{-4,126},{-4,134}}, color={0,0,127}));
      connect(realExpression1.u, product1.y)
        annotation (Line(points={{40,138},{30,138},{30,140},{19,140}},
                                                     color={0,0,127}));
      connect(oneWayTransport.port_a_supply, relativePressure.port_a)
        annotation (Line(points={{-44,22},{-50,22},{-50,-47},{-42,-47}}, color=
              {0,127,255}));
      connect(sensor_T.port, sensor_h1.port_a) annotation (Line(points={{52,24},
              {52,22},{66,22},{66,30},{72,30}}, color={0,127,255}));
      connect(sensor_h1.port_b, Sink.ports[1]) annotation (Line(points={{92,30},
              {140,30},{140,18},{146,18}}, color={0,127,255}));
      connect(relativePressure.port_b, sensor_T.port) annotation (Line(points={
              {4,-47},{4,-48},{52,-48},{52,24}}, color={0,127,255}));
      connect(Source.ports[1], sensor_h.port_a)
        annotation (Line(points={{-146,24},{-134,24}}, color={0,127,255}));
      connect(sensor_h.port_b, sensor_T1.port) annotation (Line(points={{-114,
              24},{-92,24},{-92,40}}, color={0,127,255}));
      connect(sensor_m_flow.port_a, sensor_h.port_b)
        annotation (Line(points={{-78,24},{-114,24}}, color={0,127,255}));
      annotation (experiment(
          StopTime=10000,
          Interval=20,
          __Dymola_Algorithm="Esdirk45a"));
    end SteamTransOil;

    model SteamTransOilretuen
      extends Modelica.Icons.Example;
      OneWayTransport oneWayTransport(
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=oneWayTransport.L_supply,
          D=0.15408,
          ith=0.0127,
          pth=0.01905,
          nV=20),
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        th_i_supply=0.0127,
        nominal_h_sink_supply=2969.5e3,
        L_supply=750,
        U_dist_s=2000,
        S_use_T_start=true,
        S_T_a_start=353.15,
        S_T_b_start=353.15,
        Supply(p_a_start=120000, p_b_start=120000))
        annotation (Placement(transformation(extent={{-40,-16},{40,64}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_in=false,
        m_flow=42,
        T=359.85,
        nPorts=3)
        annotation (Placement(transformation(extent={{-172,14},{-152,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Sink(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=true,
        p=4200000,
        nPorts=3)
        annotation (Placement(transformation(extent={{100,14},{80,34}})));
      parameter Modelica.Media.Interfaces.Types.Temperature T=573.15
        "Fixed value of temperature";
        Modelica.Units.SI.Power hloss;
      TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{42,24},{62,44}})));
      Controls.LimOffsetPID PID(
        k=0.001,
        yMax=1.1e5,
        yMin=0.5e5,
        offset=1.1e5,
        init_output=1.1e5)
        annotation (Placement(transformation(extent={{0,100},{20,120}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=1.1e5)
        annotation (Placement(transformation(extent={{-62,106},{-42,126}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p
        annotation (Placement(transformation(extent={{-74,42},{-54,62}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-130,56},{-110,76}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-96,14},{-76,34}})));
      TRANSFORM.Fluid.Sensors.RelativePressure relativePressure(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        precision=2,
        redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
        annotation (Placement(transformation(extent={{-38,-54},{0,-22}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{62,44},{82,64}})));
      Modelica.Blocks.Math.Add add(k1=1e-6, k2=-1e-6)
        annotation (Placement(transformation(extent={{-64,148},{-44,168}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-6,144},{14,164}})));
      TRANSFORM.Blocks.RealExpression realExpression1
        annotation (Placement(transformation(extent={{38,144},{58,164}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h2(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-152,40},{-132,60}})));
    equation

      hloss=sum(oneWayTransport.S_res[:].port_a.Q_flow);
      connect(oneWayTransport.port_b_supply, Sink.ports[1])
        annotation (Line(points={{40,24},{60,24},{60,22.6667},{80,22.6667}},
                                                   color={0,127,255}));
      connect(oneWayTransport.port_b_supply, sensor_T.port)
        annotation (Line(points={{40,24},{52,24}}, color={0,127,255}));
      connect(realExpression.y, PID.u_s) annotation (Line(points={{-41,116},{
              -12,116},{-12,110},{-2,110}}, color={0,0,127}));
      connect(sensor_p.p, PID.u_m) annotation (Line(points={{-58,52},{-46,52},{
              -46,88},{10,88},{10,98}}, color={0,0,127}));
      connect(PID.y, Sink.p_in) annotation (Line(points={{21,110},{134,110},{
              134,32},{102,32}}, color={0,0,127}));
      connect(oneWayTransport.port_a_supply, relativePressure.port_a)
        annotation (Line(points={{-40,24},{-48,24},{-48,-38},{-38,-38}}, color=
              {0,127,255}));
      connect(Sink.ports[2], relativePressure.port_b) annotation (Line(points={
              {80,24},{60,24},{60,-38},{0,-38}}, color={0,127,255}));
      connect(add.u2, sensor_h1.h_out) annotation (Line(points={{-66,152},{-66,
              94},{88,94},{88,54},{78,54}}, color={0,0,127}));
      connect(add.y, product1.u1) annotation (Line(points={{-43,158},{-43,160},
              {-8,160}}, color={0,0,127}));
      connect(sensor_m_flow.m_flow, product1.u2) annotation (Line(points={{-86,
              27.6},{-86,128},{-64,128},{-64,140},{-8,140},{-8,148}}, color={0,
              0,127}));
      connect(realExpression1.u, product1.y)
        annotation (Line(points={{36,154},{15,154}}, color={0,0,127}));
      connect(sensor_m_flow.port_a, Source.ports[1]) annotation (Line(points={{-96,24},
              {-124,24},{-124,23.6667},{-152,23.6667}},         color={0,127,
              255}));
      connect(sensor_m_flow.port_b, oneWayTransport.port_a_supply)
        annotation (Line(points={{-76,24},{-40,24}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, sensor_p.port) annotation (Line(points={{
              -76,24},{-64,24},{-64,42}}, color={0,127,255}));
      connect(sensor_T1.port, Source.ports[2]) annotation (Line(points={{-120,
              56},{-110,56},{-110,24},{-152,24}}, color={0,127,255}));
      connect(sensor_h1.port, Sink.ports[3]) annotation (Line(points={{72,44},{
              74,44},{74,25.3333},{80,25.3333}}, color={0,127,255}));
      connect(sensor_h2.h_out, add.u1) annotation (Line(points={{-136,50},{-88,
              50},{-88,164},{-66,164}}, color={0,0,127}));
      connect(sensor_h2.port, Source.ports[3]) annotation (Line(points={{-142,40},
              {-142,24.3333},{-152,24.3333}},     color={0,127,255}));
      annotation (experiment(
          StopTime=10000,
          Interval=20,
          __Dymola_Algorithm="Esdirk45a"));
    end SteamTransOilretuen;

    model SteamTransOilold
      extends Modelica.Icons.Example;
      OneWayTransportold
                      oneWayTransportold(
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=2000,
          D=0.33334,
          ith=2*0.0127,
          pth=0.01748,
          nV=20),
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        th_i_supply=0.0762,
        nominal_h_sink_supply=2969.5e3,
        L_supply=750,
        S_use_T_start=true,
        S_T_a_start=523.15,
        S_T_b_start=523.15,
        Supply(
          p_a_start=4400000,
          p_b_start=4200000,
          m_flow_a_start=42,
          m_flow_b_start=-42))
        annotation (Placement(transformation(extent={{-44,-18},{36,62}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_in=true,
        m_flow=42,
        T=585.75,
        nPorts=3)
        annotation (Placement(transformation(extent={{-166,14},{-146,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Sink(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=4238000,
        nPorts=2)
        annotation (Placement(transformation(extent={{102,14},{82,34}})));
      parameter Modelica.Media.Interfaces.Types.Temperature T=573.15
        "Fixed value of temperature";
        Modelica.Units.SI.Velocity vmax;
        Modelica.Units.SI.Power hloss;
      TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{42,24},{62,44}})));
      Controls.LimOffsetPID PID(
        k=0.01,
        Ti=10,
        yMax=680,
        yMin=0,
        offset=305 + 273.15,
        init_output=305 + 273.15)
        annotation (Placement(transformation(extent={{10,98},{-10,118}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 300)
        annotation (Placement(transformation(extent={{62,96},{42,116}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-144,44},{-124,64}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{66,30},{86,50}})));
      Modelica.Blocks.Math.Add add(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{-60,134},{-40,154}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-2,130},{18,150}})));
      TRANSFORM.Blocks.RealExpression realExpression1
        annotation (Placement(transformation(extent={{42,128},{62,148}})));
      TRANSFORM.Fluid.Sensors.RelativePressure relativePressure(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        precision=2,
        redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
        annotation (Placement(transformation(extent={{-42,-58},{4,-36}})));
    equation
      vmax=max(oneWayTransportold.Supply.flowModel.vs[:]);
        hloss=sum(oneWayTransportold.S_res[:].port_a.Q_flow);
      connect(oneWayTransportold.port_b_supply, Sink.ports[1]) annotation (Line(
            points={{36,22},{60,22},{60,23},{82,23}}, color={0,127,255}));
      connect(oneWayTransportold.port_b_supply, sensor_T.port) annotation (Line(
            points={{36,22},{44,22},{44,24},{52,24}}, color={0,127,255}));
      connect(PID.u_m, sensor_T.T) annotation (Line(points={{0,96},{0,76},{68,
              76},{68,34},{58,34}}, color={0,0,127}));
      connect(realExpression.y, PID.u_s) annotation (Line(points={{41,106},{20,
              106},{20,108},{12,108}}, color={0,0,127}));
      connect(PID.y, Source.T_in) annotation (Line(points={{-11,108},{-154,108},
              {-154,38},{-176,38},{-176,28},{-168,28}}, color={0,0,127}));
      connect(Source.ports[1], sensor_T1.port) annotation (Line(points={{-146,
              23.6667},{-116,23.6667},{-116,42}}, color={0,127,255}));
      connect(Source.ports[2], sensor_h.port) annotation (Line(points={{-146,24},
              {-134,24},{-134,44}}, color={0,127,255}));
      connect(Source.ports[3], sensor_m_flow.port_a) annotation (Line(points={{-146,
              24.3333},{-84,24.3333},{-84,24},{-78,24}},      color={0,127,255}));
      connect(sensor_m_flow.port_b, oneWayTransportold.port_a_supply)
        annotation (Line(points={{-58,24},{-52,24},{-52,22},{-44,22}}, color={0,
              127,255}));
      connect(oneWayTransportold.port_b_supply, sensor_h1.port) annotation (
          Line(points={{36,22},{56,22},{56,30},{76,30}}, color={0,127,255}));
      connect(sensor_h.h_out, add.u1) annotation (Line(points={{-128,54},{-128,
              150},{-62,150}}, color={0,0,127}));
      connect(add.u2, sensor_h1.h_out) annotation (Line(points={{-62,138},{-62,
              122},{92,122},{92,40},{82,40}}, color={0,0,127}));
      connect(add.y, product1.u1) annotation (Line(points={{-39,144},{-39,146},
              {-4,146}}, color={0,0,127}));
      connect(sensor_m_flow.m_flow, product1.u2) annotation (Line(points={{-68,
              27.6},{-68,126},{-4,126},{-4,134}}, color={0,0,127}));
      connect(realExpression1.u, product1.y)
        annotation (Line(points={{40,138},{30,138},{30,140},{19,140}},
                                                     color={0,0,127}));
      connect(oneWayTransportold.port_a_supply, relativePressure.port_a)
        annotation (Line(points={{-44,22},{-50,22},{-50,-47},{-42,-47}}, color=
              {0,127,255}));
      connect(Sink.ports[2], relativePressure.port_b) annotation (Line(points={
              {82,25},{66,25},{66,-47},{4,-47}}, color={0,127,255}));
      annotation (experiment(
          StopTime=10000,
          Interval=20,
          __Dymola_Algorithm="Esdirk45a"));
    end SteamTransOilold;

    model SteamTransOilcond
      extends Modelica.Icons.Example;
      OneWayTransport oneWayTransport(
        redeclare replaceable data.pipe_data_1 Supply_pipe_data(
          L=2000,
          D=0.15408,
          ith=2*0.0127,
          pth=0.01748,
          nV=20),
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nominal_m_flow_supply=5,
        nominal_P_sink_supply=250000,
        th_i_supply=0.0127,
        lambda_supply=0.04,
        nominal_h_sink_supply=2969.5e3,
        L_supply=750,
        S_use_T_start=true,
        S_T_a_start=360.15,
        S_T_b_start=360.15,
        Supply(
          p_a_start=110000,
          p_b_start=110000,
          m_flow_a_start=42,
          m_flow_b_start=-42))
        annotation (Placement(transformation(extent={{-44,-18},{36,62}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Source(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_T_in=true,
        m_flow=42,
        T=585.75,
        nPorts=3)
        annotation (Placement(transformation(extent={{-166,14},{-146,34}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Sink(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=110000,
        nPorts=2)
        annotation (Placement(transformation(extent={{102,14},{82,34}})));
      parameter Modelica.Media.Interfaces.Types.Temperature T=573.15
        "Fixed value of temperature";
        Modelica.Units.SI.Velocity vmax;
        Modelica.Units.SI.Power hloss;
      TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{42,24},{62,44}})));
      Controls.LimOffsetPID PID(
        k=0.001,
        Ti=10,
        yMax=600,
        yMin=0,
        offset=90 + 273.15,
        init_output=90 + 273.15)
        annotation (Placement(transformation(extent={{10,98},{-10,118}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=273.15 + 87.6)
        annotation (Placement(transformation(extent={{62,96},{42,116}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-126,42},{-106,62}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-144,44},{-124,64}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-78,14},{-58,34}})));
      TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h1(redeclare package
          Medium = Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{66,30},{86,50}})));
      Modelica.Blocks.Math.Add add(k1=1, k2=-1)
        annotation (Placement(transformation(extent={{-60,134},{-40,154}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{-2,130},{18,150}})));
      TRANSFORM.Blocks.RealExpression realExpression1
        annotation (Placement(transformation(extent={{42,128},{62,148}})));
      TRANSFORM.Fluid.Sensors.RelativePressure relativePressure(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        precision=2,
        redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
        annotation (Placement(transformation(extent={{-42,-58},{4,-36}})));
    equation
      vmax=max(oneWayTransport.Supply.flowModel.vs[:]);
        hloss=sum(oneWayTransport.S_res[:].port_a.Q_flow);
      connect(oneWayTransport.port_b_supply, Sink.ports[1])
        annotation (Line(points={{36,22},{60,22},{60,23},{82,23}},
                                                   color={0,127,255}));
      connect(oneWayTransport.port_b_supply, sensor_T.port)
        annotation (Line(points={{36,22},{44,22},{44,24},{52,24}},
                                                   color={0,127,255}));
      connect(PID.u_m, sensor_T.T) annotation (Line(points={{0,96},{0,76},{68,
              76},{68,34},{58,34}}, color={0,0,127}));
      connect(realExpression.y, PID.u_s) annotation (Line(points={{41,106},{20,
              106},{20,108},{12,108}}, color={0,0,127}));
      connect(PID.y, Source.T_in) annotation (Line(points={{-11,108},{-154,108},
              {-154,38},{-176,38},{-176,28},{-168,28}}, color={0,0,127}));
      connect(Source.ports[1], sensor_T1.port) annotation (Line(points={{-146,
              23.6667},{-116,23.6667},{-116,42}}, color={0,127,255}));
      connect(Source.ports[2], sensor_h.port) annotation (Line(points={{-146,24},
              {-134,24},{-134,44}}, color={0,127,255}));
      connect(Source.ports[3], sensor_m_flow.port_a) annotation (Line(points={{-146,
              24.3333},{-84,24.3333},{-84,24},{-78,24}},      color={0,127,255}));
      connect(sensor_m_flow.port_b, oneWayTransport.port_a_supply)
        annotation (Line(points={{-58,24},{-52,24},{-52,22},{-44,22}},
                                                     color={0,127,255}));
      connect(oneWayTransport.port_b_supply, sensor_h1.port) annotation (Line(
            points={{36,22},{56,22},{56,30},{76,30}}, color={0,127,255}));
      connect(sensor_h.h_out, add.u1) annotation (Line(points={{-128,54},{-128,
              150},{-62,150}}, color={0,0,127}));
      connect(add.u2, sensor_h1.h_out) annotation (Line(points={{-62,138},{-62,
              122},{92,122},{92,40},{82,40}}, color={0,0,127}));
      connect(add.y, product1.u1) annotation (Line(points={{-39,144},{-39,146},
              {-4,146}}, color={0,0,127}));
      connect(sensor_m_flow.m_flow, product1.u2) annotation (Line(points={{-68,
              27.6},{-68,126},{-4,126},{-4,134}}, color={0,0,127}));
      connect(realExpression1.u, product1.y)
        annotation (Line(points={{40,138},{30,138},{30,140},{19,140}},
                                                     color={0,0,127}));
      connect(oneWayTransport.port_a_supply, relativePressure.port_a)
        annotation (Line(points={{-44,22},{-50,22},{-50,-47},{-42,-47}}, color=
              {0,127,255}));
      connect(Sink.ports[2], relativePressure.port_b) annotation (Line(points={
              {82,25},{66,25},{66,-47},{4,-47}}, color={0,127,255}));
      annotation (experiment(
          StopTime=10000,
          Interval=20,
          __Dymola_Algorithm="Esdirk45a"));
    end SteamTransOilcond;
  end Examples;

  model TwoWayTransport
    extends BaseClasses.Partial_SubSystem_A(
    redeclare replaceable ControlSystems.CS_Dummy CS,
    redeclare replaceable ControlSystems.ED_Dummy ED,
    redeclare replaceable data.pipe_data_1 Supply_pipe_data(L=L_supply, D=D_s,
        ith=th_i_supply),
    redeclare replaceable data.pipe_data_1 Return_pipe_data(L=L_return, D=D_r,
        ith=th_i_return));

   //---------------------------------------------------------
   //   Supply Nominal
   parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_supply=44 annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_supply=1e5
                                                          annotation(Dialog(group="Supply"));
   parameter SI.Thickness th_i_supply=0.1
                                  annotation(Dialog(group="Supply"));
   parameter SI.ThermalConductivity lambda_supply=0.08
                                               annotation(Dialog(group="Supply"));
   parameter SI.Temperature S_amb_T=300 "Ambient External Temperature on Supply Side" annotation(Dialog(group="Supply"));
   parameter SI.CoefficientOfHeatTransfer S_alpha=20 "External Convective Heat Transfer Coefficient on Supply Side" annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_supply=3e6
                                                          annotation(Dialog(group="Supply"));
   parameter Real K_supply=2.8 "Local Loss Coe"
                                               annotation(Dialog(group="Supply"));
   parameter SI.Length L_supply=500 "Supply Pipe Length"
                                                        annotation(Dialog(group="Supply"));
   parameter SI.Length U_dist_s=125 "Distance Between U Sections";
   parameter SI.Velocity v_supply=6 annotation(Dialog(group="Supply"));
   //   Return Nominal
   parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_return=44 annotation(Dialog(group="Return"));
   parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_return=1e5
                                                          annotation(Dialog(group="Return"));
   parameter SI.Thickness th_i_return=0.1
                                  annotation(Dialog(group="Return"));
   parameter SI.ThermalConductivity lambda_return=0.08
                                               annotation(Dialog(group="Return"));
   parameter SI.Temperature R_amb_T=300 "Ambient External Temperature on Return Side" annotation(Dialog(group="Return"));
   parameter SI.CoefficientOfHeatTransfer R_alpha=20 "External Convective Heat Transfer Coefficient on Return Side" annotation(Dialog(group="Return"));
   parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_return=3e6
                                                          annotation(Dialog(group="Return"));
   parameter Real K_return=2.8 "Local Loss Coe"
                                               annotation(Dialog(group="Return"));
   parameter SI.Length L_return=500 "Return Pipe Length"
                                                        annotation(Dialog(group="Return"));
   parameter SI.Length U_dist_r=125 "Distance Between U Sections";
   parameter SI.Velocity v_return=6 annotation(Dialog(group="Return"));
   //  Supply Init
   parameter SI.AbsolutePressure S_p_a_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.AbsolutePressure S_p_b_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter Boolean S_use_T_start=false;
   parameter SI.Temperature S_T_a_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.Temperature S_T_b_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_a_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_b_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_a_start=nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_b_start=-nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));


   //  Return Init
   parameter SI.AbsolutePressure R_p_a_start=nominal_P_sink_return annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.AbsolutePressure R_p_b_start=nominal_P_sink_return annotation(Dialog(tab="Initialization",group="Return"));
   parameter Boolean R_use_T_start=false;
   parameter SI.Temperature R_T_a_start=Medium.temperature_phX(nominal_P_sink_return,nominal_h_sink_return,Medium.X_default) annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.Temperature R_T_b_start=Medium.temperature_phX(nominal_P_sink_return,nominal_h_sink_return,Medium.X_default) annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.SpecificEnthalpy R_h_a_start=nominal_h_sink_return annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.SpecificEnthalpy R_h_b_start=nominal_h_sink_return annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.MassFlowRate R_m_flow_a_start=nominal_m_flow_return annotation(Dialog(tab="Initialization",group="Return"));
   parameter SI.MassFlowRate R_m_flow_b_start=-nominal_m_flow_return annotation(Dialog(tab="Initialization",group="Return"));




   final parameter SI.Diameter D_s(fixed=false)=0.51;
   final parameter Integer nU_s(fixed=false)=1;
   final parameter Integer nSp_s(fixed=false)=1;
   final parameter Real [:] Ks_s(fixed=false)=fill(0,Supply_pipe_data.nV);
   final parameter Integer i_s(fixed=false)=1;
   final parameter Integer j_s(fixed=false)=1;
   final parameter Integer g_s(fixed=false)=1;
   final parameter SI.ThermalResistance S_R_val(fixed=false)=10 "Thermal resistance";


   final parameter SI.Diameter D_r(fixed=false)=0.51;
   final parameter Integer nU_r(fixed=false)=1;
   final parameter Integer nSp_r(fixed=false)=1;
   final parameter Real [:] Ks_r(fixed=false)=fill(0,Return_pipe_data.nV);
   final parameter Integer i_r(fixed=false)=1;
   final parameter Integer j_r(fixed=false)=1;
   final parameter Integer g_r(fixed=false)=1;
   final parameter SI.ThermalResistance R_R_val(fixed=false)=10 "Thermal resistance";


    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(
      redeclare package Medium = Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
          (Ks_ab=Ks_s, Ks_ba=Ks_s),
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{-30,20},{30,80}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-50,30},{-30,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{30,30},{50,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-80,34},{-60,14}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{60,30},{80,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T)
      annotation (Placement(transformation(extent={{120,100},{100,120}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
      annotation (Placement(transformation(extent={{80,100},{60,120}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance S_res[
      Supply_pipe_data.nV](R_val=S_R_val)
      annotation (Placement(transformation(extent={{10,70},{30,90}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Return(
      redeclare package Medium = Medium,
      use_Ts_start=R_use_T_start,
      p_a_start=R_p_a_start,
      p_b_start=R_p_b_start,
      T_a_start=R_T_a_start,
      T_b_start=R_T_b_start,
      h_a_start=R_h_a_start,
      h_b_start=R_h_b_start,
      m_flow_a_start=R_m_flow_a_start,
      m_flow_b_start=R_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Return_pipe_data.D,
          length=Return_pipe_data.L,
          dheight=Return_pipe_data.dH,
          nV=Return_pipe_data.nV),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
          (Ks_ab=Ks_r, Ks_ba=Ks_r),
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{30,-90},{-30,-30}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_in(redeclare package Medium =
          Medium, precision=2)
      annotation (Placement(transformation(extent={{70,-74},{90,-94}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_R_out(redeclare package Medium =
          Medium, precision=2)
      annotation (Placement(transformation(extent={{-90,-74},{-70,-94}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_in(redeclare package Medium =
          Medium, precision=2)
      annotation (Placement(transformation(extent={{30,-74},{50,-94}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_R_out(redeclare package Medium =
          Medium, precision=2)
      annotation (Placement(transformation(extent={{-50,-74},{-30,-94}})));
    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance R_res[
      Return_pipe_data.nV](R_val=R_R_val)
      annotation (Placement(transformation(extent={{6,-28},{26,-8}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl1(
      nNodes=Return_pipe_data.nV,
      r_outer=(Return_pipe_data.D + 2*Return_pipe_data.pth + 2*Return_pipe_data.ith)
          /2,
      length=Return_pipe_data.L,
      alphas=R_alpha*ones(Return_pipe_data.nV))
      annotation (Placement(transformation(extent={{76,-28},{56,-8}})));

    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature R_boundary_conv[
      Return_pipe_data.nV](T=R_amb_T)
      annotation (Placement(transformation(extent={{116,-28},{96,-8}})));


  initial algorithm
    nU_s:= integer( ceil(L_supply/U_dist_s));
    nSp_s:=integer(floor(Supply_pipe_data.nV/nU_s));
    i_s:=1;
    j_s:=1;
    g_s:=0;
    while i_s <Supply_pipe_data.nV+1 loop
      if j_s==nSp_s and g_s<nU_s then
        Ks_s[i_s]:=K_supply;
        j_s:=1;
        g_s:=g_s+1;
      else
        Ks_s[i_s]:=0;
        j_s:=j_s+1;
      end if;
      i_s:=i_s+1;
    end while;

    nU_r:= integer( ceil(L_return/U_dist_r));
    nSp_r:=integer(floor(Return_pipe_data.nV/nU_r));
    i_r:=1;
    j_r:=1;
    g_r:=0;
    while i_r <Return_pipe_data.nV+1 loop
      if j_r==nSp_r and g_r<nU_r then
        Ks_r[i_r]:=K_return;
        j_r:=1;
        g_r:=g_r+1;
      else
        Ks_r[i_r]:=0;
        j_r:=j_r+1;
      end if;
      i_r:=i_r+1;
    end while;

  initial equation
    assert(Supply_pipe_data.nV>nU_s,"Not Enough Nodes (supply)",AssertionLevel.error);
    assert(Return_pipe_data.nV>nU_r,"Not Enough Nodes (return)",AssertionLevel.error);
    nominal_m_flow_supply=v_supply*Modelica.Constants.pi*(D_s^2)*0.25
                                            *Medium.density( Medium.setState_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default));
    S_R_val=(D_s+2*th_i_supply)*ln((D_s+2*th_i_supply)/D_s)/lambda_supply;
    nominal_m_flow_return=v_return*Modelica.Constants.pi*(D_r^2)*0.25
                                            *Medium.density(Medium.setState_phX(nominal_P_sink_return,nominal_h_sink_return,Medium.X_default));
    R_R_val=(D_r+2*th_i_return)*ln((D_r+2*th_i_return)/D_r)/lambda_return;

  equation



    connect(S_convection_constantArea_2DCyl.port_a,S_boundary_conv. port)
      annotation (Line(points={{81,110},{100,110}},
                                                  color={127,0,0}));
    connect(Supply.port_a,sensor_T_S_in. port) annotation (Line(points={{-30,50},{
            -70,50},{-70,34}},                   color={0,127,255}));
    connect(Supply.port_a,sensor_p_S_in. port)
      annotation (Line(points={{-30,50},{-40,50},{-40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_p_S_out. port)
      annotation (Line(points={{30,50},{40,50},{40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_T_S_out. port) annotation (Line(points={{30,50},{
            70,50},{70,30}},                 color={0,127,255}));
    connect(S_res.port_b, S_convection_constantArea_2DCyl.port_b)
      annotation (Line(points={{27,80},{59,80},{59,110}}, color={191,0,0}));
    connect(S_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{13,80},{0,80},{0,65}}, color={191,0,0}));
    connect(Supply.port_b, port_b_supply) annotation (Line(points={{30,50},{80,50},
            {80,60},{100,60}}, color={0,127,255}));
    connect(port_a_supply, Supply.port_a) annotation (Line(points={{-100,60},{-80,
            60},{-80,50},{-30,50}}, color={0,127,255}));
    connect(Return.port_a, sensor_T_R_in.port)
      annotation (Line(points={{30,-60},{40,-60},{40,-74}},  color={0,127,255}));
    connect(Return.port_a, sensor_p_R_in.port)
      annotation (Line(points={{30,-60},{80,-60},{80,-74}},  color={0,127,255}));
    connect(Return.port_b, sensor_p_R_out.port) annotation (Line(points={{-30,-60},
            {-80,-60},{-80,-74}},  color={0,127,255}));
    connect(Return.port_b, sensor_T_R_out.port) annotation (Line(points={{-30,-60},
            {-40,-60},{-40,-74}},  color={0,127,255}));
    connect(R_res.port_b, S_convection_constantArea_2DCyl1.port_b) annotation (
        Line(points={{23,-18},{55,-18}},                   color={191,0,0}));
    connect(R_res.port_a, Return.heatPorts[:, 1])
      annotation (Line(points={{9,-18},{0,-18},{0,-45}}, color={191,0,0}));
    connect(S_convection_constantArea_2DCyl1.port_a, R_boundary_conv.port)
      annotation (Line(points={{77,-18},{96,-18}}, color={127,0,0}));
    connect(Return.port_a, port_a_return) annotation (Line(points={{30,-60},{100,-60}},
                                 color={0,127,255}));
    connect(Return.port_b, port_b_return) annotation (Line(points={{-30,-60},{-100,
            -60}},            color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TwoWayTransport;

  model OneWayTransport
    extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data(L=L_supply, D=D_s,
        ith=th_i_supply));

   //---------------------------------------------------------
   //   Supply Nominal
   parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_supply=44 annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_supply=1e5
                                                          annotation(Dialog(group="Supply"));
   parameter SI.Thickness th_i_supply=0.1
                                  annotation(Dialog(group="Supply"));
   parameter SI.ThermalConductivity lambda_supply=0.08
                                               annotation(Dialog(group="Supply"));
   parameter SI.Temperature S_amb_T=300 "Ambient External Temperature on Supply Side" annotation(Dialog(group="Supply"));
   parameter SI.CoefficientOfHeatTransfer S_alpha=20 "External Convective Heat Transfer Coefficient on Supply Side" annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_supply=3e6
                                                          annotation(Dialog(group="Supply"));
   parameter Real K_supply=2.8 "Local Loss Coe"
                                               annotation(Dialog(group="Supply"));
   parameter SI.Length L_supply=500 "Supply Pipe Length"
                                                        annotation(Dialog(group="Supply"));
   parameter SI.Length U_dist_s=125 "Distance Between U Sections";
   parameter SI.Velocity v_supply=6 annotation(Dialog(group="Supply"));

   //  Supply Init
   parameter SI.AbsolutePressure S_p_a_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.AbsolutePressure S_p_b_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter Boolean S_use_T_start=false;
   parameter SI.Temperature S_T_a_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.Temperature S_T_b_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_a_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_b_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_a_start=nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_b_start=-nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));



   final parameter SI.Diameter D_s(fixed=false)=0.51;
   final parameter Integer nU_s(fixed=false)=1;
   final parameter Integer nSp_s(fixed=false)=1;
   final parameter Real [:] Ks_s(fixed=false)=fill(0,Supply_pipe_data.nV);
   final parameter Integer i_s(fixed=false)=1;
   final parameter Integer j_s(fixed=false)=1;
   final parameter Integer g_s(fixed=false)=1;
   final parameter SI.ThermalResistance S_R_val(fixed=false)=10 "Thermal resistance";



    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(
      redeclare package Medium = Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
          (Ks_ab=Ks_s, Ks_ba=Ks_s),
      use_HeatTransfer=true,
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration)
      annotation (Placement(transformation(extent={{-30,20},{30,80}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-50,30},{-30,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{30,30},{50,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-80,34},{-60,14}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{60,30},{80,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T)
      annotation (Placement(transformation(extent={{120,100},{100,120}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance S_res[
      Supply_pipe_data.nV](R_val=S_R_val)
      annotation (Placement(transformation(extent={{10,72},{30,92}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.ConvectionMediaSimple
      convection[Supply_pipe_data.nV](
      v=0,
      dimension=0,
      surfaceArea=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*
          Supply_pipe_data.ith)*Modelica.Constants.pi*Supply_pipe_data.L/
          Supply_pipe_data.nV,
      alpha=S_alpha)
      annotation (Placement(transformation(extent={{68,70},{88,90}})));
  initial algorithm
    nU_s:= integer( ceil(L_supply/U_dist_s));
    nSp_s:=integer(floor(Supply_pipe_data.nV/nU_s));
    i_s:=1;
    j_s:=1;
    g_s:=0;
    while i_s <Supply_pipe_data.nV+1 loop
      if j_s==nSp_s and g_s<nU_s then
        Ks_s[i_s]:=K_supply;
        j_s:=1;
        g_s:=g_s+1;
      else
        Ks_s[i_s]:=0;
        j_s:=j_s+1;
      end if;
      i_s:=i_s+1;
    end while;


  initial equation
    assert(Supply_pipe_data.nV>nU_s,"Not Enough Nodes (supply)",AssertionLevel.error);
    nominal_m_flow_supply=v_supply*Modelica.Constants.pi*(D_s^2)*0.25
                                            *Medium.density( Medium.setState_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default));
    //S_R_val=(D_s+2*th_i_supply)*ln((D_s+2*th_i_supply)/D_s)/lambda_supply;
     S_R_val=ln((D_s+2*th_i_supply)/D_s)/(2*Modelica.Constants.pi*lambda_supply*Supply_pipe_data.L/Supply_pipe_data.nV);
  equation

    connect(Supply.port_a,sensor_T_S_in. port) annotation (Line(points={{-30,50},
            {-70,50},{-70,34}},                  color={0,127,255}));
    connect(Supply.port_a,sensor_p_S_in. port)
      annotation (Line(points={{-30,50},{-40,50},{-40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_p_S_out. port)
      annotation (Line(points={{30,50},{40,50},{40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_T_S_out. port) annotation (Line(points={{30,50},
            {70,50},{70,30}},                color={0,127,255}));
    connect(S_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{13,82},{0,82},{0,65}}, color={191,0,0}));
    connect(Supply.port_b, port_b_supply) annotation (Line(points={{30,50},{80,
            50},{80,0},{100,0}},
                               color={0,127,255}));
    connect(port_a_supply, Supply.port_a) annotation (Line(points={{-100,0},{
            -80,0},{-80,50},{-30,50}},
                                    color={0,127,255}));
    connect(convection.port_a, S_res.port_b) annotation (Line(points={{71,80},{54,
            80},{54,82},{27,82}}, color={191,0,0}));
    connect(convection.port_b, S_boundary_conv.port) annotation (Line(points={{85,
            80},{94,80},{94,110},{100,110}}, color={191,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OneWayTransport;

  package data

    model pipe_data_1
      extends BaseClasses.Record_Data;
      import Modelica.Fluid.Types.Dynamics;
            //Geometery ---------------------------------------------------------
        parameter Modelica.Units.SI.Length L=100 "Supply Pipe Length" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Diameter D=0.25
                                                   "Inner Diameter Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Thickness ith=0.1  "Thickness Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Thickness pth=0.1  "Thickness Of Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Integer nV(min=2) =10  "Number Of Volume Nodes In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));
        parameter Modelica.Units.SI.Height dH=0 "Elevation Gain In Supply Pipe" annotation (Dialog(group="Supply Pipe Geometery"));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end pipe_data_1;
  end data;

  package BaseClasses
    partial model Partial_SubSystem

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable Partial_ControlSystem CS annotation (
          choicesAllMatching=true, Placement(transformation(extent={{-18,122},{
                -2,138}})));
      replaceable Partial_EventDriver ED annotation (
          choicesAllMatching=true, Placement(transformation(extent={{2,122},{18,
                138}})));

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus annotation (
          Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));

    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;
      extends TRANSFORM.Icons.BasesPackage;

    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput                           sensorBus annotation (
          Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      SignalSubBus_ActuatorInput actuatorBus annotation (
          Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus annotation (
          Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    model Partial_SubSystem_A
      extends Partial_SubSystem;
      replaceable BaseClasses.Record_Data Supply_pipe_data
        annotation (Placement(transformation(extent={{60,122},{76,138}})));
      replaceable BaseClasses.Record_Data Return_pipe_data
        annotation (Placement(transformation(extent={{82,122},{98,138}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_supply(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_supply(redeclare
          package Medium = Medium)
        annotation (Placement(transformation(extent={{90,50},{110,70}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_return(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_return(redeclare
          package Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation (choicesAllMatching=true);
      annotation (Icon(graphics={
            Rectangle(
              extent={{-90,20},{-84,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,30},{-36,46}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-36,20},{-30,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,54},{-82,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,22},{-82,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,46},{-82,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,40},{-82,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,34},{-82,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,28},{-82,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,22},{-36,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,28},{-36,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,34},{-36,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,40},{-36,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,46},{-36,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,54},{-36,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-30,20},{-24,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,30},{24,46}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{24,20},{30,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,54},{-22,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,22},{-22,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,46},{-22,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,40},{-22,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,34},{-22,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,28},{-22,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,22},{24,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,28},{24,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,34},{24,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,40},{24,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,46},{24,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,54},{24,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{30,20},{36,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,30},{84,46}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{84,20},{90,56}},
              lineColor={255,0,0},
              lineThickness=0.5,
              fillColor={255,102,105},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,54},{38,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,22},{38,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,46},{38,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,40},{38,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,34},{38,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,28},{38,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,22},{84,24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,28},{84,30}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,34},{84,36}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,40},{84,42}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,46},{84,48}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,54},{84,52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-90,-56},{-84,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,-46},{-36,-30}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-36,-56},{-30,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,-22},{-82,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-54},{-82,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-30},{-82,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-36},{-82,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-42},{-82,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-48},{-82,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-54},{-36,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-48},{-36,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-42},{-36,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-36},{-36,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-30},{-36,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-22},{-36,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-30,-56},{-24,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,-46},{24,-30}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{24,-56},{30,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,-22},{-22,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-54},{-22,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-30},{-22,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-36},{-22,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-42},{-22,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-48},{-22,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-54},{24,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-48},{24,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-42},{24,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-36},{24,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-30},{24,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-22},{24,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{30,-56},{36,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,-46},{84,-30}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{84,-56},{90,-20}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,-22},{38,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-54},{38,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-30},{38,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-36},{38,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-42},{38,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-48},{38,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-54},{84,-52}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-48},{84,-46}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-42},{84,-40}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-36},{84,-34}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-30},{84,-28}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-22},{84,-24}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
              Text(
              extent={{-100,-70},{100,-92}},
              textColor={0,0,0},
              textString="%name")}));
    end Partial_SubSystem_A;

    model Partial_SubSystem_B
      extends Partial_SubSystem;
      replaceable BaseClasses.Record_Data Supply_pipe_data
        annotation (Placement(transformation(extent={{60,122},{76,138}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_supply(redeclare package
          Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_supply(redeclare
          package Medium = Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
        annotation (choicesAllMatching=true);
      annotation (Icon(graphics={
            Rectangle(
              extent={{-90,-18},{-84,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,-8},{-36,8}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-36,-18},{-30,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-84,16},{-82,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-16},{-82,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,8},{-82,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,2},{-82,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-4},{-82,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-84,-10},{-82,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-16},{-36,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-10},{-36,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,-4},{-36,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,2},{-36,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,8},{-36,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-38,16},{-36,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-30,-18},{-24,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,-8},{24,8}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{24,-18},{30,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,16},{-22,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-16},{-22,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,8},{-22,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,2},{-22,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-4},{-22,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{-24,-10},{-22,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-16},{24,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-10},{24,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,-4},{24,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,2},{24,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,8},{24,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{22,16},{24,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{30,-18},{36,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,-8},{84,8}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{84,-18},{90,18}},
              lineColor={0,140,72},
              lineThickness=0.5,
              fillColor={0,255,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{36,16},{38,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-16},{38,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,8},{38,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,2},{38,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-4},{38,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{36,-10},{38,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-16},{84,-14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-10},{84,-8}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,-4},{84,-2}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,2},{84,4}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,8},{84,10}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{82,16},{84,14}},
              lineColor={175,175,175},
              lineThickness=0.5,
              fillColor={175,175,175},
              fillPattern=FillPattern.HorizontalCylinder),
              Text(
              extent={{-100,-70},{100,-92}},
              textColor={0,0,0},
              textString="%name")}));
    end Partial_SubSystem_B;
  end BaseClasses;

  package ControlSystems
    model CS_Dummy

      extends BaseClasses.Partial_ControlSystem;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_Dummy;

    model ED_Dummy

      extends
        NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Partial_EventDriver;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end ED_Dummy;
  end ControlSystems;

  model OneWayTransportold
    extends BaseClasses.Partial_SubSystem_B(
      redeclare replaceable ControlSystems.CS_Dummy CS,
      redeclare replaceable ControlSystems.ED_Dummy ED,
      redeclare replaceable data.pipe_data_1 Supply_pipe_data(L=L_supply, D=D_s,
        ith=th_i_supply));

   //---------------------------------------------------------
   //   Supply Nominal
   parameter Modelica.Units.SI.MassFlowRate nominal_m_flow_supply=44 annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.AbsolutePressure nominal_P_sink_supply=1e5
                                                          annotation(Dialog(group="Supply"));
   parameter SI.Thickness th_i_supply=0.1
                                  annotation(Dialog(group="Supply"));
   parameter SI.ThermalConductivity lambda_supply=0.08
                                               annotation(Dialog(group="Supply"));
   parameter SI.Temperature S_amb_T=300 "Ambient External Temperature on Supply Side" annotation(Dialog(group="Supply"));
   parameter SI.CoefficientOfHeatTransfer S_alpha=20 "External Convective Heat Transfer Coefficient on Supply Side" annotation(Dialog(group="Supply"));
   parameter Modelica.Units.SI.SpecificEnthalpy nominal_h_sink_supply=3e6
                                                          annotation(Dialog(group="Supply"));
   parameter Real K_supply=2.8 "Local Loss Coe"
                                               annotation(Dialog(group="Supply"));
   parameter SI.Length L_supply=500 "Supply Pipe Length"
                                                        annotation(Dialog(group="Supply"));
   parameter SI.Length U_dist_s=125 "Distance Between U Sections";
   parameter SI.Velocity v_supply=6 annotation(Dialog(group="Supply"));

   //  Supply Init
   parameter SI.AbsolutePressure S_p_a_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.AbsolutePressure S_p_b_start=nominal_P_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter Boolean S_use_T_start=false;
   parameter SI.Temperature S_T_a_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.Temperature S_T_b_start=Medium.temperature_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default) annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_a_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.SpecificEnthalpy S_h_b_start=nominal_h_sink_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_a_start=nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));
   parameter SI.MassFlowRate S_m_flow_b_start=-nominal_m_flow_supply annotation(Dialog(tab="Initialization",group="Supply"));

   final parameter SI.Diameter D_s(fixed=false)=0.51;
   final parameter Integer nU_s(fixed=false)=1;
   final parameter Integer nSp_s(fixed=false)=1;
   final parameter Real [:] Ks_s(fixed=false)=fill(0,Supply_pipe_data.nV);
   final parameter Integer i_s(fixed=false)=1;
   final parameter Integer j_s(fixed=false)=1;
   final parameter Integer g_s(fixed=false)=1;
   final parameter SI.ThermalResistance S_R_val(fixed=false)=10 "Thermal resistance";

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Supply(
      redeclare package Medium = Medium,
      use_Ts_start=S_use_T_start,
      p_a_start=S_p_a_start,
      p_b_start=S_p_b_start,
      T_a_start=S_T_a_start,
      T_b_start=S_T_b_start,
      h_a_start=S_h_a_start,
      h_b_start=S_h_b_start,
      m_flow_a_start=S_m_flow_a_start,
      m_flow_b_start=S_m_flow_b_start,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=Supply_pipe_data.D,
          length=Supply_pipe_data.L,
          dheight=Supply_pipe_data.dH,
          nV=Supply_pipe_data.nV),
      redeclare model FlowModel =
          TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple
          (Ks_ab=Ks_s, Ks_ba=Ks_s),
      use_HeatTransfer=true)
      annotation (Placement(transformation(extent={{-30,20},{30,80}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-50,30},{-30,10}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{30,30},{50,10}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_in(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{-80,34},{-60,14}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_S_out(redeclare package Medium =
          Medium,   precision=2)
      annotation (Placement(transformation(extent={{60,30},{80,10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature S_boundary_conv[
      Supply_pipe_data.nV](T=S_amb_T)
      annotation (Placement(transformation(extent={{120,100},{100,120}})));
    TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.BoundaryConditions.Convection_constantArea_2DCyl
      S_convection_constantArea_2DCyl(
      nNodes=Supply_pipe_data.nV,
      r_outer=(Supply_pipe_data.D + 2*Supply_pipe_data.pth + 2*Supply_pipe_data.ith)
          /2,
      length=Supply_pipe_data.L,
      alphas=S_alpha*ones(Supply_pipe_data.nV))
      annotation (Placement(transformation(extent={{80,100},{60,120}})));

    TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Specified_Resistance S_res[
      Supply_pipe_data.nV](R_val=S_R_val)
      annotation (Placement(transformation(extent={{10,72},{30,92}})));

  initial algorithm
    nU_s:= integer( ceil(L_supply/U_dist_s));
    nSp_s:=integer(floor(Supply_pipe_data.nV/nU_s));
    i_s:=1;
    j_s:=1;
    g_s:=0;
    while i_s <Supply_pipe_data.nV+1 loop
      if j_s==nSp_s and g_s<nU_s then
        Ks_s[i_s]:=K_supply;
        j_s:=1;
        g_s:=g_s+1;
      else
        Ks_s[i_s]:=0;
        j_s:=j_s+1;
      end if;
      i_s:=i_s+1;
    end while;

  initial equation
    assert(Supply_pipe_data.nV>nU_s,"Not Enough Nodes (supply)",AssertionLevel.error);
    nominal_m_flow_supply=v_supply*Modelica.Constants.pi*(D_s^2)*0.25
                                            *Medium.density( Medium.setState_phX(nominal_P_sink_supply,nominal_h_sink_supply,Medium.X_default));
    S_R_val=(D_s+2*th_i_supply)*ln((D_s+2*th_i_supply)/D_s)/lambda_supply;

  equation

    connect(S_convection_constantArea_2DCyl.port_a,S_boundary_conv. port)
      annotation (Line(points={{81,110},{100,110}},
                                                  color={127,0,0}));
    connect(Supply.port_a,sensor_T_S_in. port) annotation (Line(points={{-30,50},{
            -70,50},{-70,34}},                   color={0,127,255}));
    connect(Supply.port_a,sensor_p_S_in. port)
      annotation (Line(points={{-30,50},{-40,50},{-40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_p_S_out. port)
      annotation (Line(points={{30,50},{40,50},{40,30}}, color={0,127,255}));
    connect(Supply.port_b,sensor_T_S_out. port) annotation (Line(points={{30,50},{
            70,50},{70,30}},                 color={0,127,255}));
    connect(S_res.port_a, Supply.heatPorts[:, 1])
      annotation (Line(points={{13,82},{0,82},{0,65}}, color={191,0,0}));
    connect(Supply.port_b, port_b_supply) annotation (Line(points={{30,50},{80,50},
            {80,0},{100,0}},   color={0,127,255}));
    connect(port_a_supply, Supply.port_a) annotation (Line(points={{-100,0},{-80,0},
            {-80,50},{-30,50}},     color={0,127,255}));
    connect(S_convection_constantArea_2DCyl.port_b, S_res.port_b)
      annotation (Line(points={{59,110},{59,82},{27,82}}, color={127,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end OneWayTransportold;
  annotation (            Icon(graphics={
        Rectangle(
          extent={{-70,-30},{30,40}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{-60,-40},{-40,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{30,-30},{72,-30},{72,-2},{50,24},{38,24},{30,24},{30,24},{30,
              -30}},
          lineColor={0,0,0},
          fillColor={145,145,145},
          fillPattern=FillPattern.Solid,
          lineThickness=1),
        Ellipse(
          extent={{40,-40},{60,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{44,20},{44,-2},{66,-2}},
          color={0,0,0},
          thickness=1),          Bitmap(extent={{-70,-20},{28,34}},   fileName="modelica://NHES/Resources/Images/Systems/Fire.jpg")}));
end HeatTransport;
