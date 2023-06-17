function [u_MPC, delta_MPC, z_MPC, tau_MPC, xsi_MPC, cost_MPC]= MPC(dimens, const, v_ref, MLD)
    
    constraint_state = state_constraint(MLD, const, dimens, v_ref);
    if dimens.Np ~= dimens.Nc
        contraint_input = input_constraint(dimens);
    end
    
    % Define the sdpvar optimization variables
    u_MPC = sdpvar(dimens.u*dimens.Np,1);                               
    delta_MPC = binvar(dimens.delta*dimens.Np,1);
    z_MPC  = sdpvar(dimens.z*dimens.Np,1);
    tau_MPC = sdpvar(dimens.tau,1);
    xsi_MPC = sdpvar(dimens.xsi*dimens.Np,1);

    % Creates the complete constraint matrix
%     Constraint = [constraint_state.E3 * delta_MPC + constraint_state.E4 * z_MPC <= constraint_state.E2  * u_MPC + constraint_state.E6 * tau_MPC + constraint_state.E7 * xsi_MPC + constraint_state.B, ...
%               eye(dimens.Np*dimens.u)*u_MPC <= const.u_max, ...
%               -eye(dimens.Np*dimens.u)*u_MPC <= -const.u_min, ...
%               ones(1,dimens.z*dimens.Np)*z_MPC <= 0];

    Constraint = [constraint_state.E3 * delta_MPC + constraint_state.E4 * z_MPC <= constraint_state.E2  * u_MPC + constraint_state.E6 * tau_MPC + constraint_state.E7 * xsi_MPC + constraint_state.B];
    Constraint = [Constraint, eye(dimens.Np*dimens.u)*u_MPC <= const.u_max];
    Constraint = [Constraint, -eye(dimens.Np*dimens.u)*u_MPC <= -const.u_min];

    % Add the control horizon contraint if the statement is true    
    if dimens.Np ~= dimens.Nc
        Constraint = [Constraint, contraint_input.left*u_MPC <= contraint_input.right];
    end

    % Creates the objective function
    c_x = [zeros(1 ,dimens.Np*dimens.xsi) ones(1 ,dimens.Np) zeros(1 ,dimens.Np)];
    c_u = const.lambda*[zeros(1 ,dimens.Np*dimens.xsi) zeros(1 ,dimens.Np) ones(1 ,dimens.Np)];
    Objective = c_x+c_u;
%     Objective = ones(1,dimens.xsi*dimens.Np) * xsi_MPC + const.lambda * tau_MPC;

    % Solve the optimization problem
    opt = sdpsettings('solver','GLPK','verbose',2,'debug', 1);
    optimize(Constraint,Objective,opt);    
    diagnostics = optimize(Constraint,Objective,opt);  
    yalmiperror(diagnostics.problem)

    % Find the final values from the sdpvar variables
    z_MPC = value(z_MPC); 
    u_MPC = value(u_MPC); 
    delta_MPC = value(delta_MPC);
    tau_MPC = value(tau_MPC);
    xsi_MPC = value(xsi_MPC);
    cost_MPC = Objective;
end
