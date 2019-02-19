function dy=func_ode(t,condIniciais,~,mg,kg,C,F)

%Considerando um grupo de dança com w=2,5 Hz = 15.7080 rad/s e alfai=0.5
u = condIniciais(1:32);
v = condIniciais(33:64);
Ft = F;
Ft(4) = Ft(4)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(8) = Ft(8)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(12) = Ft(12)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(16) = Ft(16)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(20) = Ft(20)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(24) = Ft(24)*(1 + 0.5*sin(2*pi*1*2.5*t));
Ft(28) = Ft(28)*(1 + 0.5*sin(2*pi*1*2.5*t));

dy(1:32,1) = v;
dy(33:64,1) = mg\(Ft - C*v - kg*u);

end