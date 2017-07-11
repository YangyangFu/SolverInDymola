within NZW_final.BaseClasses.Components;
model Tank

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";
  parameter Modelica.SIunits.MassFlowRate mLifPumFloNominal= 64*3.78541/60 "Dorm flow rate";

  parameter Modelica.SIunits.Length tankThickness = 0.005 "Plastic tank thickness";

Modelica.Fluid.Vessels.OpenTank Tank(
    height=1,
    redeclare package Medium = MediumW,
    use_T_start=true,
    crossArea=4.15,
    use_HeatTransfer=true,
    nPorts=2,
    m_flow_small=0,
    m_flow_nominal=mLifPumFloNominal,
    use_portsData=true,
    level_start=0.60,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.05,
        height=0.03,
        zeta_out=0.5,
        zeta_in=1.04),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.05,
        height=0.03,
        zeta_out=0.5,
        zeta_in=1.04)},
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.ConstantHeatTransfer (
        k=0.5,
        T_ambient=293.15,
        alpha0=0.50),
    p_ambient=101325,
    T_ambient=293.15,
    T_start=306.65)
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TanTem_a(
    redeclare package Medium = MediumW,
    m_flow_nominal=mSepFloNominal,
    T_start=308.15)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TanTem_b(
    redeclare package Medium = MediumW,
    m_flow_nominal=mLifPumFloNominal,
    T_start=306.75) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-44,-50},{-24,-30}}),
        iconTransformation(extent={{-44,-50},{-24,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{24,-50},{44,-30}}),
        iconTransformation(extent={{24,-50},{44,-30}})));
equation
  connect(Tank.ports[1], TanTem_a.port_b)
    annotation (Line(points={{-4,20},{-4,0},{-20,0}}, color={0,127,255}));
  connect(Tank.ports[2], TanTem_b.port_a)
    annotation (Line(points={{4,20},{2,20},{2,0},{20,0}}, color={0,127,255}));
  connect(port_b, port_b)
    annotation (Line(points={{34,-40},{36,-40},{34,-40}}, color={0,127,255}));
  connect(port_b, TanTem_b.port_b) annotation (Line(points={{34,-40},{34,-20},{
          50,-20},{50,0},{40,0}}, color={0,127,255}));
  connect(port_a, TanTem_a.port_a) annotation (Line(points={{-34,-40},{-34,-40},
          {-34,-20},{-50,-20},{-50,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false,
        extent={{-60,-40},{60,80}},
        initialScale=0.1),                                      graphics={
          Rectangle(
            extent={{-60,80},{60,-40}},
            lineColor={255,255,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.VerticalCylinder),
        Text(
          extent={{-42,12},{40,-12}},
          lineColor={0,0,0},
          textString="%Tank")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false,
        extent={{-60,-40},{60,80}},
        initialScale=0.1)));
end Tank;
