within NZW_final.System;
model SepticTank

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";
  parameter Modelica.SIunits.MassFlowRate mLifPumFloNominal= 64*3.78541/60 "Dorm flow rate";

  parameter Modelica.SIunits.Length pipeThickness = 0.005 "PVC pipe thickness";
  parameter Modelica.SIunits.Length tankThickness = 0.005 "Plastic tank thickness";

Buildings.Fluid.Movers.FlowControlled_m_flow sepTanPum(redeclare package Medium =
        MediumW, m_flow_nominal=mLifPumFloNominal)
                                                  annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={60,-30})));
  Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium = MediumW,
    nPorts=1,
    p=101325)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-60})));
  BaseClasses.Controls.STPumpController STPumpController
    "Septic Tank Pump Controller"
    annotation (Placement(transformation(extent={{-30,-40},{-10,-20}})));
  Modelica.Blocks.Math.Gain gain(k=mLifPumFloNominal)
    annotation (Placement(transformation(extent={{12,-40},{32,-20}})));
  Modelica.Blocks.Sources.RealExpression SepTanLev(y=SepTan.Tank.level)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  BaseClasses.Components.Tank SepTan "Septic Tank"
    annotation (Placement(transformation(extent={{44,6},{64,26}})));
  BaseClasses.Components.Pipe pipe
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  BaseClasses.Components.DormFlow dormFlow
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(bou.ports[1],sepTanPum. port_b)
    annotation (Line(points={{60,-50},{60,-52},{60,-40}}, color={0,127,255}));
  connect(gain.y,sepTanPum. m_flow_in)
    annotation (Line(points={{33,-30},{48,-30},{48,-29.8}},
                                                      color={0,0,127}));
  connect(gain.u,STPumpController. y)
    annotation (Line(points={{10,-30},{10,-30},{-9,-30}},
                                              color={0,0,127}));
  connect(SepTanLev.y,STPumpController. ST_level)
    annotation (Line(points={{-39,-30},{-32,-30}},       color={0,0,127}));
  connect(SepTan.port_b, sepTanPum.port_a)
    annotation (Line(points={{59.6667,6},{60,6},{60,-20}}, color={0,127,255}));
  connect(pipe.port_a, dormFlow.port_b)
    annotation (Line(points={{0,0},{-20,0}}, color={0,127,255}));
  connect(SepTan.port_a, pipe.port_b) annotation (Line(points={{48.3333,6},{48,
          6},{48,0},{20,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Line(
          points={{-100,0},{-100,-20},{-100,-40},{-80,-60},{-60,-60},{60,-60},{80,
              -60},{100,-40},{100,-20},{100,20},{100,40},{80,60},{60,60},{-60,60},
              {-80,60},{-100,40},{-100,20},{-100,0}},
          color={28,108,200},
          smooth=Smooth.Bezier)}), Diagram(coordinateSystem(preserveAspectRatio=
           false)));
end SepticTank;
