function LTI = fpwaModel(const,curr_theta)
    % LTI PWA model for region 1
    LTI.A1 = [1, const.deltaT;
        0, 1 - const.deltaT * (const.b/const.alpha)];
    LTI.B1 = [0; (const.deltaT*const.b)/(const.m*(1+const.gamma))];
    LTI.F1 = [0;-const.deltaT*const.g]*curr_theta;
    
    % LTI PWA model for region 2
    LTI.A2 = [1, const.deltaT;
        0, 1 - const.deltaT * (const.b/const.alpha)];
    LTI.B2 = [0; (const.deltaT*const.b)/(const.m*(1+2*const.gamma))];
    LTI.F2 = [0;-const.deltaT*const.g]*curr_theta;

    % LTI PWA model for region 3
    LTI.A3 = [1, const.deltaT;
        0, 1 - (((const.deltaT * const.c * const.v_max^2)-(const.deltaT*const.b))/(const.v_max - const.alpha))];
    LTI.B3 = [0; (const.deltaT*const.b)/(const.m*(1+2*const.gamma))];
    LTI.F3 = [0;-const.deltaT*const.g]*curr_theta + [0; const.alpha*(((const.deltaT * const.c * const.v_max^2)-(const.deltaT*const.b))/(const.v_max - const.alpha)) - (const.deltaT * const.b)];
end