function dy=func_ode_riser(t,condIniciais,~,mg,kg,C,F)
%t
u = condIniciais(1:7);
v = condIniciais(8:14);

Ft = F;
Ft(3) = onda_riser_FDL(t);

dy(1:7,1) = v;
dy(8:14,1) = mg\(Ft - C*v - kg*u);

end