within NZW_draft2;
block STPumpControllerLogic
  Modelica.StateGraph.InitialStepWithSignal off
    annotation (Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.StateGraph.StepWithSignal on
    annotation (Placement(transformation(extent={{12,10},{32,30}})));
  Modelica.StateGraph.Transition offToOn(condition=histOut == true and offTime
         >= 3600*3)
    annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
  Modelica.StateGraph.Transition onToOff(condition=onTime >= 60)
    annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  Modelica.Blocks.Math.MultiSwitch multiSwitch1(nu=2, expr={0,1})
    annotation (Placement(transformation(extent={{54,-10},{94,10}})));
  Modelica.Blocks.Interfaces.RealInput onTime "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-6},{-100,34}})));
  Modelica.Blocks.Interfaces.RealInput offTime "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-52},{-100,-12}})));
  Modelica.Blocks.Interfaces.BooleanInput histOut
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,38},{-100,78}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  connect(on.outPort[1], onToOff.inPort) annotation (Line(points={{32.5,20},{40,
          20},{40,-20},{-16,-20}}, color={0,0,0}));
  connect(onToOff.outPort, off.inPort[1]) annotation (Line(points={{-21.5,-20},
          {-21.5,-20},{-80,-20},{-80,20},{-71,20}}, color={0,0,0}));
  connect(offToOn.outPort, on.inPort[1]) annotation (Line(points={{-16.5,40},{0,
          40},{0,20},{11,20}}, color={0,0,0}));
  connect(multiSwitch1.y, y)
    annotation (Line(points={{95,0},{110,0}}, color={0,0,127}));
  connect(y, y) annotation (Line(points={{110,0},{110,0}}, color={0,0,127}));
  connect(off.active, multiSwitch1.u[1]) annotation (Line(points={{-60,9},{-60,
          9},{-60,1.5},{54,1.5}}, color={255,0,255}));
  connect(on.active, multiSwitch1.u[2])
    annotation (Line(points={{22,9},{22,-1.5},{54,-1.5}}, color={255,0,255}));
  connect(off.outPort[1], offToOn.inPort) annotation (Line(points={{-49.5,20},{
          -44,20},{-40,20},{-40,40},{-22,40}}, color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end STPumpControllerLogic;
