function returnPath=pathCheck(path)
if isempty(path)
    disp('不存在路径');
else
    currentPath=mfilename('fullpath');
    [directoryPath,~,~]=fileparts(currentPath);
    [parentDirectoryPath,~,~]=fileparts(directoryPath);
    returnPath=fullfile(parentDirectoryPath,path);
    if ispc
        returnPath=strrep(returnPath,'/','\');
    end
    if isunix
        returnPath=strrep(returnPath,'\','/');
    end

end


        