function [A,b] = createSlopeCond(d_h, L)
% Create a matrix that holds our slope conditions and is of the form
% [ 1 -1
% [ -1 1
% [    1 -1
% [    -1 1 ...

h = 1/d_h;
A = sparse(2*d_h, d_h);
b = L*h*ones(1,2*d_h);

j = 1;
for i = 1:d_h
    if mod(j,2) == 1
        A(2*i-1:2*i,j) = [1,-1];
    else
       A(2*i-1:2*i,j) = [-1,1];
    end
    j = j+1;
end

end

