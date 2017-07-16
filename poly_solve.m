% clear all
% close all
% clc

syms u t1 t2 t3 t4 tf real

u_ = 20;
amax = 10;

tt = [];

% init =
%     4.0272    4.4479   -1.0000
% final =
%    -0.1075   -1.6228    1.0000

% init = initState;
% final = finalState;

% newInit =   [2.0045   -9.2634   -1.0000    0.3221];
% newFinal =  [1.4125   -1.7951    1.0000    0.3405];

% init = zinit;
% final = zfinal;
%     
% x0 = init(1); v0 = init(2); a0 = init(3);
% xf = final(1);vf = final(2);af = final(3);

x0 = zinit(1); 
v0 = zinit(2);
a0 = zinit(3);

xf = zfinal(1);
vf = zfinal(2);
af = zfinal(3);

signs = [1 -1 1];

a1 = a0 + signs(1)*t1*u;
a2 = a1;
a3 = a2 + signs(2)*(t3-t2)*u;
a4 = a3;
a5 = a4 + signs(3)*(tf-t4)*u;

v1 = v0 + a0*t1      + signs(1)*1/2*u*t1^2;
v2 = v1 + a1*(t2-t1);
v3 = v2 + a2*(t3-t2) + signs(2)*1/2*u*(t3-t2)^2;
v4 = v3 + a3*(t4-t3);
v5 = v4 + a4*(tf-t4) + signs(3)*1/2*u*(tf-t4)^2;

x1 = x0 + v0*t1      + 1/2*a0*t1^2      + signs(1)*1/6*u*t1^3;
x2 = x1 + v1*(t2-t1) + 1/2*a1*(t2-t1)^2;
x3 = x2 + v2*(t3-t2) + 1/2*a2*(t3-t2)^2 + signs(2)*1/6*u*(t3-t2)^3;
x4 = x3 + v3*(t4-t3) + 1/2*a3*(t4-t3)^2;
x5 = x4 + v4*(tf-t4) + 1/2*a4*(tf-t4)^2 + signs(3)*1/6*u*(tf-t4)^3;

%%
a5_ = subs(a5,[t2 t4 u],[t1 t3 u_]);
v5_ = subs(v5,[t2 t4 u],[t1 t3 u_]);
x5_ = subs(x5,[t2 t4 u],[t1 t3 u_]);

[solt1,solt3,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t1,t3,tf]);

for k=1:length(solt1)
   tt = [tt;double([solt1(k) solt1(k) solt3(k) solt3(k) soltf(k) u_])]; 
end

a5_ = subs(a5,[t2 t4 u],[t1 t3 -u_]);
v5_ = subs(v5,[t2 t4 u],[t1 t3 -u_]);
x5_ = subs(x5,[t2 t4 u],[t1 t3 -u_]);

[solt1,solt3,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t1,t3,tf]);

for k=1:length(solt1)
   tt = [tt;double([solt1(k) solt1(k) solt3(k) solt3(k) soltf(k) -u_])]; 
end

%% 
% u > 0, 
a5_ = subs(a5,[t1 t4 u],[(amax-a0)/u_ t3 u_]);
v5_ = subs(v5,[t1 t4 u],[(amax-a0)/u_ t3 u_]);
x5_ = subs(x5,[t1 t4 u],[(amax-a0)/u_ t3 u_]);

[solt2,solt3,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t2,t3,tf]);

for k=1:length(solt2)
   tt = [tt;double([(amax-a0)/u_ solt2(k) solt3(k) solt3(k) soltf(k) u_])]; 
end

% u < 0
a5_ = subs(a5,[t1 t4 u],[(-amax-a0)/-u_,t3,-u_]);
v5_ = subs(v5,[t1 t4 u],[(-amax-a0)/-u_,t3,-u_]);
x5_ = subs(x5,[t1 t4 u],[(-amax-a0)/-u_,t3,-u_]);

[solt2,solt3,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t2,t3,tf]);

for k=1:length(solt2)
   tt = [tt;double([(-amax-a0)/-u_ solt2(k) solt3(k) solt3(k) soltf(k) -u_])]; 
end

%%
% u > 0
a5_ = subs(a5,[t2 tf u],[t1 t4 + (af+amax)/u_ u_]);
v5_ = subs(v5,[t2 tf u],[t1 t4 + (af+amax)/u_ u_]);
x5_ = subs(x5,[t2 tf u],[t1 t4 + (af+amax)/u_ u_]);

[solt1,solt3,solt4] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t1,t3,t4]);

for k=1:length(solt1)
   tt = [tt;double([solt1(k) solt1(k) solt3(k) solt4(k) solt4(k)+(af+amax)/u_ u_])]; 
end

% u < 0
a5_ = subs(a5,[t2 tf u],[t1,t4 + (af-amax)/-u_ -u_]);
v5_ = subs(v5,[t2 tf u],[t1,t4 + (af-amax)/-u_ -u_]);
x5_ = subs(x5,[t2 tf u],[t1,t4 + (af-amax)/-u_ -u_]);

[solt1,solt3,solt4] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t1,t3,t4]);

for k=1:length(solt1)
   tt = [tt;double([solt1(k) solt1(k) solt3(k) solt4(k) solt4(k)+(af-amax)/-u_ -u_])]; 
end

%%
% u > 0
a5_ = subs(a5,[t1 t3 u],[(amax-a0)/u_ t2 + 2*amax/u_ u_]);
v5_ = subs(v5,[t1 t3 u],[(amax-a0)/u_ t2 + 2*amax/u_ u_]);
x5_ = subs(x5,[t1 t3 u],[(amax-a0)/u_ t2 + 2*amax/u_ u_]);

[solt2,solt4,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t2,t4,tf]);

for k=1:length(solt2)
   tt = [tt;double([(amax-a0)/u_ solt2(k) solt2(k)+2*amax/u_ solt4(k) soltf(k) u_])]; 
end

% u < 0
a5_ = subs(a5,[t1 t3 u],[(-amax-a0)/-u_ t2 + 2*amax/u_ -u_]);
v5_ = subs(v5,[t1 t3 u],[(-amax-a0)/-u_ t2 + 2*amax/u_ -u_]);
x5_ = subs(x5,[t1 t3 u],[(-amax-a0)/-u_ t2 + 2*amax/u_ -u_]);

[solt2,solt4,soltf] = solve([a5_ == af,v5_ == vf,x5_ == xf],[t2,t4,tf]);

for k=1:length(solt2)
   tt = [tt;double([(-amax-a0)/-u_ solt2(k) solt2(k)+2*amax/u_ solt4(k) soltf(k) -u_])]; 
end

%%
chad = diff(real(tt)')';

idx = [];
for k=1:size(chad,1)
    temp = sum(find(chad(k,1:end-1) >= 0));
    if temp == 10
        idx = [idx;k];
    end
end

if idx ~= 0
    for aa = 1:length(idx)
        ttt = real(tt(idx(aa),:));
        
        x0_ = x0;
        v0_ = v0;
        a0_ = a0;
        a1_ = subs(a1,[t1 t2 t3 t4 tf u],ttt);
        a2_ = subs(a2,[t1 t2 t3 t4 tf u],ttt);
        a3_ = subs(a3,[t1 t2 t3 t4 tf u],ttt);
        a4_ = subs(a4,[t1 t2 t3 t4 tf u],ttt);
        a5_ = subs(a5,[t1 t2 t3 t4 tf u],ttt);
        
        %%
        tf_ = ttt(end-1);
        tpiece = double([0 ttt(1:end-1)]);
        apiece = double([a0_ a1_ a2_ a3_ a4_ a5_]);
        temp = find(abs(apiece) > abs(amax)+1e-5);
        temp1 = find(tpiece < 0);
        
        if and(isempty(temp),isempty(temp1))
            tpiece
            apiece
%             sim('simMinTimeTraj');
%             xTraj = traj;
%             figure(2)
%             for k=1:3
%                 subplot(3,1,k)
%                 plot(xTraj.Time,xTraj.Data(:,k))
%                 grid on
%                 box on
%             end
        end
    end
end













