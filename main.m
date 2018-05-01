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
%[speed_timeStampRawData,SpeedRawData] = getSpeedData(fileData);
%% get speed raw data with regex
[speed_timeStampRawData,SpeedRawData] = getSpeedData_regex(fileData);
%% analyze speed data and get every wheel real speed
%tic
[SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF] = analyzeSpeedData(SpeedRawData);
%toc
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
title('wheel Speed');
xlabel('t[sec]');
ylabel('Wheel Speed');
hold off;

%% Get speeds data without turns:
threshold_in_kmh = 1.9;
[RR_noTurns, LR_noTurns, RF_noTurns, LF_noTurns] = removeTurns(SpeedData_RR,SpeedData_LR,SpeedData_RF,SpeedData_LF, threshold_in_kmh);
%% plot the speeds data without turns:
figure;
plot(RR_noTurns,'blue');hold on;
plot(RF_noTurns,'green');
plot(LR_noTurns,'red');
plot(LF_noTurns,'black');
hold off;
legend('Right Rear','Right Front','Left Rear','Left Front');
%% remove acc and breaks from RR:
RR_noAccAndBreaks = removeAccAndBreaks(RR_noTurns,0.15);
figure;
plot(RR_noAccAndBreaks);

%% remove standing (speed = 0)
RR_noStanding = removeStanding(RR_noAccAndBreaks,10);
figure;
plot(RR_noStanding);
%% AP = After Preproccessed
RR_AP_Len = length(RR_noStanding);
leftForMod2 = mod(RR_AP_Len,2);
RR_AP = RR_noStanding;
RR_AP(end:end+leftForMod2) = 0;
RR_AP_Len = length(RR_AP);
FFT_RR_AP = fft(RR_AP);
Fs=1/(t(2)-t(1)); %sampling freq
f =linspace(-Fs/2,Fs/2,length(FFT_RR_AP));
figure;
plot(f,FFT_RR_AP);
title('FFT');
IFFT_RR_AP = ifft(FFT_RR_AP);
t = 0:0.01:(length(IFFT_RR_AP)-1)*0.01;
figure;
plot(t,IFFT_RR_AP);
title('IFFT');
%% get speed from gps pos:
[gpsSpeedData] = getSpeedFromGPS(fileData);

%% show speed from gps on graph:
t_gps = 0:0.01:(length(gpsSpeedData)-1)*0.01;
figure();
plot(t_gps,gpsSpeedData,'blue');

%% get speed from gps with 4001 not 10033:
[gpsSpeedData_V2] = getSpeedFromGPS_V2(fileData);
t_gps_V2 = 0:0.01:(length(gpsSpeedData_V2)-1)*0.01;
figure();
plot(t_gps_V2,gpsSpeedData_V2,'red');

%% 10033 on 4001 graphs:
figure;
plot(t_gps,gpsSpeedData,'blue');hold on;
plot(t_gps_V2,gpsSpeedData_V2,'red');
legend('from 10033 samples','from 4001&4002 samples');
title('GPS Speed from lon&lat samples');
hold off;

%% trying to do the FFT algorithem:
FFT_LF = fft(SpeedData_LF);
FFT_RF = fft(SpeedData_RF);
FFT_RR = fft(SpeedData_RR);
FFT_LR = fft(SpeedData_LR);
Fs=1/(t(2)-t(1)); %sampling freq
Ts = 1/Fs;
f =linspace(-Fs/2,Fs/2,length(FFT_LF));
% figure;
% plot(f,FFT_LF);
% title('LF Speed FFT');
fft_peak_LF = max(FFT_LF);
fft_peak_RF = max(FFT_RF);
fft_peak_RR = max(FFT_RR);
fft_peak_LR = max(FFT_LR);
% figure;
% plot(t,IFFT_LF);
% title('LF Speed IFFT');
IFFT_LF = ifft(FFT_LF);
IFFT_RF = ifft(FFT_RF);
IFFT_RR = ifft(FFT_RR);
IFFT_LR = ifft(FFT_LR);

ifft_peak_LF = max(IFFT_LF);
ifft_peak_RF = max(IFFT_RF);
ifft_peak_RR = max(IFFT_RR);
ifft_peak_LR = max(IFFT_LR);


%% finish
toc
