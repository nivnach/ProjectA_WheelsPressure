function [timeStampData,speed_data] = getSpeedData_regex(data)
start_text = 'MWSTRM ';
speed_delimiter = '1002a';
idx = 1;
linesIdxPos = strfind(data,speed_delimiter);
linesNum = find(~cellfun(@isempty,linesIdxPos));
speed_data = strings(1,length(linesNum));
data_2(:,1) = data(linesNum,1);
%speed_part_ = regexp(data_2, '(?<=\s*1002a)(\w+)\s*','match');
speed_part_ = regexp(data_2, '\s*1002a(\w+)\s*','match');
for k=1:length(speed_part_)
    temp = speed_part_{k};
    for i=1:length(speed_part_{k})
        if strlength(string(temp(i))) == (16+length(speed_delimiter))
            temp_speed = char(temp(i));
            speed_data(idx) = temp_speed(6:end);
            idx = idx + 1;
        end
    end
end

data_2 = string(data_2);
timeStampData = extractBetween(data_2,length(start_text)+1,length(start_text)+6);
end