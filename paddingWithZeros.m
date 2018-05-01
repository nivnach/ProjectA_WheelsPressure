function [paddedData] = paddingWithZeros(data)

data_Len = length(data);
leftForMod2 = mod(data_Len,2);
data(end:end+leftForMod2) = 0;
paddedData = data;
end