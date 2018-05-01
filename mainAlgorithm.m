%% start fresh:
clear all; clc;
%% Calibration Run or Test Run ?
isCalibration = 0;
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
%% get speed raw data with regex
[speed_timeStampRawData,SpeedRawData] = getSpeedData_regex(fileData);
%% analyze speed data and get every wheel real speed
%tic
[SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData(SpeedRawData);
%toc
%% Get speeds data without turns:
threshold_in_kmh = 1.9;
[RR_noTurns, LR_noTurns, RF_noTurns, LF_noTurns] = removeTurns(SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF, threshold_in_kmh);
%% remove acc and breaks from RR:
RR_noAccAndBreaks = removeAccAndBreaks(RR_noTurns,0.15);
RF_noAccAndBreaks = removeAccAndBreaks(RF_noTurns,0.15);
LR_noAccAndBreaks = removeAccAndBreaks(LR_noTurns,0.15);
LF_noAccAndBreaks = removeAccAndBreaks(LF_noTurns,0.15);
%% remove standing (speed = 0)
RR_noStanding = removeStanding(RR_noAccAndBreaks,30);
RF_noStanding = removeStanding(RF_noAccAndBreaks,30);
LR_noStanding = removeStanding(LR_noAccAndBreaks,30);
LF_noStanding = removeStanding(LF_noAccAndBreaks,30);
%% remove noise 
% TODO
%% Set the last speed data: (AP = after preprocessed)
RR_AP = RR_noStanding;
RF_AP = RF_noStanding;
LR_AP = LR_noStanding;
LF_AP = LF_noStanding;
%% Wheel Vibrations Algorithm:
[vibrations_decision] = WheelVibrationsAlgorithm(RR_AP,RF_AP,LR_AP,LF_AP,isCalibration);
