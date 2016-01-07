%% define system parameters.
sys = struct;
sys.m = 12;
sys.l = .9;
sys.g = -9.81;

sys.d = sys.l/2;
sys.I = 1/12*sys.m*sys.l^2;
%% define simulation parameters.
odeopts = odeset('reltol',1e-8,'abstol',1e-8);
%% simulate.
[t,state]=ode45(@ode_singlePendulum,[0:0.001,6],[2,0],odeopts,sys);
%% compute energy.
phi = state(:,1);
dphi = state(:,2);
cphi = cos(phi);
sphi = sin(phi);

y = d*sphi;
xd = -d*sphi.*dphi;
yd = d*cphi.*dphi;

erot = 1/2*sys.I*dphi.^2;
elin = 1/2*sys.m*(xd.^2+yd.^2);
ekin = erot+elin;
eg = m*abs(g)*y;
emech = ekin + eg;

figure;
plot(elin,'r');
hold on;
plot(erot,'c');
plot(ekin,'b');
plot(eg,'g');
plot(emech,'k');
legend({'K linear','K rot','K','G','Mech'});

percent_e_diff=(emech-mean(emech))/emech(1)*100;
fprintf('The maximum %% energy diff is %.15f.\n',max(percent_e_diff));
fprintf('The average %% energy diff is %.15f.\n',mean(percent_e_diff));
fprintf('This given odeopts of reltol = %.15f, abstol = %.15f.\n',odeopts.RelTol,odeopts.AbsTol);
%% make video data.
period_vid = 1/30;
t_vid = t(1):period_vid:t(end);% for visualization only.
state_vid = linterp2d(t,state,t_vid);
out_vid = ode_singlePendulumFwd(t_vid,state_vid,sys);
%% make video.
figure;
for i =1:length(out_vid.x)
    plot(0,0);
    a=line([0,out_vid.x(i)],[0,out_vid.y(i)]);
    set(a,'color','b','linewidth',3);
    hold on;
    a=line([0,out_vid.Fx(i)/1000],[0,out_vid.Fy(i)/1000]);
    set(a,'color','r','linewidth',1);
    ax=1.5;
    axis([-ax,ax,-ax,ax]);
    pause(period_vid);   
    hold off
end;