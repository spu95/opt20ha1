function [eopt, qopt, qx] = solveThickness (d_h, f, L, gamma, emin, emax)
% function solveThickness (d_h, f, L0, gamma0, emin0, emax0)
% d_h       :   number of intervals in partition of Delta_h
% f         :   force function mapping from [0,1] -> R implemented as Matlab function,
%               which returns function value and first derivative at a given point (see,
%               e.g. fex1.m)
% L         :   uniform Lipschitz constant for design
% gamma     :   prescribed total volume
% emin,emax :   lower and upper bounds for design
% e0        :   initial design (optional)
% eopt      :   optimal design vector (algebraic form)
% qopt      :   corresponding optimal state vector (algebraic form)

% compute interval length from # elements
h = 1/d_h;

% assemble local stiffness matrix and right hand side

% use/complete function createF for to evaluate f at nodes
% (function values and first derivatives) 
ftmp = createF(d_h, f);

% use/complete function createData to assmble Kloc and r.h.s. ff
[Kloc, ff] = createData(d_h, ftmp);

if nargin < 7
    % set initial thickness (compatible with volume constraint)
    e0 = gamma*ones(1,d_h);
    %e0 = zeros(1,d_h);
    %e0(1) = gamma/h;
end

% set box constraints
lb = emin*ones(1,d_h);
ub = emax*ones(1,d_h);

%define inequality (=slope) constraints
[A,b] = createSlopeCond(d_h,L);

%define equality (=volume) constraint
Aeq = ones(1,d_h);
beq = gamma/h;

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

% compute deformation associated with optimal design eopt
% (solve one more state problem for this)

% assemble global stiffness matrix
Kglob = createKglob(eopt,Kloc);

% solve equilibrium equation
qopt = Kglob\ff;

% display eopt, qopt
hold off;
plot([0,1],[0,0],'black')
%ylim([-1.5 10])
hold on;

% add zeroes for b.c.
q=[0;0;qopt;0;0];
% scale deformation (for visualization)
%q=q/max(abs(q));

% use/complete interpolation function evalq to plot state
%qq = @(x) feval(@evalq, x, q);
X = 0:h:1-h;
qx = evalq(X,q);
qx2 = qx/max(abs(qx));
plot(X,qx2,'b');
%fplot(qq, [0 1], 'b');

% use/complete interpolation function evale to plot design
%ee = @(x) feval(@evale, x, eopt);
ee = evale(X,eopt);
%fplot(ee, [0 1], 'r');
plot(X,ee,'r');

legend('design','displaced design','Location','EastOutside');

end
