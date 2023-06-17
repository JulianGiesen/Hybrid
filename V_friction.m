function V = V_friction(v, const)
V = zeros(1,length(v));

    for i = 1:length(v)
        V(i) = const.c*v(i)^2;
    end
end

