within NHES.Systems.Templates.SubSystem_Category_Simple.SubSystem_Specific_Simple.BaseClasses;
partial model Partial_SubSystem_A

  extends Partial_SubSystem;

  extends Record_SubSystem_A;

  annotation (
    defaultComponentName="changeMe",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            140}})));
end Partial_SubSystem_A;
