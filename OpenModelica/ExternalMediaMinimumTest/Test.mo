within ExternalMediaMinimumTest;
package Test
  extends Modelica.Icons.ExamplesPackage;
  import Media.TestMedium;

  // package ConstantMedium
  //   extends Media.TestMedium(fluidConstants = {constantFluidConstants});
  // constant FluidConstants constantFluidConstants = FluidConstants(
  //   iupacName = "unknown",
  //   casRegistryNumber = "unknown",
  //   chemicalFormula = "unknown",
  //   structureFormula = "unknown",
  //   molarMass = 2,
  //   criticalTemperature = 21,
  //   criticalPressure = 0,
  //   criticalMolarVolume = 0,
  //   acentricFactor = 0,
  //   triplePointTemperature = 280.0,
  //   triplePointPressure = 500.0,
  //   meltingPoint = 280,
  //   normalBoilingPoint = 380.0,
  //   dipoleMoment = 2.0);
  // end ConstantMedium;

  model TestConstants
    extends Modelica.Icons.Example;
    replaceable package Medium = Media.TestMedium;
    // replaceable package Medium = ConstantMedium;
    // SI.Pressure P = 101325.;
    // SI.Temperature Tc = 0;
    // SI.Temperature Tc = Medium.criticalTemperature(P);
    SI.Temperature Tc = Medium.fluidConstants[1].criticalTemperature;
    // SI.Temperature Tc = Medium.externalCriticalTemperature;
  end TestConstants;

end Test;
