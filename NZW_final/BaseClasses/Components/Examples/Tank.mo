within NZW_final.BaseClasses.Components.Examples;
model Tank

  extends Modelica.Icons.Example;

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";
  parameter Modelica.SIunits.MassFlowRate mLifPumFloNominal= 64*3.78541/60 "Dorm flow rate";

  parameter Modelica.SIunits.Length tankThickness = 0.005 "Plastic tank thickness";

Modelica.Fluid.Vessels.OpenTank SepTan(
    height=1,
    redeclare package Medium = MediumW,
    use_T_start=true,
    use_portsData=false,
    portsData={Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.05,
        height=0.03,
        zeta_out=0.5,
        zeta_in=1.04),Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(
        diameter=0.05,
        height=0.03,
        zeta_out=0.5,
        zeta_in=1.04)},
    crossArea=4.15,
    level_start=0.49,
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.ConstantHeatTransfer (
        k=0.53,
        T_ambient=293.15,
        alpha0=0.19),
    use_HeatTransfer=true,
    p_ambient=101325,
    T_ambient=293.15,
    T_start=308.15,
    m_flow_nominal=mLifPumFloNominal,
    nPorts=1)
    annotation (Placement(transformation(extent={{20,20},{60,60}})));
  Buildings.Fluid.Sources.MassFlowSource_T dorFloSou(
    redeclare package Medium = MediumW,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=0.001,
    T=308.15) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(SepTan.ports[1],dorFloSou. ports[1]) annotation (Line(points={{40,20},
          {40,20},{40,0},{-40,0}},color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Tank;
