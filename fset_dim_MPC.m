function dimens = fset_dim_MPC()
    dimens.Np = 5;      % Prediction horizon
    dimens.Nc = 4;      % Control horizon
    dimens.x = 1;       % Number of states
    dimens.u = 1;       % Number of inputs
    dimens.delta = 3;   % Dimension of delta
    dimens.z = 3;       % Dimension of z
    dimens.xsi = 1;     % Dimension of xsi
    dimens.tau = 1;    % Dimension of tau
end