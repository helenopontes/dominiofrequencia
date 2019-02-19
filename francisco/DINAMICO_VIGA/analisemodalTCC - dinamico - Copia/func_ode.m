function dy=func_ode(t,condIniciais,~,mg,kg,C,F)
%t
u = condIniciais(1:8);
v = condIniciais(9:16);
Ft = F;
Ft(4) = Ft(4)*cos(70*t);

dy(1:8,1) = v;
dy(9:16,1) = mg\(Ft - C*v - kg*u);

end