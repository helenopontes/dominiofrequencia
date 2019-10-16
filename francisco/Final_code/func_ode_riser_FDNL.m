function dy=func_ode_riser_FDNL(t,condIniciais,~,mg,kg,C,F)
%t
u = condIniciais(1:7);
v = condIniciais(8:14);

Ft = F;
Ft(1) = Ft(1) + onda_riser_FDNL(t,[0,0,-6]);
Ft(3) = Ft(3) + onda_riser_FDNL(t,[0,0,-4]);
Ft(5) = Ft(5) + onda_riser_FDNL(t,[0,0,-2]);

dy(1:7,1) = v;
dy(8:14,1) = mg\(Ft - C*v - kg*u);

end