function resultImg = Leefilter(I, windowSize)
    % I: 输入的SAR图像
    % windowSize: 滤波窗口的大小（奇数）
    [x, y] = size(I);
    N = zeros(x, y);
    padSize = floor(windowSize / 2);
    I = padarray(I, [padSize padSize], 'symmetric');
    %用滤波窗口的倒数作为斑点噪声的局部方差系数
    Cf=1/windowSize;
   for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
        for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
            window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
            % 计算局部均值和方差
            localMean = mean(window(:));
            localVar = var(window(:));
            %计算局部方差系数
            Ci=localVar / localMean^2;
            if(localMean == 0)
                k = 0;
            else
                k = (1 - (Cf^2)/(Ci^2));
            end
            if(k<0)
                k = 0;
            end
            N(i-(windowSize-1)/2,j-(windowSize-1)/2) = localMean + k*(I(i,j) - localMean);
        end
    end
    resultImg=N;
    filename = 'result.tif'; 
    imwrite(N, filename);
end

