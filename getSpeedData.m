function [timeStampData,speed_data] = getSpeedData(data)
start_text = 'MWSTRM ';
speed_delimiter = '1002a';
delimiter_len = length(speed_delimiter);
speed_data_len = 16;
idx = 1;
linesIdxPos = strfind(data,speed_delimiter);
linesNum = find(~cellfun(@isempty,linesIdxPos));
speed_data = strings(1,length(linesNum));
data_2(:,1) = data(linesNum,1);
for i=1:length(linesNum)
   line = cell2mat(linesIdxPos(linesNum(i)));
   speed_part = string(data_2(i,1));
   temp_cell = linesIdxPos(linesNum(i),1);
   for j=1:length(temp_cell{1,1})
      start_pos = line(j)+delimiter_len;
      speed_part_ = extractBetween(speed_part,start_pos,start_pos+speed_data_len-1);
      speed_data(idx) = speed_part_;
      idx = idx + 1;
   end
end
data_2 = string(data_2);
timeStampData = extractBetween(data_2,length(start_text)+1,length(start_text)+6);
end