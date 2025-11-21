%
% This is an Octave script for extracting x/y data from a .fig file
% obtained with a line-profile generator in XMapTools.
%
% Author: Ryo Fukushima (Kochi JAMSTEC)
% ver. Nov-20-2025
%
clear,close all
[FileName, PathName, FilterIndex] = uigetfile({'*.fig'},'File Selector');

figstruct = load(strcat(PathName,FileName),'-mat');
mainfield = fieldnames(figstruct);
figstruct = figstruct.(mainfield{1});

idx = 0;
for i = 1:length(figstruct.children)
  if strcmp(getfield(figstruct.children, {i}, 'type'),'axes')
    idx = i;
  end
end

XinMicron = figstruct.children(idx).children(1).properties.XData;
data1 = figstruct.children(idx).children(1).properties.YData;
data2 = figstruct.children(idx).children(2).properties.YData;

plot(XinMicron, data1, XinMicron, data2);
title(FileName,"interpreter", "none")
xlabel("Distance in um");
ylabel("Intensity");
legend("show");

exportmatrix = [XinMicron;data1;data2]';
csvwrite(strcat(FileName,".csv"), exportmatrix);






