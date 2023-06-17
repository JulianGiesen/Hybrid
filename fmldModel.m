function MLD = fmldModel(LTI,const)
    
    % State, input and logic vectors
    MLD.A = zeros(1);
    MLD.B1 = zeros(1,1);    % Corresponds to the input u
    MLD.B2 = zeros(3,1);    % Corresponds to binary logic vector delta
    MLD.B3 = [1,1,1];       % Corresponds to the cont. logic vector z
    
    % Constraints RHS
    MLD.E2 = [0;0;LTI.B1(2,1)   ;-LTI.B1(2,1)   ;0;0;LTI.B2(2,1)    ;-LTI.B2(2,1);0;0   ;LTI.B3(2,1)    ;-LTI.B3(2,1) ;0;0;0;0;0];
    MLD.E1 = [0;0;LTI.A1(2,2)   ;-LTI.A1(2,2)   ;0;0;LTI.A2(2,2)    ;-LTI.A2(2,2);0;0   ;LTI.A3(2,2)    ;-LTI.A3(2,2) ;0;0;0;0;0];

    MLD.E5 =          [0;0;-LTI.f1    ;LTI.f1     ;0;0;-LTI.f2        ;LTI.f2         ;0;0;-LTI.f3        ;LTI.f3; 1];
    MLD.E5 = MLD.E5 + [0;0;0          ;const.vg   ;0;0;-const.vg      ;const.alpha    ;0;0;LTI.f4         ;-LTI.f4; 0];
    MLD.E5 = MLD.E5 + [0;0;0          ;0          ;0;0;0              ;0              ;0;0;-const.alpha   ;const.v_max; 0];
    MLD.E5 = [MLD.E5; zeros(4,1)];
    
    % Constraints LHS
    MLD.E3 = zeros(17,3);
    MLD.E3(1:4,1) = [-const.vg;0;0; const.vg];
    MLD.E3(5:8,2) = [-const.alpha;const.vg;-const.vg; const.alpha];
    MLD.E3(9:12,3) = [-const.v_max;const.alpha;-const.alpha; const.v_max];
    MLD.E3(13,:) = 1;
    
    MLD.E4 = zeros(17,3);
    MLD.E4(1:4,1) = [1;-1;1; -1];
    MLD.E4(5:8,2) = [1;-1;1; -1];
    MLD.E4(9:12,3) = [1;-1;1; -1];

    MLD.E6 = zeros(length(MLD.E1),1);
    MLD.E6(14:15) = -1;
    MLD.E7 = zeros(length(MLD.E1),1);
    MLD.E7(16:17) = 1;
end
    
