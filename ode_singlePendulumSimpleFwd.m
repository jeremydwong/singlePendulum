function out=ode_singlePendulumSimpleFwd(t,state,sys)
% function out=ode_singlePendulumSimpleFwd(t,state,sys)
% here we do not solve for contact forces.
dim = size(state);
if dim(2) ==1
    state = state';
end;
l = sys.l;
d = sys.d;
m = sys.m;
g = sys.g;
I = sys.I;

for i = 1:length(t)
    cphi = cos(state(i,1));   
    stated(1) = state(2);
    stated(2) = g*cphi/l;
end;

out.stated = stated(:);
out.phi = state(:,1);
out.dphi = state(:,2);
out.x = d*cos(state(:,1));
out.y = d*sin(state(:,1));
out.dx = -d*sin(state(:,1)).*ddt_phi;
out.dy = d*cos(state(:,1)).*ddt_phi;
