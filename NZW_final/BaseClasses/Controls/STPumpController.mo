within NZW_final.BaseClasses.Controls;
model STPumpController

  extends Modelica.Blocks.Icons.Block;

  Buildings.Controls.Continuous.OffTimer offTim
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Logical.Timer onTim
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
 Modelica.Blocks.Logical.Hysteresis hysPum(          uHigh=0.9, uLow=0.60)
    "Pump hysteresis"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Interfaces.RealInput ST_level
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  STPumpControllerLogic sTPumpControllerLogic
    annotation (Placement(transformation(extent={{-40,-8},{-20,12}})));
equation
  connect(realToBoolean.y,onTim. u) annotation (Line(points={{21,-40},{36,-40},
          {36,-20},{58,-20}},   color={255,0,255}));
  connect(realToBoolean.y,offTim. u) annotation (Line(points={{21,-40},{36,-40},
          {36,-60},{58,-60}},     color={255,0,255}));
  connect(ST_level,hysPum. u) annotation (Line(points={{-120,0},{-120,0},{-90,0},
          {-90,40},{-82,40}}, color={0,0,127}));
  connect(y,realToBoolean. u) annotation (Line(points={{110,0},{-10,0},{-10,-40},
          {-2,-40}}, color={0,0,127}));
  connect(sTPumpControllerLogic.y, realToBoolean.u) annotation (Line(points={{
          -19,0.6},{-10,0.6},{-10,-40},{-2,-40}}, color={0,0,127}));
  connect(sTPumpControllerLogic.offTime, offTim.y) annotation (Line(points={{
          -42,-2.6},{-52,-2.6},{-52,-80},{84,-80},{84,-60},{81,-60}}, color={0,
          0,127}));
  connect(onTim.y, sTPumpControllerLogic.onTime) annotation (Line(points={{81,
          -20},{86,-20},{92,-20},{92,-88},{-60,-88},{-60,2},{-42,2}}, color={0,
          0,127}));
  connect(hysPum.y, sTPumpControllerLogic.histOut) annotation (Line(points={{
          -59,40},{-50,40},{-50,6.4},{-42,6.4}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end STPumpController;
