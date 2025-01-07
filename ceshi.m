
inpath="D:\Users\79877\Desktop\guoc";
outputFileName="a.jpg";
if isempty(outpath)
    % 用户选择了文件夹，将路径赋值给 filepath
    outpath = inpath;
end
if ~endsWith(outpath, filesep)
    outpath = outpath+"\";
end

% 构建完整的文件路径
fullOutputPath = outpath+outputFileName;
outfilepath = fullOutputPath;
disp(outfilepath)