function [SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData(speed_data)

SpeedData_RR = double((hex2dec(extractBetween(speed_data,1,2))+256*hex2dec(extractBetween(speed_data,3,4)))-10000)/100;
SpeedData_LR = double((hex2dec(extractBetween(speed_data,5,6))+256*hex2dec(extractBetween(speed_data,7,8)))-10000)/100;
SpeedData_RF = double((hex2dec(extractBetween(speed_data,9,10))+256*hex2dec(extractBetween(speed_data,11,12)))-10000)/100;
SpeedData_LF = double((hex2dec(extractBetween(speed_data,13,14))+256*hex2dec(extractBetween(speed_data,15,16)))-10000)/100;


end