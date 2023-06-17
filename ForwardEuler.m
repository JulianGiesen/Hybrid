function [T, x] = ForwardEuler(x0,u,const)

% Initialize
x = zeros(2, const.end_T);
x(:,1) = x0;

T = 1:const.end_t;
T = T*const.deltaT;

% Forward Euler integr
for t = 2:const.end_t
    x(:,t) = x(:,t-1) + const.deltaT * fpwaModel(t*const.deltaT, x(:,t-1),u,const,"");
end

end