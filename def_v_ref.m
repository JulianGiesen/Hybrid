function v_ref = def_v_ref(const)

% Initialize vectors and constants
t_range = linspace(const.t0,const.end_t, const.end_t/const.Ts+1);
v_ref = zeros(1,const.end_t/const.Ts+1);
i = 0;

% Define the speed reference signal
for t =t_range
    i = i+1;
    if 0 <= t && t <= 3
        v_ref(i) = 0.85*const.alpha;
    elseif 3 < t && t <= 9
        v_ref(i) = 1.2*const.alpha;
    elseif 9 < t && t  <= 15
        v_ref(i) = 1.2*const.alpha - 1/12*const.alpha*(t-9);
    elseif 15< t && t  <= 18
        v_ref(i) = 0.7*const.alpha;
    elseif 18< t && t  <= 21
        v_ref(i) = 0.7*const.alpha + 4/15*const.alpha*(t-18);
    elseif 21< t && t  <= const.end_t
        v_ref(i) = 0.9*const.alpha;
    end
end
end