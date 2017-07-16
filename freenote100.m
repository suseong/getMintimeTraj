clear
clc

xinit =  [10*(rand(1,2)-0.5) 30*(rand(1)-0.5)];
xfinal = [10*(rand(1,2)-0.5) 30*(rand(1)-0.5)];

yinit =  [10*(rand(1,2)-0.5) 15*(rand(1)-0.5)];
yfinal = [10*(rand(1,2)-0.5) 15*(rand(1)-0.5)];

zinit =  [10*(rand(1,2)-0.5) 3*(rand(1)-0.5)];
zfinal = [10*(rand(1,2)-0.5) 3*(rand(1)-0.5)];

init{1} =  xinit;
init{2} =  yinit;
init{3} =  zinit;
final{1} = xfinal;
final{2} = yfinal;
final{3} = zfinal;

[tsq,pos,vel,acc,act] = mintime_traj_(init,final);


