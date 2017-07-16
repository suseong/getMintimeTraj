function [p,v] = calc_pv(tsq,init,acc)

x0 = init(1); v0 = init(2);

a0 = acc(1); a1 = acc(2); a2 = acc(3); a3 = acc(4);
a4 = acc(5); a5 = acc(6); a6 = acc(7); a7 = acc(8);

t1 = tsq(1); t2 = tsq(2); t3 = tsq(3); t4 = tsq(4);
t5 = tsq(5); t6 = tsq(6); t7 = tsq(7);

v1 = v0 + a0*t1      + 1/2*u*t1^2;
v2 = v1 + a1*(t2-t1);
v3 = v2 + a2*(t3-t2) - 1/2*u*(t3-t2)^2;
v4 = v3 + a3*(t4-t3);
v5 = v4 + a4*(tf-t4) + 1/2*u*(tf-t4)^2;
v6 = v3 + a3*(t4-t3);
v5 = v4 + a4*(tf-t4) + 1/2*u*(tf-t4)^2;

x1 = x0 + v0*t1      + 1/2*a0*t1^2      + 1/6*u*t1^3;
x2 = x1 + v1*(t2-t1) + 1/2*a1*(t2-t1)^2;
x3 = x2 + v2*(t3-t2) + 1/2*a2*(t3-t2)^2 - 1/6*u*(t3-t2)^3;
x4 = x3 + v3*(t4-t3) + 1/2*a3*(t4-t3)^2;
x5 = x4 + v4*(tf-t4) + 1/2*a4*(tf-t4)^2 + 1/6*u*(tf-t4)^3;




end