function [Mglob] = createMglob (Mloc, d_h)
% function [Mglob] = createMglob (Mloc, d_h)
% Mloc   :    local stiffness matrix on element of length h
% d_h    :    number of intervals in partition Delta_h
% Mglob  :    global stiffness matrix (after application of b.c.)
    
% Initialize
Mglob = sparse(2*(d_h+1), 2*(d_h+1));

% Assemble

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% complete the codes here %
%%%%%%%%%%%%%%%%%%%%%%%%%%% 
for l=1:d_h
    Mlocfull = spalloc(2*d_h+2, 2*d_h+2,4*4);
    for ii = 1:4
        for jj = 1:4
            Mlocfull(2*l-2+ii,2*l-2+jj) = Mloc(ii,jj);
        end
    end
    Mglob = Mglob + Mlocfull;   
end
