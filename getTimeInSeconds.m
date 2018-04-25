function [timeInSeconds] = getTimeInSeconds(timeRawData)

time_stamp_Data = hex2dec(timeRawData);
timeInSeconds = time_stamp_Data * (10^(-3));

end