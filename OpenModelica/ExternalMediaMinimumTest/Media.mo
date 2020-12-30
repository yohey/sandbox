within ExternalMediaMinimumTest;
package Media
  extends Modelica.Icons.ExamplesPackage;

  package TestMedium
    extends Modelica.Media.Interfaces.PartialTwoPhaseMedium(
      singleState = false,
      onePhase = false,
      smoothModel = false,
      fluidConstants = {externalFluidConstants});

    // constant Real externalCriticalTemperature = getCriticalTemperature();
    // constant Real externalCriticalTemperature = 21;
    constant FluidConstants externalFluidConstants = FluidConstants(
      iupacName = "unknown",
      casRegistryNumber = "unknown",
      chemicalFormula = "unknown",
      structureFormula = "unknown",
      // molarMass = getMolarMass(),
      criticalTemperature = getCriticalTemperature(),
      // criticalPressure = getCriticalPressure(),
      // criticalMolarVolume = getCriticalMolarVolume(),
      // criticalTemperature = externalCriticalTemperature,
      molarMass = 2,
      // criticalTemperature = 21,
      criticalPressure = 0,
      criticalMolarVolume = 0,
      acentricFactor = 0,
      triplePointTemperature = 280.0,
      triplePointPressure = 500.0,
      meltingPoint = 280,
      normalBoilingPoint = 380.0,
      dipoleMoment = 2.0);

    function getCriticalTemperature
      output Real Tc;
    // algorithm
    //   Tc := 21;
    external "C" Tc = criticalTemperature(101325.);
      annotation(Include = "#include \"ExternalMediaMinimumTest.h\"",
                 Library = "ExternalMediaMinimumTest",
                 IncludeDirectory = "modelica://ExternalMediaMinimumTest/Resources/Include",
                 LibraryDirectory = "modelica://ExternalMediaMinimumTest/Resources/Library");
    end getCriticalTemperature;

    // function getCriticalTemperature
    //   input Real P;
    //   output Real Tc;
    // external
    //   Tc = criticalTemperature(P);
    //   annotation(Include = "#include \"ExternalMediaMinimumTest.h\"",
    //              Library = "ExternalMediaMinimumTest",
    //              IncludeDirectory = "modelica://ExternalMediaMinimumTest/Resources/Include",
    //              LibraryDirectory = "modelica://ExternalMediaMinimumTest/Resources/Library");
    // end criticalTemperature;
  end TestMedium;

end Media;
