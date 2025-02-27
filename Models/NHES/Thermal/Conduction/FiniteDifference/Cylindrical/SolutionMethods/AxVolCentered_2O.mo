within NHES.Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods;
model AxVolCentered_2O
  "2-D Radial | Axially Volume Centered | 2nd Order Central Finite Difference"
  import      Modelica.Units.SI;
  import Modelica.Constants.pi;

  extends BaseClasses.Partial_FDCond_Cylinder;

  SI.Length[nRadial-1] dr = {r[i+1] - r[i] for i in 1:nRadial-1}
    "Radial nodal spacing";
  SI.Length[nAxial] dz = {if i == 1 then 2*z[i] else 2*(z[i]-z[i-1])-dz[i-1] for i in 1:nAxial}
    "Axial nodal spacing";

  Real beta_max = max(dr)/min(dz) "Maximum skewness of dr/dz";
  Real beta_min = min(dr)/max(dz) "Minimum skewness of dr/dz";

equation
  /* 

  Energy Equations with Boundary Conditions specified externally.
  dE/dt = q_r + q_(r+dr) + q_z + q_(z+dz) + q'''*V
  where q = -lambda*A*dT/dx

  Format:
  rho_ij*cp_ij*V_ij*der(T_ij) = 
    q_(i-1/2,j)
  + q_(i+1/2,j)
  + q_(i,j-1/2)
  + q_(i,j+1/2)
  + q'''*V_ij
  
  */
if energyDynamics == Modelica.Fluid.Types.Dynamics.SteadyState then
  /* Center Nodes */
  for i in 2:nRadial-1 loop
    for j in 2:nAxial-1 loop
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Inner Edge */
  for i in 1:1 loop
    for j in 2:nAxial-1 loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[j].T;
      0 =
        heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Outer Edge */
  for i in nRadial:nRadial loop
    for j in 2:nAxial-1 loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Edge */
  for i in 2:nRadial-1 loop
    for j in 1:1 loop
      A_bottom[i] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]));
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      T[i,j] = heatPorts_bottom[i].T;
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Edge */
  for i in 2:nRadial-1 loop
    for j in nAxial:nAxial loop
      A_top[i] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]));
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      T[i,j] = heatPorts_top[i].T;
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Inner Corner */
  for i in 1:1 loop
    for j in 1:1 loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      A_bottom[i] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i]);
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[i].T;
      heatPorts_bottom[i].T = T[i,j];
      0 = heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Inner Corner */
  for i in 1:1 loop
    for j in nAxial:nAxial loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      A_top[i] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i]);
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[j].T;
      heatPorts_top[i].T = T[i,j];
      0 =heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Outer Corner */
  for i in nRadial:nRadial loop
    for j in 1:1 loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      A_bottom[i] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1]);
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      heatPorts_bottom[i].T = T[i,j];
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Outer Corner */
  for i in nRadial:nRadial loop
    for j in nAxial:nAxial loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      A_top[i] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1]);
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      heatPorts_top[i].T = T[i,j];
      0 =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

else
  /* Center Nodes */
  for i in 2:nRadial-1 loop
    for j in 2:nAxial-1 loop
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Inner Edge */
  for i in 1:1 loop
    for j in 2:nAxial-1 loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[j].T;
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Outer Edge */
  for i in nRadial:nRadial loop
    for j in 2:nAxial-1 loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Edge */
  for i in 2:nRadial-1 loop
    for j in 1:1 loop
      A_bottom[i] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]));
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      T[i,j] = heatPorts_bottom[i].T;
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Edge */
  for i in 2:nRadial-1 loop
    for j in nAxial:nAxial loop
      A_top[i] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]));
      volNode[i,j] = pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*dz[j];
      T[i,j] = heatPorts_top[i].T;
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*(dr[i]+dr[i-1])+0.25*(dr[i]*dr[i]-dr[i-1]*dr[i-1]))*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Inner Corner */
  for i in 1:1 loop
    for j in 1:1 loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      A_bottom[i] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i]);
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[i].T;
      heatPorts_bottom[i].T = T[i,j];
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
          heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Inner Corner */
  for i in 1:1 loop
    for j in nAxial:nAxial loop
      A_inner[j] = 2*pi*r[i]*dz[j];
      A_top[i] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i]);
      volNode[i,j] = pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*dz[j];
      T[i,j] = heatPorts_inner[j].T;
      heatPorts_top[i].T = T[i,j];
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
         heatPorts_inner[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i+1,j])*2*pi*(r[i]+0.5*dr[i])*dz[j]*(T[i,j]-T[i+1,j])/dr[i]
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i]+0.25*dr[i]*dr[i])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Bottom Outer Corner */
  for i in nRadial:nRadial loop
    for j in 1:1 loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      A_bottom[i] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1]);
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      heatPorts_bottom[i].T = T[i,j];
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        + heatPorts_bottom[i].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j+1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j+1])/(0.5*(dz[j]+dz[j+1]))
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;

  /* Top Outer Corner */
  for i in nRadial:nRadial loop
    for j in nAxial:nAxial loop
      A_outer[j] = 2*pi*r[i]*dz[j];
      A_top[i] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1]);
      volNode[i,j] = pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*dz[j];
      T[i,j] = heatPorts_outer[j].T;
      heatPorts_top[i].T = T[i,j];
      rho[i,j]*cp[i,j]*volNode[i,j]*der(T[i,j]) =
        - 0.5*(lambda[i,j]+lambda[i-1,j])*2*pi*(r[i]-0.5*dr[i-1])*dz[j]*(T[i,j]-T[i-1,j])/dr[i-1]
        + heatPorts_outer[j].Q_flow
        - 0.5*(lambda[i,j]+lambda[i,j-1])*pi*(r[i]*dr[i-1]-0.25*dr[i-1]*dr[i-1])*(T[i,j]-T[i,j-1])/(0.5*(dz[j]+dz[j-1]))
        + heatPorts_top[i].Q_flow
        + q_ppp[i,j]*volNode[i,j];
    end for;
  end for;
end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Below is a representative stencil for the distribution of the nodes and associated stencil. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Note that the nodes lie are &apos;volume centered&apos; in the axial direction but still lie along the boundaries in the radial direction. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">This governs the ability, or lack thereof, to use predefined boundary conditions.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">For example, this stencil WILL directly interface with &apos;DynamicPipe&apos; because that requires volume centered Q_flow and T values which this method satisfies.</span></p>
<p><img src=\"modelica://TRANSFORM/../Resources/Images/Thermal/Conduction/FiniteDifference/FD_AxVolCentered_2DCyl.PNG\"/></p>
</html>"));
end AxVolCentered_2O;
