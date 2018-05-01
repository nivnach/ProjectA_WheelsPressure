function [wheelSpeedData] = removeAccAndBreaks(SpeedData, threshold_in_kmh)
speedData_len = length(SpeedData);
idx = 1;
for i=1:speedData_len-1
    if abs(SpeedData(i+1) - SpeedData(i)) > threshold_in_kmh
        %Acc or break
    else
        wheelSpeedData(idx) = SpeedData(i);
        idx = idx + 1;
    end
end

end