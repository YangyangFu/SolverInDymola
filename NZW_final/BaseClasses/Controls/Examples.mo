within NZW_final.BaseClasses.Controls;
package Examples

  extends Modelica.Icons.ExamplesPackage;

  model STPumpController
    import NZW_final;

    extends Modelica.Icons.Example;

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
      level_start=0.49,
      redeclare model HeatTransfer =
          Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.ConstantHeatTransfer
          (
          k=0.53,
          T_ambient=293.15,
          alpha0=0.19),
      use_HeatTransfer=true,
      p_ambient=101325,
      T_ambient=293.15,
      T_start=308.15,
      m_flow_nominal=mLifPumFloNominal,
      nPorts=2)
      annotation (Placement(transformation(extent={{14,52},{54,92}})));
    Buildings.Fluid.Sources.MassFlowSource_T floSou(
      redeclare package Medium = MediumW,
      use_m_flow_in=false,
      nPorts=1,
      m_flow=0.01,
      T=308.15) annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Buildings.Fluid.Movers.FlowControlled_m_flow SepTanPum(redeclare package
        Medium =
          MediumW, m_flow_nominal=mLifPumFloNominal)
                                                    annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=-90,
          origin={40,0})));
    Buildings.Fluid.Sources.FixedBoundary bou(redeclare package Medium = MediumW,
      nPorts=1,
      p=101325)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,-60})));
    NZW_final.BaseClasses.Controls.STPumpController sTPumpController
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Blocks.Math.Gain gain(k=mLifPumFloNominal)
      annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
    Modelica.Blocks.Sources.RealExpression SepTanLev(y=SepTan.level)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  equation
    connect(floSou.ports[1],SepTan. ports[1]) annotation (Line(points={{-40,40},
            {-40,40},{30,40},{30,52}},
                                  color={0,127,255}));
    connect(bou.ports[1],SepTanPum. port_b)
      annotation (Line(points={{40,-50},{40,-50},{40,-10}}, color={0,127,255}));
    connect(SepTanPum.port_a, SepTan.ports[2])
      annotation (Line(points={{40,10},{40,52},{38,52}}, color={0,127,255}));
    connect(gain.y, SepTanPum.m_flow_in)
      annotation (Line(points={{17,0},{28,0},{28,0.2}}, color={0,0,127}));
    connect(gain.u, sTPumpController.y)
      annotation (Line(points={{-6,0},{-19,0},{-19,0}}, color={0,0,127}));
    connect(SepTanLev.y, sTPumpController.ST_level)
      annotation (Line(points={{-59,0},{-50.5,0},{-42,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end STPumpController;
end Examples;
