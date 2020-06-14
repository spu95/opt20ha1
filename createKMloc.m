function createKMloc()
% function createKMloc()
% Helper function to create 
% - local stiffness matrix (with beta=1 and e=1) 
% - local mass matrix
% evaluated on *reference element* of length 1

% first define polynomials basis polynomials
% each line defines one of the 4 basis polynomials
psi = [2,-3,0,1;
1,-2,1,0;
-2,3,0,0;
1,-1,0,0];

Kloc = zeros(4);
Mloc = zeros(4);

% you may use polyint, conv, polyder and polyval 
% to calculate the required integrals
for ii = 1:4
    for jj = 1:4
        phii = psi(ii,:);
        phij = psi(jj,:);
        int = polyint(conv(phii,phij));
        Mloc(ii,jj) = polyval(int,1)-polyval(int,0);
        
        d2phii = polyder(polyder(phii));
        d2phij = polyder(polyder(phij));
        int = polyint(conv(d2phii,d2phij));
        Kloc(ii,jj) = polyval(int,1)-polyval(int,0);
    end
end

save('lsm.mat','Kloc','Mloc');
    
end