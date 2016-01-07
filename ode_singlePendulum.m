function stated = ode_singlePendulum(t,state,sys_param)
% function stated = ode_singlePendulum(t,state,sys_param)
% wrapping function that calls the forward simulation function.
temp = ode_singlePendulumSimpleFwd(t,state,sys_param);
stated = temp.stated;
