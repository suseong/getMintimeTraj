function acc_ = find_valid_acc(init,final,actuation,accRange,targetTime)

maxAcc = accRange(2);
cnt = 1;

while(1)
    tempMinAcc = accRange(2) - 0.1*cnt;
    if tempMinAcc < accRange(1)
        tempMinAcc = accRange(1);
    end
    tsq = calc_mintime_traj_(init,final,[actuation(1) tempMinAcc]);
    if tsq(end) >= targetTime
        minAcc = tempMinAcc;
        break;
    elseif tempMinAcc < accRange(1)
        disp('something wrong')
        keyboard
        break;
    elseif cnt > 5
        disp('check find valid acc function')
    end
    cnt = cnt+1;
end

for k = 1:10
    acc_ = (maxAcc + minAcc)/2;
    tsq = calc_mintime_traj_(init,final,[actuation(1) acc_]);
    
    if(tsq(end) > targetTime)
        minAcc = acc_;
    else
        maxAcc = acc_;
    end
    
    if abs(tsq(end) - targetTime) < 1e-4
%         disp([num2str(k),' ',num2str(tsq(end)),' ',num2str(acc_)]);
        break;
    end
end

end