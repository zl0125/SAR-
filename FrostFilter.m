function resultImg=FrostFilter(I, windowSize, alpha)
    % I: 输入的SAR图像
    % windowSize: 滤波窗口的大小（奇数）
    % alpha: 是一个微调因子，值越小，则边缘的保持效果不好，而斑点噪声平滑效果好；
    % alpha值越大，则边缘的保持效果越好，而斑点噪声平滑效果越差。
    [x, y] = size(I);
    N = zeros(x, y);
    padSize = floor(windowSize / 2);
    I = padarray(I, [padSize padSize], 'symmetric');
    distances = zeros(windowSize,windowSize);
    
    %计算距离矩阵(欧氏距离)
    for i = 1:windowSize
        for j = 1:windowSize
            distances(i,j)=sqrt((i-(windowSize+1)/2)^2+sqrt(j-(windowSize+1)/2)^2);
        end
    end

    for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
        for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
            window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
            % 应用Frost滤波
            N(i-(windowSize-1)/2,j-(windowSize-1)/2) = sum(window .* exp(-alpha * distances.^2)) / sum(exp(-alpha * distances.^2));
        end
    end
    resultImg=N;
    filename = 'result.tif'; 
    imwrite(N, filename);
end
