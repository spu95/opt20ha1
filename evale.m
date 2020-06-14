function ex = evale(x,e)
% function ex = evale(x,e)
% x      :  evaluation point
% e      :  design vector
% ex     :  function value evaluated at x

ex = 0;

if x >= 1
    return;
elseif x <= 0
    return;
end

n = length(e);
h = 1/n;

% code for evaluation of p.w. function here
ex = e(floor(x/h)+1);