% function resultImg=GammaMAPFilter(I, windowSize)
%     % I: 输入的SAR图像
%     % windowSize: 滤波窗口的大小（奇数）
%     % a, b: Gamma分布的形状和尺度参数
%     I=double(I);
%     [x, y] = size(I);
%     N = zeros(x, y);
%     padSize = floor(windowSize / 2);
%     I = padarray(I, [padSize padSize], 'symmetric');
%     Cf=1/windowSize;
%     for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
%         for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
%             window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
%             % 计算局部均值和方差
%             localMean = mean(window(:));
%             localVar = var(window(:));
% 
% 
%             Ci=sqrt(localVar)/localMean;
%             alpha=2/(Ci^2-1);
%             if(Ci>=Cf)
%                N(i-(windowSize-1)/2,j-(windowSize-1)/2)=((alpha-2)*(localMean)...
%                    +sqrt(localMean^2+8*alpha*I(i,j)*localMean))/2*alpha;
%             else
%                  N(i-(windowSize-1)/2,j-(windowSize-1)/2)=localMean;
%             end
%         end
%     end
% 
%     % 显示结果
%     resultImg=N;
%     filename = 'result.tif'; 
%     imwrite(N, filename);
% end
function resultImg = GammaMAPFilter(I, windowSize)
    % I: 输入的SAR图像
    % windowSize: 滤波窗口的大小（奇数）
    I = double(I);
    [x, y] = size(I);
    N = zeros(x, y);
    padSize = floor(windowSize / 2);
    I = padarray(I, [padSize padSize], 'symmetric');
    
    % 遍历图像的每个像素
    for i = 1 + padSize : x + padSize
        for j = 1 + padSize : y + padSize
            window = I(i - padSize:i + padSize, j - padSize:j + padSize);
            % 计算局部均值和方差
            localMean = mean(window(:));
            localVar = var(window(:));
            
            % 计算局部方差系数
            C = localVar / localMean^2;
            
            % Gamma MAP滤波公式
            if C > 1
                alpha = 2 / (C - 1);
                beta = alpha * localMean;
                gamma = localMean^2 + 8 * alpha * I(i, j) * localMean;
                N(i - padSize, j - padSize) = ((beta - 2) * localMean + sqrt(gamma)) / (2 * beta);
            else
                % 如果方差系数不大于1，保留原像素值
                N(i - padSize, j - padSize) = I(i, j);
            end
        end
    end

    % 显示结果
    resultImg = N;
    filename = 'GammaMAPResult.tif';
    imwrite(N, filename);
end