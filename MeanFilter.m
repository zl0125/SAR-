function resultImg = MeanFilter(I, windowSize)
 % I: 输入的SAR图像
 % windowSize: 滤波窗口的大小（奇数）

    if windowSize/2==0
        windowSize=windowSize+1;
    end
    if size(I)<3
        [x, y] = size(I);
        N = zeros(x, y);
        padSize = floor(windowSize / 2);
        I = padarray(I, [padSize padSize], 'symmetric');
        for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
            for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
                window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
                % 计算局部均值
                localMean = mean(window(:));
                N(i-(windowSize-1)/2,j-(windowSize-1)/2)=localMean;
            end
        end
    else
        [x, y, ~] = size(I);
        N = zeros(x, y, 3); % 注意这里增加了第三个维度，用于存储三个颜色通道的结果
        padSize = floor(windowSize / 2);
        I = padarray(I, [padSize padSize], 'symmetric');
        for k = 1:3 % 遍历每个颜色通道
            for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
                for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
                    window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2, k);
                    % 计算局部均值
                    localMean = mean(window(:));
                    N(i-(windowSize-1)/2,j-(windowSize-1)/2,k)=localMean;
                end
            end
        end
    end
    % 显示结果
    resultImg=N;
    filename = 'result.tif'; 
    imwrite(N, filename);
end

