function [fileData] = getInputFileData(filePath, fileName)
%copy the file to the run folder:
newFilePath = [pwd '\' fileName];
copyfile(filePath,newFilePath);

% put the entire text in data:
fileData = importdata(fileName);
if(~iscell(fileData))
    fileData = fileData.textdata;
end


% Delete the new file we used:
delete(newFilePath);
end