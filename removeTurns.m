function [RR_noTunrs, LR_noTurns, RF_noTurns, LF_noTurns] = removeTurns(SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF, threshold_in_kmh)
speedData_len = length(SpeedData_RR);
idx = 1;
for i=1:speedData_len
   if abs(SpeedData_RR(i) - SpeedData_RF(i)) < abs(SpeedData_RR(i)-SpeedData_LF(i))
       right_wheel_speed = (SpeedData_RR(i)+SpeedData_RF(i))/2;
       left_wheel_speed = (SpeedData_LR(i)+SpeedData_LF(i))/2;
       if abs(right_wheel_speed - left_wheel_speed) > threshold_in_kmh
           %Turn !!
       else
           RR_noTunrs(idx) = SpeedData_RR(i);
           LR_noTurns(idx) = SpeedData_LR(i);
           RF_noTurns(idx) = SpeedData_RF(i);
           LF_noTurns(idx) = SpeedData_LF(i);
           idx = idx+1;
       end
   else
        RR_noTunrs(idx) = SpeedData_RR(i);
        LR_noTurns(idx) = SpeedData_LR(i);
        RF_noTurns(idx) = SpeedData_RF(i);
        LF_noTurns(idx) = SpeedData_LF(i);
        idx = idx+1;
   end
end

end