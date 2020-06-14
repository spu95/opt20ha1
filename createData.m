function [Kloc,ff] = createData (d_h, f)
% function [Kloc,ff] = createData (d_h, f)
% d_h    :  number of intervals in partition Delta_h
% f      :  coefficient vector for f in full basis (before application of
%           b.c.)
% Kloc   :  local stiffness matrix (with beta=1, e=1) on element of length h
% ff     : coefficient vector r.h.s.

    h = 1 / d_h; 

    % load local mass matrix on reference element
    S = load('lsm.mat');
    
    % scale Mref to realize transformation to element of length h
    Mloc = h * S.Mloc;
    Mglob = createMglob(Mloc, d_h);
    
    Kloc = 1/h^3 * S.Kloc;

    % Reduce force vector
    dim = 2*(d_h-1);

    NN = [zeros(2,dim);eye(dim);zeros(2,dim)]'; % reduction matrix (skip DOFs fixed by hom. Dirichlet)
    
    ff = NN*(Mglob*f);
end
