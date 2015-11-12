function reg_P2 = alvaro_6dof( P2, P1 )
    th=5;
    lwbnd=10; %not working yet
    gap=10;
    boxSide= floor((max(P1(:,1)) - min(P1(:,1))) * 0.3);
    
    xP1 = downsample_OPC_to_less_than(P1,60);
    xP2 = downsample_OPC_to_less_than(P2,60);

    [~, T, ~, ~] = run_bnb6dof(xP2, xP1, th, lwbnd, gap, boxSide);

    reg_P2 = (T*P2')';
end

