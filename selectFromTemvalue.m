function selectedKey=selectFromTemvalue(obj)
temp_value_dict = obj.tempValue;
selected_value = obj.value;
keys=fieldnames(temp_value_dict);
values=struct2cell(temp_value_dict);
numTempvalue=length(keys);
for i=1:numTempvalue
    value=values{i};
    if selected_value==value
        selectedKey=keys{i};
    end
end

