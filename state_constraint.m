function state_con = state_constraint(MLD, const, dimens, v_ref)

    % Initialize contraint vectors
    state_con.E1 = zeros(dimens.Np*length(MLD.E1),dimens.x);
    state_con.E2 = zeros(dimens.Np*length(MLD.E2),dimens.u*dimens.Np);
    state_con.E3 = zeros(dimens.Np*length(MLD.E3),dimens.delta*dimens.Np);
    state_con.E4 = zeros(dimens.Np*length(MLD.E4),(dimens.z)*dimens.Np);
    state_con.E5 = zeros(dimens.Np*length(MLD.E5),1);
    state_con.E6 = zeros(dimens.Np*length(MLD.E6),1);
    state_con.E7 = zeros(dimens.Np*length(MLD.E7),dimens.xsi*dimens.Np);

    state_con.E1(1:length(MLD.E1),1) = MLD.E1*const.v0;

    for k = 0:dimens.Np-1
        state_con.E2(k*length(MLD.E2)+1:(k+1)*length(MLD.E2), k*dimens.u+1:(k+1)*dimens.u) = MLD.E2;
        state_con.E3(k*length(MLD.E3)+1:(k+1)*length(MLD.E3), k*dimens.delta+1:(k+1)*dimens.delta) = MLD.E3;
        state_con.E4(k*length(MLD.E4)+1:(k+1)*length(MLD.E4), k*dimens.z+1:(k+1)*dimens.z) = MLD.E4;
        state_con.E5(k*length(MLD.E5)+1:(k+1)*length(MLD.E5), 1) = MLD.E5;
        state_con.E6(k*length(MLD.E6)+1:(k+1)*length(MLD.E6), dimens.tau) = MLD.E6;
        state_con.E7(k*length(MLD.E7)+1:(k+1)*length(MLD.E7), k*dimens.xsi+1:(k+1)*dimens.xsi) = MLD.E7; 
    end

    E1_rep = repmat([MLD.E1],1,3);

    for k = 1:dimens.Np-1 
        state_con.E4(k*(length(MLD.E4(:,1)))+1:(k+1)*(length(MLD.E4(:,1))), (k-1)*dimens.z+1:(k)*dimens.z) = -E1_rep; 
    end

    for k = 1:dimens.Np
        state_con.E2((k-1)*length(MLD.E4)+14:(k-1)*length(MLD.E4)+15, k) = [1;-1];
%         state_con.E4((k-1)*length(MLD.E4)+14:(k-1)*length(MLD.E4)+15, (k-1)*dimens.z+1:(k)*dimens.z) = [-1/const.deltaT,-1/const.deltaT,-1/const.deltaT;1/const.deltaT,1/const.deltaT,1/const.deltaT];     
    end

     for k = 1:dimens.Np
         state_con.E5((k-1)*length(MLD.E5)+14:(k-1)*length(MLD.E5)+15, 1) = [const.a_comfmax; const.a_comfmax];      
         state_con.E5((k-1)*length(MLD.E5)+16:(k-1)*length(MLD.E5)+17,1) = [v_ref(k); -v_ref(k)];
     end

    state_con.B = state_con.E1 + state_con.E5;
end
