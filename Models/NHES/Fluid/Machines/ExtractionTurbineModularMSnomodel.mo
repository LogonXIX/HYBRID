within NHES.Fluid.Machines;
model ExtractionTurbineModularMSnomodel

  replaceable package medium=Modelica.Media.Water.StandardWater;
  parameter Modelica.Units.SI.AbsolutePressure P_in=100e5 "Nominal Turbine Inlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_out=20e5 "Nominal Turbine Outlet Pressure" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.SpecificEnthalpy h_in=2.8e6 "Nominal Turbine Inlet Enthalpy" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.MassFlowRate m_in=10 "Nominal Inlet Mass Flow Rate" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Real eta_t=0.9 "Turbine Isentropic Efficiency" annotation (Dialog(group="Nominal Turbine Conditions"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext1=60e5 "Nominal Turbine First Extraction Pressure" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.AbsolutePressure P_ext2=50e5 "Nominal Turbine Second Extraction Pressure" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Modelica.Units.SI.AbsolutePressure P_ext3=30e5 "Nominal Turbine Thrid Extraction Pressure" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Modelica.Units.SI.MassFlowRate m_ext1=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points"));
  parameter Modelica.Units.SI.MassFlowRate m_ext2=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Modelica.Units.SI.MassFlowRate m_ext3=2 "Nominal Turbine First Extraction Flow Rate" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Boolean Ms1=false "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points"));
  parameter Boolean Ms2=false "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Boolean Ms3=false "Use Moisture Seperation a the Extraction Point" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Real fms1=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points"));
  parameter Real fms2=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points",enable=nExt>1));
  parameter Real fms3=0.99
                          "Moisture Seperation Efficiency" annotation (Dialog(group="Extraction Points",enable=nExt>2));
  parameter Integer nExt(min=1,max=3)=1 "Number of Extractions, Max=3";

    final parameter Modelica.Units.SI.SpecificEnthalpy h_out0(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_out3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_ext3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR1(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR2(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEnthalpy h_AR3(fixed=false)=2e6;
    final parameter Modelica.Units.SI.SpecificEntropy s_in(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out0(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_out2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_ext3(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR1(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR2(fixed=false)=5e3;
    final parameter Modelica.Units.SI.SpecificEntropy s_AR3(fixed=false)=5e3;
    final parameter Real eta_1(fixed=false)=0.9;
    final parameter Real eta_2(fixed=false)=0.9;
    final parameter Real eta_3(fixed=false)=0.9;
    final parameter Real eta_4(fixed=false)=0.9;
    final parameter Real X1(fixed=false)=0.9;
    final parameter Real X2(fixed=false)=0.9;
    final parameter Real X3(fixed=false)=0.9;
    final parameter Modelica.Units.SI.Density d_in(fixed=false)=50;
    final parameter Modelica.Units.SI.Density d_ext1(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext2(fixed=false)=15;
    final parameter Modelica.Units.SI.Density d_ext3(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t1(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t2(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t3(fixed=false)=15;
    final parameter Modelica.Units.SI.MassFlowRate m_flow_t4(fixed=false)=15;


initial equation
  //Inlet
  s_in=medium.specificEntropy(medium.setState_ph(P_in,h_in));
  d_in=medium.density_ph(P_in,h_in);
  //First Expansion Line
  h_out0=h_in-(h_in-medium.specificEnthalpy_ps(P_out,s_in))*eta_t;
  s_out0=medium.specificEntropy(medium.setState_ph(P_out,h_out0));
  //Extraction
  h_ext1=((h_out0-h_in)/(s_out0-s_in))*s_ext1+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
  h_ext1=medium.specificEnthalpy_ps(P_ext1,s_ext1);

  //is the first extraction a MS
  if Ms1 then
      //check quality
      X1=(h_ext1-medium.bubbleEnthalpy(medium.setSat_p(P_ext1)))/(medium.dewEnthalpy(medium.setSat_p(P_ext1))-medium.bubbleEnthalpy(medium.setSat_p(P_ext1)));
      assert(X1>0,"Subcooled Extraction",AssertionLevel.error);
      assert(X1>1,"Superheated Moisture Separation",AssertionLevel.warning);
    //for SH, nominally the same as no MS
    if X1>1 then
      h_AR1=h_ext1;
      s_AR1=s_ext1;
    else
    //for two phase
      h_AR1=(m_in*h_ext1-m_in*fms1*(1-X1)*medium.bubbleEnthalpy(medium.setSat_p(P_ext1)))/(m_in-m_in*fms1*(1-X1));
      s_AR1=medium.specificEntropy(medium.setState_ph(P_ext1,h_AR1));
    end if;
    //no MS
   else
     h_AR1=h_ext1;
     s_AR1=s_ext1;
     X1=0.9;
   end if;

  //for 2nd extration point
  if nExt>1 then
    //which expansion line?
    if Ms1 then  //second
      h_out1=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_out,s_AR1))*eta_t;
      s_out1=medium.specificEntropy(medium.setState_ph(P_out,h_out1));
      h_ext2=((h_out1-h_AR1)/(s_out1-s_AR1))*s_ext2+h_AR1-((h_out1-h_AR1)/(s_out1-s_AR1))*s_AR1;
      h_ext2=medium.specificEnthalpy_ps(P_ext2,s_ext2);
    else //first
      h_out1=h_out0;
      s_out1=s_out0;
      h_ext2=((h_out0-h_in)/(s_out0-s_in))*s_ext2+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
      h_ext2=medium.specificEnthalpy_ps(P_ext2,s_ext2);
    end if;
    //is the second extraction a MS?
    if Ms2 then
      //check qual
      X2=(h_ext2-medium.bubbleEnthalpy(medium.setSat_p(P_ext2)))/(medium.dewEnthalpy(medium.setSat_p(P_ext2))-medium.bubbleEnthalpy(medium.setSat_p(P_ext2)));
      assert(X2>0,"Subcooled Extraction",AssertionLevel.error);
      assert(X2>1,"Superheated Moisture Separation",AssertionLevel.warning);
      if X2>1 then  //SH
        h_AR2=h_ext2;
        s_AR2=s_ext2;
      else  //two phase
        h_AR2=(m_in*h_ext2-m_in*fms2*(1-X2)*medium.bubbleEnthalpy(medium.setSat_p(P_ext2)))/(m_in-m_in*fms2*(1-X2));
        s_AR2=medium.specificEntropy(medium.setState_ph(P_ext2,h_AR2));
      end if;
    else
      h_AR2=h_ext2;
      s_AR2=s_ext2;
      h_out2=h_out0;
      X2=0.9;
    end if;
  else
    eta_3=eta_1;
    h_AR2=h_AR1;
    h_ext2=h_ext1;
    h_out2=h_out0;
    s_AR2=s_AR1;
    s_ext2=s_ext1;
    s_out1=s_out0;
    X2=X1;
  end if;
  //for 3rd extraction point
  if nExt>2 then
  //which expansion line?
    if Ms2 then //third
      h_out2=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_out,s_AR2))*eta_t;
      s_out2=medium.specificEntropy(medium.setState_ph(P_out,h_out2));
      h_ext3=((h_out2-h_AR2)/(s_out2-s_AR2))*s_ext3+h_AR2-((h_out2-h_AR2)/(s_out2-s_AR2))*s_AR2;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    elseif Ms1 then //second
      s_out2=s_out0;
      h_ext3=((h_out1-h_AR1)/(s_out1-s_AR1))*s_ext3+h_AR1-((h_out1-h_AR1)/(s_out1-s_AR1))*s_AR1;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    else //first
      s_out2=s_out0;
      h_ext3=((h_out0-h_in)/(s_out0-s_in))*s_ext3+h_in-((h_out0-h_in)/(s_out0-s_in))*s_in;
      h_ext3=medium.specificEnthalpy_ps(P_ext3,s_ext3);
    end if;
    //is the third extraction a MS?
    if Ms3 then
        //check qual
        X3=(h_ext3-medium.bubbleEnthalpy(medium.setSat_p(P_ext3)))/(medium.dewEnthalpy(medium.setSat_p(P_ext3))-medium.bubbleEnthalpy(medium.setSat_p(P_ext3)));
        assert(X3>0,"Subcooled Extraction",AssertionLevel.error);
        assert(X3>1,"Superheated Moisture Separation",AssertionLevel.warning);
      if X3>1 then  //SH
        h_AR3=h_ext3;
        s_AR3=s_ext3;
      else  //two phase
        h_AR3=(m_in*h_ext3-m_in*fms3*(1-X3)*medium.bubbleEnthalpy(medium.setSat_p(P_ext3)))/(m_in-m_in*fms3*(1-X3));
        s_AR3=medium.specificEntropy(medium.setState_ph(P_ext3,h_AR3));
      end if;
      //make last expansion line
      h_out3=h_AR3-(h_AR3-medium.specificEnthalpy_ps(P_out,s_AR3))*eta_t;
    else
      h_AR3=h_ext3;
      s_AR3=s_ext3;
      h_out3=h_out0;
      X3=0.9;
    end if;
  else
    h_AR3=h_AR1;
    h_ext3=h_ext1;
    h_out3=h_out0;
    s_AR3=s_AR1;
    s_ext3=s_ext1;
    X3=X1;
    eta_4=eta_1;
    s_out2=s_out0;
  end if;



 //now with all of the extraction enthalpys, nominal turbine conditions can be found (densities, mass flows and etas)
 h_ext1=h_in-(h_in-medium.specificEnthalpy_ps(P_ext1,s_in))*eta_1;
 d_ext1=medium.density_ph(P_ext1,h_AR1);
 if nExt==3 then
 h_ext2=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_ext2,s_AR1))*eta_2;
 d_ext2=medium.density_ph(P_ext2,h_AR2);
 h_ext3=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_ext3,s_AR2))*eta_3;
 d_ext3=medium.density_ph(P_ext3,h_AR3);
 h_out3=h_AR3-(h_AR3-medium.specificEnthalpy_ps(P_out,s_AR3))*eta_4;
 elseif nExt==2 then
 h_ext2=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_ext2,s_AR1))*eta_2;
 d_ext2=medium.density_ph(P_ext2,h_AR2);
 h_out2=h_AR2-(h_AR2-medium.specificEnthalpy_ps(P_out,s_AR2))*eta_3;
 d_ext3=d_ext2;
 if Ms2 then
 eta_4=eta_3;
 end if;
 else
 h_out1=h_AR1-(h_AR1-medium.specificEnthalpy_ps(P_out,s_AR1))*eta_2;
 d_ext2=d_ext1;
 eta_3=eta_2;
 d_ext3=d_ext2;
 //eta_4=eta_3;
 end if;


 m_flow_t1=m_in;
 if Ms1 then
   m_flow_t2=m_flow_t1-m_flow_t1*fms1*(1-X1);
 else
   m_flow_t2=m_flow_t1-m_ext1;
 end if;

 if Ms2 then
   m_flow_t3=m_flow_t2-m_flow_t2*fms2*(1-X2);
 else
   m_flow_t3=m_flow_t2-m_ext2;
 end if;

 if Ms3 then
   m_flow_t4=m_flow_t3-m_flow_t3*fms3*(1-X3);
 else
   m_flow_t4=m_flow_t3-m_ext3;
 end if;


equation

  annotation (experiment(__Dymola_NumberOfIntervals=5, __Dymola_Algorithm="Esdirk45a"));
end ExtractionTurbineModularMSnomodel;
