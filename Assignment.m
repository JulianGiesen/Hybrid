clc 
clear all
folder_YALMIP = 'YALMIP-master';
addpath(genpath(folder_YALMIP));
const = fset_consts(); % Create the constants class to have the dimensions ready
dimens = fset_dim_MPC(); % Create the dimension class to have the dimensions ready

%% 2.2
v = linspace(0,const.v_max,100);
P = PWA(v,const);
V = V_friction(v,const);

% figure(1)
% plot_2_2(v,P,V,const)

%% 2.3
t_0 = 0;
t_end = 100;
t_span = t_0:0.1:t_end;
v_0 = [0; 1.5*const.alpha];

[~,PWA_v] = ode45(@(t,x) PWA_2_3(t,x,const), t_span, v_0);
[t,x] =     ode45(@(t,x) sys_2_3(t,x,const), t_span, v_0);

% figure(2)
% plot_2_3(const,x,t,PWA_v)

%% 2.4
% Derive the slope based on given x
x = 49;                 % Testing X
curr_theta = round(fget_slope(x,const),1);

% Create PWA of the LTI models
LTI = fpwaModel(const,curr_theta);
[LTI.f1, LTI.f2, LTI.f3] = deal(const.deltaT * const.g * curr_theta);
LTI.f4 = (((const.alpha * const.deltaT * const.c * const.v_max^2) - (const.deltaT * const.beta)) / ...
    (const.v_max - const.alpha)) - (const.deltaT * const.beta);

%% 2.6
% Create the MLD model
MLD = fmldModel(LTI,const);


% %% Set current gear
% if y(2) < const.vg
%     curr_gear = 1;
% elseif y(2) >= const.vg
%     curr_gear = 2;
% end

%% Expand MLD model into MILP model

% MLD.E6 = zeros(length(MLD.E1),1);
% MLD.E6(14:15) = -1;
% MLD.E7 = zeros(length(MLD.E1),1);
% MLD.E7(16:17) = 1;

% Set the reference speed
% const.v_ref = 20; % RANDOMLY SELECTED

% % Set state constraint vectors and fill them
% state_constraint = state_constraint(MLD, const, dimens);
% 
% % Set dimenions of vectors xsi and tau
% dimens.xsi = 1; % New vector xi for the optimization
% dimens.tau = 1; % New vector tau for the optimization
% 
% % Set optimization variables
% 
% u_mpc = sdpvar(dimens.u*dimens.Np,1); % u*Np x 1 matrix
% z_mpc = sdpvar(dimens.z*dimens.Np,1); % z*Np x 1 matrix
% delta_mpc = binvar(dimens.delta*dimens.Np,1); % delta*Np x 1 matrix, note binvar because of binary variable
% xsi_mpc = sdpvar(dimens.xsi*dimens.Np,1); %xsi*Np x 1 matrix
% tau_mpc = sdpvar(dimens.tau*dimens.Np,1); %tau*Np x 1 matrix
% 
% % Creates the complete constraint matrix
% Constraint = [state_constraint.E3 * delta_mpc + state_constraint.E4 * z_mpc + state_constraint.E6 * tau_mpc <= state_constraint.E2  * u_mpc + state_constraint.E7 * xsi_mpc + state_constraint.E7 + constrait.B, ...
%               eye(dimens.Np*dimens.u)*u_mpc <= const.u_max, ...
%               -eye(dimens.Np*dimens.u)*u_mpc <= -const.u_min, ...
%               ones(1,dimens.z*dimens.Np)*z_mpc <= 0];
% 
% Objective = ones(1,dimens.xsi*dimens.Np) * xsi_mpc + const.lambda * tau_mpc;
% 
% options = sdpsettings('solver','GLPK', 'verbose', 0);
% optimize(Constraint,Objective,options);                                %solve the problem
% z_mpc=value(z_mpc); 
% u_mpc=value(u_mpc); 
% delta_mpc=value(delta_mpc);
% tau_mpc=value(tau_mpc);
% xsi_mpc=value(xsi_mpc);
% cost = ones(1,dimens.xsi*dimens.Np)*xsi_mpc + const.lambda * tau_mpc;

%% Work in progress
% 
% % Number of states / inputs
% dimens.nx = 1; % Only speed is considered
% dimens.nu = 1; % Only throttle
% dimens.Nc = 3; % Control horizon
% dimens.Np = 5; % Predict horizon
% dimens.delta = 3; % Size of delta vector
% dimens.z = 3; % Size of z vector
% 
% % Initial state = const.v0
% 
% u = sdpvar(repmat(dimens.nu,1,dimens.Np),ones(1,dimens.Np)); %sdpvar because non binary variable
% deltaMPC = binvar(dimens.delta*dimens.Np,1); %bin var because of the binary variable
% zMPC = sdpvar(dimens.z*dimens.Np,1);
% 
% 
% 
% constraints = [];
% x = const.v0;
% 
% % Jinput = norm(tildeu(k),1);
% % Jtrack = norm(tildeu(k),"inf");
% 
% for k = 1:N
% 
%     objective = objective + Jtrack + const.lambda * Jinput;
% 
%     Region1 = [x{k+1} == LTI.A1*x{k} + LTI.B1*u{k} - [0;const.deltaT * const.g]*fget_slope(x{k},const), x{k}(1) >= 0];
%     Region2 = [x{k+1} == LTI.A2*x{k} + LTI.B2*u{k} - [0;const.deltaT * const.g]*fget_slope(x{k},const), x{k}(1) >= const.vg];
%     Region3 = [x{k+1} == LTI.A3*x{k} + LTI.B3*u{k} - [0;const.deltaT * const.g]*fget_slope(x{k},const) + ...
%         [0;(const.alpha*((const.deltaT*const.c*const.v_max^2) - (const.deltaT*const.beta)) / (const.v_max - const.alpha)) - (const.deltaT*const.beta)], x{k}(1) >= const.alpha];
% 
% 
%     constraints = [constraints, implies(deltaMPC{k}(1), Region1), implies(deltaMPC{k}(2), Region2), implies(deltaMPC{k}(3), Region3)];
% 
%     constraints = [constraints, (const.u_min <= u{k}) && (u{k} <= const.u_max), (0 <= x) && (x <= const.v_max)];
% end
% 
% optimize(constraints,objective);
% value(u{1})

%% 2.7
% Dimensions
dim = fset_dim_MPC();
v_ref = def_v_ref(const);
state_constraint = state_constraint(MLD, const, dim, v_ref);
% [u_MPC, delta_MPC, z_MPC, cost_MPC] = MPC(dim, const, v_ref, MLD);

%% MPC For loop Task 2.7.I
val.x = zeros(dim.x, const.steps+1);
val.u = zeros(dim.u, const.steps);
val.delta = zeros(dim.delta, const.steps);
val.x(:,1)= const.v0;

for t = 1:const.steps
    vref_t = v_ref(t:t+1);
    [u_MPC, delta_MPC, z_MPC, cost_MPC] = MPC(dim, const, v_ref, MLD);
    val.u(:,t) = u_MPC(1:dim.u);
    val.delta(:,t) = delta_MPC(1:3);
    val.x(t+1) = [1,1,1] * z_MPC(1:3);
end

%% Data processing For loop Task 2.7.I
val.acc = [];
for i = 1:length(val.x)-1
    a_i = (val.x(i+1)-val.x(i))/const.Ts;
    val.acc = [val.acc a_i];
end

%% plot Task 2.7.I
t_list = linspace(0,const.end_t + const.Ts,const.steps+1);

figure(3)
plot(t_list, v_ref(1:const.steps+1), '--', 'color', [0.7 0.7 0.7], 'DisplayName', 'v_{ref}')
hold on
plot(t_list,val.x, 'color', [0, 0, 1], 'DisplayName', 'v')
yline(const.vg, 'g--','HandleVisibility','off');
text(t_list(end-10),const.vg+1,'v_g');
legend();
ylabel('Speed [m/s]');
