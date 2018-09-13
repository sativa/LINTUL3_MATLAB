function [irradiation,precipitation,Tmin,Tmax,day,Pvap,MeanWindSpeed] = Read_Weatherfile(filename, startDay, endDay)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [COUNTRY,NETHERL,ANDS,VARNAME4,VARNAME5,VARNAME6,VARNAME7,VARNAME8,VARNAME9]
%   = IMPORTFILE(FILENAME) Reads data from text file FILENAME for the
%   default selection.
%
%   [COUNTRY,NETHERL,ANDS,VARNAME4,VARNAME5,VARNAME6,VARNAME7,VARNAME8,VARNAME9]
%   = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows STARTROW
%   through ENDROW of text file FILENAME.
%
% Example:
%   [Country,Netherl,ands,VarName4,VarName5,VarName6,VarName7,VarName8,VarName9] = importfile('NLD6.987',24, 388);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2018/09/07 12:13:48

%% Initialize variables.
if nargin<=2
    startRow = 24;
    endRow = inf;
end
%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%10f%8f%8f%11f%9f%10f%9f%10f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
irradiation = dataArray{:, 4}/1000;
precipitation = dataArray{:, 9};
Tmin = dataArray{:, 5};
Tmax = dataArray{:, 6};
day = dataArray{:, 3};
Pvap = dataArray{:, 7};
MeanWindSpeed = dataArray{:, 8};

