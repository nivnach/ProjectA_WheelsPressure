function [decision] = WheelVibrationsAlgorithm(RR_AP,RF_AP,LR_AP, LF_AP,isCalibration)
%% if len is not power of 2, add zeros at the end:
RR_AP = paddingWithZeros(RR_AP);
% RR_AP_Len = length(RR_AP);
RF_AP = paddingWithZeros(RF_AP);
% RF_AP_Len = length(RF_AP);
LR_AP = paddingWithZeros(LR_AP);
% LR_AP_Len = length(LR_AP);
LF_AP = paddingWithZeros(LF_AP);
% LF_AP_Len = length(LF_AP);
%% FFT and finding peak:
FFT_RR_AP = fft(RR_AP);
FFT_RF_AP = fft(RF_AP);
FFT_LR_AP = fft(LR_AP);
FFT_LF_AP = fft(LF_AP);

RR_Peak = max(FFT_RR_AP);
RF_Peak = max(FFT_RF_AP);
LR_Peak = max(FFT_LR_AP);
LF_Peak = max(FFT_LF_AP);

%% handle peaks:
  calibrationFileName = 'CalibrationFile/CalibrationData_Vibrations.txt';
if isCalibration == 1
    % save the data in the calibration text file and finish
    fileID = fopen(calibrationFileName,'w');
    fprintf(fileID,'LF FFT peak: %5d\n',LF_Peak);
    fprintf(fileID,'RF FFT peak: %5d\n',RF_Peak);
    fprintf(fileID,'LR FFT peak: %5d\n',LR_Peak);
    fprintf(fileID,'RR FFT peak: %5d\n',RR_Peak);
    fclose(fileID);
    decision = -1;
else
%     read data from calibration file and compare to our results:
      fileID = fopen(calibrationFileName,'r');
      peaks = zeros(1,4);
      for i=1:4
          tline = fgetl(fileID);
          splitLine = strsplit(tline,':');
          splitMat = cell2mat(splitLine(2));
          peaks(i) = str2double(splitMat);
      end     
     fclose(fileID);
     %make the decision according to our IRS
     decision = 1;
end

end








% for graph:
% t = 0:0.01:(RR_AP_Len-1)*0.01;
% Fs=1/(t(2)-t(1)); %sampling freq
% f_RR =linspace(-Fs/2,Fs/2,length(FFT_RR_AP));
% f_LR =linspace(-Fs/2,Fs/2,length(FFT_LR_AP));
% f_RF =linspace(-Fs/2,Fs/2,length(FFT_RF_AP));
% f_LF =linspace(-Fs/2,Fs/2,length(FFT_LF_AP));