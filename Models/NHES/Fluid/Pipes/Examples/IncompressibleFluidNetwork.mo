within NHES.Fluid.Pipes.Examples;
model IncompressibleFluidNetwork
  "Multi-way connections of pipes and incompressible medium model"
  extends Modelica.Icons.Example;

  parameter Modelica.Fluid.Types.ModelStructure pipeModelStructure=Modelica.Fluid.Types.ModelStructure.av_vb;
  //parameter Types.ModelStructure pipeModelStructure = Modelica.Fluid.Types.ModelStructure.a_v_b;

  replaceable package Medium =
      Modelica.Media.Incompressible.Examples.Glycol47
    constrainedby Modelica.Media.Interfaces.PartialMedium;

  //replaceable package Medium =
  //    Modelica.Media.Water.StandardWaterOnePhase
  //  constrainedby Modelica.Media.Interfaces.PartialMedium;

  import Modelica.Fluid.Types.Dynamics;
  parameter Dynamics systemMassDynamics = if Medium.singleState then Dynamics.SteadyState else Dynamics.SteadyStateInitial;
  parameter Boolean filteredValveOpening = not Medium.singleState;

  Modelica.Fluid.Sources.Boundary_pT source(
    nPorts=1,
    redeclare package Medium = Medium,
    p=5.0e5,
    T=300) annotation (Placement(transformation(extent={{-98,-6},{-86,6}},
          rotation=0)));
  StraightPipe                              pipe1(
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=0)));

  StraightPipe                              pipe2(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=0.5,
    modelStructure=pipeModelStructure,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(
        origin={-50,20},
        extent={{-10,-10},{10,10}},
        rotation=90)));

  StraightPipe                              pipe3(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=0.5,
    modelStructure=pipeModelStructure,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(
        origin={-50,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  StraightPipe                              pipe4(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=2,
    modelStructure=pipeModelStructure,
    use_HeatTransfer=true,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}}, rotation=0)));
  StraightPipe                              pipe6(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=20,
    modelStructure=pipeModelStructure,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    rho_nominal=1000,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=2.5e-2^2/4*Modelica.Constants.pi,
    dp_nominal=30000) annotation (Placement(transformation(extent={{-46,30},{-26,
            50}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    rho_nominal=1000,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=2.5e-2^2/4*Modelica.Constants.pi,
    dp_nominal=30000) annotation (Placement(transformation(extent={{-46,-30},{-26,
            -50}}, rotation=0)));
  StraightPipe                              pipe7(
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    use_HeatTransfer=true,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{-20,30},{0,50}}, rotation=0)));
  Modelica.Fluid.Valves.ValveIncompressible valve3(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    rho_nominal=1000,
    CvData=Modelica.Fluid.Types.CvTypes.Av,
    Av=2.5e-2^2/4*Modelica.Constants.pi,
    dp_nominal=30000) annotation (Placement(transformation(extent={{80,0},{100,20}},
          rotation=0)));
  Modelica.Fluid.Sources.Boundary_pT sink(
    nPorts=1,
    redeclare package Medium = Medium,
    T=300,
    p=1.0e5) annotation (Placement(transformation(extent={{118,4},{106,16}},
          rotation=0)));
  inner Modelica.Fluid.System system(
      massDynamics=systemMassDynamics, energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    use_eps_Re=true)    annotation (Placement(transformation(extent={{90,-92},{
            110,-72}},  rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening1(
    offset=1,
    startTime=50,
    height=-1)   annotation (Placement(transformation(extent={{-80,80},{-60,60}},
                   rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening2(
    offset=1,
    height=-0.5,
    startTime=100)
                 annotation (Placement(transformation(extent={{-80,-60},{-60,
            -80}}, rotation=0)));
  Modelica.Blocks.Sources.Step valveOpening3(
    offset=1,
    startTime=150,
    height=-0.5) annotation (Placement(transformation(extent={{60,80},{80,60}},
          rotation=0)));
  StraightPipe                              pipe8(
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    use_HeatTransfer=true,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow,
    redeclare model HeatTransfer =
        BaseClasses.HeatTransfer.IdealFlowHeatTransfer)
    annotation (Placement(transformation(
        origin={10,10},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  StraightPipe                              pipe9(
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    use_HeatTransfer=true,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{20,30},{40,50}}, rotation=0)));
  StraightPipe                              pipe10(
    length=10,
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    use_HeatTransfer=true,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}}, rotation=0)));
  StraightPipe                              pipe5(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    length=20,
    modelStructure=pipeModelStructure,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow[pipe8.nV] heat8(Q_flow=
        16e3*pipe8.dxs)
    annotation (Placement(transformation(extent={{-20,0},{0,20}}, rotation=0)));
  StraightPipe                              pipe11(
    diameter=2.5e-2,
    redeclare package Medium = Medium,
    modelStructure=pipeModelStructure,
    length=0.5,
    redeclare model FlowModel = BaseClasses.FlowModels.DetailedPipeFlow)
    annotation (Placement(transformation(extent={{54,0},{74,20}}, rotation=0)));
equation
  connect(source.ports[1], pipe1.port_a) annotation (Line(points={{-86,0},{-80,
          0}},  color={0,127,255}));
  connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-60,0},{-50,0},
          {-50,-10}},    color={0,127,255}));
  connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{-60,0},{-50,0},
          {-50,10}},     color={0,127,255}));
  connect(pipe2.port_b, valve1.port_a) annotation (Line(points={{-50,30},{-50,
          40},{-46,40}}, color={0,127,255}));
  connect(valve2.port_b, pipe4.port_a) annotation (Line(points={{-26,-40},{-26,
          -40},{-20,-40}},
                 color={0,127,255}));
  connect(pipe3.port_b, valve2.port_a) annotation (Line(points={{-50,-30},{-50,
          -40},{-46,-40}},     color={0,127,255}));
  connect(valve1.port_b, pipe7.port_a) annotation (Line(points={{-26,40},{-26,
          40},{-20,40}},
                color={0,127,255}));
  connect(valve3.port_b, sink.ports[1]) annotation (Line(points={{100,10},{100,
          10},{106,10}},
        color={0,127,255}));
  connect(valveOpening1.y, valve1.opening) annotation (Line(points={{-59,70},{
          -36,70},{-36,48}},        color={0,0,127}));
  connect(valveOpening2.y, valve2.opening) annotation (Line(points={{-59,-70},{
          -36,-70},{-36,-48}},         color={0,0,127}));
  connect(valveOpening3.y, valve3.opening) annotation (Line(points={{81,70},{90,
          70},{90,18}},           color={0,0,127}));
  connect(pipe7.port_b, pipe9.port_a)
    annotation (Line(points={{0,40},{0,40},{20,40}},
                                              color={0,127,255}));
  connect(pipe7.port_b, pipe8.port_a) annotation (Line(points={{0,40},{10,40},{
          10,20}}, color={0,127,255}));
  connect(pipe8.port_b, pipe10.port_a) annotation (Line(points={{10,0},{10,-20},
          {20,-20}},
                   color={0,127,255}));
  connect(pipe4.port_b, pipe6.port_a) annotation (Line(
      points={{0,-40},{20,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe8.port_b, pipe4.port_b) annotation (Line(
      points={{10,0},{10,-40},{0,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe5.port_a, pipe4.port_b) annotation (Line(
      points={{20,-60},{10,-60},{10,-40},{0,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heat8.port, pipe8.heatPorts) annotation (Line(
      points={{0,10},{6,10},{6,9.9},{5.6,9.9}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pipe5.port_b, pipe6.port_b) annotation (Line(
      points={{40,-60},{50,-60},{50,-40},{40,-40}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe6.port_b, pipe10.port_b) annotation (Line(
      points={{40,-40},{50,-40},{50,-20},{40,-20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe11.port_b, valve3.port_a) annotation (Line(
      points={{74,10},{80,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe9.port_b, pipe11.port_a) annotation (Line(
      points={{40,40},{50,40},{50,10},{54,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(pipe10.port_b, pipe11.port_a) annotation (Line(
      points={{40,-20},{50,-20},{50,10},{54,10}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (         Documentation(info="<html>
<p>
This example demonstrates two aspects: the treatment of multi-way connections
and the usage of an incompressible medium model.
</p><p>
Eleven pipe models with nV=2 each introduce 22 temperature states and and 22 pressure states.
When configuring <b>pipeModelStructure=a_v_b</b>, the flow models at the pipe ports constitute algebraic loops for the pressures.
A common work-around is to introduce \"mixing volumes\" in critical connections.
</p><p>
Here the problem is treated alternatively with the default <b>pipeModelStructure=av_vb</b> of the
<a href=\"modelica://Fluid.Pipes.StraightDynamicPipe\">DynamicPipe</a> model.
Each pipe exposes the states of the outer fluid segments to the respective fluid ports.
Consequently the pressures of all connected pipe segments get lumped together into one mass balance spanning the whole connection set.
Overall this treatment as high-index DAE results in the reduction to 9 pressure states, preventing algebraic loops in connections.
This can be studied with a rigorous medium model like <b>StandardWaterOnePhase</b>.
</p><p>
The pressure dynamics completely disappears with an incompressible medium model, like the used <b>Glycol47</b>.
It appears reasonable to assume steady-state mass balances in this case
(see parameter systemMassDynamics used in system.massDynamics, tab Assumptions).
</p><p>
Note that with the stream concept in the fluid ports, the energy and substance balances of the connected pipe segments remain independent
from each other, despite of pressures being lumped together. The following simulation results can be observed:
</p>
<ol>
<li>The simulation starts with system.T_ambient as initial temperature in all pipes.
    The temperatures upstream or bypassing pipe8 are approaching the value of 26.85 degC from the source, including also pipe9.
    The temperatures downstream of pipe8 take a higher value, depending on the mixing with heated fluid, see e.g. pipe10.</li>
<li>After 50s valve1 fully closes. This causes flow reversal in pipe8. Now heated fluid flows from pipe8 to pipe9.
    Note that the temperature of the connected pipe7 remains unchanged as there is no flow into pipe7.
    The temperature of pipe10 cools down to the source temperature.</li>
<li>After 100s valve2 closes half way, which affects mass flow rates and temperatures.</li>
<li>After 150s valve5 closes half way, which affects mass flow rates and temperatures.</li>
</ol>
<p>
The fluid temperatures in the pipes of interest are exposed through heatPorts.
</p>
<img src=\"modelica://Modelica/Resources/Images/Fluid/Examples/IncompressibleFluidNetwork.png\" border=\"1\"
     alt=\"IncompressibleFluidNetwork.png\">
</html>"),
    experiment(StopTime=200),
    __Dymola_Commands(file=
          "modelica://Modelica/Resources/Scripts/Dymola/Fluid/IncompressibleFluidNetwork/plotResults.mos"
        "plotResults"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            100}})));
end IncompressibleFluidNetwork;
