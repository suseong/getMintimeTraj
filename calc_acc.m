function [pos,vel,acc,isSol] = calc_acc(init,final,newInit,newFinal,tsq,u_)

if min(diff(tsq)) < -1e-2
    isSol = 0;
    pos = zeros(8,1);
    vel = zeros(8,1);
    acc = zeros(8,1);
else    

t1 = tsq(1); t2 = tsq(2); t3 = tsq(3); t4 = tsq(4);
t5 = tsq(5); t6 = tsq(6); t7 = tsq(7);

u = u_(1);
if t1 > 1e-5
    u1 = (newInit(3)-init(3))/t1;
else
    u1 = 0;
end

if t7 -t6 > 1e-5
    u2 = (final(3)-newFinal(3))/(t7-t6);
else
    u2 = 0;
end

a0 = init(3); 
% a1 = a0 + t1*u1;
a1 = newInit(3);
a2 = a1 + (t2-t1)*u;
a3 = a2;
a4 = a3 - (t4-t3)*u;
a5 = a4;
a6 = a5 + (t6-t5)*u; 
a7 = a6 + (t7-t6)*u2;

acc = [a0 a1 a2 a3 a4 a5 a6 a7];

v0 = init(2);
v1 = v0 + a0*t1      + 1/2*u1*t1^2;
v2 = v1 + a1*(t2-t1) + 1/2*u *(t2-t1)^2;
v3 = v2 + a2*(t3-t2);
v4 = v3 + a3*(t4-t3) - 1/2*u *(t4-t3)^2;
v5 = v4 + a4*(t5-t4);
v6 = v5 + a5*(t6-t5) + 1/2*u *(t6-t5)^2;
v7 = v6 + a6*(t7-t6) + 1/2*u2*(t7-t6)^2;

vel = [v0 v1 v2 v3 v4 v5 v6 v7];

p0 = init(1);
p1 = p0 + v0*t1      + 1/2*a0*t1^2      + 1/6*u1*t1^3;
p2 = p1 + v1*(t2-t1) + 1/2*a1*(t2-t1)^2 + 1/6*u *(t2-t1)^3;
p3 = p2 + v2*(t3-t2) + 1/2*a2*(t3-t2)^2;
p4 = p3 + v3*(t4-t3) + 1/2*a3*(t4-t3)^2 - 1/6*u *(t4-t3)^3;
p5 = p4 + v4*(t5-t4) + 1/2*a4*(t5-t4)^2;
p6 = p5 + v5*(t6-t5) + 1/2*a5*(t6-t5)^2 + 1/6*u *(t6-t5)^3;
p7 = p6 + v6*(t7-t6) + 1/2*a6*(t7-t6)^2 + 1/6*u2*(t7-t6)^3;

pos = [p0 p1 p2 p3 p4 p5 p6 p7];

isSol = 0;

isPos = and(abs(p0 - init(1))<1e-2,abs(p7 - final(1))<1e-2);
isVel = and(abs(v0 - init(2))<1e-2,abs(v7 - final(2))<1e-2);
isAcc = and(abs(a0 - init(3))<1e-2,abs(a7 - final(3))<1e-2);
isAccInRange = max(abs(acc(2:6))) - abs(u_(2)) < 1e-1;

if and(and(isPos,isVel),and(isAcc,isAccInRange))
    isSol = 1;
end
    
end
end