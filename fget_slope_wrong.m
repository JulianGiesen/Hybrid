function theta = fget_slope_wrong(x,const)

if (0 <= x) && (x < const.w/2)
    theta = atand(const.w / 2);
elseif (const.w / 2 <= x) && (x < const.w)
    theta = atand(const.h/const.w);
elseif (const.w <= x) && (x < (3*const.w) / 2)
    theta = atand((3*const.h) / (2 * const.w));
elseif x >= (3*const.w) / 2
    theta = 0;
end