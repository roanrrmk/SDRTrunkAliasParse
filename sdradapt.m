clear all
close all
clc
tdfread('alltalkgroups.txt')
data = table(Decimal,Encrypted,Name,Group);
data = data(sum(data.Encrypted =='DE',2) ~= 2,:);
data.Names = strings(length(data.Decimal),1);
data.Groups = strings(length(data.Decimal),1);
for i = 1:length(data.Decimal)
data.Names(i) = strtrim(convertCharsToStrings(data.Name(i,:)));
data.Groups(i) = strtrim(convertCharsToStrings(data.Group(i,:)));
data.Names(i) = strrep(data.Names(i),',',' ');
data.Groups(i) = strrep(data.Groups(i),',',' ');
data.Names(i) = strrep(data.Names(i),'"','');
data.Groups(i) = strrep(data.Groups(i),'"','');
end
% return
fileID = fopen('Aliases.txt','w');
for i = 1:length(data.Decimal)
fprintf(fileID,['  <alias name="%s" color="-16777216" group="%s" list="MIAMI" iconName="No Icon">\n'...
'    <id type="priority" priority="10"/>\n'...
'    <id type="talkgroup" value="%d" protocol="APCO25"/>\n'...
'  </alias>\n']...
,data.Names(i,:),data.Groups(i,:),data.Decimal(i));
end