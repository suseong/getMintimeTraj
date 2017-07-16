function [time_seq,pos,vel,acc,iter,act,num,isOkay] = calc_mintime_traj_(initState,finalState,actLimit)

%       |  1  |     2     |     3      |  4  |
input_ = [1  1  2  2  2  2  3  3  3  3  4  4;
          1 -1  1 -1  1 -1  1 -1  1 -1  1 -1;
          1  1  1  1  2  2  1  1  2  2  1  1];

infos = [];
tfList = [];

numValidSol = 0;

[newInit,newFinal] = toMaxAcc(initState,finalState,actLimit);

t00 = newInit(4); tff = newFinal(4);

for j = 1:size(input_,2)
    [pos,tsq] = bisection_(input_(2,j)*actLimit,newInit(1:3),newFinal(1:3),input_(3,j),input_(1,j));
    for k = 1:length(pos)
        if ~isempty(pos{k})
            tsq_ = t00 + [0 tsq{k} tff+tsq{k}(end)];
            [p,v,a,isSol] = calc_acc(initState,finalState,newInit,newFinal,tsq_,input_(2,j)*actLimit);
            if isSol
                numValidSol = numValidSol + 1;
                infos{numValidSol,1} = p;
                infos{numValidSol,2} = v;
                infos{numValidSol,3} = a;
                infos{numValidSol,4} = tsq_;
                infos{numValidSol,5} = input_(2,j);
                infos{numValidSol,6} = j;
                tfList = [tfList;tsq{k}(end)];
            end
        end
    end
end

%%
if size(infos,1) >= 1
    isOkay = 1;
else
    isOkay = 0;
end

if isOkay == 1
    [~,k] = min(tfList);
    pos = infos{k,1};
    vel = infos{k,2};
    iter = 0;
    acc = infos{k,3};
    act = infos{k,6};
    num = infos{k,5};
    time_seq = infos{k,4};
else
    pos = [];
    vel = [];
    iter = 0;
    acc = [];
    act = [];
    num = 0;
    time_seq = [];    
end

end