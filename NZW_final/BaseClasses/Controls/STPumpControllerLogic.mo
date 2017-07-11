within NZW_final.BaseClasses.Controls;
model STPumpControllerLogic

  extends Modelica.Blocks.Icons.Block;

  Modelica.StateGraph.InitialStepWithSignal off
    annotation (Placement(transformation(extent={{-70,-4},{-50,16}})));
  Modelica.StateGraph.StepWithSignal on
    annotation (Placement(transformation(extent={{12,-4},{32,16}})));
  Modelica.StateGraph.Transition offToOn(condition=histOut == true and offTime
         >= 3600*3)
    annotation (Placement(transformation(extent={{-28,16},{-8,36}})));
  Modelica.StateGraph.Transition onToOff(condition=onTime >= 47)
    annotation (Placement(transformation(extent={{-10,-44},{-30,-24}})));
  Modelica.Blocks.Math.MultiSwitch multiSwitch1(nu=2, expr={0,1})
    annotation (Placement(transformation(extent={{54,-24},{94,-4}})));
  Modelica.Blocks.Interfaces.RealInput onTime "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput offTime "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-66},{-100,-26}})));
  Modelica.Blocks.Interfaces.BooleanInput histOut
    "Connector of Boolean input signal"
    annotation (Placement(transformation(extent={{-140,24},{-100,64}})));
  Modelica.Blocks.Interfaces.RealOutput y "Output depending on expression"
    annotation (Placement(transformation(extent={{100,-24},{120,-4}})));
equation
  connect(on.outPort[1],onToOff. inPort) annotation (Line(points={{32.5,6},{40,
          6},{40,-34},{-16,-34}},  color={0,0,0}));
  connect(onToOff.outPort,off. inPort[1]) annotation (Line(points={{-21.5,-34},
          {-21.5,-34},{-80,-34},{-80,6},{-71,6}},   color={0,0,0}));
  connect(offToOn.outPort,on. inPort[1]) annotation (Line(points={{-16.5,26},{0,
          26},{0,6},{11,6}},   color={0,0,0}));
  connect(multiSwitch1.y,y)
    annotation (Line(points={{95,-14},{110,-14}},
                                              color={0,0,127}));
  connect(y,y)  annotation (Line(points={{110,-14},{110,-14}},
                                                           color={0,0,127}));
  connect(off.active,multiSwitch1. u[1]) annotation (Line(points={{-60,-5},{-60,
          -5},{-60,-12.5},{54,-12.5}},
                                  color={255,0,255}));
  connect(on.active,multiSwitch1. u[2])
    annotation (Line(points={{22,-5},{22,-15.5},{54,-15.5}},
                                                          color={255,0,255}));
  connect(off.outPort[1],offToOn. inPort) annotation (Line(points={{-49.5,6},{
          -44,6},{-40,6},{-40,26},{-22,26}},   color={0,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end STPumpControllerLogic;
