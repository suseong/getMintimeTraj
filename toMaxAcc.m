function [toMax,fromMax] = toMaxAcc(init,final,input)

x0 = init(1);  v0 = init(2);  a0 = init(3);
xf = final(1); vf = final(2); af = final(3);
u = abs(input(1)); am = abs(input(2));

if a0 > am 
   t_ = (a0 - am) / u;
   v_ = v0 + a0*t_ - 1/2*u*t_^2;
   x_ = x0 + v0*t_ + 1/2*a0*t_^2 - 1/6*u*t_^3;
   a_ = am;
elseif a0 < -am
   t_ = (-a0 - am) / u;
   v_ = v0 + a0*t_ + 1/2*u*t_^2;
   x_ = x0 + v0*t_ + 1/2*a0*t_^2 + 1/6*u*t_^3;    
   a_ = -am;
else
   t_ = 0.0;
   v_ = v0;
   x_ = x0;
   a_ = a0;
end

toMax = [x_ v_ a_ t_];

if af > am
   t_ = (af - am) / u;
   a_ = am; % af - u*t_;
   v_ = vf - a_*t_ - 1/2*u*t_^2;
   x_ = xf - v_*t_ - 1/2*a_*t_^2 - 1/6*u*t_^3;
elseif af < -am
   t_ = (-af - am) / u;
   a_ = -am; % af + u*t_;
   v_ = vf - a_*t_ + 1/2*u*t_^2;
   x_ = xf - v_*t_ - 1/2*a_*t_^2 + 1/6*u*t_^3;
else
   t_ = 0;
   x_ = xf;
   v_ = vf;
   a_ = af;
end
    
fromMax = [x_ v_ a_ t_];

end