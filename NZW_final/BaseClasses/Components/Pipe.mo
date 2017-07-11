within NZW_final.BaseClasses.Components;
model Pipe

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";

  parameter Modelica.SIunits.Length pipeThickness = 0.005 "PVC pipe thickness";

  Buildings.Fluid.FixedResistances.Pipe Pipe(
    redeclare package Medium = MediumW,
    thicknessIns=pipeThickness,
    m_flow_nominal=mSepFloNominal,
    length=10,
    lambdaIns=0.19,
    T_start=308.15,
    diameter=0.025)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort PipTem_a(
    redeclare package Medium = MediumW,
    m_flow_nominal=mSepFloNominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature TOut(T(displayUnit="K")=
         273.15 + 20)
    "Outside Temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,70})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=0.19)
           annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,30})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
equation
  connect(PipTem_a.port_b, Pipe.port_a)
    annotation (Line(points={{-10,0},{10,0}}, color={0,127,255}));
  connect(thermalConductor.port_b,TOut. port)
    annotation (Line(points={{20,40},{20,40},{20,60}},  color={191,0,0}));
  connect(thermalConductor.port_a, Pipe.heatPort)
    annotation (Line(points={{20,20},{20,5}}, color={191,0,0}));
  connect(PipTem_a.port_a, port_a)
    annotation (Line(points={{-30,0},{-30,0},{-100,0}}, color={0,127,255}));
  connect(Pipe.port_b, port_b)
    annotation (Line(points={{30,0},{100,0}},        color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, initialScale=0.1),
                                                                graphics={
        Rectangle(
          extent={{-100,66},{100,-64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,56},{100,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={217,236,255}),
        Text(
          extent={{-42,12},{40,-12}},
          lineColor={0,0,0},
          textString="%Pipe With
Heat Transfer")}),                                               Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-100,-50},{100,100}},
        initialScale=0.1)));
end Pipe;
