function P = PWA(v, const)
P = zeros(1,length(v));

for i = 1:length(v)
    if 0 <= v(i) && v(i) <= const.alpha
        P(i) = const.beta/const.alpha * v(i);
    elseif const.alpha <= v(i) &&  v(i) <= const.v_max
        P(i) = (const.c * const.v_max^2 - const.beta)/(const.v_max - const.alpha) * (v(i)-const.alpha) + const.beta;
    end
end

