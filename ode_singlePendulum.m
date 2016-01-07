function stated = ode_singlePendulum(t,state,sys_param)
temp = ode_singlePendulumFwd(t,state,sys_param);
stated = temp.stated;
