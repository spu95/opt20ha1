% script for testing local and global stiffness matrix implementation

S0 = load('lsm0.mat');

d_h = length(S0.e0);

% first, test Mloc
createKMloc();
S = load('lsm.mat');

rscale = 1/h^3;   % scale reference matrix to obtain local matrix
                % for element of length h
Kloc = rscale * S.Kloc; % compute from Kref

diff_loc = norm(full(S0.Kloc-Kloc));
if diff_loc < 1.0e-6
    'test of local stiffness matrix passed'
else
    'test of local stiffness matrix failed'
end

% you have to scale local stiffness matrix on reference element to 
% correct interval length
Kglob = createKglob(S0.e0,Kloc);

test_glob = norm(full(Kglob-S0.Kglob));
if test_glob < 1.0e-6
    'test of global stiffness matrix passed'
else
    'test of global stiffness matrix failed'
end