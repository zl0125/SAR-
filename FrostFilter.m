function resultImg = FrostFilter(I, windowSize, alpha)
    % I: 输入的SAR图像
    % windowSize: 滤波窗口的大小（奇数）
    % alpha: 是一个微调因子，值越小，则边缘的保持效果不好，而斑点噪声平滑效果好；
    % alpha值越大，则边缘的保持效果越好，而斑点噪声平滑效果越差。
    
    [x, y] = size(I);
    N = zeros(x, y);
    padSize = floor(windowSize / 2);
    I = padarray(I, [padSize padSize], 'symmetric');
    
    % 创建距离矩阵 (欧氏距离)
    distances = zeros(windowSize, windowSize);
    for i = 1:windowSize
        for j = 1:windowSize
            distances(i,j) = sqrt((i - (windowSize + 1) / 2)^2 + (j - (windowSize + 1) / 2)^2);
        end
    end

    % 处理图像
    for i = 1 + (windowSize - 1) / 2 : x + (windowSize - 1) / 2
        for j = 1 + (windowSize - 1) / 2 : y + (windowSize - 1) / 2
            % 提取当前窗口
            window = double(I(i - (windowSize - 1) / 2 : i + (windowSize - 1) / 2, ...
                               j - (windowSize - 1) / 2 : j + (windowSize - 1) / 2));
            % 应用 Frost 滤波
            N(i - (windowSize - 1) / 2, j - (windowSize - 1) / 2) = ...
                sum(window .* exp(-alpha * distances.^2), 'all') / sum(exp(-alpha * distances.^2), 'all');
        end
    end

    % 返回处理结果
    resultImg = N;
    filename = 'result.tif'; 
    imwrite(N, filename);
end
