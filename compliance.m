function [ce, dce] = compliance (e,Kloc,ff) 
% function [ce, dce] = compliance (e,Kloc,ff) 
% e      :   design vector (algebraic form)
% Kloc   :   local stiffness matrix on element of length h
% ff     :   nodal force vector
% ce     :   value of compliance functional for design e
% dce    :   gradient of compliance functional evaluated at design e

    d_h = length(e);
    
    % assemble global stiffness matrix
    Kglob = createKglob(e,Kloc);
    
    % solve equilibrium equation
    q = Kglob\ff;
    
    % objective value
    ce = ff'*q;
    
    q = [0;0;q;0;0];
    
    % Gradient
    if nargout > 1
      dce = zeros(d_h, 1);  
      for ll=1:d_h
        qq = q(2*ll-1:2*ll+2);
        
        % compute partial derivative
        dce(ll) =  -3*e(ll)^2*qq'*Kloc*qq;  % complete the code here *
      end
    end
    
end
