function [Kglob] = createKglob (e, Kloc)
% function [Kglob] = createKglob (e, Kloc)
% e      :    design vector
% Kloc   :    local stiffness matrix on element of length h
% Kglob  :    global stiffness matrix (after application of b.c.)
    
    d_h = length(e); % dimension of design space = #intervals ...
    h = 1/d_h;
    
    % Initialize (full dimension *before* appl. of b.c.)
    Kglob = sparse(2*d_h+2, 2*d_h+2);
    
    % Assemble
   for l=1:d_h
        % blow up local stiff mat to full dimensions and add to Kglob
        Klocfull = spalloc(2*d_h+2, 2*d_h+2,4*4);
        
        for ii = 1:4
            for jj = 1:4
                Klocfull(2*l-2+ii,2*l-2+jj) = Kloc(ii,jj);
            end
        end
        
        Kglob = Kglob + e(l)^3*Klocfull;
    end

    % Reduce local stiffness matrices
    % according to boundary conditions
    dim = 2*(d_h-1);
      
    NN = [zeros(2,dim);eye(dim);zeros(2,dim);];
    Kglob = NN'*Kglob*NN;
end 