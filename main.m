%% start fresh:
tic
clear all; clc; close all;

%% get the input file:
[filesPaths, filesNames] = getInputFilesPaths();
%for now, we will do only for the 1st file:
filePath = filesPaths;
fileName = filesNames;
%% get file data:
fileData = getInputFileData(filePath,fileName);
Data_Start_Indicator = 'Start DATA';
startIndex = find(contains(fileData,Data_Start_Indicator));
fileData = fileData(startIndex+1:end);
%% get speed raw data
[speed_timeStampRawData,SpeedRawData] = getSpeedData(fileData);
%% analyze speed data and get every wheel real speed
[SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData(SpeedRawData);

%% analyze time stamp of the speed data:
%[timeStampInSeconds] = getTimeInSeconds(speed_timeStampRawData);
%% show speed on graph:
%t = timeStampInSeconds;
t = 0:0.01:(length(SpeedData_LF)-1)*0.01;
figure();
plot(t,SpeedData_LF,'blue'); hold on;
plot(t,SpeedData_RF,'red');
plot(t,SpeedData_LR,'green');
plot(t,SpeedData_RR,'black');
legend('Left Front','Right Front','Left Rear','Right Rear');
hold off;

%% get speed from gps pos:
[gpsSpeedData] = getSpeedFromGPS(fileData);

%% show speed from gps on graph:
t_gps = 0:0.01:(length(gpsSpeedData)-1)*0.01;
figure();
plot(t_gps,gpsSpeedData,'blue');
%% finish
toc
