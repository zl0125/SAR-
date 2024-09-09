function resultImg=Kuanfilter(I, windowSize)
    % I: 输入的SAR图像
    % windowSize: 滤波窗口的大小（奇数）
    
    [x, y] = size(I);
    N = zeros(x, y);
    padSize = floor(windowSize / 2);
    I = padarray(I, [padSize padSize], 'symmetric');
    
 for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
        for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
            window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
            % 计算局部均值和方差
            localMean = mean(window(:));
            localVar = var(window(:));
            % 计算权重
            w = exp(-((window - localMean).^2) / (2 * localVar));
            % 应用Kuan滤波
             N(i-(windowSize-1)/2,j-(windowSize-1)/2) = sum(w(:) .* window(:)) / sum(w(:));
        end
    end
    resultImg=N;
    filename = 'result.tif'; 
    imwrite(N, filename);
end
