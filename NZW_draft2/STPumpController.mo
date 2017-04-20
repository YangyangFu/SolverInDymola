within NZW_draft2;
block STPumpController
  import ST_pump_controller_logic;
  Modelica.Blocks.Interfaces.RealInput ST_level
    "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Controls.Continuous.OffTimer offTim
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Logical.Timer onTim
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
 Modelica.Blocks.Logical.Hysteresis hysPum(uLow=0.5, uHigh=0.9)
    "Pump hysteresis"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  STPumpControllerLogic sTPumpControllerLogic
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(realToBoolean.y,onTim. u) annotation (Line(points={{21,-40},{36,-40},
          {36,-20},{58,-20}},   color={255,0,255}));
  connect(realToBoolean.y,offTim. u) annotation (Line(points={{21,-40},{36,-40},
          {36,-60},{58,-60}},     color={255,0,255}));
  connect(ST_level, hysPum.u) annotation (Line(points={{-120,0},{-120,0},{-90,0},
          {-90,40},{-82,40}}, color={0,0,127}));
  connect(y, realToBoolean.u) annotation (Line(points={{110,0},{-10,0},{-10,-40},
          {-2,-40}}, color={0,0,127}));
  connect(sTPumpControllerLogic.y, realToBoolean.u) annotation (Line(points={{
          -19,0},{-10,0},{-10,-40},{-2,-40}}, color={0,0,127}));
  connect(hysPum.y, sTPumpControllerLogic.histOut) annotation (Line(points={{
          -59,40},{-50,40},{-50,5.8},{-42,5.8}}, color={255,0,255}));
  connect(sTPumpControllerLogic.offTime, offTim.y) annotation (Line(points={{
          -42,-3.2},{-50,-3.2},{-50,-80},{86,-80},{86,-60},{81,-60}}, color={0,
          0,127}));
  connect(onTim.y, sTPumpControllerLogic.onTime) annotation (Line(points={{81,
          -20},{88,-20},{92,-20},{92,-88},{-60,-88},{-60,1.4},{-42,1.4}}, color=
         {0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end STPumpController;
