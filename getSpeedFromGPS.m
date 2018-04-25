function [gpsSpeedData] = getSpeedFromGPS(data)
start_text = 'MWSTRM ';
gps_delimiter = '10033';
gps_index = 1;
gpsDataLength = 28;
soh_delimiter = '\u';
b1 = ones(1,gpsDataLength);
linesIdxPos = strfind(data,gps_delimiter);
linesNum = find(~cellfun(@isempty,linesIdxPos));
%gps_data = strings(1,length(linesNum));
idx = 1;
data_2(:,1) = data(linesNum,1);
for i=1:length(linesNum)
     line = cell2mat(linesIdxPos(linesNum(i)));
     gps_line = string(data_2(i,1));
     %need to get all gps data, check every time if in the next 28 chars
     %we have a soh, maybe by doing str2hex and check if it returns NaN.
     start_pos = length(gps_delimiter) + line(1);
     gps_part = extractBetween(gps_line,start_pos,start_pos+gpsDataLength-1);
     b = isstrprop(gps_part, 'xdigit');
     if (b == b1)
         if  (strlength(gps_part)==gpsDataLength)
        gps_data(idx) = gps_part;
        time_stamp_data(idx) = extractBetween(gps_line,length(start_text)+1,length(start_text)+6);
        time_stamp_data(idx) = (hex2dec(time_stamp_data(idx)) * 0.001);
        idx = idx + 1;
         end
     end
end

offset = 18000000;
res = 0.00001;
% analyze the gps data:
lonDegData = double((hex2dec(extractBetween(gps_data,1,8))-offset)*res);
latDegData = double((hex2dec(extractBetween(gps_data,9,16))-offset)*res);
time_stamp_data = double(time_stamp_data);
%from nadav's equation:
%% calcaulate distance and speed between each two following coordinates
for i=2:length(latDegData)
   [dist ~] = deg2dist(latDegData(i-1),lonDegData(i-1),latDegData(i),lonDegData(i)); %[km]
   v(i-1,1) = double(dist*3600/((time_stamp_data(i) - time_stamp_data(i-1)))); %[km/h]
end
v(i,1) = 0; % just for same length as time vector
gpsSpeedData = v;
end