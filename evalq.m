function qx = evalq(x,coeff)
% function qx = evalq(x,coeff)
% x      :  evaluation point
% coeff  :  coefficient vector (= displacement vector, algebraic form)
% qx     :  function value evaluated at x

if x >= 1
    return;
elseif x <= 0
    return;
end

n_h = length(coeff)/2 - 1;
h = 1/n_h;

% evaluation of p.w. hermite polynomial here
psi = [2,-3,0,1;
    1,-2,1,0;
    -2,3,0,0;
    1,-1,0,0];

ii = ceil(x/h)+1;
qx = zeros(max(ii),1);
for i = 1:size(ii,2)
    idx = ii(i);
    poly = (psi .* coeff(2*idx-1:2*idx+2)) * ones(4,1);
    qx(idx) = polyval(poly, x(idx));
end
    
%qx(n_h) = 0;

end