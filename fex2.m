% Example: constant load

function [ res ] = fex2(x)
    mu = 0.01;
    sigma2 = 0.5;
    fx = (-2e7)* (1/sqrt(2*pi*sigma2))*exp(-(x-mu)^2/(2*sigma2));
    dfx = (-2e7)*(-(x-mu)/sigma2)* ...
        (1/sqrt(2*pi*sigma2))*exp(-(x-mu)^2/(2*sigma2));
    %fx = -2000.0*(x(1)*(x(1)-1));
    %dfx = -2000*(2*x(2)-1);
    res = [fx,dfx];
end