package TestCoolProp "Test case using CoolPropMedium"
  extends Modelica.Icons.ExamplesPackage;
  import SI = Modelica.SIunits;
  import ExternalMedia;

  model CheckState_pT
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;
    Medium.ThermodynamicState state;
    Modelica.Blocks.Interfaces.RealInput p
      annotation(
                 Placement(visible = true, transformation(origin = {-100, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealInput T
      annotation(
                 Placement(visible = true, transformation(origin = {-100, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput h
      annotation(
                 Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput s
      annotation(
                 Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    state = Medium.setState_pTX(p, T, Medium.reference_X);
    h = Medium.specificEnthalpy(state);
    s = Medium.specificEntropy(state);

    annotation(
      Icon(graphics = {Rectangle(extent = {{-100, -100}, {100, 100}})}));
  end CheckState_pT;

  model TestHydrogen
    extends Modelica.Icons.Example;

    package Hydrogen = ExternalMedia.Media.CoolPropMedium(mediumName = "Hydrogen", substanceNames = {"H2"});

    Modelica.Blocks.Sources.Ramp pressure(duration = 1, height = 0, offset = 101325, startTime = 0)
      annotation(
                 Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    Modelica.Blocks.Sources.Ramp temperature(duration = 1, height = 0, offset = 20, startTime = 0)
      annotation(
                 Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    CheckState_pT checkStateHydrogen(redeclare package Medium = Hydrogen)
      annotation(
                 Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

    SI.Pressure p "Pressure";
    SI.Temperature T "Temperature";
    SI.SpecificEnthalpy h "Specific enthalpy";
    SI.SpecificEntropy s "Specific entropy";
  equation
    connect(pressure.y, checkStateHydrogen.p) annotation(
      Line(points = {{-30, 20}, {-20, 20}, {-20, 5}, {-10, 5}}));
    connect(temperature.y, checkStateHydrogen.T) annotation(
      Line(points = {{-30, -20}, {-20, -20}, {-20, -5}, {-10, -5}}));
    p = pressure.y;
    T = temperature.y;
    h = checkStateHydrogen.h;
    s = checkStateHydrogen.s;
  end TestHydrogen;

end TestCoolProp;
