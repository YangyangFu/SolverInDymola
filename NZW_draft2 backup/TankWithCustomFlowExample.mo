within NZW_draft2;
model TankWithCustomFlowExample

  extends Modelica.Icons.ExamplesPackage;

  replaceable package MediumW = Buildings.Media.Water "Medium water";

  parameter Modelica.SIunits.MassFlowRate mSepFloNominal= 0.5 "Dorm flow rate";
  parameter Modelica.SIunits.MassFlowRate mLifPumFloNominal= 64*3.78541/60 "Dorm flow rate";

  parameter Modelica.SIunits.Length tankThickness = 0.001 "Plastic tank thickness";

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
    redeclare model HeatTransfer =
        Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.ConstantHeatTransfer (
        k=0.53,
        T_ambient=293.15,
        alpha0=0.19),
    use_HeatTransfer=true,
    m_flow_nominal=mLifPumFloNominal,
    nPorts=1,
    p_ambient=101325,
    T_ambient=293.15,
    level_start=0.01,
    T_start=308.15)
    annotation (Placement(transformation(extent={{20,22},{60,62}})));
  Modelica.Blocks.Sources.CombiTimeTable DorFlo(tableOnFile=false, table=[0,0;
        95000,0; 100000,0.1; 105000,0; 395000,0; 400000,0.2; 405000,0; 795000,0;
        800000,0.08; 805000,0; 864000,0])
    annotation (Placement(transformation(extent={{-60,-2},{-40,18}})));
  Buildings.Fluid.Sources.MassFlowSource_T dorFloSou(
    use_m_flow_in=true,
    redeclare package Medium = MediumW,
    nPorts=1,
    T=308.15) annotation (Placement(transformation(extent={{-2,-10},{18,10}})));
  Modelica.Blocks.Sources.CombiTimeTable DorFlo1(
                                                tableOnFile=false, table=[0,0;
        60000,0; 100000,0.01; 160000,0; 360000,0; 400000,0.02; 460000,0; 660000,
        0; 700000,0.01; 760000,0; 864000,0])
    annotation (Placement(transformation(extent={{-60,-46},{-40,-26}})));
equation
  connect(SepTan.ports[1], dorFloSou.ports[1]) annotation (Line(points={{40,22},
          {40,22},{40,0},{18,0}}, color={0,127,255}));
  connect(DorFlo1.y[1], dorFloSou.m_flow_in) annotation (Line(points={{-39,-36},
          {-20,-36},{-20,8},{-2,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TankWithCustomFlowExample;
