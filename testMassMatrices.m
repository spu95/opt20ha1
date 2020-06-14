% Script for testing local and global mass matrix implementation

S0 = load('lsm0.mat');

d_h = length(S0.e0);
h = 1/d_h;

% first, test Mloc
createKMloc();
S = load('lsm.mat');

rscale = h; % scale reference matrix to obtain local matrix
              % for element of length h
Mloc = rscale * S.Mloc; % compute from Kref

diff_loc = norm(full(S0.Mloc-Mloc));
if diff_loc < 1.0e-6
    'test of local mass matrix passed'
else
    'test of local mass matrix failed'
end

Mglob = createMglob(Mloc,d_h);

test_glob = norm(full(Mglob-S0.Mglob));
if test_glob < 1.0e-6
    'test of global mass matrix passed'
else
    'test of global mass matrix failed'
end