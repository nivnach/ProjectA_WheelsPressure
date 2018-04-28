function [SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData_faster(speed_data)
SpeedData_RR = zeros(1, length(speed_data));
SpeedData_LR = zeros(1, length(speed_data));
SpeedData_RF = zeros(1, length(speed_data));
SpeedData_LF = zeros(1, length(speed_data));


RR_first = char(extractBetween(speed_data,1,2));
RR_second = char(extractBetween(speed_data,3,4));
LR_first = char(extractBetween(speed_data,5,6));
LR_second = char(extractBetween(speed_data,7,8));
RF_first = char(extractBetween(speed_data,9,10));
RF_second = char(extractBetween(speed_data,11,12));
LF_first = char(extractBetween(speed_data,13,14));
LF_second = char(extractBetween(speed_data,15,16));

for i=1:length(speed_data)
    
SpeedData_RR(i) = double((sscanf(RR_first(i),'%x')+256*sscanf(RR_second(i),'%x'))-10000)/100;
SpeedData_LR(i) = double((sscanf(LR_first(i),'%x')+256*sscanf(LR_second(i),'%x'))-10000)/100;
SpeedData_RF(i) = double((sscanf(RF_first(i),'%x')+256*sscanf(RF_second(i),'%x'))-10000)/100;
SpeedData_LF(i) = double((sscanf(LF_first(i),'%x')+256*sscanf(LF_second(i),'%x'))-10000)/100;

end

end