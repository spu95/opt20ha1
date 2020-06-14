d_h = 10;
f = @fex1;
L = 10;
gamma = 5;
emin = .01;
emax = 20;

h = 1/d_h;
e0 = gamma/h*ones(1,d_h);

% assemble local stiffness matrix and right hand side

% use/complete function createF for to evaluate f at nodes
% (function values and first derivatives) 
ftmp = createF(d_h, f);

% use/complete function createData to assmble Kloc and r.h.s. ff
[Kloc, ff] = createData(d_h, ftmp);

% set box constraints
lb = emin*ones(1,d_h);
ub = emax*ones(1,d_h);

%define inequality (=slope) constraints
[A,b] = createSlopeCond(d_h,L);

%define equality (=volume) constraint
Aeq = ones(1,d_h);
beq = gamma/h;

compliance(e0, Kloc, ff)

% set options for fmincon
options = optimset('Display','iter','LargeScale','off','TolX',1.0e-5,...
    'GradObj','on','DerivativeCheck','off',...
    'MaxFunEvals',100000,'Diagnostics','off');

% Call fmincon
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% complete the codes here %
%
% note: use function compliance.m as objective (to get rid of additional
%       parameters you may use the concept of anonymous functions)
%
% eopt = fmincon(...,[],options);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun = @(e) compliance(e, Kloc, ff);
eopt = fmincon(fun,e0,A,b,Aeq,beq,lb,ub,[],options);

% assemble global stiffness matrix
Kglob = createKglob(eopt,Kloc);

% solve equilibrium equation
qopt = Kglob\ff;