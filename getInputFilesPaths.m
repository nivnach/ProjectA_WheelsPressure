function [filesPaths, filesNames] = getInputFilesPaths()

dinfo = dir('InputFiles/*.txt');
numOfFiles = length(dinfo);
%only 1 file for now
fileName = dinfo(1).name;  %just the name
filesPaths = [pwd '\InputFiles\' fileName];
filesNames = fileName;

end