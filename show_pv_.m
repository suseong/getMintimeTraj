function [p,v] = show_pv_(tsq,acc,initState,actLimit,act,ptNum)

t = linspace(0,tsq(end),ptNum);
p = [];
v = [];
u = actLimit(1)*act;

t1 = tsq(1); t2 = tsq(2); t3 = tsq(3); t4 = tsq(4);
t5 = tsq(5); t6 = tsq(6); t7 = tsq(7);

% u = u_(1);
if t1 > 1e-5
    u1 = (acc(2)-acc(1))/t1;
else
    u1 = 0;
end

if t7 -t6 > 1e-5
    u2 = (acc(8)-acc(7))/(t7-t6);
else
    u2 = 0;
end

a0 = acc(1);
a1 = acc(2);
a2 = acc(3);
a3 = acc(4);
a4 = acc(5);
a5 = acc(6);
a6 = acc(7);
a7 = acc(8);

v0 = initState(2);
v1 = v0 + a0*t1      + 1/2*u1*t1^2;
v2 = v1 + a1*(t2-t1) + 1/2*u *(t2-t1)^2;
v3 = v2 + a2*(t3-t2);
v4 = v3 + a3*(t4-t3) - 1/2*u *(t4-t3)^2;
v5 = v4 + a4*(t5-t4);
v6 = v5 + a5*(t6-t5) + 1/2*u *(t6-t5)^2;
v7 = v6 + a6*(t7-t6) + 1/2*u2*(t7-t6)^2;

p0 = initState(1);
p1 = p0 + v0*t1      + 1/2*a0*t1^2      + 1/6*u1*t1^3;
p2 = p1 + v1*(t2-t1) + 1/2*a1*(t2-t1)^2 + 1/6*u *(t2-t1)^3;
p3 = p2 + v2*(t3-t2) + 1/2*a2*(t3-t2)^2;
p4 = p3 + v3*(t4-t3) + 1/2*a3*(t4-t3)^2 - 1/6*u *(t4-t3)^3;
p5 = p4 + v4*(t5-t4) + 1/2*a4*(t5-t4)^2;
p6 = p5 + v5*(t6-t5) + 1/2*a5*(t6-t5)^2 + 1/6*u *(t6-t5)^3;
p7 = p6 + v6*(t7-t6) + 1/2*a6*(t7-t6)^2 + 1/6*u2*(t7-t6)^3;

for k=1:length(t)
    if t(k) < tsq(1)
        p(k) = p0 + v0*t(k)      + 1/2*a0*t(k)^2      + 1/6*u1*t(k)^3;
        v(k) = v0 + a0*t(k)      + 1/2*u1*t(k)^2;
    elseif and(t(k) >= tsq(1),t(k) < tsq(2))
        p(k) = p1 + v1*(t(k)-t1) + 1/2*a1*(t(k)-t1)^2 + 1/6*u *(t(k)-t1)^3;
        v(k) = v1 + a1*(t(k)-t1) + 1/2*u *(t(k)-t1)^2;
    elseif and(t(k) >= tsq(2),t(k) < tsq(3))
        p(k) = p2 + v2*(t(k)-t2) + 1/2*a2*(t(k)-t2)^2;
        v(k) = v2 + a2*(t(k)-t2);
    elseif and(t(k) >= tsq(3),t(k) < tsq(4))
        p(k) = p3 + v3*(t(k)-t3) + 1/2*a3*(t(k)-t3)^2 - 1/6*u *(t(k)-t3)^3;
        v(k) = v3 + a3*(t(k)-t3) - 1/2*u *(t(k)-t3)^2;
    elseif and(t(k) >= tsq(4),t(k) <= tsq(5))
        p(k) = p4 + v4*(t(k)-t4) + 1/2*a4*(t(k)-t4)^2;
        v(k) = v4 + a4*(t(k)-t4);
    elseif and(t(k) >= tsq(5),t(k) <= tsq(6))
        p(k) = p5 + v5*(t(k)-t5) + 1/2*a5*(t(k)-t5)^2 + 1/6*u *(t(k)-t5)^3;
        v(k) = v5 + a5*(t(k)-t5) + 1/2*u *(t(k)-t5)^2;
    elseif and(t(k) >= tsq(6),t(k) <= tsq(7))
        p(k) = p6 + v6*(t(k)-t6) + 1/2*a6*(t(k)-t6)^2 + 1/6*u2*(t(k)-t6)^3;
        v(k) = v6 + a6*(t(k)-t6) + 1/2*u2*(t(k)-t6)^2;
    end
   
end

end