% Example: constant load

function [ res ] = fex1(x)
    fx = -2000.0;
    dfx = 0;
    %fx = -2000.0*(x(1)*(x(1)-1));
    %dfx = -2000*(2*x(2)-1);
    res = [fx,dfx];
end