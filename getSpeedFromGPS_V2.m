function [v] = getSpeedFromGPS_V2(data)
%%find gps data
linesCount = 1;
for i=1:size(data,1)
    str = string(data(i,1));
    idIndexes = strfind(str,'4001');
    idIndexes2 = strfind(str,'4002');
    if ~isempty(idIndexes) && ~isempty(idIndexes2)% get lines with GPS data
        %gpsLines(linesCount,1) = regexp(str, '\S*4001(\S+).4002(\S+)*','match');
        %lon(linesCount,1) =regexp(str, '(?<=\S*4001)\w+','match');
        %lat(linesCount,1) =regexp(str, '(?<=\W4002)\w+','match');
        TimeStamp_ms(linesCount, 1) = extractBetween(str,8,13);
        TimeStamp_s(linesCount, 1) = hex2dec(TimeStamp_ms(linesCount, 1)) * 0.001;
        
        lonHex(linesCount,1) = extractBetween(str, idIndexes+4,idIndexes+10);
        latHex(linesCount,1) = extractBetween(str, idIndexes2(1)+4,idIndexes2(1)+10);
        lonDeg(linesCount,1) = (((hex2dec(lonHex(linesCount,1)))-180000000)/100000);
        latDeg(linesCount,1) = ((hex2dec(latHex(linesCount,1)))-180000000)/100000;
        linesCount = linesCount + 1;
    end
end

%% calcaulate distance and speed between each two following coordinates
for i=2:length(latDeg)
   [dist ~] = deg2dist(latDeg(i-1),lonDeg(i-1),latDeg(i),lonDeg(i)); %[km]
   v(i-1,1) = double(dist*3600/((TimeStamp_s(i, 1) - TimeStamp_s(i-1, 1)))); %[km/h]
end
v(i,1) = 0; % just for same length as time vector
% [d1 ~] = deg2dist(latDeg(151),lonDeg(151),latDeg(152),lonDeg(152)) %[km]
% v = double(d1*3600/((TimeStamp_s(152, 1) - TimeStamp_s(151, 1)))) %[km/h]


end