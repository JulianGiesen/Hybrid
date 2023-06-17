function xdot = PWA_2_3(t,x,const)
u = sin(t);
r = 1;
Fdrive = const.b/(1 + const.gamma*r)*u;
xdot = [x(2); 
       1/const.m*(Fdrive - PWA(x(2),const))];
end
