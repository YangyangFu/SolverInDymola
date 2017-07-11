within NZW_final.BaseClasses.Components.Examples;
model Pipe
  import NZW_final;

  extends Modelica.Icons.Example;

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";
  parameter Modelica.SIunits.Length pipeThickness = 0.005 "PVC pipe thickness";

  NZW_final.BaseClasses.Components.Pipe pipe
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  NZW_final.BaseClasses.Components.DormFlow dormFlow
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium = MediumW,
    nPorts=1,
    p=101325)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-30})));
equation
  connect(dormFlow.port_b, pipe.port_a)
    annotation (Line(points={{-40,0},{-30,0},{-20,0}}, color={0,127,255}));
  connect(pipe.port_b, bou.ports[1]) annotation (Line(points={{0,0},{10,0},{20,
          0},{20,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=864000,
      Interval=1,
      __Dymola_fixedstepsize=1,
      __Dymola_Algorithm="Rkfix4"));
end Pipe;
