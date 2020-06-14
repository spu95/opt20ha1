function [ff] = createF (d_h, f)
% function [ff] = createF (d_h, f)
% nelem: 1/h (number of intervales)
% f: force function: [0,1] -> R implemented as matlab function, which
% returns function value and derivative at a given x
% ff: vector of function values and derivatives at nodes

h = 1/d_h;

ff = zeros(2*d_h+2,1);

% start with leftmost node
x = 0;

for ii=1:d_h+1
    ff(2*ii-1:2*ii) = f(x);
    x = x + h;
end

end