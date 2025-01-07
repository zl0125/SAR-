function [PSNR,ENL,EPI] = Evaluate(I,N)
    %峰值信噪比（PSNR）、信噪比增强（ENL）和边缘保持指标（EPI）
    %较高的 PSNR 表示较低误差，
    %较高的 ENL 表示较好的去噪效果，
    %接近 1 的 EPI 表示边缘信息得到了较好的保留。
    
    f1=I;
    f2=N;
    [x,y]=size(f1);
    G1=double(f1);
    G2=double(f2);
    [m1,n1]=size(G1);
    [m2,n2]=size(G2);
    m=min(m1,m2);
    n=min(n1,n2);
    b=0;
    b=max(G1(:));
    c=0;
    for i=1:m
        for j=1:n
            w=G1(i,j)-G2(i,j);
            c=c+w^2;
        end
    end
    PSNR=10*log10(b^2*m*n/c)+0.00001;
    ENL=mean(N(:))^2/var(N(:));
    sum1=0;
    sum2=0;
    %去噪前
    for i=1:x   %水平
        for j=1:y-1
            sum1=sum1+abs(I(i,j)-I(i,j+1));
        end
    end
    for i=1:x-1  %垂直
        for j=1:y
            sum1=sum1+abs(I(i,j)-I(i+1,j));
        end
    end
    
    for i=1:x  %水平
        for j=1:y-1
            sum2=sum2+abs(N(i,j)-N(i,j+1));
        end
    end
    for i=1:x-1  %垂直
        for j=1:y
            sum2=sum2+abs(N(i,j)-N(i+1,j));
        end
    end
    sum1=double(sum1);
    sum2=double(sum2);
    EPI=sum2/sum1;
end

