function [RR_decision,RF_decision,LR_decision,LF_decision] = WheelVibrationsAlgorithm(RR_AP,RF_AP,LR_AP, LF_AP,isCalibration,fileName)
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
LF_decision = -1;
LR_decision= -1;
RR_decision = -1;
RF_decision = -1;
calibrationFileName = 'CalibrationFile/CalibrationData_Vibrations.txt';
if isCalibration == 1
    % save the data in the calibration text file and finish
    fileID = fopen(calibrationFileName,'w');
    fprintf(fileID,'LF FFT peak: %5d\n',LF_Peak);
    fprintf(fileID,'RF FFT peak: %5d\n',RF_Peak);
    fprintf(fileID,'LR FFT peak: %5d\n',LR_Peak);
    fprintf(fileID,'RR FFT peak: %5d\n',RR_Peak);
    fclose(fileID);
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
     if LF_Peak > peaks(1)
         LF_decision = 1;
     else
         LF_decision = 0;
     end
       if RF_Peak > peaks(2)
         RF_decision = 1;
     else
         RF_decision = 0;
       end
       if LR_Peak > peaks(3)
         LR_decision = 1;
     else
         LR_decision = 0;
     end
     if RR_Peak > peaks(4)
         RR_decision = 1;
     else
         RR_decision = 0;
     end
     %% For Testing easier:
     if exist('Tests_Results','dir') ~= 7
        mkdir Tests_Results; 
     end
     fileNameSplit = strsplit(fileName,'_');
     resultsFileName = strcat('Tests_Results\' ,string(fileNameSplit(end)));
     fid_results = fopen(resultsFileName,'w');
     fprintf(fid_results,'Peak Data for Input file number %s\n',string(fileNameSplit(end)));
     fprintf(fid_results,'LF FFT peak: %5d\n',LF_Peak);
     fprintf(fid_results,'RF FFT peak: %5d\n',RF_Peak);
     fprintf(fid_results,'LR FFT peak: %5d\n',LR_Peak);
     fprintf(fid_results,'RR FFT peak: %5d\n',RR_Peak);
     fclose(fid_results);
     %% 
end

end








% for graph:
% t = 0:0.01:(RR_AP_Len-1)*0.01;
% Fs=1/(t(2)-t(1)); %sampling freq
% f_RR =linspace(-Fs/2,Fs/2,length(FFT_RR_AP));
% f_LR =linspace(-Fs/2,Fs/2,length(FFT_LR_AP));
% f_RF =linspace(-Fs/2,Fs/2,length(FFT_RF_AP));
% f_LF =linspace(-Fs/2,Fs/2,length(FFT_LF_AP));