function [SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData(speed_data)
%SpeedData_RR = double((hex2dec(extractBetween(speed_data,1,2))+256*hex2dec(extractBetween(speed_data,3,4)))-10000)/100;
%SpeedData_LR = double((hex2dec(extractBetween(speed_data,5,6))+256*hex2dec(extractBetween(speed_data,7,8)))-10000)/100;
%SpeedData_RF = double((hex2dec(extractBetween(speed_data,9,10))+256*hex2dec(extractBetween(speed_data,11,12)))-10000)/100;
%SpeedData_LF = double((hex2dec(extractBetween(speed_data,13,14))+256*hex2dec(extractBetween(speed_data,15,16)))-10000)/100;

SpeedData_RR = zeros(1, length(speed_data));
SpeedData_LR = zeros(1, length(speed_data));
SpeedData_RF = zeros(1, length(speed_data));
SpeedData_LF = zeros(1, length(speed_data));

for i=1:length(speed_data)
    
RR_first = char(extractBetween(speed_data(i),1,2));
RR_second = char(extractBetween(speed_data(i),3,4));
LR_first = char(extractBetween(speed_data(i),5,6));
LR_second = char(extractBetween(speed_data(i),7,8));
RF_first = char(extractBetween(speed_data(i),9,10));
RF_second = char(extractBetween(speed_data(i),11,12));
LF_first = char(extractBetween(speed_data(i),13,14));
LF_second = char(extractBetween(speed_data(i),15,16));

%sscanf(str,'%x') 
SpeedData_RR(i) = double((sscanf(RR_first,'%x')+256*sscanf(RR_second,'%x'))-10000)/100;
SpeedData_LR(i) = double((sscanf(LR_first,'%x')+256*sscanf(LR_second,'%x'))-10000)/100;
SpeedData_RF(i) = double((sscanf(RF_first,'%x')+256*sscanf(RF_second,'%x'))-10000)/100;
SpeedData_LF(i) = double((sscanf(LF_first,'%x')+256*sscanf(LF_second,'%x'))-10000)/100;
end
end