function resultImg = MedianFilter(I, windowSize)
% I: 输入的SAR图像
 % windowSize: 滤波窗口的大小（奇数）

     if windowSize/2==0
         windowSize=windowSize+1;
     end
     [x, y] = size(I);
     N = zeros(x, y);
     padSize = floor(windowSize / 2);
     I = padarray(I, [padSize padSize], 'symmetric');
     for i = 1+(windowSize-1)/2:x+(windowSize-1)/2
        for j = 1+(windowSize-1)/2:y+(windowSize-1)/2
             window = I(i-(windowSize-1)/2:i+(windowSize-1)/2, j-(windowSize-1)/2:j+(windowSize-1)/2);
             N(i-(windowSize-1)/2,j-(windowSize-1)/2)=median(window(:));
         end
     end
    
     % 显示结果
     resultImg=N;
     filename = 'result.tif';
     imwrite(N, filename);
end

